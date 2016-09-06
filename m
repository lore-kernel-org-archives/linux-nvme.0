From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 5 Sep 2016 23:24:35 -0700
Subject: [PATCH] nvme-rdma: fix null pointer dereference on req->mr
In-Reply-To: <20160905152438.14299-1-colin.king@canonical.com>
References: <20160905152438.14299-1-colin.king@canonical.com>
Message-ID: <20160906062435.GA25322@infradead.org>

On Mon, Sep 05, 2016@04:24:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king at canonical.com>
> 
> If there is an error on req->mr, req->mr is set to null, however
> the following statement sets req->mr->need_inval causing a null
> pointer dereference.  Fix this by bailing out to label 'out' to
> immediately return and hence skip over the offending null pointer
> dereference.
> 
> Fixes: f5b7b559e1488 ("nvme-rdma: Get rid of duplicate variable")
> Signed-off-by: Colin Ian King <colin.king at canonical.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
