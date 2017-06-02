From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Fri, 2 Jun 2017 22:19:53 +0000
Subject: [PATCH v3 3/9] blk-mq: use the introduced blk_mq_unquiesce_queue()
In-Reply-To: <20170602020041.GE30505@ming.t460p>
References: <20170531123706.20885-1-ming.lei@redhat.com>
 <20170531123706.20885-4-ming.lei@redhat.com>
 <1496244100.2608.3.camel@sandisk.com> <20170601005423.GA23563@ming.t460p>
 <1496358538.3075.12.camel@sandisk.com> <20170602020041.GE30505@ming.t460p>
Message-ID: <1496441991.1214.25.camel@sandisk.com>

On Fri, 2017-06-02@10:00 +0800, Ming Lei wrote:
> On Thu, Jun 01, 2017@11:09:00PM +0000, Bart Van Assche wrote:
> > My opinion is that scsi_internal_device_block() and scsi_internal_device_unblock()
> > should be changed as follows for the scsi-mq code path:
> > * scsi_internal_device_block() should call blk_mq_quiesce_queue(q) if the "wait"
> >   argument is true and should set the QUEUE_FLAG_QUIESCED flag if the "wait"
> >   argument is false.
> > * scsi_internal_device_unblock() should call blk_mq_unquiesce_queue().
> > 
> > I am aware it sounds weird to set the QUEUE_FLAG_QUIESCED flag without waiting
> > until ongoing .queue_rq() calls have finished. The only driver that triggers
> 
> This way may break the contract of blk_mq_quiesce_queue() and is really weird.
> And the above change shouldn't be related with this patchset, so better
> to do whatever you want once this patch is merged.

No, what I proposed doesn't break the contract of blk_mq_quiesce_queue().
The contract of that function is that if it is called that all pending
.queue_rq() calls have finished and no new .queue_rq() calls will occur
until blk_mq_unquiesce_queue() is called. Since the wait == false path does
not call blk_mq_quiesce_queue() that contract does not apply.

> This patchset won't break current SCSI uses of blk_mq_quiesce_queue() and
> won't cause regression, and I setup one iSCSI target yesterday and it works
> just fine, how about just keeping this patch as it is?

As I explained in a previous e-mail, the iSCSI initiator driver does not
trigger the wait == false path so your test did not trigger that code path.

Something else I explained in a previous e-mail is that your patch makes it
impossible to use the STOPPED flag in the SCSI core what it was originally
intended for, namely preventing that the block layer keeps trying to queue
requests while the block driver knows that it will have to return "BUSY".
This is why I asked you to modify the SCSI integration of your patch.

Bart.
