MultiIndentView = require './multi-indent-view'
{CompositeDisposable} = require 'atom'

module.exports = MultiIndent =
  multiIndentView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @multiIndentView = new MultiIndentView(state.multiIndentViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @multiIndentView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'multi-indent:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @multiIndentView.destroy()

  serialize: ->
    multiIndentViewState: @multiIndentView.serialize()

  toggle: ->
    console.log 'MultiIndent was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
