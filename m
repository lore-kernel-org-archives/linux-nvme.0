From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 7 Aug 2016 12:12:35 +0300
Subject: [PATCH RFC] nvme-rdma: Queue ns scanning after a sucessful
 reconnection
In-Reply-To: <1470330508.19927.18.camel@linux.intel.com>
References: <1469980540-16103-1-git-send-email-sagi@grimberg.me>
 <1470330508.19927.18.camel@linux.intel.com>
Message-ID: <ce424fe1-d6e8-706f-18f8-aa9c880bcdec@grimberg.me>


>> On an ordered target shutdown, the target can send a AEN on a
>> namespace
>> removal, this will trigger the host to queue ns-list query. The
>> shutdown
>> will trigger error recovery which will attepmt periodic reconnect.
>>
>> We can hit a race where the ns rescanning fails (error recovery
>> kicked
>> in and we're not connected) causing removing all the namespaces and
>> when
>> we reconnect we won't see any namespaces for this controller.
>>
>> So, queue a namespace rescan after we successfully reconnected to the
>> target.
>>
>> Note, that unlike user initiated controller reset, we don't need to
>> trigger
>> namespace scanning (until the point I noticed the above at least)
>> because we
>> reconnect to an existing controller. However due to the interaction
>> with
>> the aen mechanism we queue ns scan here as well.
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> I'm open to other suggestions if anyone has any...
>
> this sounds like a fix that should really go in the core target code
> instead of RDMA code as this could affect any implementation layer.

But it fixes the host behavior (nvme-rdma).

> If the target is shutting down I'm not sure why it would enter error
> recovery which would attempt a reconnect.  If the target is shutting
> down, shut down.  Maybe the keep-alive timer needs to stop
> (nvmet_stop_keep_alive_timer()???). I could see the benefit of the
> target emitting an AEN to tell the host to rescan for namespaces so it
> doesn't keep a stale list of namespaces after shutdown.

Its not the target entering error recovery, its the host. What would
you expect from a host that suddenly was disconnected by the target?
Not sure what other than periodic reconnects would be adequate...

The patch here just requeue ns scanning when we successfully reconnected
to the target that was restored.
