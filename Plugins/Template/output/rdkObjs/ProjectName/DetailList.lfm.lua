require("firecast.lua");
local __o_rrpgObjs = require("rrpgObjs.lua");
require("rrpgGUI.lua");
require("rrpgDialogs.lua");
require("rrpgLFM.lua");
require("ndb.lua");
require("locale.lua");
local __o_Utils = require("utils.lua");

local function constructNew_frmDetailList()
    local obj = GUI.fromHandle(_obj_newObject("form"));
    local self = obj;
    local sheet = nil;

    rawset(obj, "_oldSetNodeObjectFunction", rawget(obj, "setNodeObject"));

    function obj:setNodeObject(nodeObject)
        sheet = nodeObject;
        self.sheet = nodeObject;
        self:_oldSetNodeObjectFunction(nodeObject);
    end;

    function obj:setNodeDatabase(nodeObject)
        self:setNodeObject(nodeObject);
    end;

    _gui_assignInitialParentForForm(obj.handle);
    obj:beginUpdate();
    obj:setName("frmDetailList");
    obj:setAlign("client");

    obj.scrollBox1 = GUI.fromHandle(_obj_newObject("scrollBox"));
    obj.scrollBox1:setParent(obj);
    obj.scrollBox1:setAlign("client");
    obj.scrollBox1:setName("scrollBox1");

    obj.layout1 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout1:setParent(obj.scrollBox1);
    obj.layout1:setAlign("top");
    obj.layout1:setHeight(25);
    obj.layout1:setName("layout1");

    obj.button1 = GUI.fromHandle(_obj_newObject("button"));
    obj.button1:setParent(obj.layout1);
    obj.button1:setAlign("left");
    obj.button1:setWidth(25);
    obj.button1:setText("+");
    obj.button1:setHint("Adicionar");
    obj.button1:setName("button1");

    obj.layout2 = GUI.fromHandle(_obj_newObject("layout"));
    obj.layout2:setParent(obj.scrollBox1);
    obj.layout2:setAlign("left");
    obj.layout2:setWidth(250);
    obj.layout2:setMargins({right=10});
    obj.layout2:setName("layout2");

    obj.rectangle1 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle1:setParent(obj.layout2);
    obj.rectangle1:setAlign("client");
    obj.rectangle1:setColor("black");
    obj.rectangle1:setName("rectangle1");

    obj.rclSelector = GUI.fromHandle(_obj_newObject("recordList"));
    obj.rclSelector:setParent(obj.rectangle1);
    obj.rclSelector:setAlign("top");
    obj.rclSelector:setAutoHeight(true);
    obj.rclSelector:setName("rclSelector");
    obj.rclSelector:setField("listaDeOpcoes");
    obj.rclSelector:setTemplateForm("frmDetailListItem");
    obj.rclSelector:setLayout("vertical");
    obj.rclSelector:setSelectable(true);

    obj.boxDetalhesDoItem = GUI.fromHandle(_obj_newObject("dataScopeBox"));
    obj.boxDetalhesDoItem:setParent(obj.scrollBox1);
    obj.boxDetalhesDoItem:setAlign("client");
    obj.boxDetalhesDoItem:setName("boxDetalhesDoItem");
    obj.boxDetalhesDoItem:setVisible(false);

    obj.rectangle2 = GUI.fromHandle(_obj_newObject("rectangle"));
    obj.rectangle2:setParent(obj.boxDetalhesDoItem);
    obj.rectangle2:setAlign("client");
    obj.rectangle2:setColor("black");
    obj.rectangle2:setName("rectangle2");

    obj.edit1 = GUI.fromHandle(_obj_newObject("edit"));
    obj.edit1:setParent(obj.rectangle2);
    obj.edit1:setAlign("top");
    obj.edit1:setHeight(25);
    obj.edit1:setField("nome");
    obj.edit1:setMargins({top=5,right=5,left=5,bottom=5});
    obj.edit1:setName("edit1");

    obj.textEditor1 = GUI.fromHandle(_obj_newObject("textEditor"));
    obj.textEditor1:setParent(obj.rectangle2);
    obj.textEditor1:setAlign("client");
    obj.textEditor1:setHeight(25);
    obj.textEditor1:setField("details");
    obj.textEditor1:setMargins({right=5,left=5,bottom=5});
    obj.textEditor1:setName("textEditor1");

    obj._e_event0 = obj.button1:addEventListener("onClick",
        function (_, event)
            self.rclSelector:append();
        end, obj);

    obj._e_event1 = obj.rclSelector:addEventListener("onCompare",
        function (_, nodeA, nodeB)
            -- Esse codigo organiza a ordem dos objetos da lista alfabeticamente. 
            				        return Utils.compareStringPtBr(nodeA.nome, nodeB.nome);
        end, obj);

    obj._e_event2 = obj.rclSelector:addEventListener("onSelect",
        function (_)
            local node = self.rclSelector.selectedNode;
            							self.boxDetalhesDoItem.node = node; 
            							self.boxDetalhesDoItem.visible = (node ~= nil);
        end, obj);

    function obj:_releaseEvents()
        __o_rrpgObjs.removeEventListenerById(self._e_event2);
        __o_rrpgObjs.removeEventListenerById(self._e_event1);
        __o_rrpgObjs.removeEventListenerById(self._e_event0);
    end;

    obj._oldLFMDestroy = obj.destroy;

    function obj:destroy() 
        self:_releaseEvents();

        if (self.handle ~= 0) and (self.setNodeDatabase ~= nil) then
          self:setNodeDatabase(nil);
        end;

        if self.rectangle2 ~= nil then self.rectangle2:destroy(); self.rectangle2 = nil; end;
        if self.textEditor1 ~= nil then self.textEditor1:destroy(); self.textEditor1 = nil; end;
        if self.rectangle1 ~= nil then self.rectangle1:destroy(); self.rectangle1 = nil; end;
        if self.rclSelector ~= nil then self.rclSelector:destroy(); self.rclSelector = nil; end;
        if self.layout2 ~= nil then self.layout2:destroy(); self.layout2 = nil; end;
        if self.boxDetalhesDoItem ~= nil then self.boxDetalhesDoItem:destroy(); self.boxDetalhesDoItem = nil; end;
        if self.edit1 ~= nil then self.edit1:destroy(); self.edit1 = nil; end;
        if self.button1 ~= nil then self.button1:destroy(); self.button1 = nil; end;
        if self.scrollBox1 ~= nil then self.scrollBox1:destroy(); self.scrollBox1 = nil; end;
        if self.layout1 ~= nil then self.layout1:destroy(); self.layout1 = nil; end;
        self:_oldLFMDestroy();
    end;

    obj:endUpdate();

    return obj;
end;

function newfrmDetailList()
    local retObj = nil;
    __o_rrpgObjs.beginObjectsLoading();

    __o_Utils.tryFinally(
      function()
        retObj = constructNew_frmDetailList();
      end,
      function()
        __o_rrpgObjs.endObjectsLoading();
      end);

    assert(retObj ~= nil);
    return retObj;
end;

local _frmDetailList = {
    newEditor = newfrmDetailList, 
    new = newfrmDetailList, 
    name = "frmDetailList", 
    dataType = "", 
    formType = "undefined", 
    formComponentName = "form", 
    title = "", 
    description=""};

frmDetailList = _frmDetailList;
Firecast.registrarForm(_frmDetailList);

return _frmDetailList;
