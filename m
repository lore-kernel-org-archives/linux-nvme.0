From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 12:44:06 +0200
Subject: [PATCH] nvme_fc: correct hang in nvme_ns_remove()
In-Reply-To: <20180111234636.GA3243@localhost.localdomain>
References: <20180111232138.10669-1-jsmart2021@gmail.com>
 <eb86826e-3850-013b-ca07-e89021ea572e@gmail.com>
 <20180111234636.GA3243@localhost.localdomain>
Message-ID: <a1d6c135-cdb7-c71d-f860-8b42db7ae1f2@grimberg.me>


>> If you compare behavior of FC with rdma, rdma starts the queues at the tail
>> end of losing connectivity to the device - meaning any pending io and any
>> future io issued while connectivity has yet to
>> be re-established (e.g. in RECONNECTING state) will fail with an io
>> error. This is good, if there is a multipathing config, as it's a
>> near-immediate fast fail scenario. But... if there is no multipath,
>> it means applications and filesystems are now seeing io errors while
>> connectivity is pending and that can be disastrous.  FC currently
>> leaves the queues quiesced while connectivity is pending so io errors are
>> not seen. But this means FC won't fastfail the ios to the
>> multipath'er.
>>
>> For now I want to fix this keeping the existing FC behavior. From there, I'd
>> like the transports to block like FC does so no errors. However, a new timer
>> would be introduced for a "fast failure timeout" - which starts at loss of
>> connectivity and when expires, starts the queues and fails any pending and
>> future io.
>>
>> Thoughts ?
> 
> Yes, I think that sounds ok.
> 
> Longer term, I think it's a bit tacky that we rely on queue_rq to check
> for early termination states. Since we can quiece blk-mq, it'd be better
> if we introduce another tag iterator to end unstarted requests directly
> when we need to give up on the request, rather than rely on queue_rq. I
> was going to post a patch that does just that, but I still haven't gotten
> a chance to test it... :(

I agree with the fast_fail_tmo, we also need it for the multipath code
which currently blocks forever until either we reconnect successfully
or delete the controller.

James, are you looking into this? Note that this should be done in
nvme-core.
