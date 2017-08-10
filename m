From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 02:16:26 -0700
Subject: nvmf question - synchronization between target/initiator
 regarding partitions
In-Reply-To: <4c199e9e-ed58-5a5b-cedc-2d3c3bc1464c@linux.vnet.ibm.com>
References: <82c4d1d8-ffa9-fa99-df58-05e2945eafdc@linux.vnet.ibm.com>
 <c382184a-1621-c6b2-2a20-bd16498be998@suse.de>
 <4c199e9e-ed58-5a5b-cedc-2d3c3bc1464c@linux.vnet.ibm.com>
Message-ID: <20170810091626.GA21958@infradead.org>

On Mon, Aug 07, 2017@02:29:47PM -0300, Guilherme G. Piccoli wrote:
> Thanks for your feedback Hannes, agreed!

And btw, you'll see similar results with the SCSI target or nbd,
so it's not really nvme specific.
