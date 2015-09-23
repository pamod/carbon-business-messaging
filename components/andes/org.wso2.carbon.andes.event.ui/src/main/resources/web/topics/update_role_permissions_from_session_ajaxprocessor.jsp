<%@ page import="org.apache.axis2.client.Options" %>
<%@ page import="org.apache.axis2.client.ServiceClient" %>
<%@ page import="org.apache.axis2.context.ConfigurationContext" %>
<%@ page import="org.wso2.carbon.CarbonConstants" %>
<%@ page import="org.wso2.carbon.andes.event.stub.core.TopicRolePermission" %>
<%@ page import="org.wso2.carbon.andes.event.stub.service.AndesEventAdminServiceStub" %>
<%@ page import="org.wso2.carbon.ui.CarbonUIUtil" %>
<%@ page import="java.util.ArrayList" %>
<%
    ConfigurationContext configContext = (ConfigurationContext) config.getServletContext()
            .getAttribute(CarbonConstants.CONFIGURATION_CONTEXT);
    //Server URL which is defined in the server.xml
    String serverURL = CarbonUIUtil.getServerURL(config.getServletContext(),
            session) + "AndesEventAdminService.AndesEventAdminServiceHttpsSoap12Endpoint";
    AndesEventAdminServiceStub stub = new AndesEventAdminServiceStub(configContext, serverURL);

    String cookie = (String) session.getAttribute(org.wso2.carbon.utils.ServerConstants.ADMIN_SERVICE_COOKIE);

    ServiceClient client = stub._getServiceClient();
    Options option = client.getOptions();
    option.setManageSession(true);
    option.setProperty(org.apache.axis2.transport.http.HTTPConstants.COOKIE_STRING, cookie);
    String message = "";

    String topic = (String) session.getAttribute("topic");
    ArrayList<TopicRolePermission> topicRolePermissionArrayList = (ArrayList<TopicRolePermission>) session.getAttribute("topicRolePermissions");
    TopicRolePermission[] topicRolePermissions = new TopicRolePermission[topicRolePermissionArrayList.size()];

    try {
        stub.updatePermission(topic, topicRolePermissionArrayList.toArray(topicRolePermissions));
        message = "Topic added successfully";
    } catch (Exception e) {
        message = "Error in adding/updating permissions : " + e.getMessage();
    }

    session.removeAttribute("topicRolePermissions");
%><%=message%>
