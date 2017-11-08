From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Nov 2017 09:36:24 +0200
Subject: [PATCH] nvme-rdma: Use mr pool
In-Reply-To: <20171106164839.GA27494@lst.de>
References: <1509982181-6340-1-git-send-email-israelr@mellanox.com>
 <20171106164839.GA27494@lst.de>
Message-ID: <6b505330-3319-4016-be52-0dbdef56f2ce@grimberg.me>


> Also we shouldn't need the hack for the flush special case in
> nvme_rdma_post_send once we stop embedding the MR in struct request.

IIRC the flush hack was for the chelsio device for requests that are
not coming from the tagset and are freed possibly before we flush the
ib qp.
