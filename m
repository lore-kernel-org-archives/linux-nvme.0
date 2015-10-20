From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:54:32 +0300
Subject: [PATCH 09/18] nvme: move nvme_error_status to common code
In-Reply-To: <1444975128-8768-10-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-10-git-send-email-hch@lst.de>
Message-ID: <56261D68.4020706@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> And mark it inline so that we don't slow down the completion path by
> having to turn it into a forced out of line call.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
