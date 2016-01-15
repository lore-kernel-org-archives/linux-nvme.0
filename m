From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 Jan 2016 16:40:31 +0000
Subject: [PATCH RFC] nvme-core: Log the ctrl device instance name
In-Reply-To: <1452416444-22714-1-git-send-email-sagig@mellanox.com>
References: <1452416444-22714-1-git-send-email-sagig@mellanox.com>
Message-ID: <20160115164031.GA11165@localhost.localdomain>

On Sun, Jan 10, 2016@11:00:44AM +0200, Sagi Grimberg wrote:
> Having the ctrl instance name "nvmeX" seems much more friendly than
> the underlying device name. Also, with other nvme transports
> such as the soon to come nvme-loop we don't have an underlying
> device and it doesn't makes sense to make up one.

For PCI, I think this is okay if you add a message each time a device gets
an instance that ties it back to PCI device's name. Without something
like that, it doesn't look straight forward to match the NVMe device
name to it's PCI function just from the logs.
