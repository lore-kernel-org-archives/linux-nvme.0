From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Aug 2019 11:46:34 -0700
Subject: [PATCH rfc 2/2] nvme: fix possible use-after-free condition when
 controller reset is racing namespace scanning
In-Reply-To: <b6b929e7-3da5-f274-f7c8-4e98f8585917@suse.de>
References: <20190729233201.27993-1-sagi@grimberg.me>
 <20190729233201.27993-3-sagi@grimberg.me>
 <e3b0f11f-a66f-9b1a-6790-89efcaa33140@suse.de>
 <fb6c9d38-32f6-a659-f3b9-1c57f28b410d@grimberg.me>
 <b6b929e7-3da5-f274-f7c8-4e98f8585917@suse.de>
Message-ID: <97583db4-8ff5-9d13-bbc8-d133bbc3f28d@grimberg.me>


>> nvme_stop/start_queue are quiescing the queue, not freezing it which
>> does not block requests in blk_queue_enter.
>> So I don't think that blk_cleanup_queue will hang for unquiesced queues.
> 
> My worry here is for quiesced queues; they are not unquiesced when
> blk_clean_queue() is running. So I'm not sure if we're able to flush all
> commands then.

blk_cleanup_queue does not block on quiesced queues, it blocks on frozen
queues.

> But be it as it may, I've sent a patchset for checking the NS_REMOVING
> flag when traversing the namespace list. That should take care of this
> issue, and should render this patch obsolete.

I've shared feedback on that one, I need to understand what is the
crash that you are talking about.. and why not promoting the list
removal in nvme_ns_remove() doesn't address it.
