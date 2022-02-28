package project.elms.Validator;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.lang.StringUtils;

import project.Utilities.DBUtils;


public class FinanceOperation {
	Map<String, String> ResultMap = new HashMap<String, String>();

	public FinanceOperation() {
		ResultMap.clear();
	}
	public Map<String, String> FetchEmpData(Map DataMap) {
		ResultMap.put("ERROR_MSG", "");
		DBUtils ob = new DBUtils();
		String sql = "SELECT EMP_NAME FROM prms_EMPLOYEE "
					+"WHERE EMP_ID = ?";
		Connection con = ob.GetConnection();
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			stmt.setString(1, DataMap.get("EmployeeId").toString());
			ResultSet rs = stmt.executeQuery();
			if (!rs.next()) {
				ResultMap.put("ERROR_MSG", "Employee not Found!");
			} else {
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
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	
	public Map<String, String> SaveLoanData(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {			
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_ELMS.SP_DISBURSE_LOAN(?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("EmployeeId").toString());
			cstmt.setString(3, DataMap.get("LoanType").toString());
			cstmt.setString(4, DataMap.get("DisbDate").toString()); //"14-may-2019");//"05/14/2019");//
			cstmt.setString(5, DataMap.get("DisbAmt").toString());
			cstmt.setString(6, DataMap.get("IntRate").toString());
			cstmt.setString(7, DataMap.get("EntdBy").toString());
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(8);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  SaveLoanData!\n" + error);
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
	
	public Map<String, String> SaveRealizationData(Map DataMap) {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {			
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_ELMS.SP_LOAN_REAL_BY_MANUAL(?,?,?,?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("EmployeeId").toString());
			cstmt.setString(3, DataMap.get("LoanType").toString());
			cstmt.setString(4, DataMap.get("RealType").toString()); 
			cstmt.setString(5, DataMap.get("DrCrType").toString());
			cstmt.setString(6, DataMap.get("VoucherType").toString());
			cstmt.setString(7, DataMap.get("RealDate").toString()); 
			cstmt.setString(8, DataMap.get("RealAmt").toString());		
			cstmt.setString(9, DataMap.get("EntdBy").toString());
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(10);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  SaveRealizationData!\n" + error);
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
