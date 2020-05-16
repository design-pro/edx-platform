<div class="form-field <%=type%>-<%= name %>">
    <% if ( type !== 'checkbox' ) { %>
        <label for="<%= form %>-<%= name %>">
            <%= label %>
            <% if ( required && requiredStr ) { %> <%= requiredStr %></label><% } %>
        </label>
    <% } %>

    <% if ( type === 'select' ) { %>
        <select id="<%= form %>-<%= name %>"
            name="<%= name %>"
            class="input-inline"
            aria-describedby="<%= form %>-<%= name %>-desc"
            <% if ( typeof errorMessages !== 'undefined' ) {
                _.each(errorMessages, function( msg, type ) {%>
                    data-errormsg-<%= type %>="<%= msg %>"
            <%  });
            } %>
            <% if ( required ) { %> aria-required="true" required<% } %>>
        <% _.each(options, function(el) { %>
            <option value="<%= el.value%>"<% if ( el.default ) { %> data-isdefault="true"<% } %>><%= el.name %></option>
        <% }); %>
        </select>
        <% if ( instructions ) { %> <span class="tip tip-input" id="<%= form %>-<%= name %>-desc"><%= instructions %></span><% } %>
    <% } else if ( type === 'textarea' ) { %>
        <textarea id="<%= form %>-<%= name %>"
            type="<%= type %>"
            name="<%= name %>"
            class="input-block"
            aria-describedby="<%= form %>-<%= name %>-desc"
            <% if ( restrictions.min_length ) { %> minlength="<%= restrictions.min_length %>"<% } %>
            <% if ( restrictions.max_length ) { %> maxlength="<%= restrictions.max_length %>"<% } %>
            <% if ( typeof errorMessages !== 'undefined' ) {
                _.each(errorMessages, function( msg, type ) {%>
                    data-errormsg-<%= type %>="<%= msg %>"
            <%  });
            } %>
            <% if ( required ) { %> aria-required="true" required<% } %> ></textarea>
            <% if ( instructions ) { %> <span class="tip tip-input" id="<%= form %>-<%= name %>-desc"><%= instructions %></span><% } %>
    <% } else { %>
        <input id="<%= form %>-<%= name %>"
           type="<%= type %>"
           name="<%= name %>"
           class="input-block <% if ( type === 'checkbox' ) { %>checkbox<% } %>"
            <% if ( type !== 'password' ) { %> aria-describedby="<%= form %>-<%= name %>-desc" <% } %>
            <% if ( restrictions.min_length ) { %> minlength="<%= restrictions.min_length %>"<% } %>
            <% if ( restrictions.max_length ) { %> maxlength="<%= restrictions.max_length %>"<% } %>
            <% if ( required ) { %> aria-required="true" required<% } %>
            <% if ( typeof errorMessages !== 'undefined' ) {
                _.each(errorMessages, function( msg, type ) {%>
                    data-errormsg-<%= type %>="<%= msg %>"
            <%  });
            } %>
            <% if ( placeholder ) { %> placeholder="<%= placeholder %>"<% } %>
            value="<%- defaultValue %>"
        />
        <% if ( type === 'checkbox' ) { %>
            <label for="<%= form %>-<%= name %>">
                <%= label %>
                <% if ( required && requiredStr ) { %> <%= requiredStr %><% } %>
            </label>
        <% } %>
        <% if ( instructions ) { %> <span class="tip tip-input" id="<%= form %>-<%= name %>-desc"><%= instructions %></span><% } %>
    <% } %>

    <% if( form === 'login' && name === 'password' ) { %>
        <a href="#" class="forgot-password field-link"><%- gettext("Forgot password?") %></a>
    <% } %>
</div>

        </script>
        <script type="text/template" id="login-tpl">
            <div class="status already-authenticated-msg hidden">
    <% if (context.currentProvider) { %>
        <p class="message-copy">
            <%- _.sprintf( gettext("You have successfully signed into %(currentProvider)s, but your %(currentProvider)s account does not have a linked %(platformName)s account. To link your accounts, sign in now using your %(platformName)s password."), context ) %>
        </p>
    <% } %>
</div>

<div class="js-reset-success status submission-success hidden">
    <h4 class="message-title"><%- gettext("Password Reset Email Sent") %></h4>
    <div class="message-copy">
        <p>
            <%- gettext("We've sent instructions for resetting your password to the email address you provided.") %>
        </p>
    </div>
</div>

<div class="status submission-error hidden" aria-live="polite">
    <h4 class="message-title"><%- gettext("We couldn't sign you in.") %></h4>
    <ul class="message-copy"></ul>
</div>

<% if (context.errorMessage) { %>
    <div class="status submission-error">
        <h4 class="message-title"><%- _.sprintf( gettext("An error occurred when signing you in to %(platformName)s."), context ) %></h4>
        <ul class="message-copy"><%- context.errorMessage %></ul>
    </div>
<% } %>

<form id="login" class="login-form" tabindex="-1">

    <div class="section-title lines">
        <h2>
            <span class="text"><%- gettext("Sign in") %></span>
        </h2>
    </div>

    <p class="sr">
        <% if ( context.providers.length > 0 && !context.currentProvider || context.hasSecondaryProviders ) { %>
            <%- gettext("Sign in here using your email address and password, or use one of the providers listed below.") %>
        <% } else { %>
            <%- gettext("Sign in here using your email address and password.") %>
        <% } %>
        <%- gettext("If you do not yet have an account, use the button below to register.") %>
    </p>

    <%= context.fields %>

    <button type="submit" class="action action-primary action-update js-login login-button"><%- gettext("Sign in") %></button>

    <% if ( context.providers.length > 0 && !context.currentProvider || context.hasSecondaryProviders ) { %>
    <div class="login-providers">
        <div class="section-title lines">
            <h2>
                <span class="text"><%- gettext("or sign in with") %></span>
            </h2>
        </div>

        <% _.each( context.providers, function( provider ) {
            if ( provider.loginUrl ) { %>
                <button type="button" class="button button-primary button-<%- provider.id %> login-provider login-<%- provider.id %>" data-provider-url="<%- provider.loginUrl %>">
                    <div class="icon fa <%- provider.iconClass %>" aria-hidden="true"></div>
                    <span aria-hidden="true"><%- provider.name %></span>
                    <span class="sr"><%- _.sprintf( gettext("Sign in with %(providerName)s"), {providerName: provider.name} ) %></span>
                </button>
            <% }
        }); %>

        <% if ( context.hasSecondaryProviders ) { %>
            <button type="button" class="button-secondary-login form-toggle" data-type="institution_login">
                <%- gettext("Use my institution/campus credentials") %>
            </button>
        <% } %>
    </div>
    <% } %>
</form>

<div class="toggle-form">
    <div class="section-title">
        <h2>
            <span class="text"><%- _.sprintf( gettext("New to %(platformName)s?"), context ) %></span>
        </h2>
    </div>
    <button class="nav-btn form-toggle" data-type="register"><%- gettext("Create an account") %></button>
</div>