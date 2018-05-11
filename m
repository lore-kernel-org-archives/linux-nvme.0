From: jsmart2021@gmail.com (James Smart)
Date: Fri, 11 May 2018 13:19:03 -0700
Subject: [PATCH 3/7] nvme_fc: retry failures to set io queue count
In-Reply-To: <20180508080041.62af2693@pentland.suse.de>
References: <20180508001214.8951-1-jsmart2021@gmail.com>
 <20180508001214.8951-4-jsmart2021@gmail.com>
 <20180508080041.62af2693@pentland.suse.de>
Message-ID: <481a6feb-1a3b-72b4-29a7-310d3525e21c@gmail.com>

On 5/7/2018 11:00 PM, Hannes Reinecke wrote:
> On Mon,  7 May 2018 17:12:10 -0700
> "James Smart" <jsmart2021@gmail.com> wrote:
> 
>> During the creation of a new controller association, it's possible for
>> errors and link connectivity issues to cause nvme_set_queue_count() to
>> have its SET_FEATURES command fail with a positive non-zero code. The
>> routine doesn't treat this as a hard error, instead setting the io
>> queue count to zero and returning success.  This has the result of the
>> transport setting the io queue count to 0, making the storage
>> controller inoperable. The message "...Could not set queue count..."
>> is seen.
>>
>> Revise the fc transport to detect when it asked for io queues but got
>> back a result of 0 io queues. In such a case, fail the re-connection
>> attempt and fall into the retry loop.
>>
>> Signed-off-by: James Smart <james.smart at broadcom.com>
>> ---
>>   drivers/nvme/host/fc.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
> The usual problem when having _two_ return values.
> Can't have nvme_set_queue_count() return the number of queues or a
> negative number on failure?
> Then the check would be much simplified.
> 
> Cheers,
> 
> Hannes
> 

the routine that nvme_set_queue_count() uses to perform the SET_FEATURES 
command to set the queue count returns either a negative error (linux 
error code), 0 for success, or a positive error (nvme command status 
value).   The nvme_set_queue_count() routine, in the case where it is a 
positive error - converts it to logging a message, setting io count to
zero, and returning success. In the case where it was a negative error,
nvme_set_queue_count() returns the negative error. Success sets the io 
count and returns zero.

In looking through history, it appears the desired to not fault 
controller connect if the SET_FEATURES command failed due to a nvme 
status was to allow the (degraded) controller to come up and at least 
offer the adminq for maintenance.

Obviously, my patch is reverting that "maintenance" path. This is a 
little more complex than desired as its not clear whether the nvme 
status was from a real device completion or one that was stamped by the 
transport as it recovered from a transport error or connectivity error 
(NVME_SC_ABORT_REQ  or NVME_SC_INTERNAL). Former is when you would want 
to continue, latter you want to fail. It appears the other transports 
stamp only NVME_SC_ABORT_REQ.

I'm going to repost with nvme_set_queue_count() returning failure 
(positive nvme result) if one of those two codes are returned. Any other 
status will keep the existing behavior.

-- james
