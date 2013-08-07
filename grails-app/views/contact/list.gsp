<%@ page import="csv.app.Contact" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'modal.css')}" type="text/css">
		<g:set var="entityName" value="${message(code: 'contact.label', default: 'Contact')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
        <g:javascript library="jquery" />
	</head>
	<body>
		<a href="#list-contact" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><a id="ajax-create" href="#">Ajax Create</a></li>

                <g:uploadForm action="csvUpload" enctype="multipart/form-data">
                    <li><input type="file" name="file"></li>
                    <li><input type="submit" value="Upload CSV"></li>
                </g:uploadForm>
			</ul>
		</div>

		<div id="list-contact" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <table>
				<thead>
					<tr>
					
						<g:sortableColumn property="email" title="${message(code: 'contact.email.label', default: 'Email')}" />
					
						<g:sortableColumn property="firstName" title="${message(code: 'contact.firstName.label', default: 'First Name')}" />
					
						<g:sortableColumn property="lastName" title="${message(code: 'contact.lastName.label', default: 'Last Name')}" />
					
						<g:sortableColumn property="prefix" title="${message(code: 'contact.prefix.label', default: 'Prefix')}" />
					
						<g:sortableColumn property="phone" title="${message(code: 'contact.phone.label', default: 'Phone')}" />
					
						<g:sortableColumn property="fax" title="${message(code: 'contact.fax.label', default: 'Fax')}" />

                        <g:sortableColumn property="company" title="${message(code: 'contact.company.label', default: 'Company')}" />

                        <g:sortableColumn property="title" title="${message(code: 'contact.title.label', default: 'Title')}" />

                        <th>Edit</th>

                        <th>Delete</th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${contactInstanceList}" status="i" var="contactInstance">
					<tr id="contact-${contactInstance.id}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${contactInstance.id}">${fieldValue(bean: contactInstance, field: "email")}</g:link></td>
					
						<td>${fieldValue(bean: contactInstance, field: "firstName")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "lastName")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "prefix")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "phone")}</td>
					
						<td>${fieldValue(bean: contactInstance, field: "fax")}</td>

                        <td>${fieldValue(bean: contactInstance, field: "company")}</td>

                        <td>${fieldValue(bean: contactInstance, field: "title")}</td>

                        <td><g:link elementId="ajax-edit" action="editModal" id="${contactInstance.id}">edit</g:link></td>

                        <td><g:remoteLink action="ajaxDelete" params="${[id:contactInstance.id]}" update="main-content">delete</g:remoteLink></td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${contactInstanceTotal}" />
			</div>
		</div>
        <g:javascript src="modal.js"/>
    </body>
</html>
