From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 30 Oct 2017 10:14:08 +0200
Subject: [PATCH 2/2] nvme-rdma: Add remote_invalidation module parameter
In-Reply-To: <20171029175237.GD4488@ziepe.ca>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-3-git-send-email-idanb@mellanox.com>
 <20171029175237.GD4488@ziepe.ca>
Message-ID: <740c93f4-164e-d4e3-97b1-313a0420ae81@grimberg.me>


> Sagi, is this really an apples to apples comparison?

No

> When I was talking with Chuck on NFS there were some various issues on
> that side that made the local invalidate run faster, but it wasn't
> actually working properly.
> 
> Does nvme wait for the local invalidate to finish before moving on?

Not really, and we should, I'll get to it.
