From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jan 2016 14:49:01 +0000
Subject: [PATCH v1] nvme: Log the ctrl device name instead of the
 undelying pci device name
In-Reply-To: <1453126453-17976-1-git-send-email-sagig@mellanox.com>
References: <1453126453-17976-1-git-send-email-sagig@mellanox.com>
Message-ID: <20160128144900.GA3863@localhost.localdomain>

On Mon, Jan 18, 2016@04:14:13PM +0200, Sagi Grimberg wrote:
> Having the ctrl name "nvmeX" seems much more friendly than
> the underlying device name. Also, with other nvme transports
> such as the soon to come nvme-loop we don't have an underlying
> device so it doesn't makes sense to make up one.
> 
> In order to help matching an instance name to a pci function,
> we add a info print in nvme_probe.
> 
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>

Acked-by: Keith Busch <keith.busch at intel.com>
