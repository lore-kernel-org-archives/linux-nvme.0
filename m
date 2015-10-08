From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 8 Oct 2015 18:52:24 +0300
Subject: [PATCH 8/8] nvme: properly handle partially initialized queues in
 nvme_create_io_queues
In-Reply-To: <1443879587-23553-9-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-9-git-send-email-hch@lst.de>
Message-ID: <56169138.90804@dev.mellanox.co.il>

On 10/3/2015 4:39 PM, Christoph Hellwig wrote:
> This avoids having to clean up later in a seemingly unrelated place.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

I assume Keith reviewed this one correct? :)
