From: keith.busch@intel.com (Keith Busch)
Date: Thu, 2 Mar 2017 11:02:27 -0500
Subject: [PATCH] nvme: Correct NVMF enum values to match NVMe-oF rev 1.0
In-Reply-To: <20170302155242.GA31807@infradead.org>
References: <20170302022201.2946-1-roland@kernel.org>
 <20170302155242.GA31807@infradead.org>
Message-ID: <20170302160227.GD14852@localhost.localdomain>

On Thu, Mar 02, 2017@07:52:42AM -0800, Christoph Hellwig wrote:
> So this basically affects the discovery information, which at least
> in the Linux world is not used anywhere except for printing it in
> nvme-cli.  So this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> But can you also send an update for nvme-cli, please?

Yep, that's done: https://github.com/linux-nvme/nvme-cli/pull/161
