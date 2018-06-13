From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 04:32:10 -0700
Subject: [PATCH v3 3/4] nvme_fc: fix nulling of queue data on reconnect
In-Reply-To: <20180612235028.17969-4-jsmart2021@gmail.com>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-4-jsmart2021@gmail.com>
Message-ID: <20180613113210.GC18531@infradead.org>

On Tue, Jun 12, 2018@04:50:27PM -0700, James Smart wrote:
> The reconnect path is calling the init routines to clear a queue
> structure. But the queue structure has state that perhaps needs
> to persist as long as the controller is live.
> 
> Remove the nvme_fc_init_queue() calls on reconnect.
> The nvme_fc_free_queue() calls will clear state bits and reset
> any relevant queue state for a new connection.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Looks fine to me.
