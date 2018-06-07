From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 13:27:19 +0200
Subject: [PATCH 2/3] nvme: do not access request after calling
 blk_mq_end_request()
In-Reply-To: <20180607083847.51019-3-hare@suse.de>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-3-hare@suse.de>
Message-ID: <20180607112719.GB10939@lst.de>

On Thu, Jun 07, 2018@10:38:46AM +0200, Hannes Reinecke wrote:
> After calling blk_mq_end_request() the request should be considered
> freed, so accessing it afterwards might lead to use-after-free error.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

Looks fine, although I'd call the variable status instead of nvme_status.

I'll fold this into the next ANA series given that as-is it isn't going
to apply anyway..
