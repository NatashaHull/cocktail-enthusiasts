var drinkTypes = {
    "duo": {description: "A duo is a combination of a two spirits and liquers (typically one is a spirit and the other is a liquer, though both can liquers)", components: ['spirit_or_liqueur', 'liqueur']},
    "trio": {description: "A trio is the same thing as a duo, but it also has cream.", components: ['spirit_or_liqueur', 'liqueur', 'cream']},
    "french-italian family": {description: "The French-Italian family&rsquo;s best known drinks are martinis and manhattans. These drinks include a base spirit, a type of vermouth, and sometimes include a type of bitters.", components: ['base_spirit', 'vermouth', 'bitters']},
    "highball": {description: "Highballs typically are defined by a base spirit and some form of soda.  Well known highballs include the dark and stormy, gin and tonic, and cuba libre.  Highballs can also include lime juice and other juices.", components: ['base_spirit', 'soda', 'juice']},
    "sparkling sour": {description: "A sparkling sour encompasses both collinses and fizzes.  It is typically composed of a base spirit, sweetener, citrus, and some form of soda.  That said, some sparkling sours can also have bitters, juice, cream and eggs.", components: ['base_spirit', 'sweetener', 'citrus', 'soda', 'other']},
    'sour': {description: "A sour is a combination of a base spirit (whiskey, or rum, for example) with a sweetening agent and some citrus (a lemon or a lime).", components: ['base_spirit', 'sweetener', 'citrus']}
};

var components = {};
  components['base_spirit'] = ["bourbon", "brandy", "gin", "rum", "rye", "scotch", "tequila", "vodka"];
  components['liqueur'] = ["amaretto", "apple sour pucker", "benedictine", "cointreau", "creme de menthe", "creme de cocoa", "drambuie", "frangelico", "grand marnier", "kahlua", "peach schnapps", "sloe gin", "triple sec"];
  components['spirit_or_liqueur'] = components['base_spirit'].concat(components['liqueur']);
  components['citrus'] = ['lemon', 'lime'];
  components['vermouth'] = ["sweet vermouth", "dry vermouth", "lillet blanc", "cocci americano"];
  components['sweetener'] = components['liqueur'].concat(["grenadine", "simple syrup"]);
  components['soda'] = ["club soda", "cola", "ginger beer"];
  components['juice'] = ["cranberry juice", "grapefruit juice", "pineapple juice", "orange juice"];
  components['bitters'] = ["angostura bitters", "orange bitters", "none"];
  components['cream'] = ["cream", "irish creme liqueur"];
  components['other'] = components['spirit_or_liqueur'].concat(components['sweetener'], components['juice'], components['soda'], components['bitters'], components["cream"]);
  String.prototype.toCapitalize = function() { 
    return this.toLowerCase().replace(/^.|\s\S/g, function(a) { return a.toUpperCase();});
  }

function setUpFirstPage() {
    for (drinkType in drinkTypes){
        if (drinkTypes.hasOwnProperty(drinkType)) {
            var drinkTypeRow = $('<tr>');
            drinkTypeRow.append('<input type="radio" name="drink" value="' + drinkType + '">');
            drinkTypeRow.append('<span style="text-transform: capitalize;">' + drinkType + ' </span>');
            drinkTypeRow.append($('<a href="#" style="font-size: 0.7em;" onclick="alert(\'' + drinkTypes[drinkType].description + '\');">[?]</a>'));
            drinkTypeRow.appendTo('#drinkTypesTable');
        }
    }
      
    $('#drinkTypesTable input[type=radio]').click(function(e) {
        $('#tabs-1 .nextButton').attr('disabled', false);
        
        var selectedDrinkType = e.currentTarget.value;
        var drinkComponents = drinkTypes[selectedDrinkType].components
        
        setUpSecondPage(selectedDrinkType, drinkComponents);
    });
    
    $('#tabs-1 .nextButton').click(function() {
        $("#tabs").tabs("enable", 1).tabs("option", "active", 1);
    });
}

