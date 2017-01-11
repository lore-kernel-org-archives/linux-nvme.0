From: hch@infradead.org (hch@infradead.org)
Date: Wed, 11 Jan 2017 08:12:38 -0800
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <1484150893.2619.1.camel@sandisk.com>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com>
Message-ID: <20170111161238.GA18881@infradead.org>

On Wed, Jan 11, 2017@04:08:31PM +0000, Bart Van Assche wrote:
> A typical Ethernet network adapter delays the generation of an interrupt
> after it has received a packet. A typical block device or HBA does not delay
> the generation of an interrupt that reports an I/O completion.

NVMe allows for configurable interrupt coalescing, as do a few modern
SCSI HBAs.
