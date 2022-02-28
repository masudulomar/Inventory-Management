package project.validators;

import java.io.File;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import net.sf.jasperreports.engine.JasperRunManager;
import project.Common.Infos.CommonInfo;
import project.Service.MailService;
import project.Utilities.AESEncrypt;
import project.Utilities.DBUtils;


public class SuperOperation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	private static String secretKey = "DarkHorse";
	
	public SuperOperation() {
		ResultMap.clear();
	}
	
	public Map<String, String> CreateUser(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String UserId = DataMap.get("UserRole").toString() + DataMap.get("branch_code").toString();
		String sql = "INSERT INTO PRMS_USER (USER_ID ,USER_NAME,USER_PASSWORD,USER_BRANCH,USER_ROLE,ENTD_BY)  VALUES(?,?,?,?,?,?) ";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, UserId);
			stmt.setString(2, DataMap.get("Branch_name").toString());
			stmt.setString(3, AESEncrypt.encrypt(DataMap.get("Password").toString(), secretKey));
			stmt.setString(4, DataMap.get("branch_code").toString());
			stmt.setString(5, DataMap.get("UserRole").toString());
			stmt.setString(6, "BHBFC");
			int res = stmt.executeUpdate();
			if (res == 1) {
				ResultMap.put("SUCCESS", " User Id : " + UserId + "\n Data Sucessfully Updated");
			} else {
				ResultMap.put("ERROR_MSG", "Data Not Updated");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> InitProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_INIT_VALUES(?)");
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			String msg = cstmt.getString(1);
			if (msg.equalsIgnoreCase("EXPIRED")) {
				ResultMap.put("ERROR_MSG", "Can't Initialize! \n Date Expired!!");
			} else if (msg.equalsIgnoreCase("SUCCESS")) {
				ResultMap.put("SUCCESS", "Initialization Successfully Completed!");
			} else
				ResultMap.put("ERROR_MSG", "");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> RunProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {

			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_SALARY_CALCULATION_NEW(?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("User_Id").toString());
			cstmt.setString(3, DataMap.get("SalaryCode").toString());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(4);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  RunProcess!");
			} else
				ResultMap.put("SUCCESS", "Salary Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FractionSalaryMathod(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {

			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.sp_fraction_salary_calculation(?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("EmployeeId").toString());
			cstmt.setString(3, DataMap.get("NoOfDay").toString());
			cstmt.setString(4, DataMap.get("TotalDays").toString());
			cstmt.setString(5, DataMap.get("SalaryType").toString());
			cstmt.setString(6, DataMap.get("User_Id").toString());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  FractionSalaryMathod!");
			} else
				if (DataMap.get("SalaryType").toString().equalsIgnoreCase("C")) {
					ResultMap.put("SUCCESS", "Fraction Salary  Canceled  ! "+" -"+DataMap.get("EmployeeId").toString());
				}
				else{
					ResultMap.put("SUCCESS", "Fraction Salary  Successfully Completed ! "+" -"+DataMap.get("EmployeeId").toString());
				}
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	
	public Map<String, String> SalaryDataBackup(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.sp_data_backup(?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("EffectiveDate").toString());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(3);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  SalaryDataBackup!");
			} else
				ResultMap.put("SUCCESS", "Data-Backup Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> BonusProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_PRMS.SP_BONUS_CAL(?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("User_Id").toString());
			cstmt.setString(3, DataMap.get("Year").toString());
			cstmt.setString(4, DataMap.get("MonthCode").toString());
			cstmt.setString(5, DataMap.get("bonusType").toString());
			cstmt.setString(6, DataMap.get("bonusPct").toString());
			cstmt.setString(7, DataMap.get("orderNo").toString());
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(8);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Bonus Process!\n" + error);
			} else
				ResultMap.put("SUCCESS", "Bonus/Incentive Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> PensionProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {

			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_pension.sp_PensionCalculation_new(?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("User_Id").toString());
			cstmt.setString(3, DataMap.get("SalaryCode").toString());
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(4);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  PensionProcess!");
			} else
				ResultMap.put("SUCCESS", "Pension Calculation Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	
	public Map<String, String> PensionDataBackup(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_pension.sp_pension_data_backup(?,?)");
			cstmt.setString(1,  DataMap.get("asonDate").toString());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(2);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Pension BackUp Process! "+error);
			} else
				ResultMap.put("SUCCESS", "Pension Data Backup Process Successfully Completed!");
				
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	
	public Map<String, String> InitPensionProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_pension.SP_INIT_VALUES(?)");
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
			cstmt.execute();
			String msg = cstmt.getString(1);
			if (msg.equalsIgnoreCase("EXPIRED")) {
				ResultMap.put("ERROR_MSG", "Can't Initialize! \n Date Expired!!");
			} else if (msg.equalsIgnoreCase("SUCCESS")) {
				ResultMap.put("SUCCESS", "Initialization Successfully Completed!");
			} else
				ResultMap.put("ERROR_MSG", "");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	String GetMonthName(String monthcode) {
		Map<String, String> parameter = new HashMap<String, String>();
		parameter.put("1", "JAN");
		parameter.put("2", "FEB");
		parameter.put("3", "MAR");
		parameter.put("4", "APR");
		parameter.put("5", "MAY");
		parameter.put("6", "JUN");
		parameter.put("7", "JUL");
		parameter.put("8", "AUG");
		parameter.put("9", "SEP");
		parameter.put("10", "OCT");
		parameter.put("11", "NOV");
		parameter.put("12", "DEC");
		return parameter.get(monthcode);
	}
	
	@SuppressWarnings("unused")
	public Map<String, String> BulkMailSendMethod(Map DataMap) throws Exception {

		DBUtils ob = new DBUtils();
		PRMSValidator prmsValidator = new PRMSValidator();
		MailService bulkmailservice = new MailService();
		Map<String, Object> parameter = new HashMap<String, Object>();
		String Year = DataMap.get("Year").toString();
		String Month = DataMap.get("MonthCode").toString();
		String Branch = DataMap.get("Branch_Code").toString();
		String emailCode = DataMap.get("mailcode").toString();
		String report_path = GetReportPath(emailCode);
		String ProjectPath =DataMap.get("ProjectPath").toString();
		
		parameter.put("LOGO_PATH", ProjectPath+CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath+CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath+CommonInfo._REPORT_DIR_PRMS);
		Connection con = ob.GetConnection();
		File file = new File(ProjectPath+report_path);
		String host_mail = "ict.bhbfc@gmail.com";
		String host_password = "apbhbfc123";
		
	/*	String host_mail = "prms@bhbfc.gov.bd";
		String host_password = "Bhbfc@mail123";
		
		*/
		ResultSet rs = null;
		PreparedStatement stmt = null;
		String pf_id = "";
		String pf_name = "";
		String toEmail = "";
		String emp_Branch = "";
		String Filename = "";
		String sql=null;
		if (emailCode.equalsIgnoreCase("Payslip")) {
			String _mailBody = "Dear Sir, \nPlease find the attachment of your e-Payslip for this month.\n"
					+ "\n*This mail is auto-generated by PRMS. Please do not reply.\n" + "\n"
					+ "\nThanks!\nTeam PRMS.";

			parameter.put("P_BRANCH", Branch);
			String _mailSubject = "e-Payslip " + GetMonthName(Month) + "-" + Year + "";

			sql = "SELECT TRIM(E.EMP_ID)EMP_ID,S.EMP_BRN_CODE,E.EMP_NAME,TRIM(E.EMAIL)EMAIL,E.CONTACT_NO FROM PRMS_EMPLOYEE E JOIN PRMS_EMP_SAL S \r\n"
					+ "ON (E.EMP_ID=S.EMP_ID)\r\n" + "WHERE E.EMAIL <>'N/A' AND S.ACC_NO_ACTIVE<>'N' \r\n";

			if (Branch.equalsIgnoreCase("0"))
				sql = sql + " and  s.EMP_BRN_CODE not in ('9999','9998')";				
			else
				sql = sql + " and  s.EMP_BRN_CODE= '" + Branch + "'";
						
			try {
				stmt = con.prepareStatement(sql);
				rs = stmt.executeQuery();
				while (rs.next()) {
					
					pf_id = rs.getString("EMP_ID").toString();
					pf_name = rs.getString("EMP_NAME").toString();
					toEmail = rs.getString("EMAIL").toString();
					emp_Branch = rs.getString("EMP_BRN_CODE").toString();
					Filename = "ePayslip_" + pf_id + "_" + Year + "_" + Month;
					parameter.put("P_EMP_ID", pf_id);
					Map<String, String> brn_info = new HashMap<String, String>();
					brn_info.put("branch_code", emp_Branch);
					brn_info = prmsValidator.BranchKeyPress(brn_info);

					parameter.put("P_BRANCH", emp_Branch);
					parameter.put("P_YEAR", Year);
					parameter.put("P_MONTH", Month);
					parameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
					parameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));

					byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), parameter, con);
					String sucess = "";
					String[] bulkmail = { toEmail };
					sucess = bulkmailservice.MailService(_mailSubject, _mailBody, host_mail, host_password, bulkmail,
							bytes, Filename);

					if (sucess.equalsIgnoreCase("Sucess")) {
						System.out.println("Email Sent Sucessfully - PF: " + pf_id + ", name: " + pf_name);
					} else {
						System.out.println("Email Not Sent - " + pf_id + " name: " + pf_name);
					}
				}

			} catch (SQLException e) {
				e.printStackTrace();
			} catch (AddressException e) {
				e.printStackTrace();
			} catch (MessagingException e) {
				e.printStackTrace();
			}

		} else {
			String CommomHead = null;
			if (emailCode.equalsIgnoreCase("details_branch")) {
				CommomHead = "salary details report";
			} else if (emailCode.equalsIgnoreCase("summary_branch")) {
				CommomHead = "salary summary report";
			} else if (emailCode.equalsIgnoreCase("payslip_branch")) {
				CommomHead = "salary individual payslip ";
			} else if (emailCode.equalsIgnoreCase("bank_advice_branch")) {
				CommomHead = "bank advice";
			}
			else if (emailCode.equalsIgnoreCase("BranchLoan")) {
				CommomHead = " Branch Account Lists";
			}
			String _mailBody = "Dear Sir, \nPlease find the attachment of your " + CommomHead + "\n"
					+ "\n*This mail is auto-generated. Please do not reply.\n" + "\n"
					+ "\nThanks!\n";

		//	String _mailSubject = CommomHead + "2020-2021";

			 sql = " select m.brn_code,m.brn_name,m.brn_address,'data_ict@bhbfc.gov.bd' /*trim(m.emil_id)*/emil_id from prms_mbranch m \r\n"
					+ "   where m.emil_id is not null\r\n";

			if (!(Branch.equalsIgnoreCase("") || Branch.equalsIgnoreCase("NA") || Branch == null)) {
				sql = sql + "and m.brn_code='" + Branch + "'";
			}
			try {
				stmt = con.prepareStatement(sql);
				rs = stmt.executeQuery();
				while (rs.next()) {
					String branch_code = rs.getString("brn_code").toString();
					String branch_name = rs.getString("brn_name").toString();
					String branch_addr = rs.getString("brn_address").toString();
					String mail_id = rs.getString("emil_id").toString();
					Filename = CommomHead + "_" + GetMonthName(Month)+"_"+branch_code ;
					
					String _mailSubject = CommomHead + "2020-2021  "+branch_code;
					parameter.put("P_BRANCH", branch_code);
					parameter.put("parameter1", branch_code);
					parameter.put("P_YEAR", Year);
					parameter.put("P_MONTH", Month);
					parameter.put("BRANCH_NAME", branch_name);
					parameter.put("BRANCH_ADDRESS", branch_addr);

					byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), parameter, con);
					String sucess = "";
					String[] bulkmail = { mail_id };
					sucess = bulkmailservice.MailService(_mailSubject, _mailBody, host_mail, host_password, bulkmail,
							bytes, Filename);
					if (sucess.equalsIgnoreCase("Sucess")) {
						System.out.println(
								"Email Sent Sucessfully - Branch name: " + branch_name + ",Branch mail ID: " + mail_id);
					} else {
						System.out.println(
								"Email Not Sent - Branch name:- " + branch_name + " Branch mail ID: " + mail_id);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		ResultMap.put("SUCCESS", "Email Sucessfully Sent");
		ResultMap.put("ERROR_MSG", "");
		return ResultMap;
	}
	private String GetReportPath(String report_code){
		String ReportPath="";
		if(report_code.equalsIgnoreCase("Payslip")){
			ReportPath= CommonInfo._REPORT_DIR_PRMS + "Single_Pay_Slip.jasper";
		}
		else if(report_code.equalsIgnoreCase("details_branch")){
			ReportPath= CommonInfo._REPORT_DIR_PRMS + "Salary_Report_All.jasper";
		}
		else if(report_code.equalsIgnoreCase("summary_branch")){
			ReportPath= CommonInfo._REPORT_DIR_PRMS + "Salary_Summary_Report.jasper";
		}
		else if(report_code.equalsIgnoreCase("payslip_branch")){
			ReportPath= CommonInfo._REPORT_DIR_PRMS + "Individual_Pay_Slip.jasper";
		}
		else if(report_code.equalsIgnoreCase("bank_advice_branch")){
			ReportPath= CommonInfo._REPORT_DIR_PRMS + "Bank_Advice_All.jasper";
		}
		else if(report_code.equalsIgnoreCase("BranchLoan")){
			ReportPath= CommonInfo._REPORT_DIR_DST + "BranchWiseLoanAcc.jasper";
		}
		return ReportPath;
		
	}
	
}