function setUpSecondPage(drinkType, drinkComponents) {
    $('#chooseComponents').html('');
    $('<h3>You have selected to make a <span style="text-transform: capitalize;">' + drinkType + '</span> cocktail!</h3>').appendTo('#chooseComponents');
    $('<p>This drink contains: a ' + drinkComponents.join(', a ').replace(/_/g,' ') + '. Please select the specific ingredients you want below!</p>').appendTo('#chooseComponents');
    $('<p>Is this not the drink which you intended to make?  If so, click the back button below!</p>').appendTo('#chooseComponents');
    
    for(var i = 0; i < drinkComponents.length; i++) {
        var ingredient = drinkComponents[i];
        $('<p>Please select your ' + drinkComponents[i].replace(/_/g,' ') + ' below:</p>').appendTo('#chooseComponents');
        var selectBox = $('<select id="' + ingredient + '">')
        selectBox.append('<option value=""></option>');
        for(var j = 0; j < components[ingredient].length; j++) {
            ingredientOption = $('<option name="item-' + ingredient + '" value="' + components[ingredient][j] + '">');
            ingredientOption.append(components[ingredient][j].toCapitalize());
            ingredientOption.appendTo(selectBox);
        }
        selectBox.appendTo('#chooseComponents');
    }
    
    $('#chooseComponents select').change(function() {
        var readyToMoveOn = true;
        var ingredients = [];
        var selects = $('#chooseComponents select');
        for (var i = 0; i < selects.length; i++) {
            var select = selects[i];
            if (select.value == '') {
                readyToMoveOn = false;
            } else if (select.value !== 'none') {
                ingredients.push(select.value);
            }
        }
      
        if (readyToMoveOn) {
            $('#tabs-2 .nextButton').attr('disabled', false);
            setUpThirdPage(ingredients);
        }
    });
      
    $("#tabs-2 .backButton").click(function() {
        $("#tabs").tabs("option", "active", 0);
    });
    $('#tabs-2 .nextButton').click(function() {
        $("#tabs").tabs("enable", 2).tabs("option", "active", 2);
    });
}

function setUpThirdPage(ingredients) {
    $('#chooseAmounts').html('');
    for (var i = 0; i < ingredients.length; i++) {
        amountOption = $('<p>');
        amountOption.append($('<input type="text">'));
        amountOption.append($('<span>' + ingredients[i] + '</span>'));
        amountOption.appendTo($('#chooseAmounts'));
    }
    
    $('#chooseAmounts input, #instructions').keyup(function() {
        var readyToMoveOn = true;
        var amounts = {};
      
        $('#chooseAmounts p').each(function (i, row) {
            var amount = $(row).find('input').val();
            var ingredient = $(row).find('span').text();
          
            if (amount == '') {
                readyToMoveOn = false;
            } else {
                amounts[ingredient] = amount;
            }
        });
      
        var instructions = $('#tabs-3 #instructions').val();
      
        if (readyToMoveOn) {
            $('#tabs-3 .nextButton').attr('disabled', false);
      
            setUpFourthPage(amounts, instructions);
        }
    });
      
    $("#tabs-3 .backButton").click(function() {
        $("#tabs").tabs("option", "active", 1);
    });
    $('#tabs-3 .nextButton').click(function() {
        $("#tabs").tabs("enable", 3).tabs("option", "active", 3);
    });
}
      
function setUpFourthPage(amounts, instructions) {
    $('#showCocktail').html('');
    for (ingredient in amounts) {
        if (amounts.hasOwnProperty(ingredient)) {
            var paragraph = $('<p>');
            paragraph.text(amounts[ingredient] + ' ' + ingredient);
            paragraph.appendTo($('#showCocktail'));
        }
    }
    
    var instructionsPar = $('<p>');
    instructionsPar.text(instructions);
    instructionsPar.appendTo($('#showCocktail'));
    
    $("#tabs-4 .backButton").click(function() {
        $("#tabs").tabs("option", "active", 2);
    });
}
$(document).ready(function() {
    $("#tabs").tabs({ disabled: [ 1, 2, 3 ] });
    setUpFirstPage();
    $('body').show();
});