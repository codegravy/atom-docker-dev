DockerDevAtomView = require './docker-dev-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = DockerDevAtom =
  dockerDevAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @dockerDevAtomView = new DockerDevAtomView(state.dockerDevAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @dockerDevAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'docker-dev-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @dockerDevAtomView.destroy()

  serialize: ->
    dockerDevAtomViewState: @dockerDevAtomView.serialize()

  toggle: ->
    console.log 'DockerDevAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
