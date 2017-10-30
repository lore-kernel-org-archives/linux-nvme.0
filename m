From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Mon, 30 Oct 2017 20:37:09 +0000
Subject: [PATCH v2 6/8] scsi/ipr: Use sgl_alloc_order() and
 sgl_free_order()
In-Reply-To: <ce6f2f5b-b4bc-380f-8ac1-1e91e4d6bf24@linux.vnet.ibm.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-7-bart.vanassche@wdc.com>
 <c804098f-5543-395c-1395-5778ef74a61b@suse.de>
 <ce6f2f5b-b4bc-380f-8ac1-1e91e4d6bf24@linux.vnet.ibm.com>
Message-ID: <1509395828.27259.21.camel@wdc.com>

On Wed, 2017-10-18@15:57 -0500, Brian King wrote:
> On 10/17/2017 01:19 AM, Hannes Reinecke wrote:
> > On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> > > [ ... ]
> > 
> > Not sure if this is a valid conversion.
> > Originally the driver would allocate a single buffer; with this buffer
> > we have two distinct buffers.
> > Given that this is used to download the microcode I'm not sure if this
> > isn't a hardware-dependent structure which requires a single buffer
> > including the sglist.
> > Brian, can you shed some light here?
> 
> The struct ipr_sglist is not a hardware defined data structure, so on initial
> glance, this should be OK. I'll load it up and give it a try to make sure
> it doesn't break code download.

Hello Brian,

Have you already obtained any test results?

Thanks,

Bart.
