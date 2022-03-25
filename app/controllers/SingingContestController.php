<?php
declare(strict_types = 1);

namespace App\Controllers;

use App\Core\App;
use App\Models\RoundLog;
use App\Services\SingingContest\ContestService;
use App\Services\SingingContest\Round\RoundService;
use App\Services\SingingContest\ServiceManager;

class SingingContestController
{
    private $numberOfRounds;

    private $roundService;
    private $contestService;
    private $serviceManager;


    public function __construct()
    {
        $this->numberOfRounds = App::get('config')['singing_contest_options']['number_of_rounds'];

        $this->roundService   = new RoundService();
        $this->contestService = new ContestService();
        $this->serviceManager = new ServiceManager();
    }

    /**
     * @return mixed
     * This function returns starting contest page.
     */
    public function indexAction()
    {
        return view('index');
    }

    /**
     * create the singing contest.
     */
    public function createAction()
    {
        /**
         * check if a contest is going on
         */
        $contestId = $this->contestService->getContestGoingOn();
        if ($contestId) {
            return redirect('show');
        }

        /**
         * create contest data and go to rounds
         */
        $this->serviceManager->createContest();

        /**
         * clear table round_log,
         * because this table is only to keep track of th rounds when a contest is going on
         * and it must be cleared when a new contest starts
         */
        App::DB()->raw(
            'DELETE FROM rounds_log;'
        );

        return redirect('show');
    }

    /**
     * round from where to start
     */
    public function showAction()
    {
        return view('show');
    }

    /**
     * @return mixed
     * show best contestants history
     */
    public function historyAction()
    {
        $bestContestants = App::DB()->raw(
            'SELECT name, score 
             FROM contestants 
             WHERE winner = "1" 
             ORDER BY score DESC LIMIT 10'
        );
        return view('history', compact('bestContestants'));
    }

    /**
     * calculate and update round score
     */
    public function roundsAction()
    {
        /** @var check if the round is already calculated $roundsLog */
        $roundsLog = new RoundLog();
        if ($_POST['round'] <= $roundsLog->count()) {
            return;
        }

        $contestId = $this->contestService->getContestGoingOn();

        /**
         * calculate and update round result score
         */
        $this->serviceManager->calculateAndUpdateRound();

        /**
         * create round log
         */
        $this->roundService->roundLog((int)$contestId);
    }

    /**
     * get tables data
     */
    public function tablesDataAction()
    {
        $roundLog = new RoundLog();

        echo json_encode($roundLog->all());
    }
}
