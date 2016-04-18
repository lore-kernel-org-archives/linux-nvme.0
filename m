From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Apr 2016 18:49:04 +0000
Subject: [PATCH 4/5] nvme: move namespace scanning to core
In-Reply-To: <57152B88.1080403@grimberg.me>
References: <1460982893-11315-1-git-send-email-hch@lst.de>
 <1460982893-11315-5-git-send-email-hch@lst.de>
 <57152B88.1080403@grimberg.me>
Message-ID: <20160418184903.GD4640@localhost.localdomain>

On Mon, Apr 18, 2016@09:46:32PM +0300, Sagi Grimberg wrote:
> Why does the affinity hints setting needs to happen
> after the ns scan?

The driver has no idea what queues are associated to which CPU(s) until
after the namespaces are registered with blk-mq. We need to know that
mapping before providing affinity hints.
