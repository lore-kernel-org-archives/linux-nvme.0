From: hch@lst.de (Christoph Hellwig)
Date: Tue, 3 May 2016 11:11:37 +0200
Subject: [PATCH] NVMe: eliminate potential deadlock by
 nvme_get_ns_from_disk invoking nvme_free_ns
In-Reply-To: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>
References: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <20160503091137.GA19645@lst.de>

On Tue, May 03, 2016@04:25:54PM +0800, Wang Sheng-Hui wrote:
> Release dev_list_lock before enter nvme_free_ns from
> nvme_get_ns_from_disk to avoid potential deadlock.
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
