extends Node

# -- VARIÁVEIS PARA DEFINIR O DIÁLOGO --
var ground_condition = true
var redDialog = 1
var greenDialog = 1
var blueDialog = 1
var kingDialog = 1
var velhoDialog = 1

# -- VARIÁVEIS PARA MOSTRAR AS PEDRAS NO HUD / CONTAGEM DAS PEDRAS --
var showRedStone = false
var showGreenStone = false
var showBlueStone = false
var stonesCount = 0

# -- VARIÁVEIS PARA VERIFICAR SE É A PRIMEIRA VEZ NAQUELA SCENE --
var firstTimeInDomum = true
var firstTimeInGreenOBJ = true

# -- VARIÁVEIS PARA POSICIONAR O PLAYER EM DOMUM APÓS UM PUZZEL --
var comeBackRed = false
var comeBackGreen = false
var comeBackBlue = false

# -- VARIÁVEIS PARA TORNAR O TRIGGER GLOBAL --
var allowTriggerRed = false
var allowTriggerGreen = false
var allowTriggerBlue = false

func _ready():
	pass
