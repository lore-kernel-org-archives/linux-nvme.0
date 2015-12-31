From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Dec 2015 17:00:38 -0700
Subject: [RFC] CPU: New state for iopoll
In-Reply-To: <1451520039-18220-1-git-send-email-keith.busch@intel.com>
References: <1451520039-18220-1-git-send-email-keith.busch@intel.com>
Message-ID: <1451520039-18220-2-git-send-email-keith.busch@intel.com>

This accounts for CPU time spent polling for IO seperately from system
time.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-core.c            | 7 ++++++-
 fs/proc/stat.c              | 8 ++++++--
 include/linux/kernel_stat.h | 1 +
 include/linux/sched.h       | 1 +
 kernel/sched/cpuacct.c      | 1 +
 kernel/sched/cputime.c      | 7 ++++++-
 6 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 93810f2..b46fc2c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3330,6 +3330,7 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 	if (plug)
 		blk_flush_plug_list(plug, false);
 
+	current->in_iopoll = 1;
 	state = current->state;
 	while (!need_resched()) {
 		unsigned int queue_num = blk_qc_t_to_queue_num(cookie);
@@ -3342,19 +3343,23 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 		if (ret > 0) {
 			hctx->poll_success++;
 			set_current_state(TASK_RUNNING);
+			current->in_iopoll = 0;
 			return true;
 		}
 
 		if (signal_pending_state(state, current))
 			set_current_state(TASK_RUNNING);
 
-		if (current->state == TASK_RUNNING)
+		if (current->state == TASK_RUNNING) {
+			current->in_iopoll = 0;
 			return true;
+		}
 		if (ret < 0)
 			break;
 		cpu_relax();
 	}
 
+	current->in_iopoll = 0;
 	return false;
 }
 
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index 510413eb..5982efc 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -81,14 +81,14 @@ static int show_stat(struct seq_file *p, void *v)
 {
 	int i, j;
 	unsigned long jif;
-	u64 user, nice, system, idle, iowait, irq, softirq, steal;
+	u64 user, nice, system, idle, iowait, iopoll, irq, softirq, steal;
 	u64 guest, guest_nice;
 	u64 sum = 0;
 	u64 sum_softirq = 0;
 	unsigned int per_softirq_sums[NR_SOFTIRQS] = {0};
 	struct timespec boottime;
 
-	user = nice = system = idle = iowait =
+	user = nice = system = idle = iowait = iopoll =
 		irq = softirq = steal = 0;
 	guest = guest_nice = 0;
 	getboottime(&boottime);
@@ -98,6 +98,7 @@ static int show_stat(struct seq_file *p, void *v)
 		user += kcpustat_cpu(i).cpustat[CPUTIME_USER];
 		nice += kcpustat_cpu(i).cpustat[CPUTIME_NICE];
 		system += kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
+		iopoll += kcpustat_cpu(i).cpustat[CPUTIME_IOPOLL];
 		idle += get_idle_time(i);
 		iowait += get_iowait_time(i);
 		irq += kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
@@ -128,6 +129,7 @@ static int show_stat(struct seq_file *p, void *v)
 	seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(steal));
 	seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(guest));
 	seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(guest_nice));
+	seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(iopoll));
 	seq_putc(p, '\n');
 
 	for_each_online_cpu(i) {
@@ -135,6 +137,7 @@ static int show_stat(struct seq_file *p, void *v)
 		user = kcpustat_cpu(i).cpustat[CPUTIME_USER];
 		nice = kcpustat_cpu(i).cpustat[CPUTIME_NICE];
 		system = kcpustat_cpu(i).cpustat[CPUTIME_SYSTEM];
+		iopoll = kcpustat_cpu(i).cpustat[CPUTIME_IOPOLL];
 		idle = get_idle_time(i);
 		iowait = get_iowait_time(i);
 		irq = kcpustat_cpu(i).cpustat[CPUTIME_IRQ];
@@ -153,6 +156,7 @@ static int show_stat(struct seq_file *p, void *v)
 		seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(steal));
 		seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(guest));
 		seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(guest_nice));
+		seq_put_decimal_ull(p, ' ', cputime64_to_clock_t(iopoll));
 		seq_putc(p, '\n');
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 25a822f..c092745 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -28,6 +28,7 @@ enum cpu_usage_stat {
 	CPUTIME_STEAL,
 	CPUTIME_GUEST,
 	CPUTIME_GUEST_NICE,
+	CPUTIME_IOPOLL,
 	NR_STATS,
 };
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index edad7a4..b34830e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1458,6 +1458,7 @@ struct task_struct {
 	unsigned in_execve:1;	/* Tell the LSMs that the process is doing an
 				 * execve */
 	unsigned in_iowait:1;
+	unsigned in_iopoll:1;
 
 	/* Revert to default priority/policy when forking */
 	unsigned sched_reset_on_fork:1;
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index dd7cbb5..5ad3ad4 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -200,6 +200,7 @@ static int cpuacct_stats_show(struct seq_file *sf, void *v)
 	for_each_online_cpu(cpu) {
 		struct kernel_cpustat *kcpustat = per_cpu_ptr(ca->cpustat, cpu);
 		val += kcpustat->cpustat[CPUTIME_SYSTEM];
+		val += kcpustat->cpustat[CPUTIME_IOPOLL];
 		val += kcpustat->cpustat[CPUTIME_IRQ];
 		val += kcpustat->cpustat[CPUTIME_SOFTIRQ];
 	}
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 05de80b..887c1a9 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -222,6 +222,8 @@ void account_system_time(struct task_struct *p, int hardirq_offset,
 		index = CPUTIME_IRQ;
 	else if (in_serving_softirq())
 		index = CPUTIME_SOFTIRQ;
+	else if (p->in_iopoll)
+		index = CPUTIME_IOPOLL;
 	else
 		index = CPUTIME_SYSTEM;
 
@@ -367,7 +369,10 @@ static void irqtime_account_process_tick(struct task_struct *p, int user_tick,
 	} else if (p->flags & PF_VCPU) { /* System time or guest time */
 		account_guest_time(p, cputime, scaled);
 	} else {
-		__account_system_time(p, cputime, scaled,	CPUTIME_SYSTEM);
+		if (p->in_iopoll)
+			__account_system_time(p, cputime, scaled, CPUTIME_IOPOLL);
+		else
+			__account_system_time(p, cputime, scaled, CPUTIME_SYSTEM);
 	}
 }
 
-- 
2.6.2.307.g37023ba
