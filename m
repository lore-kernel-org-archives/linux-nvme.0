From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 30 Oct 2017 11:44:26 +0200
Subject: [PATCH 2/2] nvme-rdma: Add remote_invalidation module parameter
In-Reply-To: <7e038d80-de95-8fb7-e313-825e40c03e88@mellanox.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-3-git-send-email-idanb@mellanox.com>
 <20171029175237.GD4488@ziepe.ca>
 <740c93f4-164e-d4e3-97b1-313a0420ae81@grimberg.me>
 <7e038d80-de95-8fb7-e313-825e40c03e88@mellanox.com>
Message-ID: <38523e67-fa00-dd03-5b6f-34cd6f863c8f@grimberg.me>


> I agree we should fix this, nevertheless I don't expect this to create 
> an IO rate issue for long queue depths.
> Indeed we will have a tradeoff here of latency vs rate.

I suggest we hold back with this one for now, I have fixes for
the local invalidate flow. Once we get them in we can see if
this approach makes a difference, and if so, we need to expose
it through a generic mechanism.
