package project.Utilities;

import java.util.HashMap;
import java.util.Map;

import project.Common.Infos.CommonInfo;

public class ReportUtilities {

	public static String GetReportPath(String ReportType, String branch_code) {
		
		String ReportPath = "";
		if (ReportType.equalsIgnoreCase("details_rpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Salary_Report_All.jasper";
		} else if (ReportType.equalsIgnoreCase("bank_adv_rpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Bank_Advice_All.jasper";
		} else if (ReportType.equalsIgnoreCase("indvidual_pay_slip")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Individual_Pay_Slip.jasper";
		} else if (ReportType.equalsIgnoreCase("summary_rpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Salary_Summary_Report.jasper";
		} else if (ReportType.equalsIgnoreCase("bonus_dtl_rpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Bonus_Report_All.jasper";

			if (branch_code.equalsIgnoreCase("9999") || branch_code.equalsIgnoreCase("9998")) {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "Bonus_Report_All.jasper";
			} else {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "Bonus_Report_Branch.jasper";
			}

		}
		else if (ReportType.equalsIgnoreCase("IncentiveDetails")) {
			if (branch_code.equalsIgnoreCase("9999") || branch_code.equalsIgnoreCase("9998")) {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "IncentiveReportHO.jasper";
			} else {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "IncentiveReportBranch.jasper";
			}
		}
		else if (ReportType.equalsIgnoreCase("IncentiveAdvice")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "IncentiveAdviceReport.jasper";
		}
		else if (ReportType.equalsIgnoreCase("TaxCertificate")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Tax_Certificate.jasper";
		}
		
		else if (ReportType.equalsIgnoreCase("_bonus_bank_adv_rpt")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Bank_Advice_Bonus.jasper";
		} else if (ReportType.equalsIgnoreCase("monthly_salary_summary")) {
			/* Monthly Summary Report*/
			if (branch_code.equalsIgnoreCase("NA")) {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "Salary_Summary_Report_All.jasper";
			} else {
				ReportPath = CommonInfo._REPORT_DIR_PRMS + "Salary_Summary_Report.jasper";
			}
			
		} else if (ReportType.equalsIgnoreCase("monthly_others_All")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Other_Allowance.jasper";
		} else if (ReportType.equalsIgnoreCase("monthly_others_Ded")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Other_Deduction.jasper";
		}
		else if (ReportType.equalsIgnoreCase("INC")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Deduction_report_incomeTax.jasper";
		} else if (ReportType.equalsIgnoreCase("WEL")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Deduction_report_welfare.jasper";
		} else if (ReportType.equalsIgnoreCase("ITR")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Salary_Statement_Tax.jasper";
		} 
		else if (ReportType.equalsIgnoreCase("PfReport")) {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "pf_statement_new.jasper";
		}
		
		else if(ReportType.equalsIgnoreCase("HO-PFA-PFC-PEN-WEL")) { 
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "DeductionByHO-PF_PEN_WEL.jasper";
		}
		else if(ReportType.equalsIgnoreCase("HO-HB_MOT_COM_GI")) { 
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "DeductionByHO-HB_MOT_COM_GI.jasper";
		}
		else if(ReportType.equalsIgnoreCase("HO-GAS_WAT_ELE")) { 
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "DeductionByHO-GAS_WAT_ELE.jasper";
		}
		else if(ReportType.equalsIgnoreCase("AllDeduction")) { 
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "AllDeduction.jasper";
		}
		else {
			ReportPath = CommonInfo._REPORT_DIR_PRMS + "Deduction_report.jasper";
		}
		
		return ReportPath;
	}
	
	public Map<String, Object> SetReportParameter(Map  RequestedParameter){
		Map<String, Object> ReportParameter = new HashMap<String, Object>();
		
		return ReportParameter;
	}
	
}
