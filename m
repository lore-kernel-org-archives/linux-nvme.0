From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 27 Jun 2018 11:06:22 +0300
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180627073328.aws2apvc357jobge@linux-x5ow.site>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
 <20180626150106.GB6628@localhost.localdomain>
 <20180627073328.aws2apvc357jobge@linux-x5ow.site>
Message-ID: <1e7d0f93-9d20-1b99-58c4-651b1d0dedf0@grimberg.me>


>> Not related to your patch, but I did notice that the req->q->id isn't
>> really useful here since that's not the hardware context identifier.
>> That's just some ida assigned software identifier. For the admin command
>> completion trace, it's actually a little confusing to see the qid in the
>> trace.
> 
> It was actually requested by Martin so we can easily see which request
> got dispatched/completed on which request queue.

Would be good in the future to display the hwqid, but we'll need to work
before we can do that.

Maybe change the display to request_queue_id=%d?
