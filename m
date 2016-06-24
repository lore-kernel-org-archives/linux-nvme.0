From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 00:37:28 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160619230634.17229-1-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
Message-ID: <20160624073728.GA30277@infradead.org>

On Sun, Jun 19, 2016@04:06:31PM -0700, Jethro Beekman wrote:
> Hi all,
> 
> If an NVMe drive is locked with ATA Security, most commands sent to the drive 
> will fail. This includes commands sent by the kernel upon discovery to probe 
> for partitions. The failing happens in such a way that trying to do anything 
> with the drive (e.g. sending an unlock command; unloading the nvme module) is 
> basically impossible with the high default command timeout.

Do you have any spec that defines this ATA security protocol and how
it applies to NVMe?  The NVMe spec just referes to SPC4 for security
protocols, and I haven't been able to find a reference to an ATA
security protocol in it either, but I haven't tried hard yet.
