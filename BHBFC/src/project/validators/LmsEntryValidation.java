
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

import project.Utilities.ApplicationLog;
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
			ApplicationLog.LMSLoging(DataMap,"Installment");
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_LMS_ENTRY.sp_memo_insert_update(?,?,?, ?,?,?, ?,?,?, ?,?)");
			cstmt.setString(1, DataMap.get("BankCode").toString());
			cstmt.setString(2, DataMap.get("LoanCode").toString());
			cstmt.setString(3, DataMap.get("OfficeCode").toString());
			cstmt.setString(4, DataMap.get("MemoNo").toString());
			cstmt.setString(5, DataMap.get("PayDate").toString());
			cstmt.setString(6, DataMap.get("PayAmount").toString());
			cstmt.setString(7, DataMap.get("Purpose").toString());
			cstmt.setString(8, DataMap.get("User_Id").toString());
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
			ApplicationLog.LMSLoging(DataMap,"Disburse");
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
			cstmt.setString(9, DataMap.get("User_Id").toString());
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

}