package com.hr.web;

import java.text.ParseException;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import com.hr.dto.DepartmentDTO;
import com.hr.dto.EmployeeDTO;
import com.hr.dto.JobDTO;
import com.hr.dto.UserDTO;
import com.hr.dto.UserSessionBean;
import com.hr.model.Employees;
import com.hr.model.Job;
import com.hr.service.DepartmentService;
import com.hr.service.EmployeeService;
import com.hr.service.MiscService;
import com.hr.service.UserService;


import com.google.common.collect.Lists;
import com.google.gson.Gson;

@Controller
public class HrController {
	@Autowired
	private EmployeeService employeeService;
	@Autowired
	private MiscService misc;
	@Autowired
	private DepartmentService deptServ;
	@Autowired
	private UserService UserService;
	@Autowired
	private UserSessionBean currentUser;
	
	//login
	@RequestMapping(value="/login")
	String login(Model model){
		return "login";
	}
	
	@RequestMapping("/checklogin")
	String checkLogin(@ModelAttribute("user") UserDTO current, BindingResult b, Model model) throws ParseException{
		//try to return a user dto object given the password and username
		UserDTO newDTO = UserService.getUser(current.getUsername(), current.getPassword());
		if(newDTO != null){
			this.currentUser.setUsername(current.getUsername());
			this.currentUser.setPassword(current.getPassword());
			return "redirect:/table"; //table
		}
		
		else{
			return "login";
		}	
	}
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String index(Model model){
		return "redirect:/table";
	}
	//table
	@RequestMapping(value="/table", method=RequestMethod.GET)
	public String showAllUsers(Model model){
		
		List<EmployeeDTO> list = Lists.newArrayList();
		for(Employees e : employeeService.getAll()){
			EmployeeDTO edto = new EmployeeDTO();
			if(e.getDepartment()!=null){
				edto.setDepartmentID(e.getDepartment().getDepartmentId());
			}
			else{
				edto.setDepartmentID((long)000);
			}
				edto.setFirstName(e.getFirstName());
				edto.setLastName(e.getLastName());
				edto.setJobTitle(e.getJob().getJobTitle());
				edto.setID(e.getEmployeeId());
				edto.setDeleteLink("<a href='/delete?id=" + edto.getID()+ "' " 
				+"class='btn btn-danger'>Delete</a>");
				edto.setUpdateLink("<a href='/update?id=" + edto.getID()+ "' "
						+ "class='btn btn-success'>Update</a>");
				list.add(edto);
		}
		
		model.addAttribute("employees", list);
		return "table";
	}
	
	//Create
	@RequestMapping(value="/create-new", method=RequestMethod.GET)
	public String createPage(Model model){
		List<JobDTO> jobs = this.misc.getJobs();
		List<DepartmentDTO> departments = this.deptServ.getDepartments();
		model.addAttribute("jobs", jobs);
		model.addAttribute("departments", departments);
		return "create";
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String createEmployee(Model model, @ModelAttribute("employee") EmployeeDTO employee, BindingResult result){
		Employees toSave = new Employees();
		Job j = new Job();
		JobDTO dto = misc.getJobDTOByID(employee.getJobID());
		
		j.setJobID(employee.getJobID());
		j.setJobTitle(employee.getJobTitle());
		j.setMaxSalary(dto.getMaxSalary());
		j.setMinSalary(dto.getMinSalary());
		
		toSave.setEmail("PIKACHU");
		toSave.setHireDate(new Date());
		toSave.setFirstName(employee.getFirstName());
		toSave.setLastName(employee.getLastName());
		toSave.setJob(j);
		toSave.setSalary(employee.getSalary());
		toSave.setDepartment(deptServ.getOne(employee.getDepartmentID()));
		toSave.setPhoneNumber(employee.getPhoneNumber());
		
		this.employeeService.saveOrUpdate(toSave);
		return "table";
	}
	//delete
	@RequestMapping("/deleteEmployee")
	public String deleteEmployee(@RequestParam("id") Long empId){
		this.employeeService.deleteEmployee(empId);
		return "redirect:/table";
	}
	
	//Update:
	@RequestMapping("/update")
	String update(@RequestParam("id") Long empId, Model model,
			@ModelAttribute("employee") EmployeeDTO update_employee) throws ParseException{
		Employees current = this.employeeService.getbyID(empId);
		JobDTO currentJob=this.misc.getJobDTOByID(current.getJob().getJobID());
		EmployeeDTO emp = new EmployeeDTO();
		emp.setID(current.getEmployeeId());
		emp.setFirstName(current.getFirstName());
		emp.setLastName(current.getLastName());
		emp.setPhoneNumber(current.getPhoneNumber());
		emp.setSalary(current.getSalary());
		emp.setDepartmentID(current.getDepartment().getDepartmentId());
		emp.setHireDate(current.getHireDate());
		emp.setJobTitle(current.getJob().getJobTitle());
		emp.setJobID(current.getJob().getJobID());
		emp.setEmail(current.getEmail());
		EmployeeDTO[] a= new EmployeeDTO[1];
		a[0] = emp;
		List<JobDTO> j = misc.getJobs();
		List<DepartmentDTO> d = deptServ.getDepartments();
		model.addAttribute("currentJob", currentJob);
		model.addAttribute("jobs", j);
		model.addAttribute("departments", d);
		model.addAttribute("employee", a);
		return "update";
	}
	
	@RequestMapping("/update-save")
	String updateSave(@ModelAttribute("employee") EmployeeDTO dto, BindingResult b, Model model) throws ParseException{
		createAndSave(dto);
		return "datatable-test";
	}
	
	private void createAndSave(EmployeeDTO emp) throws ParseException{
		//any fields that weren't changed will be same as the one in storage
		Employees toSave=this.employeeService.getbyID(emp.getID());
		//create job from job dto
		Job j = new Job();
		JobDTO setFrom = this.misc.getJobDTOByID(emp.getJobID());
		j.setJobID(setFrom.getJobID());
		j.setJobTitle(setFrom.getJobTitle());
		j.setMaxSalary(setFrom.getMaxSalary());
		j.setMinSalary(setFrom.getMinSalary());
		
		//create the new employee
		toSave.setFirstName(emp.getFirstName());
		toSave.setLastName(emp.getLastName());
		toSave.setPhoneNumber(emp.getPhoneNumber());
		toSave.setJob(j);
		toSave.setDepartment(this.deptServ.getOne(emp.getDepartmentID()));
		toSave.setSalary(emp.getSalary());
		this.employeeService.saveOrUpdate(toSave);
	}

}
