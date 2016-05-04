/**
 * Created by molhm on 30/04/16.
 */
$('#search').bind('railsAutocomplete.select', function (event, data) {
    $('#search-form').submit()
});

