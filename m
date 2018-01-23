From: tim.oleksii@gmail.com (Oleksii Timofieiev)
Date: Tue, 23 Jan 2018 22:20:04 +0300
Subject: [PATCH] nvme-cli: wdc: Removed superfluous output in WDC plugin
Message-ID: <CAEx0bN_gF7S2OBnnhSyizU0LQA5mJdCMGB1h5C=805dRODA6MQ@mail.gmail.com>

Hello everyone,

Could please someone from WDC review my patch?
It aims to fix the issue reported
https://github.com/linux-nvme/nvme-cli/issues/285

Thank you!

>From a78fcae735e7b426e75cad81738d534fd1086a3a Mon Sep 17 00:00:00 2001
From: Oleksii Timofieiev <tim.oleksii@gmail.com>
Date: Tue, 23 Jan 2018 13:16:22 +0300
Subject: [PATCH] nvme-cli: wdc: Removed superfluous output in WDC plugin

Signed-off-by: Oleksii Timofieiev <tim.oleksii at gmail.com>
---
 wdc-nvme.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index 9590a9c..176b3c7 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -1110,8 +1110,6 @@ static void wdc_print_log_normal(struct
wdc_ssd_perf_stats *perf)
  (uint64_t)le64_to_cpu(perf->nr_blks));
  printf("  Average NAND Read Size                         %20f\n",
  safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
- printf("  Host Write Odd Start Commands                  %20"PRIu64"\n",
- (uint64_t)le64_to_cpu(perf->hw_os_cmds));
  printf("  Nand Write Commands                            %20"PRIu64"\n",
  (uint64_t)le64_to_cpu(perf->nw_cmds));
  printf("  NAND Write Blocks                              %20"PRIu64"\n",
@@ -1167,8 +1165,6 @@ static void wdc_print_log_json(struct
wdc_ssd_perf_stats *perf)
  (uint64_t)le64_to_cpu(perf->nr_blks));
  json_object_add_value_int(root, "Average NAND Read Size",
  safe_div_fp((le64_to_cpu(perf->nr_blks)), (le64_to_cpu((perf->nr_cmds)))));
- json_object_add_value_int(root, "Host Write Odd Start Commands",
- (uint64_t)le64_to_cpu(perf->hw_os_cmds));
  json_object_add_value_int(root, "Nand Write Commands",
  (uint64_t)le64_to_cpu(perf->nw_cmds));
  json_object_add_value_int(root, "NAND Write Blocks",


Best regards,
Oleksii
