package project.elms.Validator;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import project.Utilities.DBUtils;



public class SuperValidation {
	Map<String, String> ResultMap = new HashMap<String, String>();
	public SuperValidation() {				
		ResultMap.clear();
	}
	public Map<String, String> RealizationProcess(Map DataMap) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_ELMS.SP_LOAN_REAL_FROM_SALARY(?,?,?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("Year").toString());
			cstmt.setString(3, DataMap.get("MonthCode").toString());
			cstmt.setString(4, DataMap.get("LoanType").toString());
			cstmt.setString(5, DataMap.get("RealDate").toString());
			cstmt.setString(6, DataMap.get("EntdBy").toString());
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(7);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  RealizationProcess!");
			} else
				ResultMap.put("SUCCESS", "Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
	public Map<String, String> AccrualProcess(Map DataMap)  {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		ResultMap.put("ERROR_MSG", "");
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL PKG_ELMS.SP_ACCRUAL_PROCESS(?,?,?,?,?)");
			cstmt.setInt(1, 1);
			cstmt.setString(2, DataMap.get("Year").toString());
			cstmt.setString(3, DataMap.get("MonthCode").toString());
			cstmt.setString(4, DataMap.get("LoanType").toString());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.execute();
			String error = cstmt.getString(5);
			if (error != null) {
				ResultMap.put("ERROR_MSG", "Error in  AccrualProcess!");
			} else
				ResultMap.put("SUCCESS", "Process Successfully Completed!");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return ResultMap;
	}
}
