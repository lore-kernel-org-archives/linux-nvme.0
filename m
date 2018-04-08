From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 8 Apr 2018 18:26:31 +0300
Subject: [PATCH 1/2 V2] nvme-rdma: Fix race between queue timeout and
 error recovery
In-Reply-To: <1523196519-23268-2-git-send-email-israelr@mellanox.com>
References: <1523196519-23268-1-git-send-email-israelr@mellanox.com>
 <1523196519-23268-2-git-send-email-israelr@mellanox.com>
Message-ID: <bf223d7b-42fb-1a85-fd22-9f93e68015ff@grimberg.me>


> When returning BLK_EH_HANDLED from nvme_rdma_timeout() the block layer
> complete the request.
> Error recovery may also complete the request when aborting the requests.
> 

This is still not a sufficient change log.

You need to describe why is this being done vs. invalidating the rkey
in the timeout handler. And what does "may also" mean?

Second, isn't the double completion protected by the request gstate?
