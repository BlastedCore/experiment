extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var money = 0

var seconds = 0

var stores = 0
var malls = 0
var stadiums = 0

var unlock_target = 1

var storeProg = 0
var mallProg = 0
var stadiumProg = 0

const storecost = 35
const mallcost = 70
const stadiumcost = 300
# Called when the node enters the scene tree for the first time.
func _ready():
	_UpdateUI()
	_UpdateStore()
	_UpdateMall()
	_UpdateStadium()
	_updateProg()
	_UpdateCosts()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	seconds+=delta
	#print(seconds)
	if money>=storecost && unlock_target==1:
		_UnlockNext(unlock_target)
	elif stores>=3 && unlock_target==2:
		_UnlockNext(unlock_target)
	elif malls>=2:
		_UnlockNext(unlock_target)
	_checkAuto()
	_updateProg()
	pass
	

func _UpdateUI():
	$MoneyLabel.text = str(money) + "§" 
	pass

func _on_Button_pressed():
	print("clicked button (+1$)")
	money+=1
	storeProg+=1
	_UpdateUI()
	pass # Replace with function body.

func _AutoButton():
	print("Auto clicked button (+1$)")
	money+=1*stores + 4*malls + 10*stadiums
	print(money)
	_UpdateUI()
	pass # Replace with function body.



func _UpdateStore():
	$StoreCounterLabel.text = str(stores)
	
	pass
func _UpdateMall():
	$MallCounterLabel.text = str(malls)
	
	pass
func _UpdateStadium():
	$StadiumCounterLabel.text = str(stadiums)
	
	pass
	


func _checkAuto():
	if seconds>1 && stores>=1:
		seconds=0
		_AutoButton()
	pass

func _UnlockNext(var x):
	
	match x :
		1: 
			$BuyButton.disabled = false
			unlock_target = 2
			
		2:
			$BuyButtonMall.disabled = false
			unlock_target = 3
			
		3:
			$BuyButtonStadium.disabled = false
			
	pass



func _on_BuyButton_pressed():
	if money>=storecost:
		money-=storecost
		stores+=1
		_UpdateUI()
		_UpdateStore()
		mallProg+=1
		if $StoreProg.value == storecost && $StoreProg3.visible==false:
			$StoreProg2.visible=true
			$StoreProg.visible=false
			$StoreProg2.value=mallProg
	pass # Replace with function body.


func _on_BuyButtonStadium_pressed():
	if money>=stadiumcost && stadiums<malls/2 && malls>=2:
		money-=stadiumcost
		stadiums+=1
		_UpdateUI()
		_UpdateStadium()
		_bruh()
	pass # Replace with function body.


func _on_BuyButtonMall_pressed():
	if money>=mallcost && malls<stores/3 && stores>=3:
		money-=mallcost
		malls+=1
		_UpdateUI()
		_UpdateMall()
		stadiumProg+=1
		if $StoreProg2.value == 3 && $StoreProg.visible==false:
			$StoreProg3.visible=true
			$StoreProg2.visible=false
			$StoreProg3.value=stadiumProg
	pass # Replace with function body.


func _updateProg():
	$StoreProg.value=storeProg
	$StoreProg2.value=mallProg
	$StoreProg3.value=stadiumProg
	pass

func _UpdateCosts():
	$BuyButton.text+=" "+str(storecost)+"$"
	$BuyButtonMall.text+=" "+str(mallcost)+"$"
	$BuyButtonStadium.text+=" "+str(stadiumcost)+"$"
	pass


func _bruh():
	
	$Popup.popup()
	
	pass
