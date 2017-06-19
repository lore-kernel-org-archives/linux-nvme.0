From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:52:31 -0400
Subject: [PATCH 5/6] nvme: track subsystems
In-Reply-To: <20170619095754.4602-6-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-6-hch@lst.de>
Message-ID: <20170619165231.GI21765@localhost.localdomain>

On Mon, Jun 19, 2017@11:57:53AM +0200, Christoph Hellwig wrote:
> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs unless
> the involved subsystems support multiple controllers.

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
