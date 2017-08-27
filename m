From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Aug 2017 18:00:41 +0200
Subject: [PATCH] nvme: fix uninitialized prp2 value on small transfers
In-Reply-To: <1503842197-29978-1-git-send-email-jschoenh@amazon.de>
References: <1503842197-29978-1-git-send-email-jschoenh@amazon.de>
Message-ID: <20170827160041.GA21416@lst.de>

On Sun, Aug 27, 2017@03:56:37PM +0200, Jan H. Sch?nherr wrote:
> The value of iod->first_dma ends up as prp2 in NVMe commands. In case
> there is not enough data to cross a page boundary, iod->first_dma is
> never initialized and contains random data.
> 
> Comply with the NVMe specification and fill in 0 in that case.

Zeroing it out is fine with me, but NVMe 1.3 says:

   PRP Entry 2 (PRP2): This field:
	a) is reserved if the data transfer does not cross a memory page boundary.

so I don't think the specification requires it to be zeroed.
What kind of controller do you have that wants PRP2 zeroed for transfers
that don't cross a page boundary?
