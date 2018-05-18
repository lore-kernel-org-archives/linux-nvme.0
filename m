From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 15:22:20 -0600
Subject: [PATCH 5/7] nvme-pci: handle completions outside of the queue lock
In-Reply-To: <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-6-git-send-email-axboe@kernel.dk>
 <20180518210630.GD27795@localhost.localdomain>
 <93585ba6-32a3-d8aa-ad5c-ee22be3e8e8e@kernel.dk>
Message-ID: <968c010b-7129-fdb2-44aa-03d76d8746e8@kernel.dk>

On 5/18/18 3:11 PM, Jens Axboe wrote:
> On 5/18/18 3:06 PM, Keith Busch wrote:
>> On Fri, May 18, 2018@08:52:33AM -0600, Jens Axboe wrote:
>>> Note that this kills the ->cqe_seen as well. I haven't been able to
>>> trigger any ill effects of this. If we do race with polling every so
>>> often, it should be rare enough NOT to trigger any issues.
>>
>> Ah hell, running HIPRI tests on low latency devices is hitting spruious
>> interrupt detection:
>>
>> [  560.169153] irq 630: nobody cared (try booting with the "irqpoll" option)
>> [  560.175988] CPU: 40 PID: 0 Comm: swapper/40 Not tainted 4.17.0-rc2+ #65
>> [  560.175990] Hardware name: Intel Corporation S2600STB/S2600STB, BIOS SE5C620.86B.00.01.0010.010920180151 01/09/2018
>> [  560.175991] Call Trace:
>> [  560.175994]  <IRQ>
>> [  560.176005]  dump_stack+0x5c/0x7b
>> [  560.176010]  __report_bad_irq+0x30/0xc0
>> [  560.176013]  note_interrupt+0x235/0x280
>> [  560.176020]  handle_irq_event_percpu+0x51/0x70
>> [  560.176023]  handle_irq_event+0x27/0x50
>> [  560.176026]  handle_edge_irq+0x6d/0x180
>> [  560.176031]  handle_irq+0xa5/0x110
>> [  560.176036]  do_IRQ+0x41/0xc0
>> [  560.176042]  common_interrupt+0xf/0xf
>> [  560.176043]  </IRQ>
>> [  560.176050] RIP: 0010:cpuidle_enter_state+0x9b/0x2b0
>> [  560.176052] RSP: 0018:ffffa0ed4659fe98 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
>> [  560.176055] RAX: ffff9527beb20a80 RBX: 000000826caee491 RCX: 000000000000001f
>> [  560.176056] RDX: 000000826caee491 RSI: 00000000335206ee RDI: 0000000000000000
>> [  560.176057] RBP: 0000000000000001 R08: 00000000ffffffff R09: 0000000000000008
>> [  560.176059] R10: ffffa0ed4659fe78 R11: 0000000000000001 R12: ffff9527beb29358
>> [  560.176060] R13: ffffffffa235d4b8 R14: 0000000000000000 R15: 000000826caed593
>> [  560.176065]  ? cpuidle_enter_state+0x8b/0x2b0
>> [  560.176071]  do_idle+0x1f4/0x260
>> [  560.176075]  cpu_startup_entry+0x6f/0x80
>> [  560.176080]  start_secondary+0x184/0x1d0
>> [  560.176085]  secondary_startup_64+0xa5/0xb0
>> [  560.176088] handlers:
>> [  560.178387] [<00000000efb612be>] nvme_irq [nvme]
>> [  560.183019] Disabling IRQ #630
> 
> Gah, I didn't manage to trigger any of that. What was your test case?
> I'll see if I can come up with a nice cqe_seen replacement.

Totally untested, does this work?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 06d1a5cd619e..d1efe6b0f107 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -159,6 +159,7 @@ struct nvme_queue {
 	s16 cq_vector;
 	u16 sq_tail;
 	u16 cq_head;
+	u16 last_cq_head;
 	u16 qid;
 	u8 cq_phase;
 	u32 *dbbuf_sq_db;
@@ -998,16 +999,22 @@ static inline bool nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	struct nvme_queue *nvmeq = data;
+	irqreturn_t ret = IRQ_NONE;
 	u16 start, end;
 
 	spin_lock(&nvmeq->cq_lock);
+	if (nvmeq->cq_head != nvmeq->last_cq_head)
+		ret = IRQ_HANDLED;
 	nvme_process_cq(nvmeq, &start, &end, -1);
+	nvmeq->last_cq_head = nvmeq->cq_head;
 	spin_unlock(&nvmeq->cq_lock);
 
-	if (start == end)
-		return IRQ_NONE;
-	nvme_complete_cqes(nvmeq, start, end);
-	return IRQ_HANDLED;
+	if (start != end) {
+		nvme_complete_cqes(nvmeq, start, end);
+		return IRQ_HANDLED;
+	}
+
+	return ret;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)

-- 
Jens Axboe
