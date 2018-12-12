From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Dec 2018 09:12:37 +0100
Subject: [PATCH 2/2] nvme-rdma: Handle completions if error_recovery fails
In-Reply-To: <24f0d05c-b309-a00d-ddd3-f13f0ac74268@grimberg.me>
References: <20181212065501.21580-1-nitzanc@mellanox.com>
 <20181212065501.21580-2-nitzanc@mellanox.com>
 <24f0d05c-b309-a00d-ddd3-f13f0ac74268@grimberg.me>
Message-ID: <20181212081237.GC29679@lst.de>

On Tue, Dec 11, 2018@11:56:26PM -0800, Sagi Grimberg wrote:
> Can't you live with just the two hunks above? and in the timeout
> handler you need to stop the queue before you complete the I/O to
> barrier against competing completions.
>
> Also, lets get rid of DNR while we're at it.
>
> I don't see why you need the others... I need further explanation for
> that.

Agreed.  Also there is a lot of churn here, some of it needs to be
split into well described self-contained prep patches.
