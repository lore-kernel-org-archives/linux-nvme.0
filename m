From: jsmart2021@gmail.com (James Smart)
Date: Thu, 11 Jan 2018 15:34:58 -0800
Subject: [PATCH] nvme_fc: correct hang in nvme_ns_remove()
In-Reply-To: <20180111232138.10669-1-jsmart2021@gmail.com>
References: <20180111232138.10669-1-jsmart2021@gmail.com>
Message-ID: <eb86826e-3850-013b-ca07-e89021ea572e@gmail.com>

If you compare behavior of FC with rdma, rdma starts the queues at the 
tail end of losing connectivity to the device - meaning any pending io 
and any future io issued while connectivity has yet to
be re-established (e.g. in RECONNECTING state) will fail with an io
error. This is good, if there is a multipathing config, as it's a
near-immediate fast fail scenario. But... if there is no multipath,
it means applications and filesystems are now seeing io errors while
connectivity is pending and that can be disastrous.  FC currently
leaves the queues quiesced while connectivity is pending so io errors 
are not seen. But this means FC won't fastfail the ios to the
multipath'er.

For now I want to fix this keeping the existing FC behavior. From there, 
I'd like the transports to block like FC does so no errors. However, a 
new timer would be introduced for a "fast failure timeout" - which 
starts at loss of connectivity and when expires, starts the queues and 
fails any pending and future io.

Thoughts ?

-- james


On 1/11/2018 3:21 PM, James Smart wrote:
> When connectivity is lost to a device, the association is terminated
> and the blk-mq queues are quiesced/stopped. When connectivity is
> re-established, they are resumed.
> 
> If connectivity is lost for a sufficient amount of time that the
> controller is then deleted, the delete path starts tearing down queues,
> and eventually calling nvme_ns_remove(). It appears that pending
> commands may cause blk_cleanup_queue() to never complete and the
> teardown stalls.
> 
> Correct by starting the ns queues after transitioning to a DELETING
> state, allowing pending commands to be flushed with io failures. Thus
> the delete path is clear when reached.
