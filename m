From: hare@suse.de (Hannes Reinecke)
Date: Wed, 11 Jan 2017 17:22:35 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <20170111161238.GA18881@infradead.org>
References: <20170111134312.GH6286@linux-x5ow.site>
 <1484150893.2619.1.camel@sandisk.com> <20170111161238.GA18881@infradead.org>
Message-ID: <2aff05af-5e83-7d3d-f879-2cce02b6d88c@suse.de>

On 01/11/2017 05:12 PM, hch@infradead.org wrote:
> On Wed, Jan 11, 2017@04:08:31PM +0000, Bart Van Assche wrote:
>> A typical Ethernet network adapter delays the generation of an interrupt
>> after it has received a packet. A typical block device or HBA does not delay
>> the generation of an interrupt that reports an I/O completion.
> 
> NVMe allows for configurable interrupt coalescing, as do a few modern
> SCSI HBAs.

Essentially every modern SCSI HBA does interrupt coalescing; otherwise
the queuing interface won't work efficiently.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
