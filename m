From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 01:59:05 -0700
Subject: [PATCH V3] nvme-pci: add sgl support
In-Reply-To: <20170801084803.GB7837@localhost.localdomain>
References: <20170726181931.21150-1-chaitanya.kulkarni@hgst.com>
 <4af4843c-1f8e-3b97-af79-ec065dbffd5b@grimberg.me>
 <MWHPR04MB1008D3259D1E7EDB5BAC0FDD86B30@MWHPR04MB1008.namprd04.prod.outlook.com>
 <20170801084803.GB7837@localhost.localdomain>
Message-ID: <20170810085905.GA12494@infradead.org>

On Tue, Aug 01, 2017@04:48:04AM -0400, Keith Busch wrote:
> On Tue, Aug 01, 2017@08:29:00AM +0000, Chaitanya Kulkarni wrote:
> > [CK] Yes, I've observed approximately %5 better
> > performance for IO sizes larger than 32k (for sgl_threshold = 32k).
> 
> Is that a physically contiguous 32k, or does each 4k require a different
> SG element? Could you try to force both conditions and see how each
> scenario compares with PRP?

How do we find out the segment alignment without walking the list of
biovecs, which would be rather annoying.
