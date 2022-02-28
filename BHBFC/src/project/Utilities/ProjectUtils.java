/***************************************************************

* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/

package project.Utilities;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;
import java.util.StringTokenizer;


import com.google.gson.Gson;


public class ProjectUtils {	
	
	
public static LinkedList TransactionSplite(String TransactionStream) {
	LinkedList<Map> transactionclause = new LinkedList<Map>();
	String[] sentance = TransactionStream.split("<sentance>"); 
    for (String clause : sentance) {
    	String[] clauseString = clause.split("<clause>");     	
    	Map<String, String> map = new HashMap<String, String>();   	
    	for (String cell : clauseString) {
    		String[] cellString = cell.split("<cell>");     		
    		try {
    			map.put(cellString[0], cellString[1]); 
    		}    		 
    		catch(Exception e) {
    			map.put(cellString[0], ""); 
    		}
       }
    	transactionclause.add(map);  	
    }        
    return transactionclause;
}

	public static LinkedList TransactionTokenizer(String TransactionStream) {
		
		LinkedList<Map> transactionclause = new LinkedList<Map>();
		try {
			StringTokenizer trantoken = new StringTokenizer(TransactionStream, "@");

			while (trantoken.hasMoreTokens()) {
				String actualElement = trantoken.nextToken();
				StringTokenizer columntoken = new StringTokenizer(actualElement, "*");
				Map<String, String> map = new HashMap<String, String>();

				while (columntoken.hasMoreElements()) {
					String acttoken = columntoken.nextToken();
					StringTokenizer atttok = new StringTokenizer(acttoken, "=");
					if (atttok.countTokens() != 2) {
						throw new RuntimeException("Unexpeced format");
					}
					String key = atttok.nextToken();
					String value = atttok.nextToken();
					map.put(key, value);
				}
				// System.out.println(map);
				transactionclause.add(map);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage().toString());
		}

		return transactionclause;
	}
	
	public static Map  DataTokenizer(String DataStream)
    {
		Map<String, String> map = new HashMap<String, String>();
		map.put("Error", "NA");
		try {
			
			StringTokenizer st = new StringTokenizer(DataStream, "$");
	    	
	    	while ( st.hasMoreElements() ) {

	    	    String actualElement = st.nextToken();
	    	    StringTokenizer et = new StringTokenizer(actualElement, "*");
	    	    if ( et.countTokens() != 2 ) {
	    	        throw new RuntimeException("Unexpeced format");
	    	    }
	    	    String key = et.nextToken();
	    	    String value = et.nextToken();
	    	    map.put(key, value);
	    	}
			
			
		}catch (Exception e) {
			map.put("Error", "Unexpected Format");
		}
    	
    	return map;
    }  
	
	public static Map  OrderTokenizer(String DataStream)
    {
		Map<String, String> map = new HashMap<String, String>();
		map.put("Error", "NA");
		try {
			
			StringTokenizer st = new StringTokenizer(DataStream, "@");
	    	
	    	while ( st.hasMoreElements() ) {

	    	    String actualElement = st.nextToken();
	    	    StringTokenizer et = new StringTokenizer(actualElement, ",");
	    	    if ( et.countTokens() != 2 ) {
	    	        throw new RuntimeException("Unexpeced format");
	    	    }
	    	    String key = et.nextToken();
	    	    String value = et.nextToken();
	    	    map.put(key, value);
	    	}
			
			
		}catch (Exception e) {
			map.put("Error", "Unexpected Format");
		}
    	
    	return map;
    }  
	
	public static Map JasonStringToHashMap (String jasonString) throws Exception {		
		Gson gson = new Gson();
		Map map = gson.fromJson(jasonString, Map.class);
		//System.out.println(map);
		return map;
	}
	public static Map  SubStringTokenizer(String DataStream)
    {
    	StringTokenizer st = new StringTokenizer(DataStream, "!");
    	Map<String, String> map = new HashMap<String, String>();
    	while ( st.hasMoreElements() ) {

    	    String actualElement = st.nextToken();
    	    StringTokenizer et = new StringTokenizer(actualElement, ":");
    	    if ( et.countTokens() != 2 ) {
    	        throw new RuntimeException("Unexpeced format");
    	    }
    	    String key = et.nextToken();
    	    String value = et.nextToken();
    	    map.put(key, value);
    	}
    	return map;
    }  
	
	public static String GetProjectPath() {
		String ReportPath = null;
		DBUtils ob = new DBUtils();
		String sql = " select ID,NAME,REPORTPATH,IPADDRESS from oms_properties a where a.id='101' ";
		Connection con = ob.GetConnection();
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			stmt = con.prepareStatement(sql);
			rs = stmt.executeQuery();
			if (rs.next()) {
				ReportPath = rs.getString("REPORTPATH");
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
		return ReportPath;
	}
}
