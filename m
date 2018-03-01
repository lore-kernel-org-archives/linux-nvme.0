From: james.smart@broadcom.com (James Smart)
Date: Thu, 1 Mar 2018 07:04:29 -0800
Subject: [PATCH] nvmet_fc: prevent new io rqsts in possible isr completions
In-Reply-To: <5e545915-14e1-857f-3013-ebd2687ab8e7@grimberg.me>
References: <20180228224911.15754-1-jsmart2021@gmail.com>
 <20180228224911.15754-2-jsmart2021@gmail.com>
 <5e545915-14e1-857f-3013-ebd2687ab8e7@grimberg.me>
Message-ID: <977c343e-12a5-1b95-8c10-f8c4fbaa2c4d@broadcom.com>

On 3/1/2018 4:04 AM, Sagi Grimberg wrote:
> Hi James,
>
>> When a bio completion calls back into the transport for a
>> back-end io device, the request completion path can free
>> the transport io job structure allowing it to be reused for
>> other operations.
>
> Is this true doe something that is not aborted?
??? I think -??? it's true regardless of whether the link-side io was 
aborted or not.
This is simply the bio completion path for say a read op, to get the 
data so the
transport can send it.

>
>> The transport has a defer_rcv queue which
>> holds temporary cmd rcv ops while waitng for io job structures.
>> when the job frees, if there's a cmd waiting, it is picked up
>> and submitted for processing, which can call back out to the
>> bio path if it's a read.? Unfortunately, what is unknown is the
>> context of the original bio done call, and it may be in a state
>> (softirq) that is not compatible with submitting the new bio in
>> the same calling sequence. This is especially true when using
>> scsi back-end devices as scsi is in softirq when it makes the
>> done call.
>>
>> Correct by scheduling the io to be started via workq rather
>> than calling the start new io path inline to the original bio
>> done path.
>
> Isn't free_iod called for every rsp completion? Is triggering defer_work
> unconditionally the optimal approach? In other words, won't that yield
> extra overhead in the "normal" case?

Yes, free_iod is on every completion. The check for defer_work is the 
overhead on every io. However, in most cases, there is never deferred 
work so the workq scheduling is rarely taken.? If it is taken, I'm fine 
with it always being a longer workq path.

The defer_rcv thing is an oddity about FC. In FC we really don't have 
dedicated landing buffers for all cmds. The transport allocates a io job 
struct for each SQ entry. But we found, the interaction with the lldd 
around sending the rsp back allowed the rsp to go on the wire and the 
initiator to send a new FC command, which could arrive before the 
adapter serviced its interrupt and did all the handshaking with the 
transport to return the job structure. So new cmd arrival beat free_iod 
even when under queue size limits.? This only happens when you are 
hovering at 100% full on the SQ.

-- james
