/***************************************************************
* Payroll Management System for BHBFC						   *
* @author   Md. Rubel Talukder & Mosharraf Hossain Talukder	   *
* @division ICT Operation									   *
* @version  1.0												   *
* @date     Feb 10, 2019 									   *
****************************************************************/

package project.Delegators;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

public class CommonFacade {
	public static Map<String, String>  SessionFacade(Map map) {
		Map<String, String> MapObj = new HashMap<String, String>();
		String method = map.get("Method").toString();
		String className = map.get("Class").toString();
		try {						
			Class classDefinition = Class.forName("project.validators."+className);
	        Object  object = classDefinition.newInstance();	        
		    Method m = object.getClass().getDeclaredMethod(method, Map.class);
		    MapObj = (Map) m.invoke(object, map);			
			m.setAccessible(true);												       
		} 
		catch (Exception e) {
			e.printStackTrace();
			MapObj.put("ERROR_MSG", "Error in SessionFacade");
		}
		
		return MapObj;
	}
}
