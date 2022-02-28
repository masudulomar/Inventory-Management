package project.Utilities;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

import com.google.gson.Gson;

public class ApplicationLog {
	public static void LMSLoging(Map DataMap,String EntryPgm) {
		DBUtils ob = new DBUtils();
		Connection con = null;		
		String Query="insert into  lms_log (loc_code, loan_code, entry_time, data_map, entry_user,entry_pgm)values(?,?,sysdate,?,?,?)";		
		PreparedStatement stmt = null;
		try {
			con = ob.GetConnection();
			stmt = con.prepareStatement(Query);
			stmt.setString(1, DataMap.get("OfficeCode").toString());
			stmt.setString(2, DataMap.get("LoanCode").toString());
			stmt.setString(3, DataMap.toString());
			stmt.setString(4, DataMap.get("User_Id").toString());
			stmt.setString(5, EntryPgm);			
			stmt.executeUpdate();

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
	}
	public static void SBLAPITracer(String ReqType,Map DataMap,String ErrorMessage) throws Exception {
		DBUtils ob = new DBUtils();
		Connection con = null;
		CallableStatement cstmt = null;
		try {
			con = ob.GetConnection();
			cstmt = con.prepareCall("CALL pkg_param.sp_application_log(?,?,?,?)");			
			cstmt.setString(1, ReqType);
			cstmt.setString(2, new Gson().toJson(DataMap));
			cstmt.setString(3, ErrorMessage);
			cstmt.setString(4, "");			
			cstmt.execute();
		} finally {
			try {
				con.close();
				cstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}		
	}
}
