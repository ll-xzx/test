LlTestView = require './ll-test-view'
{CompositeDisposable} = require 'atom'

module.exports = LlTest =
  llTestView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @llTestView = new LlTestView(state.llTestViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @llTestView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'll-test:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @llTestView.destroy()

  serialize: ->
    llTestViewState: @llTestView.serialize()

  toggle: ->
    console.log 'LlTest was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
