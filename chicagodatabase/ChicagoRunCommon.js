function rollover(ele, hover, out) {
    if (hover == null) {
        hover = ele.attr('hover');
    }
    if (hover != null && hover !== '') {
        if (out == null) {
            out = ele.attr('src');
        }
        ele.mouseover(function () { ele.attr('src', hover); }).mouseout(function () { ele.attr('src', out); });
    }
}

$(document).ready(function () {
    $('a img').each(function () { rollover($(this), $(this).parent().attr('hover')); });
    $('input[type=image]').each(function () { rollover($(this)); });
    $('.hoverChange').live('mouseover', function () { var hover = $(this).attr('hover'); $(this).attr('src', hover); });
    $('.hoverChange').live('mouseout', function () { var out = $(this).attr('out'); $(this).attr('src', out); });
    $('.deleteChange').live('mouseover', function () { $(this).attr('src', '../images/delete_hover.png'); });
    $('.deleteChange').live('mouseout', function () { $(this).attr('src', '../images/delete.png'); });
    $('.editChange').live('mouseover', function () { $(this).attr('src', '../images/edit_hover.png'); });
    $('.editChange').live('mouseout', function () { $(this).attr('src', '../images/edit.png'); });
});

function isValidDate(date) {
    var matches = /^(\d{1,2})[-\/](\d{1,2})[-\/](\d{4})$/.exec(date);
    if (matches == null) return false;
    var d = matches[2];
    var m = matches[1] - 1;
    var y = matches[3];
    var composedDate = new Date(y, m, d);
    return composedDate.getDate() == d &&
            composedDate.getMonth() == m &&
            composedDate.getFullYear() == y;
}

function mvl(id, d, dv) {
    this.id = id;
    this.d = d;
    this.dv = dv;
    if (this.d != null && this.dv != null) {
        var values = this.dv.split(this.d);
        $('#' + this.id).html('');
        for (var i = 0; i < values.length; i++) {
            this.addValue(values[i]);
        }
    }
}
mvl.prototype.addValue = function (value) {
    value = $.trim(value);
    if (value != null && value != '') {
        var originalHtml = $('#' + this.id).html();
        if (originalHtml.indexOf(value) < 0) {
            var addHtml = "<div class='singleValue'><div class='valueText'>" + value + "</div><div class='delete' title='Delete' onclick='mvl.removeValue(this)'>x</div></div>";
            $('#' + this.id).append(addHtml);
        }
    };
};
mvl.prototype.toString = function (delimiter) {
    var strValue = '';
    if (delimiter == null) {
        delimiter = this.d;
    }
    $('#' + this.id + ' .valueText').each(function () {
        strValue = strValue + delimiter + ' ' + $(this).text();
    });
    if (strValue.length > 0)
        return $.trim(strValue.substring(1));
    else
        return "";
};
mvl.removeValue = function (v) {
    $(v).closest('.singleValue').remove();
};
