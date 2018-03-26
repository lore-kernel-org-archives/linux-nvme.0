From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 Mar 2018 13:33:21 -0600
Subject: [PATCH 1/3] blk-mq: Allow PCI vector offset for mapping queues
In-Reply-To: <d818f023-01a5-0728-2cc9-7a0649b5df3c@oracle.com>
References: <20180323221923.24545-1-keith.busch@intel.com>
 <d818f023-01a5-0728-2cc9-7a0649b5df3c@oracle.com>
Message-ID: <20180326193320.GA30867@localhost.localdomain>

On Sat, Mar 24, 2018@09:55:49PM +0800, jianchao.wang wrote:
> Maybe we could provide a callback parameter for __blk_mq_pci_map_queues which
> give the mapping from hctx queue num to device-relative interrupt vector index.

If a driver's mapping is so complicated as to require a special per-hctx
callback, it'd be just as easy to implement the mapping in that driver's
blk_mq_ops' 'map_queues' directly.
