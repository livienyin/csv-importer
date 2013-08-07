<div id="edit-contact" class="content scaffold-edit" role="main">
    <h1>Edit ${contactInstance.firstName} ${contactInstance.lastName}</h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${contactInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${contactInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:formRemote name="updateForm" url="[controller: 'contact', action: 'ajaxUpdate']" update="main-content" >
        <g:hiddenField name="id" value="${contactInstance?.id}" />
        <g:hiddenField name="version" value="${contactInstance?.version}" />
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="ajaxUpdate" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </fieldset>
    </g:formRemote>
</div>