From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 13 Oct 2016 02:53:22 -0700
Subject: [PATCH 7/7 v2] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <c438c009-48fa-5fe3-5dce-bdc105a9e489@broadcom.com>
References: <57f82b14.jWEV18LIgDqDVRgP%james.smart@broadcom.com>
 <20161012103723.GA25068@infradead.org>
 <c438c009-48fa-5fe3-5dce-bdc105a9e489@broadcom.com>
Message-ID: <20161013095322.GC16162@infradead.org>

On Wed, Oct 12, 2016@01:12:34PM -0700, James Smart wrote:
> You've lost me. The fc-nvme api on the initiator side has a sgl relative to
> the original io request, while the fc-nvmet api on the target side has a
> different sgl from the target fc-nvme transport to the LLDD for the range of
> data to exchange. They are sgl's as they expect to go to fc hw on each side.
> As they are independent sgl's on each side, we have to copy between them.

Oh, right - your target sgls aren't caller provided.  That's a little
sad when looking at this code, but if it doesn't affect real drivers
I guess it's fine in the end.
