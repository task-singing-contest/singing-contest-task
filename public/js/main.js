function prepareTablesData (tablesData) {
console.log(JSON.parse(tablesData).length)
    if (JSON.parse(tablesData).length > 5) {
        $('#wizard > div.actions.clearfix > ul > li:nth-child(3) > a').show();
    }

    let tableHeadHtml = `<tr>
                                        <th>Nr</th>
                                        <th>Name</th>
                                        <th>Score</th>
                                        <th>Streangth</th>
                                        <th>Genre Score</th>
                                        <th>Judge Score</th>
                                        <th>Is Sick</th>`;

    JSON.parse(tablesData).forEach((item, index) => {
        let i = 0;
        let tableHtml = ``;
        tableHtml += tableHeadHtml;
        const roundData = JSON.parse(item.json_data);
        document.getElementById(`genre_name_${index+1}`).innerHTML = `Genre ${roundData.roundGenreName}`;
        for (const [judgeId, contestJudge] of Object.entries(roundData.contestJudges)) {
            tableHtml += `<th>${contestJudge}</th>`;
        }

        tableHtml += `</tr>`;

        for (const [contestantId, contestantData] of Object.entries(roundData.contestantDataCollection)) {
            tableHtml += `<tr id="${contestantId}">
                                                            <td>${++i}</td>
                                                            <td>${contestantData.name}</td>
                                                            <td>${contestantData.total_score}</td>
                                                            <td>${contestantData.genre_streangth}</td>
                                                            <td>${contestantData.contestant_score}</td>
                                                            <td>${contestantData.judge_round_score}</td>
                                                            <td>${contestantData.contestant_is_sick}</td>`;
            for (const [judgeIdScore, judgeScoreData] of Object.entries(contestantData.judges_score)) {
                tableHtml += `<td>${judgeScoreData.score}</td>`;
            }
        }
        document.getElementById(`contest_round_${item.round}`).innerHTML = tableHtml;
    });
}
