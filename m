From: jsmart2021@gmail.com (James Smart)
Date: Fri, 8 Sep 2017 09:11:12 -0700
Subject: [PATCH] nvme: allow timed-out ios to retry
In-Reply-To: <20170907203759.GA2832@localhost.localdomain>
References: <20170907201804.24979-1-jsmart2021@gmail.com>
 <20170907203759.GA2832@localhost.localdomain>
Message-ID: <a6b3ce68-1df1-7d9a-0234-a7aab59cd863@gmail.com>

On 9/7/2017 1:37 PM, Keith Busch wrote:
> On Thu, Sep 07, 2017@01:18:04PM -0700, James Smart wrote:
>> Currently the nvme_req_needs_retry() applies several checks to see if
>> a retry is allowed. On of those is whether the current time has exceeded
>> the start time of the io plus the timeout length. This check, if an io
>> times out, means there is never a retry allowed for the io. Which means
>> applications see the io failure.
>>
>> Remove this check and allow the io to timeout, like it does on other
>> protocols, and retries to be made.
>>
>> On the FC transport, a frame can be lost for an individual io, and there
>> may be no other errors that escalate for the connection/association.
>> The io will timeout, which causes the transport to escalate into creating
>> a new association, but the io that timed out, due to this retry logic, has
>> already failed back to the application and things are hosed.
> 
> I'm a bit conflicted on this. While it'd be nice to give commands a chance
> to succeed after a timeout handling's controller reset, some uses would
> rather a command fail fast than succeed slow, and this change could keep
> a request outstanding for a very long time.
> 
> What if we have a second timeout value: one for in-flight timeout before
> abort/controller resset, and another for total request lifetime?

I believe its mandatory to allow an in-flight timeout and at least 1 
retry, unless the io callee explicitly disables the retry.  We can't 
make an enterprise-quality solution otherwise.

I assume the existing NVME_IO_TIMEOUT value is what we continue to use 
for the in-flight timeout. "In-flight" defined as outstanding and 
waiting on the controller: i.e. placed on the SQ by the host/transport 
and no corresponding completion received from the controller.

I'm ok with a lifetime timeout. But - is it necessary? Usually the 
lifetime timeout is (io timeout * # retries allowed) and it allows for 
slop as the "timeout" recovery isn't always immediate/instantaneous. In 
other words, Timeout will fire at time X, then the transport does what 
it needs to recover the io as of the timeout, which may take an 
additional amount of time Y, then the retry determinism kicks in. So 
it's not a hard M time ticks.

Like SCSI added "fast_io_fail_tmo" to it's similar "blocked" conditions 
for an io - I expect we need a 3rd timeout for "fastfail". I/O is 
stopped/terminated when the controller is reset or reconnect started. If 
a further retry is not allowed, it will fail back to the callee. If a 
further retry is allowed, the io is queued on the blk queue, but the blk 
queue is stopped by the transport waits for controller reconnection. The 
fastfail timer would start as of the blocking of the blk queues. The 
timer would be cancelled if connectivity is restored and the blk queue 
released again allowing the io to be in-flight again. Timeout expiration 
would fail all pending io on the block queue with a connectivity status 
error and no further retries attempted.


-- james
