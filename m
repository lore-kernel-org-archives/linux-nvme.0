From: jsmart2021@gmail.com (James Smart)
Date: Wed, 1 Nov 2017 09:03:37 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <20171101153817.GB13553@infradead.org>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <286e4dc4-af2c-3482-4345-a7b9984da994@grimberg.me>
 <ed37c118-6a9b-b4ab-dc8c-27eaa0c178f9@broadcom.com>
 <20171101153817.GB13553@infradead.org>
Message-ID: <7b7521f3-5412-4969-41dc-c5d87eacd72f@gmail.com>

On 11/1/2017 8:38 AM, Christoph Hellwig wrote:
> On Sun, Oct 29, 2017@09:43:14PM -0700, James Smart wrote:
>> Currently, the FC-NVME standard strongly suggests a discovery controller on
>> each target.
> 
> Yikes.  This is a new requirement not backed by anything in NVMe or
> NVMeoF itself.  Please have discussion in the technical working group
> on this behavior first.
> 
> It's not that I'm against it - but I really want this sort of optional
> transport behavior clearly documented in the actual NVMe spec first.
> 

See my last email.

The "strongly suggest" is laymans language for the word "should" that 
was used in the standard. Should was used so that discovery of the 
available discovery controllers on FC could be done in an automatic and 
dynamic way without apriori knowledge. Any FC target device is free to 
choose if and where they implement discovery controllers, just as on any 
other transport in nvmf.

We have had discussions in the technical working group and with nvme 
leadership on this and as I said, its well within what a transport can 
do. It's doing nothing illegal or odd. It doesn't require explicit 
documentation in a NVMe spec. It is in a NVME fabrics-based transport 
specification.

-- james
