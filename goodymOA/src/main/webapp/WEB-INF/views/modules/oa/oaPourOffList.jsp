<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>倒休记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/oa/oaPourOff/">倒休记录列表</a></li>
		<shiro:hasPermission name="oa:oaPourOff:edit"><li><a href="${ctx}/oa/oaPourOff/form">倒休记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="oaPourOff" action="${ctx}/oa/oaPourOff/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="trueName" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>所属部门：</label>
				<sys:treeselect id="office" name="office.id" value="${oaPourOff.office.id}" labelName="office.name" labelValue="${oaPourOff.office.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>倒休类型：</label>
				<form:select path="pourType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>是否有效：</label>
				<form:select path="pourStatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>所属部门</th>
				<th>倒休类型</th>
				<th>发生日期</th>
				<th>小时数</th>
				<th>是否有效</th>
				<th>失效原因</th>
				<th>备注</th>
				<shiro:hasPermission name="oa:oaPourOff:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="oaPourOff">
			<tr>
				<td><a href="${ctx}/oa/oaPourOff/form?id=${oaPourOff.id}">
					${oaPourOff.trueName}
				</a></td>
				<td>
					${oaPourOff.office.name}
				</td>
				<td>
					${fns:getDictLabel(oaPourOff.pourType, '', '')}
				</td>
				<td>
					<fmt:formatDate value="${oaPourOff.pourDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${oaPourOff.hourTotal}
				</td>
				<td>
					${fns:getDictLabel(oaPourOff.pourStatus, '', '')}
				</td>
				<td>
					${oaPourOff.reason}
				</td>
				<td>
					${oaPourOff.remarks}
				</td>
				<shiro:hasPermission name="oa:oaPourOff:edit"><td>
    				<a href="${ctx}/oa/oaPourOff/form?id=${oaPourOff.id}">修改</a>
					<a href="${ctx}/oa/oaPourOff/delete?id=${oaPourOff.id}" onclick="return confirmx('确认要删除该倒休记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>