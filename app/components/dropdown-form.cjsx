React = require 'react'
ModalForm = require 'modal-form'

module.exports = React.createClass
  displayName: 'DropdownFormButton'

  getDefaultProps: ->
    tag: 'button'
    label: '···'
    required: false
    onClick: Function.prototype
    onSubmit: Function.prototype
    onCancel: Function.prototype

  getInitialState: ->
    root: null

  componentWillUnmount: ->
    @close()

  open: ->
    root = document.createElement 'div'
    root.classList.add 'dropdown-form-root'
    root.classList.add @props.className
    document.body.appendChild root

    @setState {root}

    React.render <ModalForm className={@props.className} anchor={@getDOMNode()} required={@props.required} style={@props.style} onSubmit={@handleSubmit} onCancel={@handleCancel}>
      {@props.children}
    </ModalForm>, root

  close: ->
    @getDOMNode().focus()
    if @state.root?
      React.unmountComponentAtNode @state.root
      @state.root.parentNode.removeChild @state.root
      @setState root: null

  render: ->
    React.createElement @props.tag,
      className: "dropdown-form-button"
      onClick: @handleClick
      'data-is-open': @state.root? || null
      @props.label

  handleClick: ->
    @open()
    @props.onClick arguments...

  handleSubmit: ->
    @close()
    @props.onSubmit arguments...

  handleCancel: ->
    @close()
    @props.onCancel arguments...
