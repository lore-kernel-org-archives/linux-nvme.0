From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Thu, 10 Aug 2017 09:37:03 -0300
Subject: nvmf question - synchronization between target/initiator
 regarding partitions
In-Reply-To: <20170810091626.GA21958@infradead.org>
References: <82c4d1d8-ffa9-fa99-df58-05e2945eafdc@linux.vnet.ibm.com>
 <c382184a-1621-c6b2-2a20-bd16498be998@suse.de>
 <4c199e9e-ed58-5a5b-cedc-2d3c3bc1464c@linux.vnet.ibm.com>
 <20170810091626.GA21958@infradead.org>
Message-ID: <1cd07b48-7d63-a636-eca5-2fd5201c69a0@linux.vnet.ibm.com>

On 08/10/2017 06:16 AM, Christoph Hellwig wrote:
> On Mon, Aug 07, 2017@02:29:47PM -0300, Guilherme G. Piccoli wrote:
>> Thanks for your feedback Hannes, agreed!
> 
> And btw, you'll see similar results with the SCSI target or nbd,
> so it's not really nvme specific.

Thanks, I agree - noticed the same stuff. I've used nvmf as a "trigger"
to the subject, in order to discuss a possible generic solution. But
since everything is working as expected, no need to pursue a "fix" heheh
