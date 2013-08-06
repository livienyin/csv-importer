<g:formRemote name="createForm" url="[controller: 'contact', action: 'ajaxSave']" update="main-content">
    <fieldset class="form">
        <g:render template="form"/>
    </fieldset>
    <fieldset class="buttons">
        <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
    </fieldset>
</g:formRemote>