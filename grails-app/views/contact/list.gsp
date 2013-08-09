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
        <div class="container">

		<div id="list-contact" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>

            <a id="ajax-create" href="#"><h3>Enter New Contact</h3></a>


            <g:uploadForm action="csvUpload" enctype="multipart/form-data">
                <input type="file" id="fileUploadInput" name="file">
                <input class="button" type="submit" value="Upload CSV">
            </g:uploadForm>

            <table class="contacts-table">
				<thead>
					<tr>

						<g:sortableColumn property="firstName" title="${message(code: 'contact.firstName.label', default: 'First Name')}" />
					
						<g:sortableColumn property="lastName" title="${message(code: 'contact.lastName.label', default: 'Last Name')}" />

                        <g:sortableColumn property="company" title="${message(code: 'contact.company.label', default: 'Company')}" />

                        <g:sortableColumn property="title" title="${message(code: 'contact.title.label', default: 'Title')}" />

                        <g:sortableColumn property="email" title="${message(code: 'contact.email.label', default: 'Email')}" />

						<g:sortableColumn property="phone" title="${message(code: 'contact.phone.label', default: 'Phone')}" />

                        <th>Edit</th>

                        <th>Delete</th>

					</tr>
				</thead>
				<tbody>
				<g:each in="${contactInstanceList}" status="i" var="contactInstance">
					<tr id="contact-${contactInstance.id}" class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><strong>${fieldValue(bean: contactInstance, field: "firstName")}</strong></td>
					
						<td><strong>${fieldValue(bean: contactInstance, field: "lastName")}</strong></td>

                        <td>${fieldValue(bean: contactInstance, field: "company")}</td>

                        <td>${fieldValue(bean: contactInstance, field: "title")}</td>

                        <td><g:link action="show" id="${contactInstance.id}">${fieldValue(bean: contactInstance, field: "email")}</g:link></td>
					
						<td>${fieldValue(bean: contactInstance, field: "phone")}</td>

                        <td><g:link elementId="ajax-edit" action="editModal" id="${contactInstance.id}"><img src="../images/skin/database_edit.png"></g:link></td>

                        <td><g:remoteLink action="ajaxDelete" params="${[id:contactInstance.id]}" update="main-content"><img src="../images/skin/database_delete.png"></g:remoteLink></td>

					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${contactInstanceTotal}" />
			</div>
		</div>
        </div>
        <g:javascript src="modal.js"/>
    </body>
</html>
