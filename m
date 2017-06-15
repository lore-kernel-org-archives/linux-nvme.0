From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 15 Jun 2017 09:36:27 -0700
Subject: [PATCH 1/2] nvme: use a single NVME_AQ_DEPTH
In-Reply-To: <1497544496-25134-1-git-send-email-sagi@grimberg.me>
References: <1497544496-25134-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170615163627.GA31576@infradead.org>

On Thu, Jun 15, 2017@07:34:55PM +0300, Sagi Grimberg wrote:
> No need to differentiate fabrics from pci/loop. Will
> help us to consolidate some code in the future.

Note that Fabrics controller are not required to support more than
32 AQ entries.  So we probably should just lower the value for everyone
as there is no point in having more entries on PCIe either.
