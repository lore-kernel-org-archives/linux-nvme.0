From: jmoyer@redhat.com (Jeff Moyer)
Date: Tue, 24 Nov 2015 10:51:04 -0500
Subject: [PATCH 04/47] block: provide a new BLK_EH_QUIESCED timeout return
 value
In-Reply-To: <20151124154019.GB5939@lst.de> (Christoph Hellwig's message of
 "Tue, 24 Nov 2015 16:40:19 +0100")
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-5-git-send-email-hch@lst.de>
 <x49mvu32zrw.fsf@segfault.boston.devel.redhat.com>
 <20151124154019.GB5939@lst.de>
Message-ID: <x491tbf2y6v.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> On Tue, Nov 24, 2015@10:16:51AM -0500, Jeff Moyer wrote:
>> Hi Christoph,
>> 
>> Christoph Hellwig <hch at lst.de> writes:
>> 
>> > This marks the request as one that's not actually completed yet, but
>> > should be reaped next time blk_mq_complete_request comes in.  This is
>> > useful it the abort handler kicked of a reset that will complete all
>> > pending requests.
>> 
>> What's the purpose, though?  Is this an optimization?
>
> It allows us to to correctly implement controller reset (like SCSI target
> resets) from the timeout handler.  The current HANDLED/NOT_HANDLED returns
> are not very useful if you want to eventually kick of a reset that will
> abort all requests, but needs to ensure the the requests don't get reused
> before that.  Only SCSI handles that for now, and needs it's own per-LUN
> command list and a lot of complex code for that - something we'd like
> to avoid for NVMe or other new drivers.

Thanks for the explanation.  One more question below.

>> We've had "fun" problems with races between completion and timeout
>> before.  I can't say I'm too keen on adding more complexity to this code
>> path.  Have you considered what happens in your new code when this race
>> occurs?  I don't expect it to cause any issues in the mq case, since the
>> timeout handler should run on the same cpu as the completion code for a
>> given request (right?).  However, for the old code path, they could run
>> in parallel.
>> 
>> blk_complete_request:
>> A  if (!blk_mark_rq_complete(rq) ||
>> B      test_and_cleart_bit(REQ_ATOM_QUIESCED, &req->atomic_flags)) {
>> C        __blk_mq_complete_request(rq);
>> 
>> could run alongside of:
>> 
>> blk_rq_check_expired:
>> 1 if (!blk_mark_rq_complete(rq))
>> 2   blk_rq_timed_out(rq);
>> 
>> So, if 1 comes before A, we have two cases to consider:
>> 
>> i.  the expiration path does not yet set REQ_ATOM_QUIESCED before the
>>     completion code runs, and so the completion code does nothing.
>
> The command has timed out and sets REQ_ATOM_COMPLETED first,
> the the actual completion comes in and does indeed nothing.  We now
> set REQ_ATOM_QUIESCED and kick off a controller reset, which will
> ultimatively complete all commands using blk_mq_complete_request.
> Now REQ_ATOM_QUIESCED is set on the command that caused the timeout,
> so it will be completed as well.
>
>> ii. the expiration path *does* SET REQ_ATOM_QUIESCED.  In this instance,
>>     will we get yet another completion for the request when the command
>>     is ultimately retired by the adapter reset?
>
> The command has timed out and sets REQ_ATOM_COMPLETED first, then
> REQ_ATOM_QUIESCED as well.  Now the actual completion comes in and does
> nothing because REQ_ATOM_COMPLETED was set.  We will then kick off the

See B above.  REQ_ATOM_COMPLETE is set, so the first half of that
statement is false, but then test_and_clear_bit(REQ_ATOM_QUIESCED...)
returns true, so we call __blk_complete_request.  So the question is,
will we get a double completion for that request after the reset is
performed?

-Jeff

p.s. That should be __blk_complete_request up there in 'C'.

> controller reset, which will ultimatively complete all commands using
> blk_mq_complete_request. Now REQ_ATOM_QUIESCED is set on the command that
> caused the timeout, so it will be completed as well.


> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
