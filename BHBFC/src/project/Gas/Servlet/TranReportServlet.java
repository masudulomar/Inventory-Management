package project.Gas.Servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
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
import project.validators.PRMSValidator;

/**
 * Servlet implementation class TranReportServlet
 */
@WebServlet("/TranReportServlet")
public class TranReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection con = null;

	public TranReportServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		DBUtils dbUtils = new DBUtils();
		Map<String, Object> parameter = new HashMap<String, Object>();
		String LoggedBranch = request.getParameter("loggedBranch");
		String BranchCode = request.getParameter("BranchCode");
		String ReportType = request.getParameter("ReportType");
		String report_path = GetReportPath(ReportType);
		String ProjectPath = ProjectUtils.GetProjectPath();
		Map<String, String> brn_info = new HashMap<String, String>();
		if (BranchCode.equals("0")) {
			brn_info.put("branch_code", LoggedBranch);
		} else {
			brn_info.put("branch_code", BranchCode);
		}
		PRMSValidator branValidator = new PRMSValidator();
		try {
			brn_info = branValidator.BranchKeyPress(brn_info);
			parameter.put("BRANCH_NAME", brn_info.get("BRN_NAME"));
			parameter.put("BRANCH_ADDRESS", brn_info.get("BRN_ADDRESS"));
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		parameter.put("LOGO_PATH", ProjectPath + CommonInfo._LOGO_PATH);
		parameter.put("M_LOGO", ProjectPath + CommonInfo._LOGO_PATH_2);
		parameter.put("SUBREPORT_DIR", ProjectPath + CommonInfo._REPORT_DIR_GA);
		parameter.put("P_BRANCH", request.getParameter("BranchCode"));
		parameter.put("P_Trandate", request.getParameter("TransactionDate"));

		if (ReportType.equals("ViewItemAutoVoucher")) {

			parameter.put("p_itemCode", request.getParameter("itemCode"));
			parameter.put("p_TransactionAmount", request.getParameter("TransactionAmount"));
			parameter.put("p_Remarks", request.getParameter("Remarks"));
		} else if (ReportType.equals("SingleBatch")) {
			parameter.put("p_batch", request.getParameter("BatchNumber"));
		} else if (ReportType.equals("printbulkBatch")) {
			parameter.put("P_ToDate", request.getParameter("ToDate"));
			parameter.put("P_FromDate", request.getParameter("fromdate"));
		}

		else if (ReportType.equals("cashbookDetails") || ReportType.equals("cashbookSummary")) {
			parameter.put("p_batch", request.getParameter("BatchNumber"));
			parameter.put("P_FromDate", request.getParameter("FromDate"));
			parameter.put("P_ToDate", request.getParameter("ToDate"));
		} else if (ReportType.equals("SubSidiaryLedger")) {
			parameter.put("P_GLCode", request.getParameter("glcode").trim());

		} else if (ReportType.equals("GLStatement")) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
			parameter.put("P_GLCode", request.getParameter("glcode").trim());

		} else if (ReportType.equals("InterBranchReconciliation")) {
			parameter.put("P_GLCode", request.getParameter("glcode").trim());
			parameter.put("P_FromDate", request.getParameter("FromDate"));
			parameter.put("P_ToDate", request.getParameter("ToDate"));
		}

		else if (ReportType.equals("TrailBalanceFinal") || ReportType.equals("ProfiteLossStmtFinal")
				|| ReportType.equals("BalanceSheetStmtFinal") || ReportType.equals("ConsolidateProfiteLossStmtFinal")
				|| ReportType.equals("ConsolidateTrailBalanceFinal")
				|| ReportType.equals("ConsolidateBalanceSheetStmtFinal")) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
			parameter.put("p_adjust_type", request.getParameter("AdjustType"));
		} else if (ReportType.equals("SubSidiaryLedgerFinal")) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
			parameter.put("p_adjust_type", request.getParameter("AdjustType"));
			parameter.put("P_GLCode", request.getParameter("glcode").trim());
		} else if (ReportType.equals("ConsolidatedTBIndividual") || ReportType.equals("ConsolidatedTBSummary")
				|| ReportType.equals("ConsolidatedIncome") || ReportType.equals("ConsolidatedExpenditure")
				|| ReportType.equals("ConsolidatedCapitalExpenditure") || ReportType.equals("ProfiteLossStmt")
				|| ReportType.equals("BalanceSheetStmt") || ReportType.equals("TrailBalanceCurrent")
				|| ReportType.equals("ConsolidatedProfitAndLoss")
				|| ReportType.equals("ConsolidatedBalanceSheet")
				) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());

		} else if (ReportType.equals("BranchWiseMatrixReport")) {
			if (BranchCode.equalsIgnoreCase("0")) {
				parameter.put("P_BRANCH", "%");
			}

		} else if (ReportType.equals("VoucherEntryDashboard")) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
		}

		else if (ReportType.equals("IndividualIncome") || ReportType.equals("IndividualExpenditure")) {
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
			if (ReportType.equals("IndividualIncome")) {
				parameter.put("p_glcode_prefix", "160");
			} else if (ReportType.equals("IndividualExpenditure")) {
				parameter.put("p_glcode_prefix", "171");
			}
		} else if (ReportType.equals("BranchAndProductWiseRecovery")
				|| ReportType.equals("BranchAndProductWiseRecoverable") || ReportType.equals("BranchWiseRecovery")
				|| ReportType.equals("BranchWiseRecoverable")) {
			if (BranchCode.equalsIgnoreCase("0")) {
				parameter.put("P_BRANCH", "%");
			}
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
		}
		else if (ReportType.equals("rBranchWiseGLBalance")) {
			parameter.put("P_GLCode", request.getParameter("glcode").trim());
			parameter.put("p_adjust_type", request.getParameter("AdjustType"));
			parameter.put("P_fin_year", request.getParameter("FinYear").trim());
		}
		

		try {
			File file = new File(ProjectPath + report_path);
			con = dbUtils.GetConnection();
			byte[] bytes = JasperRunManager.runReportToPdf(file.getCanonicalPath(), parameter, con);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			ServletOutputStream outputStream = response.getOutputStream();
			outputStream.write(bytes, 0, bytes.length);
			outputStream.flush();
			outputStream.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	private String GetReportPath(String reportType) {
		String ReportPath = "";
		if (reportType.equalsIgnoreCase("cashbookDetails")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "CashBookDetails.jasper";
		} else if (reportType.equalsIgnoreCase("cashbookSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "CashbookSummary.jasper";
		} else if (reportType.equalsIgnoreCase("ViewAutoVoucher")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "viewAutoVoucher.jasper";
		} else if (reportType.equalsIgnoreCase("ViewGLList")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "GLcodelistBygroup.jasper";
		} else if (reportType.equalsIgnoreCase("ViewAccountsList")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "GLAccountListBranch.jasper";
		} else if (reportType.equalsIgnoreCase("ViewGLBalance")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "GLBanance.jasper";
		} else if (reportType.equalsIgnoreCase("ViewItemAutoVoucher")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "viewItemAutoVoucher.jasper";
		} else if (reportType.equalsIgnoreCase("TrailBalanceFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "TrailBalanceSheetFinal.jasper";
		} else if (reportType.equalsIgnoreCase("ProfiteLossStmtFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_profitAndLossAccount_final.jasper";
		} else if (reportType.equalsIgnoreCase("BalanceSheetStmtFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_balancesheet_final.jasper";
		}

		else if (reportType.equalsIgnoreCase("TrailBalanceCurrent")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "TrailBalanceSheetCurrent.jasper";
		} else if (reportType.equals("ConsolidatedTBIndividual")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ConsolidatedTBIndividual.jasper";
		}else if (reportType.equals("ConsolidatedBalanceSheet")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_Consolidated_balancesheet.jasper";
		}else if (reportType.equals("ConsolidatedProfitAndLoss")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_Consolidated_profitAndLossAccount.jasper";
		}

		else if (reportType.equals("ConsolidateProfiteLossStmtFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "Consolidated_profitAndLossAccount_final.jasper";
		} else if (reportType.equals("ConsolidateTrailBalanceFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "Consolidated_TrailBalanceSheetFinal.jasper";
		} else if (reportType.equals("ConsolidateBalanceSheetStmtFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "Consolidated_balancesheet_final.jasper";
		}

		else if (reportType.equals("ConsolidatedTBSummary")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ConsolidatedTBSummary.jasper";
		} else if (reportType.equals("ConsolidatedIncome")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ConsolidatedIncome.jasper";
		} else if (reportType.equals("ConsolidatedExpenditure")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ConsolidatedExpenditure.jasper";
		} else if (reportType.equals("ConsolidatedCapitalExpenditure")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "ConsolidatedCapitalExpenditure.jasper";
		} else if (reportType.equalsIgnoreCase("BranchWiseMatrixReport")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "BranchWiseMatrixReport.jasper";
		} else if (reportType.equals("IndividualIncome") || reportType.equals("IndividualExpenditure")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "IncomeExpenditueIndividual.jasper";
		} else if (reportType.equalsIgnoreCase("SubSidiaryLedger")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "SubSidiaryLedger.jasper";
		} else if (reportType.equalsIgnoreCase("SubSidiaryLedgerFinal")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "SubSidiaryLedgerFinal.jasper";
		} else if (reportType.equalsIgnoreCase("GLStatement")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "GLStatement.jasper";
		} else if (reportType.equalsIgnoreCase("InterBranchReconciliation")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "InterBranchReconcilationReport.jasper";
		} else if (reportType.equalsIgnoreCase("printbulkBatch")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "DayWiseBatchPrint.jasper";
		} else if (reportType.equalsIgnoreCase("ProfiteLossStmt")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_profitAndLossAccount.jasper";
		} else if (reportType.equalsIgnoreCase("BalanceSheetStmt")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_balancesheet.jasper";
		}
		else if (reportType.equalsIgnoreCase("rBranchWiseGLBalance")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "as_branchWiseGLBalance.jasper";
		}
		
		else if (reportType.equals("BranchAndProductWiseRecovery")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "BranchAndProductWiseRecoverydetails.jasper";
		} else if (reportType.equals("BranchAndProductWiseRecoverable")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "BranchAndProductWiseRecoverableDetails.jasper";
		} else if (reportType.equals("BranchWiseRecovery")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "BranchWiseRecoveryDetails.jasper";
		} else if (reportType.equals("BranchWiseRecoverable")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "BranchWiseRecoverableDetails.jasper";
		} else if (reportType.equals("VoucherEntryDashboard")) {
			ReportPath = CommonInfo._REPORT_DIR_GA + "VoucherDashboard.jasper";
		} else {
			ReportPath = CommonInfo._REPORT_DIR_GA + "PrintTransactionBatchNumber.jasper";
		}
		return ReportPath;
	}

}
