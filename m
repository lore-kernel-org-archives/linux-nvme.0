From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 10:49:15 +0300
Subject: [PATCH rfc 01/30] nvme: Add admin connect request queue
In-Reply-To: <20170619071314.GA13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-2-git-send-email-sagi@grimberg.me>
 <20170619071314.GA13168@lst.de>
Message-ID: <5497966b-5f2e-ae17-c72c-50b2317ab798@grimberg.me>


>> In case we reconnect with inflight admin IO we
>> need to make sure that the connect comes before
>> the admin command. This can be only achieved by
>> using a seperate request queue for admin connects.
> 
> Use up a few more lines of the available space for your lines? :)

I warned in the cover-letter that the change logs are pure
negligence at the moment :)

> Wouldn't a head insertation also solve the problem?

the head insertion will not protect against it because
we must invoke blk_mq_start_stopped_hw_queues on the admin_q
request queue so the admin connect can make progress, at this
point (and before we actually queue up connect) pending admin
commands can sneak in...

However, you raise a valid point, I think I added this before we
had the queue_is_ready protection, which will reject the command
if the queue is not LIVE (unless its a connect). I think the reason
its still in is that I tested this with loop which doesn't have
a per-queue state machine.

I'm still wandering if its a good idea to rely on the transport
queue state to reject non-connect requests on non-LIVE queues.
if/when we introduce a queue representation to the core and we
drive the state machine there, then we could actually rely on it
(I do have some code for it, but its a pretty massive change which
cannot be added in an incremental fashion).

Thoughts?
