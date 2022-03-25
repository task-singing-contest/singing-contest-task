<?php require ('partials/header.php'); ?>

<div class="ibox-content">
    <div id="wizard">
        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_1"></h3>
                <table class="contestant" id="contest_round_1">
                </table>
            </div>
        </div>

        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_2"></h3>
                <table class="contestant" id="contest_round_2">
                </table>
            </div>
        </div>

        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_3"></h3>
                <table class="contestant" id="contest_round_3">
                </table>
            </div>
        </div>

        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_4"></h3>
                <table class="contestant" id="contest_round_4">
                </table>
            </div>
        </div>

        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_5"></h3>
                <table class="contestant" id="contest_round_5">
                </table>
            </div>
        </div>

        <h1>Round</h1>
        <div class="step-content">
            <div class="text-center m-t-md">
                <h3 id="genre_name_6"></h3>
                <table class="contestant" id="contest_round_6">
                </table>
            </div>
        </div>
    </div>

</div>

<?php require ('partials/footer.php'); ?>


<script>
    $(document).ready(function(){
        let passedRounds = [];

        $("#wizard").steps({
            onStepChanging: function (event, currentIndex, newIndex)
            {
                return true;
            },
            onStepChanged: function (event, currentIndex, priorIndex)
            {
                if(!passedRounds.includes(currentIndex)){
                    let round = currentIndex + 1;
                    $.ajax({
                        type: "POST",
                        data: {'round': round},
                        url: "/rounds",
                        success: function (response) {

                            $.ajax({
                                type: "GET",
                                url: "/tables-data",
                                success: function (tablesData) {
                                    prepareTablesData (tablesData);
                                }
                            });
                        }
                    });
                }

                passedRounds.push(priorIndex);
                passedRounds.push(currentIndex);
            },
            onFinishing: function (event, currentIndex)
            {
                window.location.href = '/';
                return true;
            },
            onFinished: function (event, currentIndex)
            {
                window.location.href = '/';
            }
        });

        $.ajax({
            type: "POST",
            data: {'round': 1},
            url: "/rounds",
            success: function (response) {

                $.ajax({
                    type: "GET",
                    url: "/tables-data",
                    success: function (tablesData) {
                        prepareTablesData (tablesData);
                        for (const [id, value] of Object.entries(JSON.parse(tablesData))) {
                            if (id > 0) {
                                $('#wizard > div.actions.clearfix > ul > li:nth-child(2) > a').click();
                            }
                        }
                    }
                });
            }
        });

        $("#wizard > div.actions.clearfix > ul > li:nth-child(3) > a").hide();
        $('#wizard > div.actions.clearfix > ul > li:nth-child(4) > a').hide();
    });
</script>

