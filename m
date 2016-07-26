From: rrandall@micron.com (Robert Randall (rrandall))
Date: Tue, 26 Jul 2016 22:02:16 +0000
Subject: kworker blocked for more than 120s - heavy load on SSD
Message-ID: <db42fba9a6344f9ea54ba477fa41ea17@bowex36e.micron.com>


We are stress testing the Windows NVMe over Fabrics host driver and we're seeing a few issues.  Snippets are below.  These issues are repeatable and occur when the underlying NVMe SSD is being overloaded; it has too much work to do.  Any and all help on tracking down the root cause would be much appreciated.  The server code is the nvmf-all.3 branch and the kernel was built early yesterday.

This issue causes a disconnect which is great for testing the Windows driver but it feels like it should not occur in the wild.

[16082.259170] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16082.259230]       Tainted: G        W       4.7.0-rc2+ #3
[16082.259272] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16082.259331] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16082.259347] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16082.259350]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16082.259355]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16082.259359]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16082.259364] Call Trace:
[16082.259375]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16082.259381]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16082.259388]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16082.259393]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16082.259398]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16082.259405]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16082.259414]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16082.259419]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16082.259423]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16082.259428]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16082.259432]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16082.259436]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16082.259439]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16082.259444]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16082.259448]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16082.259453]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16202.260735] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16202.260794]       Tainted: G        W       4.7.0-rc2+ #3
[16202.260836] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16202.260894] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16202.260907] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16202.260910]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16202.260914]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16202.260919]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16202.260923] Call Trace:
[16202.260930]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16202.260936]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16202.260941]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16202.260945]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16202.260950]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16202.260955]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16202.260962]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16202.260967]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16202.260972]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16202.260976]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16202.260979]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16202.260983]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16202.260986]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16202.260991]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16202.260995]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16202.261000]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16322.262306] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16322.262365]       Tainted: G        W       4.7.0-rc2+ #3
[16322.262406] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16322.262465] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16322.262477] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16322.262480]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16322.262485]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16322.262489]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16322.262493] Call Trace:
[16322.262501]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16322.262506]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16322.262511]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16322.262516]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16322.262521]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16322.262526]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16322.262533]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16322.262538]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16322.262543]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16322.262547]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16322.262551]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16322.262554]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16322.262558]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16322.262562]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16322.262566]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16322.262571]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16442.263888] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16442.263948]       Tainted: G        W       4.7.0-rc2+ #3
[16442.263990] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16442.264049] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16442.264061] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16442.264064]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16442.264069]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16442.264073]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16442.264077] Call Trace:
[16442.264085]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16442.264090]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16442.264095]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16442.264099]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16442.264104]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16442.264109]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16442.264117]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16442.264122]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16442.264126]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16442.264131]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16442.264134]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16442.264138]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16442.264141]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16442.264146]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16442.264150]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16442.264155]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16562.265458] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16562.265518]       Tainted: G        W       4.7.0-rc2+ #3
[16562.265560] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16562.265619] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16562.265630] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16562.265633]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16562.265638]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16562.265642]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16562.265647] Call Trace:
[16562.265654]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16562.265660]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16562.265665]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16562.265669]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16562.265674]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16562.265679]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16562.265686]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16562.265692]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16562.265696]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16562.265700]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16562.265704]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16562.265708]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16562.265711]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16562.265715]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16562.265720]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16562.265724]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16682.267032] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16682.267092]       Tainted: G        W       4.7.0-rc2+ #3
[16682.267133] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16682.267192] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16682.267204] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16682.267207]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16682.267212]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16682.267216]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16682.267220] Call Trace:
[16682.267228]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16682.267233]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16682.267238]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16682.267243]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16682.267248]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16682.267253]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16682.267260]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16682.267265]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16682.267270]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16682.267274]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16682.267278]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16682.267282]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16682.267285]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16682.267289]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16682.267294]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16682.267298]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16802.268627] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16802.268692]       Tainted: G        W       4.7.0-rc2+ #3
[16802.268733] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16802.268792] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16802.268804] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16802.268807]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16802.268812]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16802.268816]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16802.268820] Call Trace:
[16802.268828]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16802.268834]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16802.268839]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16802.268843]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16802.268848]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16802.268853]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16802.268860]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16802.268866]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16802.268870]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16802.268874]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16802.268878]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16802.268881]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16802.268885]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16802.268889]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16802.268893]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16802.268898]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[16922.270204] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[16922.270272]       Tainted: G        W       4.7.0-rc2+ #3
[16922.270314] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[16922.270372] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[16922.270384] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[16922.270388]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[16922.270392]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[16922.270396]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[16922.270401] Call Trace:
[16922.270408]  [<ffffffff8181ba15>] schedule+0x35/0x80
[16922.270414]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[16922.270419]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[16922.270423]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[16922.270428]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[16922.270433]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[16922.270440]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[16922.270446]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[16922.270450]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[16922.270454]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[16922.270458]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[16922.270462]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16922.270465]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[16922.270469]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[16922.270474]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[16922.270478]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[17042.271770] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[17042.271830]       Tainted: G        W       4.7.0-rc2+ #3
[17042.271872] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[17042.271931] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[17042.271943] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[17042.271946]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[17042.271951]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[17042.271955]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[17042.271959] Call Trace:
[17042.271967]  [<ffffffff8181ba15>] schedule+0x35/0x80
[17042.271972]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[17042.271977]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[17042.271981]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[17042.271986]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[17042.271992]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[17042.271999]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[17042.272004]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[17042.272008]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[17042.272012]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[17042.272016]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[17042.272020]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[17042.272023]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[17042.272027]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[17042.272031]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[17042.272036]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[17162.273355] INFO: task kworker/5:3:9671 blocked for more than 120 seconds.
[17162.273415]       Tainted: G        W       4.7.0-rc2+ #3
[17162.273456] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[17162.273515] kworker/5:3     D ffff8802af5a3c88     0  9671      2 0x00000000
[17162.273527] Workqueue: events nvmet_rdma_release_queue_work [nvmet_rdma]
[17162.273530]  ffff8802af5a3c88 000000000000001b ffff8802c608e3c0 ffff8802c5170000
[17162.273534]  ffff8802af5a3cb0 ffff8802af5a4000 7fffffffffffffff ffff8804c4d91e80
[17162.273539]  ffff8802c5170000 ffff8804c4d91ec8 ffff8802af5a3ca0 ffffffff8181ba15
[17162.273543] Call Trace:
[17162.273551]  [<ffffffff8181ba15>] schedule+0x35/0x80
[17162.273556]  [<ffffffff8181ede2>] schedule_timeout+0x1b2/0x270
[17162.273561]  [<ffffffff810cad91>] ? console_unlock+0x261/0x5a0
[17162.273566]  [<ffffffff810cb9a1>] ? vprintk_emit+0x2b1/0x520
[17162.273571]  [<ffffffff8181c46e>] wait_for_completion+0xae/0x130
[17162.273576]  [<ffffffff810a2460>] ? wake_up_q+0x70/0x70
[17162.273583]  [<ffffffffc03a16c1>] nvmet_sq_destroy+0x41/0x100 [nvmet]
[17162.273588]  [<ffffffffc027c298>] nvmet_rdma_free_queue+0x28/0x90 [nvmet_rdma]
[17162.273592]  [<ffffffffc027c31f>] nvmet_rdma_release_queue_work+0x1f/0x50 [nvmet_rdma]
[17162.273596]  [<ffffffff810915fb>] process_one_work+0x16b/0x480
[17162.273600]  [<ffffffff8109195b>] worker_thread+0x4b/0x500
[17162.273604]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[17162.273607]  [<ffffffff81091910>] ? process_one_work+0x480/0x480
[17162.273612]  [<ffffffff81097b58>] kthread+0xd8/0xf0
[17162.273616]  [<ffffffff8181fedf>] ret_from_fork+0x1f/0x40
[17162.273621]  [<ffffffff81097a80>] ? kthread_create_on_node+0x1a0/0x1a0
[21571.459716] nvmet: creating controller 2 for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:12345678.
[21571.516366] nvmet: adding queue 1 to ctrl 2.
[21571.570688] nvmet: adding queue 2 to ctrl 2.
[21571.626484] nvmet: adding queue 3 to ctrl 2.
[21571.682817] nvmet: adding queue 4 to ctrl 2.
[22894.868525] perf: interrupt took too long (5051 > 5050), lowering kernel.perf_event_max_sample_rate to 39500
[23907.862577] nvmet_rdma: freeing queue 5
[23955.790488] nvmet: ctrl 2 keep-alive timer (60 seconds) expired!
[23955.791663] nvmet_rdma: freeing queue 0
[23955.793137] nvmet_rdma: freeing queue 1
[23955.794551] nvmet_rdma: freeing queue 2
[23955.796222] nvmet_rdma: freeing queue 3


ROBERT RANDALL
Manager & Principal Engineer
NVE Device Drivers
Micron Technology, Inc.
