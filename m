From: hare@suse.de (Hannes Reinecke)
Date: Tue, 23 Apr 2019 16:07:49 +0200
Subject: [PATCH V6 6/9] blk-mq: always free hctx after request queue is
 freed
In-Reply-To: <20190423133015.GA31728@ming.t460p>
References: <20190417034410.31957-1-ming.lei@redhat.com>
 <20190417034410.31957-7-ming.lei@redhat.com>
 <63c09210-c20e-6b4a-56fa-b9eac2807cc1@suse.de>
 <20190417125943.GB5007@ming.t460p> <20190422033057.GC21375@ming.t460p>
 <9d93cb74-0683-bb42-2545-b4bb2bfbb831@suse.de>
 <20190423133015.GA31728@ming.t460p>
Message-ID: <b7e1ad43-9ea1-8ecf-6e1f-97343c45b82f@suse.de>

On 4/23/19 3:30 PM, Ming Lei wrote:
> Hi Hannes,
> 
> Thanks for your response.
> 
> On Tue, Apr 23, 2019@01:19:33PM +0200, Hannes Reinecke wrote:
>> On 4/22/19 5:30 AM, Ming Lei wrote:
[ .. ]
>>>
>>> Hi Hannes,
>>>
>>> Could you please let us know if you have better idea for this issue?
>>> Otherwise, I think we need to move on since it is real issue, and users
>>> want to fix that.
>>>
>> Okay. Having looked over the problem and possible alternatives, it looks
>> indeed like a viable solution.
>> I do agree that it's a sensible design to have an additional holding area
>> for hardware context elements, given that they might be reassigned during
>> blk_mq_realloc_hw_ctxs().
>>
>> However, I would rename the 'dead' elements to 'unused' (ie unused_hctx_list
>> etc).
> 
> OK, looks the name of 'unused' is better.
> 
>>
>> And I would deallocate q->queue_hw_ctx in blk_mq_exit_queue() to make things
>> more consistent.
> 
> No, that is wrong.
> 
> The request queue's refcount is often held when blk_cleanup_queue() is running,
> and blk_mq_exit_queue() is called directly by blk_cleanup_queue(). One invariant
> is that we have to allow most APIs running well if the request queue is live
> from kobject view. If q->queue_hw_ctx is freed in blk_mq_exit_queue(),
> it is quite easy to cause use-after-free.
> 
Ah. Thought as much.
But then in most cases the ->queue_hw_ctx pointer is immaterial as we're 
accessing things via the hctx pointer, which remains valid.

>> Problem with the current patch is that in blk_mq_release() we iterate
>> the 'dead_hctx_list' and free up everything in there, but then blindly call
>> 'kfree(q->queue_hw_ctx)' without checking if there are any context pointers
>> left.
> 
> If request queue is dead, it is safe to assume that there isn't any
> reference to request queue and q->queue_hw_ctx. Otherwise, it must be
> a bug somewhere.
> 
Precisely.
What I'm trying to achieve with this is to protect against such issues, 
which are quite easy to introduce given the complexity of the code ...

>> When moving the call to blk_mq_exit_queue() we could to a simple
>> WARN_ON(q->queue_hw_ctx) in blk_mq_release() to ensure that everything got
>> deallocated properly.
> 
> At that time, hctx instance might be active, but that is fine given hctx
> is covered by its own kobject. What we need to do is to make sure that no
> any references to q->queue_hw_ctx and the request queue.
> 
My point being here:
void blk_mq_release(struct request_queue *q)
{
         struct blk_mq_hw_ctx *hctx, *next;

         cancel_delayed_work_sync(&q->requeue_work);

         /* all hctx are in .dead_hctx_list now */
         list_for_each_entry_safe(hctx, next, &q->dead_hctx_list, 
hctx_list) {
                 list_del_init(&hctx->hctx_list);
                 kobject_put(&hctx->kobj);
         }

         kfree(q->queue_hw_ctx);

         /*
          * release .mq_kobj and sw queue's kobject now because
          * both share lifetime with request queue.
          */
         blk_mq_sysfs_deinit(q);
}

This assumes that _all_ hctx pointers are being removed from 
q->queue_hw_ctx, and are moved to the 'dead' list.
If for some reason this is not the case we'll be leaking hctx pointers here.
And as the reference counting _really_ is tricky it would be a good idea 
to have some safety checking here (ie if all hctx pointers from 
->queue_hw_ctx are indeed NULL) before calling kfree().

This is what I was attempting by moving the kfree() to 
blk_mq_exit_queue(), as then we could validate that we've moved all hctx 
pointers to the dead list by simply checking if ->queue_hw_ctx is NULL.

But just blindly calling 'kfree()' here is dangerous IMO.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
