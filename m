From: james.smart@broadcom.com (James Smart)
Date: Mon, 14 May 2018 08:08:12 -0700
Subject: [PATCH v2 2/7] nvme: revise nvme_set_queue_count to return error
 on some nvme status codes
In-Reply-To: <20180512133453.GB14317@infradead.org>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
 <20180512005028.29661-3-jsmart2021@gmail.com>
 <20180512133453.GB14317@infradead.org>
Message-ID: <9a65c024-1a33-ff97-f5fe-38f147eb082c@broadcom.com>

On 5/12/2018 6:34 AM, Christoph Hellwig wrote:
> On Fri, May 11, 2018@05:50:23PM -0700, James Smart wrote:
>> The status codes that transports may generate are NVME_SC_ABORT_REQ and
>> NVME_SC_INTERNAL. In those cases, return a positive error value with the
>> value being the status code.
> No, your transport should not come up with fake nvme errors, sorry.
>
> And we need this code to ignore errors to bring up various
> PCIe controller in degraded conditions.

It's not making up fake errors, per say. All transports, when they 
terminate io for an association that fails, kick them back with at least 
the aborted status. FC does have the internal value as well for 
transport-specific errors.? What is happening here - the controller 
initialization starts, but then connectivity is lost before it can 
complete. In this case, it occurred right as the SET_PROPERTY for io 
queues was outstanding.?? I wish the core code wasn't so expectant on 
the happy path, as even if we get past this error, it's very chatty on 
errors and can scare an admin even when the issues are fully recoverable.

Looking closer at the issue, there are two concerns:
a) the setting of the io queue count to zero persists in future 
connection attempts;
b) if the transport intercepts and kills the io, and the controller 
continues to come live in the os, is there any way the transport won't 
kill the association and retry ??? because otherwise, it is stuck in a 
"bogus" degraded mode.

for (a): the transport recalculates the io queue count on each new 
association attempt and ignores previous values. Except that it is used 
to size the hw_queues on the io request queue when it's initially 
created.? I assume the blk_mq_update_nr_hw_queues() call is sufficient 
to resize it on the next association.

for (b): I can't come up with a scenario where the transport would not 
be taking the association down due to the error that generated the 
failure on the command.

As such, I guess I can pull this patch and drop it. It's not necessary.

-- james
