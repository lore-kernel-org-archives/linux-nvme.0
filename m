From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 09:53:09 +0200
Subject: [PATCH 0/3] Improve readbility of NVME "wwid" attribute
In-Reply-To: <20170713222533.30794-1-mwilck@suse.com>
References: <20170713222533.30794-1-mwilck@suse.com>
Message-ID: <20170714075309.GA17877@lst.de>

On Fri, Jul 14, 2017@12:25:30AM +0200, Martin Wilck wrote:
> With the current implementation, the default "fallback" WWID generation
> code (if no nguid, euid etc. are defined) for Linux NVME host and target
> results in the following WWID format:
> 
> nvme.0000-3163653363666438366239656630386200-4c696e75780000000000000000000000000000000000000000000000000000000000000000000000-00000002
> 
> This is not only hard to read, it poses real problems for multipath
> (dm WWIDs are limited to 128 characters), and it's not fully standards
> compliant.

What standard?  The wwid field is a Linux invention. 
