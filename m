From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Tue, 20 Oct 2015 13:30:59 +0300
Subject: [PATCH 07/18] nvme: simplify nvme_setup_prps calling convention
In-Reply-To: <1444975128-8768-8-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-8-git-send-email-hch@lst.de>
Message-ID: <562617E3.5060701@dev.mellanox.co.il>

On 10/16/2015 8:58 AM, Christoph Hellwig wrote:
> Pass back a true/false value instead of the length which needs a compare
> with the bytes in the request and drop the pointless gfp_t argument.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good to me,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
