// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require jquery.remotipart


$(function () {
    $("#select-clientess").live('change', function () {
        var valor = $(this).val();
        if (valor != 0) {
            var a = $(this);
            a.attr('data-content', '<div id="clientes"></div>');
            $.get('/clients/' + valor + ".json", function (o) {
                if (!o.logo_emp.url==""){
                    var img = ['<br><img src="..' + o.logo_emp.url + '" height="100" width="100" align="middle">&nbsp;' + '</div><div>'];
                } else {
                    var img = ['</div><div>'];
                }
                var html = ['<div>' +
                    '<font face="Comic Sans MS" size="1" >' + '<b>Nombre: </b>' + o.name + '<br>' + '<b>RFC: </b>' + o.rfc + '<br>' + '<b>Dirección: </b>' + o.street + ' #' + o.num_ext + ' ' + o.num_int + ' Col. ' +
                    o.suburb + ' C.P. ' + o.cp + ' Del. ' + o.township + ' Edo. ' + o.state + '</font>'
                ].join('</div><div>') + '</div>';
                a.attr('data-content', '<div id="clientes">' + '<div class="row-fluid"><div class="span4" >' + img + html + '</div>&nbsp;' + '</div>' + '</div>');
                $('#select-clientess').popover({
                    html:true,
                    delay:{show:500, hide:300}

                }).popover('show');
                $("#select-alumnos").css({visibility:'visible'});
                $("#select-alumno").css({visibility:'visible'});
            });
            return false;
        } else {
            $("#select-alumnos").css({visibility:'hidden'});
            $("#select-alumno").css({visibility:'hidden'});
        }
    });
});


$(function () {
    $("#clients_search").live('keyup', function () {
        $.get($("#clients_search th a, #clients_search .pagination a").attr("action"), $("#clients_search").serialize(), null, "script");
        return false;
    });
});

$(function () {
    $("#resumes_search").live('keyup', function () {
        $.get($("#resumes_search").attr("action"), $("#resumes_search").serialize(), null, "script");
        return false;
    });
});

$(function () {

    $("#invoice_dates").datepicker({dateFormat:"dd-mm-yy"});

    $("#folios_date1").live('focus', function () {
        $("#folios_date1").datepicker({dateFormat:"dd-mm-yy"});
    });

    $("#folios_date2").live('focus', function () {
        $("#folios_date2").datepicker({dateFormat:"dd-mm-yy"});
    });
});

$(function () {
    $("img[rel=clients]")
        .popover({
            placement:"bottom",
            title:"Clientes",
            content:"Aquí puedes dar de alta a tus clientes",
            trigger:"hover",
            delay:{ show:500, hide:100 }
        });
    $("img[rel=folios]")
        .popover({
            placement:"bottom",
            title:"Folios",
            content:"Aquí puedes dar de alta tus Folios",
            trigger:"hover",
            delay:{ show:500, hide:100 }
        });
    $("img[rel=invoices]")
        .popover({
            placement:"bottom",
            title:"Facturas",
            content:"Aquí puedes dar de alta tus facturas",
            trigger:"hover",
            delay:{ show:500, hide:100 }
        });
    $("img[rel=invoices_nonactive]")
        .popover({
            placement:"bottom",
            title:"Facturas",
            content:"Debes de completar la infomación de tu perfil.",
            trigger:"hover",
            delay:{ show:500, hide:100 }
        });
    $("[rel=usuario]")
        .popover({
            placement:"left",
            content:"Aquí puedes editar la información del usuario",
            trigger:"hover",
            delay:{ show:500, hide:100 }
        });
});

$(function () {
    //To sort with ajax
    $("#list-clients th a, #list-clients .pagination a").live("click", function () {
        $.getScript(this.href);
        return false;
    });
});

$(function () {
    $("#clientrfc").live('blur', function () {
        //var valor = $(this).val();
        //str = valor.substring(3, 4);
        //if (isNaN(str)) {
            $("#students").css({visibility:'visible'});
        //}
        //else {
            //$("#students").css({visibility:'hidden'});
        //}
    });
});














