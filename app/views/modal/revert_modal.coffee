ModalView = require 'views/kinds/ModalView'
template = require 'templates/modal/revert'
CocoModel = require 'models/CocoModel'

module.exports = class RevertModal extends ModalView
  id: 'revert-modal'
  template: template
  
  events:
    'click #changed-models button': 'onRevertModel'
    
  onRevertModel: (e) ->
    id = $(e.target).val()
    CocoModel.backedUp[id].revert()
    $(e.target).closest('tr').remove()
    @reloadOnClose = true
  
  getRenderData: ->
    c = super()
    models = _.values CocoModel.backedUp
    models = (m for m in models when m.hasLocalChanges())
    c.models = models
    c

  onHidden: ->
    console.log 'reload?', @reloadOnClose
    location.reload() if @reloadOnClose
