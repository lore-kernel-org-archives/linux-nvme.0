From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 17:00:39 -0700
Subject: [RFC] sysstat: Report iopoll CPU percentage
In-Reply-To: <1451520039-18220-1-git-send-email-keith.busch@intel.com>
References: <1451520039-18220-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451520039-18220-3-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 common.c   |  4 ++--
 iostat.c   | 10 ++++++----
 mpstat.c   | 18 ++++++++++++------
 rd_stats.c | 10 ++++++----
 rd_stats.h |  1 +
 5 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/common.c b/common.c
index 2510f67..1f3fb3e 100644
--- a/common.c
+++ b/common.c
@@ -605,11 +605,11 @@ unsigned long long get_per_cpu_interval(struct stats_cpu *scc,
 	 * because cpu_user and cpu_nice already include them.
 	 */
 	return ((scc->cpu_user    + scc->cpu_nice   +
-		 scc->cpu_sys     + scc->cpu_iowait +
+		 scc->cpu_sys     + scc->cpu_iowait + scc->cpu_iopoll +
 		 scc->cpu_idle    + scc->cpu_steal  +
 		 scc->cpu_hardirq + scc->cpu_softirq) -
 		(scp->cpu_user    + scp->cpu_nice   +
-		 scp->cpu_sys     + scp->cpu_iowait +
+		 scp->cpu_sys     + scp->cpu_iowait + scp->cpu_iopoll +
 		 scp->cpu_idle    + scp->cpu_steal  +
 		 scp->cpu_hardirq + scp->cpu_softirq) +
 		 ishift);
diff --git a/iostat.c b/iostat.c
index 4bf0342..eb0e906 100644
--- a/iostat.c
+++ b/iostat.c
@@ -824,10 +824,10 @@ void compute_device_groups_stats(int curr)
  */
 void write_cpu_stat(int curr, unsigned long long itv)
 {
-	printf("avg-cpu:  %%user   %%nice %%system %%iowait  %%steal   %%idle\n");
+	printf("avg-cpu:  %%user   %%nice %%system %%iowait %%iopoll %%steal   %%idle\n");
 
 	printf("       ");
-	cprintf_pc(6, 7, 2,
+	cprintf_pc(7, 7, 2,
 		   ll_sp_value(st_cpu[!curr]->cpu_user,   st_cpu[curr]->cpu_user,   itv),
 		   ll_sp_value(st_cpu[!curr]->cpu_nice,   st_cpu[curr]->cpu_nice,   itv),
 		   /*
@@ -839,6 +839,7 @@ void write_cpu_stat(int curr, unsigned long long itv)
 			       st_cpu[curr]->cpu_sys + st_cpu[curr]->cpu_softirq +
 			       st_cpu[curr]->cpu_hardirq, itv),
 		   ll_sp_value(st_cpu[!curr]->cpu_iowait, st_cpu[curr]->cpu_iowait, itv),
+		   ll_sp_value(st_cpu[!curr]->cpu_iopoll,   st_cpu[curr]->cpu_iopoll, itv),
 		   ll_sp_value(st_cpu[!curr]->cpu_steal,  st_cpu[curr]->cpu_steal,  itv),
 		   (st_cpu[curr]->cpu_idle < st_cpu[!curr]->cpu_idle) ?
 		   0.0 :
@@ -1088,7 +1089,7 @@ void write_stats(int curr, struct tm *rectime)
 			fprintf(stderr, "itv=%llu st_cpu[curr]{ cpu_user=%llu cpu_nice=%llu "
 					"cpu_sys=%llu cpu_idle=%llu cpu_iowait=%llu cpu_steal=%llu "
 					"cpu_hardirq=%llu cpu_softirq=%llu cpu_guest=%llu "
-					"cpu_guest_nice=%llu }\n",
+					"cpu_guest_nice=%llu cpu_io_poll:%llu}\n",
 				itv,
 				st_cpu[curr]->cpu_user,
 				st_cpu[curr]->cpu_nice,
@@ -1099,7 +1100,8 @@ void write_stats(int curr, struct tm *rectime)
 				st_cpu[curr]->cpu_hardirq,
 				st_cpu[curr]->cpu_softirq,
 				st_cpu[curr]->cpu_guest,
-				st_cpu[curr]->cpu_guest_nice);
+				st_cpu[curr]->cpu_guest_nice,
+				st_cpu[curr]->cpu_iopoll);
 		}
 #endif
 
diff --git a/mpstat.c b/mpstat.c
index 3b62aa0..5d642e7 100644
--- a/mpstat.c
+++ b/mpstat.c
@@ -227,7 +227,7 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 	int cpu;
 
 	if (dis) {
-		printf("\n%-11s  CPU    %%usr   %%nice    %%sys %%iowait    %%irq   "
+		printf("\n%-11s  CPU    %%usr   %%nice    %%sys %%iowait %%iopoll   %%irq   "
 		       "%%soft  %%steal  %%guest  %%gnice   %%idle\n",
 		       prev_string);
 	}
@@ -238,7 +238,7 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 		printf("%-11s", curr_string);
 		cprintf_in(IS_STR, " %s", " all", 0);
 
-		cprintf_pc(10, 7, 2,
+		cprintf_pc(11, 7, 2,
 			   (st_cpu[curr]->cpu_user - st_cpu[curr]->cpu_guest) <
 			   (st_cpu[prev]->cpu_user - st_cpu[prev]->cpu_guest) ?
 			   0.0 :
@@ -257,6 +257,9 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 			   ll_sp_value(st_cpu[prev]->cpu_iowait,
 				       st_cpu[curr]->cpu_iowait,
 				       g_itv),
+			   ll_sp_value(st_cpu[prev]->cpu_iopoll,
+				       st_cpu[curr]->cpu_iopoll,
+				       g_itv),
 			   ll_sp_value(st_cpu[prev]->cpu_hardirq,
 				       st_cpu[curr]->cpu_hardirq,
 				       g_itv),
@@ -302,8 +305,8 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 			if (!DISPLAY_ONLINE_CPU(flags)) {
 				printf("%-11s", curr_string);
 				cprintf_in(IS_INT, " %4d", "", cpu - 1);
-				cprintf_pc(10, 7, 2,
-					   0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
+				cprintf_pc(11, 7, 2,
+					   0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
 				printf("\n");
 			}
 			continue;
@@ -320,13 +323,13 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 			 * If the CPU is tickless then there is no change in CPU values
 			 * but the sum of values is not zero.
 			 */
-			cprintf_pc(10, 7, 2,
+			cprintf_pc(11, 7, 2,
 				   0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 100.0);
 			printf("\n");
 		}
 
 		else {
-			cprintf_pc(10, 7, 2,
+			cprintf_pc(11, 7, 2,
 				   (scc->cpu_user - scc->cpu_guest) < (scp->cpu_user - scp->cpu_guest) ?
 				   0.0 :
 				   ll_sp_value(scp->cpu_user - scp->cpu_guest,
@@ -343,6 +346,9 @@ void write_cpu_stats(int dis, unsigned long long g_itv, int prev, int curr,
 				   ll_sp_value(scp->cpu_iowait,
 					       scc->cpu_iowait,
 					       pc_itv),
+				   ll_sp_value(scp->cpu_iopoll,
+					       scc->cpu_iopoll,
+					       pc_itv),
 				   ll_sp_value(scp->cpu_hardirq,
 					       scc->cpu_hardirq,
 					       pc_itv),
diff --git a/rd_stats.c b/rd_stats.c
index 009b770..364cb29 100644
--- a/rd_stats.c
+++ b/rd_stats.c
@@ -85,7 +85,7 @@ void read_stat_cpu(struct stats_cpu *st_cpu, int nbr,
 			 * (user, nice, etc.) among all proc. CPU usage is not reduced
 			 * to one processor to avoid rounding problems.
 			 */
-			sscanf(line + 5, "%llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
+			sscanf(line + 5, "%llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
 			       &st_cpu->cpu_user,
 			       &st_cpu->cpu_nice,
 			       &st_cpu->cpu_sys,
@@ -95,7 +95,8 @@ void read_stat_cpu(struct stats_cpu *st_cpu, int nbr,
 			       &st_cpu->cpu_softirq,
 			       &st_cpu->cpu_steal,
 			       &st_cpu->cpu_guest,
-			       &st_cpu->cpu_guest_nice);
+			       &st_cpu->cpu_guest_nice,
+			       &st_cpu->cpu_iopoll);
 
 			/*
 			 * Compute the uptime of the system in jiffies (1/100ths of a second
@@ -120,7 +121,7 @@ void read_stat_cpu(struct stats_cpu *st_cpu, int nbr,
 				 * (user, nice, etc) for current proc.
 				 * This is done only on SMP machines.
 				 */
-				sscanf(line + 3, "%d %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
+				sscanf(line + 3, "%d %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
 				       &proc_nb,
 				       &sc.cpu_user,
 				       &sc.cpu_nice,
@@ -131,7 +132,8 @@ void read_stat_cpu(struct stats_cpu *st_cpu, int nbr,
 				       &sc.cpu_softirq,
 				       &sc.cpu_steal,
 				       &sc.cpu_guest,
-				       &sc.cpu_guest_nice);
+				       &sc.cpu_guest_nice,
+				       &sc.cpu_iopoll);
 
 				if (proc_nb < (nbr - 1)) {
 					st_cpu_i = st_cpu + proc_nb + 1;
diff --git a/rd_stats.h b/rd_stats.h
index decec04..392d67a 100644
--- a/rd_stats.h
+++ b/rd_stats.h
@@ -88,6 +88,7 @@ struct stats_cpu {
 	unsigned long long cpu_sys		__attribute__ ((aligned (16)));
 	unsigned long long cpu_idle		__attribute__ ((aligned (16)));
 	unsigned long long cpu_iowait		__attribute__ ((aligned (16)));
+	unsigned long long cpu_iopoll		__attribute__ ((aligned (16)));
 	unsigned long long cpu_steal		__attribute__ ((aligned (16)));
 	unsigned long long cpu_hardirq		__attribute__ ((aligned (16)));
 	unsigned long long cpu_softirq		__attribute__ ((aligned (16)));
-- 
2.6.2.307.g37023ba
