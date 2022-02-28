/***************************************************************
* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/


package project.Common.Servlets;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JasperRunManager;
import project.Common.Infos.CommonInfo;
import project.Utilities.DBUtils;
import project.Utilities.ProjectUtils;
import project.Utilities.ReportUtilities;
import project.validators.PRMSValidator;

/**
 * Servlet implementation class ReportServlet
 */
@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException {		
			Connection con = null;
			DBUtils dbUtils = new DBUtils();			
			Map<String, Object> RequestedParameter = new HashMap<String, Object>();								
			Map<String, Object> ReportParameter = new HashMap<String, Object>();	
			
			String ReportType = request.getParameter("ReportType");			
			String branchCode = request.getParameter("Branch_Code");
			String year = request.getParameter("Year");
			String monthCode = request.getParameter("MonthCode");
			String UserId=request.getParameter("User_Id");
			//LogParam.put("UserId", request.getParameter("UserId"));
			//LogParam.put("P_BRANCH", request.getParameter("Branch_Code"));
		
			
			RequestedParameter.put("ReportType", request.getParameter("ReportType"));
			RequestedParameter.put("P_BRANCH", request.getParameter("Branch_Code"));
			RequestedParameter.put("P_YEAR", request.getParameter("Year"));
			RequestedParameter.put("P_MONTH", request.getParameter("MonthCode"));
			RequestedParameter.put("P_BONUS_TYPE", request.getParameter("bonusType"));
			RequestedParameter.put("ReportType", request.getParameter("ReportType"));
			
			String ProjectPath=ProjectUtils.GetProjectPath();
			String ReportPath=ReportUtilities.GetReportPath(ReportType,branchCode);
			
			
			
			/*common*/	
			
			Map<String, String> brn_info = new HashMap<String, String>();
			brn_info.put("branch_code", branchCode);
			PRMSValidator prmsValidator = new PRMSValidator();
			try {
				brn_info = prmsValidator.BranchKeyPress(brn_info);
				ReportParameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
				ReportParameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			
			//common
			ReportParameter.put("LOGO_PATH", ProjectPath+CommonInfo._LOGO_PATH);
			ReportParameter.put("M_LOGO", ProjectPath+CommonInfo._LOGO_PATH_2);
			ReportParameter.put("SUBREPORT_DIR", ProjectPath+CommonInfo._REPORT_DIR_PRMS);
			
			Map<String, String> Datarow = new HashMap<String, String>();
			
			if(ReportType.equalsIgnoreCase("details_rpt")||ReportType.equalsIgnoreCase("monthly_salary_summary")){
				Datarow.put("User_Id", UserId);
				Datarow.put("P_BRANCH", branchCode);
				Datarow.put("P_YEAR", year);
				Datarow.put("P_MONTH", monthCode);
				Datarow.put("P_DEDUCTION_TYPE", ReportType);
				try {
					prmsValidator.Reportlog(Datarow);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
									
		if(ReportType.equalsIgnoreCase("ITR")){
			if(request.getParameter("empID").equalsIgnoreCase("N/A")) {
				ReportParameter.put("P_EMP_ID", null);
			}else {
				ReportParameter.put("P_EMP_ID", request.getParameter("empID"));
			}
			ReportParameter.put("P_FIN_YEAR", request.getParameter("financialYear").substring(0, 4));
			ReportParameter.put("P_FIN_YEAR2", request.getParameter("financialYear").substring(5, 9));
			
		   }
		if(ReportType.equalsIgnoreCase("IncentiveDetails")|| ReportType.equalsIgnoreCase("IncentiveAdvice")||ReportType.equalsIgnoreCase("TaxCertificate")){
			ReportParameter.put("FinYear", request.getParameter("financialYear"));
		}

		ReportParameter.put("P_BRANCH", branchCode);
		ReportParameter.put("P_YEAR", year);
		ReportParameter.put("P_MONTH", monthCode);
		ReportParameter.put("P_DEDUCTION_TYPE", ReportType);
		ReportParameter.put("ReportType", request.getParameter("ReportType"));
		ReportParameter.put("P_BONUS_TYPE", request.getParameter("bonusType"));
		//common
			
			
			try {
				File file = new File(ProjectPath+ReportPath);
				con = dbUtils.GetConnection();
				byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), ReportParameter, con);
				response.setContentType("application/pdf");
				response.setContentLength(bytes.length);
				ServletOutputStream outputStream = response.getOutputStream();
				outputStream.write(bytes, 0, bytes.length);
				outputStream.flush();
				outputStream.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			finally {
				try {
					con.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
	}
}
