
package project.validators;

import java.io.Reader;
import java.sql.CallableStatement;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;
import project.Utilities.DBUtils;

public class LmsEntryValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public LmsEntryValidation() {
		ResultMap.clear();
	}

	public Map<String, String> FetchBorrowerName(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select name1 from " + "table(pkg_lms_entry.fn_get_loan_info(?,?))";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs = null;

		try {
			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());

			rs = cstmt.executeQuery();

			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "Invalid Account NUmber !!");
			}

			else {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchBankName(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select k.bk_code,k.bk_desc||' ('||BK_ADD1||')' bk_desc from lms_bank k where k.bk_code=?";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs = null;

		try {
			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("BankCode").toString());

			rs = cstmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
				// rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> FetchinstallmentData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select BANK,MEMO_NO," + "TO_CHAR(PAY_DATE, 'DD-MON-YYYY')PAY_DATE," + "PAY_AMT," + "PURPOSE,IDCP"
				+ " from table(pkg_lms_entry.fn_fetch_memo_info(?,?,?,?))";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs = null;

		try {
			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.setString(3, DataMap.get("MemoNo").toString());
			cstmt.setString(4, DataMap.get("PayDate").toString());

			rs = cstmt.executeQuery();
			if (rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
				cstmt.close();
				// rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> InsertUpdateMemoData(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.sp_memo_insert_update(?,?,?, ?,?,?, ?,?,?, ?,?)");
			cstmt.setString(1, DataMap.get("BankCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.setString(3, DataMap.get("OfficeCode").toString());
			cstmt.setString(4, DataMap.get("MemoNo").toString());
			cstmt.setString(5, DataMap.get("PayDate").toString());
			cstmt.setString(6, DataMap.get("PayAmount").toString());
			cstmt.setString(7, DataMap.get("Purpose").toString());
			cstmt.setString(8, DataMap.get("User").toString());
			cstmt.setString(9, DataMap.get("Idcp").toString());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(10);
			String msg = cstmt.getString(11);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			} else
				ResultMap.put("SUCCESS", msg);
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

	public Map<String, String> FetchLoanCodeValidationData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("OfficeCode").toString().equals(null) || DataMap.get("OfficeCode").toString().equals("")
				|| DataMap.get("OfficeCode").toString() == "" || DataMap.get("OfficeCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();

			String sql = "select NAME1 from table(pkg_lms_entry.fn_get_loan_info(?,?))";

			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("OfficeCode").toString());
				stmt.setString(2, DataMap.get("LoanCode").toString());
				rs = stmt.executeQuery();
				if (rs.next()) {
					ResultSetMetaData rsmd = rs.getMetaData();
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						try {
							ResultMap.put(rsmd.getColumnName(i),
									StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
						} catch (Exception e) {
							System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
							e.printStackTrace();
						}
					}

				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
					stmt.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println(ResultMap);
		return ResultMap;
	}

	public Map<String, String> FetchLoanDisburseData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		if (DataMap.get("OfficeCode").toString().equals(null) || DataMap.get("OfficeCode").toString().equals("")
				|| DataMap.get("OfficeCode").toString() == "" || DataMap.get("OfficeCode").toString() == null) {
			ResultMap.put("ERROR_MSG", "Session Time Out!! Please log In again");
		} else {
			DBUtils ob = new DBUtils();

			String sql = "select  NO_OF_DISB, DISB_COMP, TO_CHAR(ISSU_DATE,'DD-Mon-YYYY')ISSU_DATE, TO_CHAR(DELV_DATE,'DD-Mon-YYYY')DELV_DATE, DISB_AMT, CHEQUE_NO  from table(pkg_lms_entry.fn_get_disburse_info(?, ?, ?, ?))";

			Connection con = ob.GetConnection();
			PreparedStatement stmt = null;
			ResultSet rs = null;
			try {
				stmt = con.prepareStatement(sql);
				stmt.setString(1, DataMap.get("OfficeCode").toString());
				stmt.setString(2, DataMap.get("LoanCode").toString());
				stmt.setString(3, DataMap.get("DisbursementType").toString());
				stmt.setString(4, DataMap.get("NoOfDisburse").toString());
				rs = stmt.executeQuery();
				if (rs.next()) {
					ResultSetMetaData rsmd = rs.getMetaData();
					for (int i = 1; i <= rsmd.getColumnCount(); i++) {
						try {
							ResultMap.put(rsmd.getColumnName(i),
									StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
						} catch (Exception e) {
							System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
							e.printStackTrace();
						}
					}

				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					con.close();
					stmt.close();
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		System.out.println(ResultMap);
		return ResultMap;
	}
	
	public Map<String, String> LastCheckValidation(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.sp_Disburse_check(?,?,?)");
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.execute();
			String msg = cstmt.getString(3);			
			if (msg.equals("Complete")) {
				ResultMap.put("ERROR_MSG", "Disbursement Already Complete !!");
			} else {
				ResultMap.put("SUCCESS", "Disbursement Not Complete !!");
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
	
	public Map<String, String> PaymentDateValidation(Map DataMap) throws Exception {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = " select f.activatation from as_finyear f where ? between f.start_date and f.end_date";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("PayDate").toString());
			rs = stmt.executeQuery();
			if (rs.next()) {
				String activitation = rs.getString(1);
				if (!activitation.equals("Y")) {
					ResultMap.put("ERROR_MSG", "Payment Date does not exist in Fin year ");
				}
			} else {
				ResultMap.put("ERROR_MSG", "Payment Date does not exist in Fin year ");
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> FetchBankInfo(Map DataMap) throws Exception {

		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		
		String sql = "select rtrim(xmlagg(xmlelement(e, bk_code || ':' || bk_desc, '#').extract('//text()') order by bk_code)\r\n" + 
				"                    .getclobval(), +            '#') BANK_LIST \r\n" + 
				"     from (select bk_code,bk_desc\r\n"
				+ "  from (select k.bk_code, k.bk_desc || ' (' || BK_ADD1 || ')' bk_desc\r\n"
				+ "          from lms_bank k\r\n"
				+ "         where k.loc_code = ? \r\n"
				+ "        union\r\n"
				+ "        select k.bk_code, k.bk_desc || ' (' || BK_ADD1 || ')' bk_desc\r\n"
				+ "          from lms_bank k\r\n"
				+ "         where k.bk_code in ('666600', '888800'))) ORDER BY bk_code ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("LoggedBranch").toString());
			rs = stmt.executeQuery();

			if (rs.next()) {
				Clob clob = rs.getClob("BANK_LIST");
				Reader r = clob.getCharacterStream();
				StringBuffer buffer = new StringBuffer();
				int ch;
				while ((ch = r.read()) != -1) {
					buffer.append("" + (char) ch);
				}
				ResultMap.put("BANK_LIST", buffer.toString());
			}

		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", e.getMessage().toString());
			e.printStackTrace();
		} finally {
			try {
				con.close();
				stmt.close();
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> UpdateLoanDisburseData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		System.out.println(DataMap);
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.sp_loan_disburse_data(?,?,?,?,?,?,?,?,?,?,?)");
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.setString(3, DataMap.get("IssueDate").toString());
			cstmt.setString(4, DataMap.get("Amount").toString());
			cstmt.setString(5, DataMap.get("ChequeNo").toString());
			cstmt.setString(6, DataMap.get("NoOfDisburse").toString());
			cstmt.setString(7, DataMap.get("DeliveryDate").toString());
			cstmt.setString(8, DataMap.get("DisbursementType").toString());
			cstmt.setString(9, DataMap.get("UserID").toString());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(10);
			String Message = cstmt.getString(11);
			if (error != null) {
				ResultMap.put("ERROR_MSG", error);
			}
			else
			{
				ResultMap.put("SUCCESS", Message);
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
	public Map<String, String> FetchLoanData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "select LOAN_CODE, NAME1, NAME2, F_NAME, H_NAME, M_NAME,\r\n"
				+ "       M_ADD1||M_ADD2||M_ADD3 M_ADD, PHONE_RES, PHONE_OFF, CELL_NO,\r\n"
				+ "       S_ADD1||S_ADD2||S_ADD3 S_ADD, EMAIL, PROJ_CODE, NID1, S_DIST_CODE,\r\n"
				+ "       NID2, S_THANA_CODE,TIN_NO,PROFESSION,BANK_NAME,"
				+ "BANK_ACCOUNT_NO from table(pkg_lms_entry.fn_get_loan_info(?,?))";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs=null;
		
		try 
		{
			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			
			
			rs = cstmt.executeQuery();
			if(rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
			else {
				ResultMap.put("ERROR_MSG", "Personal Information not Found!");
				}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally {
			try {
				con.close();
				cstmt.close();
				//rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> InsertUpdateLoanData(Map DataMap) 
	{
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		
		
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.sp_loan_personal_data(?,?,?, ?,?,?, ?,?,?, ?,?,?, ?,?,?, ?,?,?, ?,?,?, ?,?,?, ?,?)");

			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			// cstmt.setString(2, DataMap.get("BranchName").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			// cstmt.setString(4, DataMap.get("LoanName").toString());
			cstmt.setString(3, DataMap.get("BorrowerName").toString());
			cstmt.setString(4, DataMap.get("JointBorrower").toString());
			cstmt.setString(5, DataMap.get("FatherName").toString());
			cstmt.setString(6, DataMap.get("HusbandName").toString());
			cstmt.setString(7, DataMap.get("MotherName").toString());
			cstmt.setString(8, DataMap.get("MailingAddress").toString()); 
			cstmt.setString(9, DataMap.get("PhoneRes").toString());
			cstmt.setString(10, DataMap.get("PhoneOff").toString());
			cstmt.setString(11, DataMap.get("MobileNo").toString());
			cstmt.setString(12, DataMap.get("SiteAddress").toString());
			cstmt.setString(13, DataMap.get("Email").toString());
			cstmt.setString(14, DataMap.get("ProjCode").toString());
			cstmt.setString(15, DataMap.get("NID1").toString());
			cstmt.setString(16, DataMap.get("DistrictCode").toString());
			cstmt.setString(17, DataMap.get("NID2").toString());
			cstmt.setString(18, DataMap.get("ThanaCode").toString());
			

			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.setString(21, DataMap.get("ProductNature").toString());
			cstmt.setString(22, DataMap.get("User").toString());
			cstmt.setString(23, DataMap.get("TaxId").toString());
			cstmt.setString(24, DataMap.get("Profession").toString());
			cstmt.setString(25, DataMap.get("BankName").toString());
			cstmt.setString(26, DataMap.get("BankAccountNo").toString());
			cstmt.execute();
			String error = cstmt.getString(19);
			String msg = cstmt.getString(20);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in insert/Update");
			} else
				ResultMap.put("SUCCESS", msg);
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
	
	public Map<String, String> FetchLoanData2(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		DBUtils ob = new DBUtils();
		String sql="";
		System.out.println("Page = "+DataMap.get("Page").toString());
		if(DataMap.get("Page").toString().equals("2")) {
			sql = "Select LOC_CODE, LOAN_CODE, TO_CHAR(OPEN_DATE,'DD-MON-YYYY')OPEN_DATE, SANC_AMT, TO_CHAR(SANC_DATE,'DD-Mon-YYYY')SANC_DATE, LOAN_PERIOD, INT_RATE, SOURCE_LAND, FLAT, concat(AREA_BUILD, 'fadsf')AREA_BUILD, NO_FLOOR, NO_UNIT, HB_EMPL, TO_CHAR(MORT_DATE,'DD-Mon-YYYY')MORT_DATE, MORT_DESC, GRATUITY, GA_REBATE, TIN_NO, ADDITIONAL_INT, PROFESSION, BANK_NAME, BANK_ACCOUNT_NO, REFIX from table(pkg_lms_entry.fn_get_loan_info(?,?))";
		
		}
		else if(DataMap.get("Page").equals("3")) {
			sql = "Select LOC_CODE, LOAN_CODE, LEDG_NO, LOAN_CLASS, OB_DESC, RESC_MONTH, RESC_NO, SECOND_MOD, SM_SANC_DT, SM_SAN_AMT, SM_BANK, SM_BK_ADD1, ACQUIRE, LOAN_CL_DT, LEGAL_ACT, LOAN_ACTIVE from table(pkg_lms_entry.fn_get_loan_info(?,?))";
			
		};
		
		//String sql = "Select LOC_CODE, LOAN_CODE, TO_CHAR(OPEN_DATE,'DD-MON-YYYY')OPEN_DATE,SANC_AMT, TO_CHAR(SANC_DATE,'DD-MON-YYYY')SANC_DATE, LOAN_PERIOD,INT_RATE, SOURCE_LAND, FLAT, AREA_BUILD,NO_FLOOR, NO_UNIT, HB_EMPL, TO_CHAR(MORT_DATE,'DD-Mon-YYYY')MORT_DATE,MORT_DESC, GRATUITY, GA_REBATE, ADDITIONAL_INT, REFIX from table(pkg_lms_entry.fn_get_loan_info(?,?))";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs=null;
		try 
		{

			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			
			
			rs = cstmt.executeQuery();
			if(rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
			else {
				ResultMap.put("ERROR_MSG", "Personal Information not Found!");
				}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally {
			try {
				con.close();
				cstmt.close();
				//rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}

	public Map<String, String> FetchLoanData3(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");

		DBUtils ob = new DBUtils();
		String sql="";
			sql = "Select LOC_CODE, LOAN_CODE, LEDG_NO, LOAN_CLASS, OB_DESC, RESC_MONTH, RESC_NO, SECOND_MOD, SM_SANC_DT, SM_SAN_AMT, SM_BANK, SM_BK_ADD1, ACQUIRE, LOAN_CL_DT, LEGAL_ACT, LOAN_ACTIVE from table(pkg_lms_entry.fn_get_loan_info(?,?))";
		//String sql = "Select LOC_CODE, LOAN_CODE, TO_CHAR(OPEN_DATE,'DD-MON-YYYY')OPEN_DATE,SANC_AMT, TO_CHAR(SANC_DATE,'DD-MON-YYYY')SANC_DATE, LOAN_PERIOD,INT_RATE, SOURCE_LAND, FLAT, AREA_BUILD,NO_FLOOR, NO_UNIT, HB_EMPL, TO_CHAR(MORT_DATE,'DD-Mon-YYYY')MORT_DATE,MORT_DESC, GRATUITY, GA_REBATE, ADDITIONAL_INT, REFIX from table(pkg_lms_entry.fn_get_loan_info(?,?))";
		Connection con = ob.GetConnection();
		PreparedStatement cstmt = null;
		ResultSet rs=null;
		try 
		{

			cstmt = con.prepareStatement(sql);
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			
			
			rs = cstmt.executeQuery();
			if(rs.next()) {
				ResultSetMetaData rsmd = rs.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					try {
						ResultMap.put(rsmd.getColumnName(i),
								StringUtils.isBlank(rs.getObject(i).toString()) ? "" : rs.getObject(i).toString());
					} catch (Exception e) {
						System.out.println(rsmd.getColumnName(i) + "--" + e.getMessage());
					}
				}
			}
			else {
				ResultMap.put("ERROR_MSG", "Personal Information not Found!");
				}
		} 
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		finally {
			try {
				con.close();
				cstmt.close();
				//rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	
	public Map<String, String> UpdateInformation2(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		

		Connection con = null;
		CallableStatement cstmt = null;
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.SP_LOAN_INFORMATION(?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?)");
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.setString(3, DataMap.get("AccountOpeningDate").toString());
			cstmt.setString(4, DataMap.get("SanctionAmount").toString());
			
			cstmt.setString(5, DataMap.get("SanctionDate").toString());
			cstmt.setString(6, DataMap.get("LoanPeriod").toString());
			cstmt.setString(7, DataMap.get("InterestRate").toString());
			cstmt.setString(8, DataMap.get("SourceOfLand").toString());
			
			cstmt.setString(9, DataMap.get("FlatLoan").toString());
			cstmt.setString(10, DataMap.get("AreaOfBuilding").toString());
			cstmt.setString(11, DataMap.get("NoOfFloor").toString());
			cstmt.setString(12, DataMap.get("TotalUnits").toString());
			
			cstmt.setString(13, DataMap.get("HbfcEmployee").toString());
			cstmt.setString(14, DataMap.get("AdditionalInterest").toString());
			cstmt.setString(15, DataMap.get("MortgageDate").toString());
			cstmt.setString(16, DataMap.get("MortgageDescription").toString());
			
			cstmt.setString(17, DataMap.get("Graduation").toString());
			cstmt.setString(18, DataMap.get("GaRebate").toString());
			cstmt.setString(19, DataMap.get("Refix").toString());
			
			
			
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(20);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Updating Employee Information!");
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
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
		
		
		
		/*Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		ResultSet rs=null;
		try {			
			String sql="UPDATE loan_mas L SET L.OPEN_DATE=?, L.SANC_AMT=?, L.SANC_DATE=?, L.LOAN_PERIOD=?, L.INT_RATE=?, L.SOURCE_LAND=?, L.FLAT=?, L.AREA_BUILD=?, L.NO_FLOOR=?, L.NO_UNIT=?, L.HB_EMPL=?, L.MORT_DATE=?, L.MORT_DESC=?, L.GRATUITY=?, L.GA_REBATE=?, L.TIN_NO=?, L.PROFESSION=?, L.BANK_NAME=?, L.BANK_ACCOUNT_NO=?, L.REFIX=?, L.ADDITIONAL_INT=?  WHERE L.LOC_CODE=? and L.LOAN_CODE=?";
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("AccountOpeningDate").toString());
			stmt.setString(2, DataMap.get("SanctionAmount").toString());
			stmt.setString(3, DataMap.get("SanctionDate").toString());
			stmt.setString(4, DataMap.get("LoanPeriod").toString());
			
			stmt.setString(5, DataMap.get("InterestRate").toString());
			stmt.setString(6, DataMap.get("SourceOfLand").toString());
			stmt.setString(7, DataMap.get("FlatLoan").toString());
			stmt.setString(8, DataMap.get("AreaOfBuilding").toString());
			
			stmt.setString(9, DataMap.get("NoOfFloor").toString());
			stmt.setString(10, DataMap.get("TotalUnits").toString());
			stmt.setString(11, DataMap.get("HbfcEmployee").toString());
			stmt.setString(12, DataMap.get("MortgageDate").toString());
			
			stmt.setString(13, DataMap.get("MortgageDescription").toString());
			stmt.setString(14, DataMap.get("Graduation").toString());
			stmt.setString(15, DataMap.get("GaRebate").toString());
			stmt.setString(16, DataMap.get("TaxId").toString());
			
			stmt.setString(17, DataMap.get("Profession").toString());
			stmt.setString(18, DataMap.get("BankName").toString());
			stmt.setString(19, DataMap.get("BankAccountNo").toString());
			stmt.setString(20, DataMap.get("Refix").toString());
			stmt.setString(21, DataMap.get("AdditionalInterest").toString());
			
			stmt.setString(22, DataMap.get("OfficeCode").toString());
			stmt.setString(23, DataMap.get("LoanCode").toString());
			
			
			
			stmt.executeUpdate();
			ResultMap.put("SUCCESS", "Data Successfully Updated");
			stmt.close();
		} catch (SQLException e) {
			ResultMap.put("ERROR_MSG", "Error in Updating information");
			e.printStackTrace();
		} finally {
			try {
				con.close();		
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		*/
		return ResultMap;
	}
	
	
	
	
	
	public Map<String, String> UpdateInformation3(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		

		Connection con = null;
		CallableStatement cstmt = null;
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.SP_LOAN_CRITERIA(?,?,?,?, ?,?,?,?, ?,?,?,?, ?,?,?,?, ?)");
			cstmt.setString(1, DataMap.get("OfficeCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
	
			cstmt.setString(3, DataMap.get("LedgerNo").toString());
			
			cstmt.setString(4, DataMap.get("LoanClass").toString());
			cstmt.setString(5, DataMap.get("ObjectDescription").toString());
			cstmt.setString(6, DataMap.get("RescheduleMonth").toString());
			
			cstmt.setString(7, DataMap.get("RescheduleNo").toString());
			cstmt.setString(8, DataMap.get("SecondMortgage").toString());
			
			cstmt.setString(9, DataMap.get("SecMortSanctionDate").toString());
			cstmt.setString(10, DataMap.get("SecMortSanctionAmount").toString());
			cstmt.setString(11, DataMap.get("SecMortBank").toString());
			cstmt.setString(12, DataMap.get("SecMortBankAddress1").toString());
			
			cstmt.setString(13, DataMap.get("Acquire").toString());
			cstmt.setString(14, DataMap.get("LoanCloseDate").toString());
			
			cstmt.setString(15, DataMap.get("LegalActive").toString());
			cstmt.setString(16, DataMap.get("LoanActive").toString());
			
			
			
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(17);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  Updating Employee Information!");
			} else
				ResultMap.put("SUCCESS", "Data Successfully Updated!");
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
}