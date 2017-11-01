From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 1 Nov 2017 09:28:24 -0700
Subject: [PATCH 0/5] nvmet/nvmet_fc: add events for discovery controller
 rescan
In-Reply-To: <7b7521f3-5412-4969-41dc-c5d87eacd72f@gmail.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <286e4dc4-af2c-3482-4345-a7b9984da994@grimberg.me>
 <ed37c118-6a9b-b4ab-dc8c-27eaa0c178f9@broadcom.com>
 <20171101153817.GB13553@infradead.org>
 <7b7521f3-5412-4969-41dc-c5d87eacd72f@gmail.com>
Message-ID: <20171101162824.GA15827@infradead.org>

On Wed, Nov 01, 2017@09:03:37AM -0700, James Smart wrote:
> The "strongly suggest" is laymans language for the word "should" that was
> used in the standard. Should was used so that discovery of the available
> discovery controllers on FC could be done in an automatic and dynamic way
> without apriori knowledge. Any FC target device is free to choose if and
> where they implement discovery controllers, just as on any other transport
> in nvmf.
> 
> We have had discussions in the technical working group and with nvme
> leadership on this and as I said, its well within what a transport can do.
> It's doing nothing illegal or odd. It doesn't require explicit documentation
> in a NVMe spec. It is in a NVME fabrics-based transport specification.

Please send a TP against Section 5 of the NVMeoF spec to add your
transport specific re-discovery notifications.
