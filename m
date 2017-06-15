From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:31:41 +0200
Subject: [PATCH v6 00/10] Implement NVMe Namespace Descriptor
 Identification
In-Reply-To: <20170607094536.32419-1-jthumshirn@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
Message-ID: <20170615163141.GA27307@lst.de>

On Wed, Jun 07, 2017@11:45:27AM +0200, Johannes Thumshirn wrote:
> A patch for nvmetcli and nvme-cli will follow shortly.

Can you send them out?  Especially as I want to debug why I don't seem
to get a uuid attribute with nvme-loop despite the fact that we should
always have one.
