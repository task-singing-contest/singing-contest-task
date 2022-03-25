<?php
Use App\Core\App;

    $router->get('', 'SingingContestController@indexAction');
    $router->get('show', 'SingingContestController@showAction');
    $router->get('history', 'SingingContestController@historyAction');
    $router->get('tables-data', 'SingingContestController@tablesDataAction');

    $router->post('create', 'SingingContestController@createAction');
    $router->post('rounds', 'SingingContestController@roundsAction');

?>
