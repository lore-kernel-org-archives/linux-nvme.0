From: hch@lst.de (Christoph Hellwig)
Date: Thu, 5 May 2016 16:06:56 +0200
Subject: [PATCH v3] NVMe: eliminate potential deadlock
 bynvme_get_ns_from_disk invoking nvme_free_ns
In-Reply-To: <1462411055-6197-1-git-send-email-shhuiw@foxmail.com>
References: <1462411055-6197-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <20160505140656.GB15000@lst.de>

On Thu, May 05, 2016@09:17:35AM +0800, Wang Sheng-Hui wrote:
> Release dev_list_lock before enter nvme_free_ns from
> nvme_get_ns_from_disk to avoid potential deadlock.
> 
> The change is finally made by Keith Busch, which
> improve v1/v2 version:
>     * Smaller change
>     * Fix the module reference drop issue in v2 version
>     * Remove gotos
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
