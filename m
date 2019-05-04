From: hch@lst.de (Christoph Hellwig)
Date: Sat, 4 May 2019 08:49:38 +0200
Subject: [PATCH v2 06/10] nvme/core: add mdev interfaces
In-Reply-To: <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
 <20190502114801.23116-7-mlevitsk@redhat.com>
 <20190503122902.GA5081@infradead.org>
 <d1c0c7ae-1a7d-06e5-d8bb-765a7fd5e41d@mellanox.com>
Message-ID: <20190504064938.GA30814@lst.de>

On Fri, May 03, 2019@10:00:54PM +0300, Max Gurtovoy wrote:
> Don't see a big difference of taking NVMe queue and namespace/partition to 
> guest OS or to P2P since IO is issued by external entity and pooled outside 
> the pci driver.

We are not going to the queue aside either way..  That is where the
last patch in this series is already working to, and which would be
the sensible vhost model to start with.
