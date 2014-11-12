$(document).ready(function()
{

    // activate Nestable for list 1
    $('#nestable1').nestable({
        group: 1
    });
    
    // activate Nestable for list 2
    $('#nestable2').nestable({
        group: 1
    });

    var $expand = false;
    $('#nestable-menu').on('click', function(e)
    {
        if ($expand) {
            $expand = false;
            $('.dd').nestable('expandAll');
        }else {
            $expand = true;
            $('.dd').nestable('collapseAll');
			
        }
    });
	
	var $checkbox_id = 0;
	var $checkbox_val = false;
	$("input[name='clickable']").on('change', function (index, elem) {
	    $checkbox_id = $(this).attr('data-mid');
		$checkbox_val = $(this).prop("checked");
	    //alert('id = '+checkbox_id + ', value = ' + $(this).prop("checked"));
	});
	
	
	$('#nestable1').on('change', function() {
	    /* on change event 
		*/
		//alert($checkbox_id+$checkbox_val);
		$.ajax
		    ({
		        type: "POST",
		        url: '/admin/menus/update-menu?id='+ $checkbox_id + '&value='+$checkbox_val,
		        dataType: 'json',
		        async: false,
		        data: 'menus=' + JSON.stringify($('#nestable1').nestable('serialize')),
		        success: function () {
					
		        	alert("Updated!"); 
		        }
		    })
	});
	
	
    //$('#nestable3').nestable();

});