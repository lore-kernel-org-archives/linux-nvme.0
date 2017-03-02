From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 Mar 2017 07:52:42 -0800
Subject: [PATCH] nvme: Correct NVMF enum values to match NVMe-oF rev 1.0
In-Reply-To: <20170302022201.2946-1-roland@kernel.org>
References: <20170302022201.2946-1-roland@kernel.org>
Message-ID: <20170302155242.GA31807@infradead.org>

On Wed, Mar 01, 2017@06:22:01PM -0800, Roland Dreier wrote:
> From: Roland Dreier <roland at purestorage.com>
> 
> The enum values for QPTYPE, PRTYPE and CMS are off by 1 from the
> values defined in figure 42 of the NVM Express over Fabrics 1.0:
> 
>     http://www.nvmexpress.org/wp-content/uploads/NVMe_over_Fabrics_1_0_Gold_20160605-1.pdf
> 
> Fix our enums to match the final spec.

So this basically affects the discovery information, which at least
in the Linux world is not used anywhere except for printing it in
nvme-cli.  So this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

But can you also send an update for nvme-cli, please?
