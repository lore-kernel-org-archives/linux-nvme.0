From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:01 -0700
Subject: [PATCH 10/18] intel: use correct endianess helpers in show_temp_stats
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-11-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 intel-nvme.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/intel-nvme.c b/intel-nvme.c
index e824a2e..a8a5041 100644
--- a/intel-nvme.c
+++ b/intel-nvme.c
@@ -129,14 +129,14 @@ static void show_temp_stats(struct intel_temp_stats *stats)
 {
 	printf("  Intel Temperature Statistics\n");
 	printf("--------------------------------\n");
-	printf("Current temperature         : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->curr));
-	printf("Last critical overtemp flag : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->last_overtemp));
-	printf("Life critical overtemp flag : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->life_overtemp));
-	printf("Highest temperature         : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->highest_temp));
-	printf("Lowest temperature          : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->lowest_temp));
-	printf("Max operating temperature   : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->max_operating_temp));
-	printf("Min operating temperature   : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->min_operating_temp));
-	printf("Estimated offset            : %"PRIu64"\n", (uint64_t)__le64_to_cpu(stats->est_offset));
+	printf("Current temperature         : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->curr));
+	printf("Last critical overtemp flag : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->last_overtemp));
+	printf("Life critical overtemp flag : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->life_overtemp));
+	printf("Highest temperature         : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->highest_temp));
+	printf("Lowest temperature          : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->lowest_temp));
+	printf("Max operating temperature   : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->max_operating_temp));
+	printf("Min operating temperature   : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->min_operating_temp));
+	printf("Estimated offset            : %"PRIu64"\n", (uint64_t)le64_to_cpu(stats->est_offset));
 }
 
 static int get_temp_stats_log(int argc, char **argv, struct command *cmd, struct plugin *plugin)
-- 
2.1.4
