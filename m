From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Dec 2017 15:12:43 +0100
Subject: [PATCH 4/6] blk-mq: avoid to map CPU into stale hw queue
In-Reply-To: <20171212110232.12495-5-ming.lei@redhat.com>
References: <20171212110232.12495-1-ming.lei@redhat.com>
 <20171212110232.12495-5-ming.lei@redhat.com>
Message-ID: <20171212141243.GA7849@lst.de>

On Tue, Dec 12, 2017@07:02:30PM +0800, Ming Lei wrote:
> blk_mq_pci_map_queues() may not map one CPU into any hw queue, but its
> previous map isn't cleared yet, and may point to one stale hw queue
> index.
> 
> This patch fixes the following issue by clearing the mapping table before
> setting it up in blk_mq_pci_map_queues().

This needs to be done in the caller intead of the transport specific
queue map helpers.
