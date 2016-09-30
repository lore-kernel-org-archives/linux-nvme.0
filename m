From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Fri, 30 Sep 2016 08:55:59 -0700
Subject: [PATCH v2 4/7] blk-mq: Introduce blk_quiesce_queue() and
 blk_resume_queue()
In-Reply-To: <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
References: <f153ee47-e599-c333-92b0-d5da475012f3@sandisk.com>
 <a9eb4e95-6d77-e527-c42a-fd2e6f104bed@sandisk.com>
 <CACVXFVOO4P3RsnWci8XHdFoYBhNPq0KqjWJddsie-92+31bpEg@mail.gmail.com>
Message-ID: <9fb67745-954c-a70f-a89a-d184c99ae9aa@sandisk.com>

On 09/29/16 14:51, Ming Lei wrote:
> On Thu, Sep 29, 2016 at 7:59 AM, Bart Van Assche
> <bart.vanassche@sandisk.com> wrote:
>> blk_quiesce_queue() prevents that new queue_rq() invocations
>
> blk_mq_quiesce_queue()

Thanks, I will update the patch title and patch description.

>> +void blk_mq_quiesce_queue(struct request_queue *q)
>> +{
>> +       struct blk_mq_hw_ctx *hctx;
>> +       unsigned int i;
>> +       bool res, rcu = false;
>> +
>> +       spin_lock_irq(q->queue_lock);
>> +       WARN_ON_ONCE(blk_queue_quiescing(q));
>> +       queue_flag_set(QUEUE_FLAG_QUIESCING, q);
>> +       spin_unlock_irq(q->queue_lock);
>> +
>> +       res = __blk_mq_freeze_queue_start(q, false);
>
> Looks the implementation is a bit tricky and complicated, if the percpu
> usage counter isn't killed, it isn't necessary to touch .mq_freeze_depth
> since you use QUEUE_FLAG_QUIESCING to set/get this status of
> the queue.
 >
 > Then using synchronize_rcu() and rcu_read_lock()/rcu_read_unlock()
 > with the flag of QUIESCING may be enough to wait for completing
 > of ongoing invocations of .queue_rq() and avoid to run new .queue_rq,
 > right?

That's an interesting thought. Can you have a look at the attached patch 
in which blk_mq_quiesce_queue() no longer manipulates the 
mq_freeze_depth counter?

>> +       WARN_ON_ONCE(!res);
>> +       queue_for_each_hw_ctx(q, hctx, i) {
>> +               if (hctx->flags & BLK_MQ_F_BLOCKING) {
>> +                       mutex_lock(&hctx->queue_rq_mutex);
>> +                       mutex_unlock(&hctx->queue_rq_mutex);
>
> Could you explain a bit why all BLOCKING is treated so special? And
> that flag just means the hw queue always need to schedule asynchronously,
> and of course even though the flag isn't set, it still may be run
> asynchronously too. So looks it should be enough to just use RCU.

The mutex manipulations introduce atomic stores in the hot path. Hence 
the use of synchronize_rcu() and rcu_read_lock()/rcu_read_unlock() when 
possible. Since BLK_MQ_F_BLOCKING indicates that .queue_rq() may sleep 
and since sleeping is not allowed while holding the RCU read lock, 
queue_rq_mutex has been introduced for the BLK_MQ_F_BLOCKING case.

Bart.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-blk-mq-Introduce-blk_mq_quiesce_queue.patch
Type: text/x-patch
Size: 6466 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160930/0dd0b79e/attachment-0001.bin>
