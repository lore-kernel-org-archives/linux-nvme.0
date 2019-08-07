From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Aug 2019 07:59:58 +0200
Subject: [PATCH v2 13/14] PCI/P2PDMA: No longer require no-mmu for host
 bridge whitelist
In-Reply-To: <20190730163545.4915-14-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-14-logang@deltatee.com>
Message-ID: <20190807055958.GC6627@lst.de>

no-mmu sounds stange, as we use that for linux ports without paging
hardware.  I think an "io" got lost somewhere..
