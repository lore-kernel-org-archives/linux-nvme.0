From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Oct 2018 11:30:58 -0700
Subject: [PATCH v3 0/2] nvmet-rdma: Rework the DoS mitigation code
In-Reply-To: <1540579520.66186.118.camel@acm.org>
References: <20181025211309.100564-1-bvanassche@acm.org>
 <56c7461f-d6c1-0fd2-30c8-334967fc3013@grimberg.me>
 <1540579520.66186.118.camel@acm.org>
Message-ID: <5de7d107-47b5-bf4d-1e7c-b4782b92acc3@grimberg.me>


>> I can't say I agree with rejecting random connect requests if we have
>> more then a maid up define resources queued for deletion. Given that
>> there is no real locking incorrectness in waiting a bit such that they
>> all drain. The issue is no more then a false complaint from lockdep.
>>
>> Given that there are a number of unknown factors that affect this such
>> as the number of hosts a target is servicing, the number of inflight I/O
>> that needs quiescing at the time of the removal, and the system resource
>> limits, any approach that has a hard-coded limit cannot be correct.
>>
>> If we do indeed want to get around the false report and not annotate it,
>> perhaps we should invoke rdma_destroy_id outside the work execution
>> context (such that it is destroyed before the work runs) and then the
>> dependency no longer exists?
> 
> Hi Sagi,
> 
> Thanks for having taken a look. However, I'm not sure that refusing some
> connection requests is really new behavior. From drivers/nvme/target/rdma.c:
> 
> 	ret = rdma_listen(cm_id, 128);
> 
> In other words, the maximum backlog for the CM ID through which connections
> are accepted is 128. What happens if a connection request is received and the
> backlog count is exceeded?

That is correct in theory, but I've never seen this limit being hit in
practice (maybe because its only relevant for iwarp).. The case where we
quiesce IO in queue shutdown is much more common.

> Regarding invoking rdma_destroy_id() from another context: which context
> should that be? rdma_destroy_id() locks and unlocks the handler mutex.
> Maintaining a list of CM IDs to be destroyed and iterating over that list
> from inside a CM ID handler function will cause nested locking because as
> you know CM ID handlers are called with the handler_mutex held. If we choose
> this approach we will have to be careful not to trigger lock inversion.

I thought maybe we should destroy the cm_id before queueing the work
(unless we are invoked from the cm_id handler in which case we can
return a non-zero code from the handler which will implicitly destroy
the cm_id).

But are we sure we can't simply resolve the false lockdep complaint?
