From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Feb 2018 08:31:35 -0700
Subject: [PATCH 1/3] nvme-fabrics: don't check for non-NULL module in
 nvmf_register_transport
In-Reply-To: <20180222152410.19222-2-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
 <20180222152410.19222-2-hch@lst.de>
Message-ID: <20180222153134.GF7076@localhost.localdomain>

On Thu, Feb 22, 2018@07:24:08AM -0800, Christoph Hellwig wrote:
> THIS_MODULE evaluates to NULL when used from code built into the kernel,
> thus breaking built-in transport modules.  Remove the bogus check.
> 
> Fixes: 0de5cd36 ("nvme-fabrics: protect against module unload during create_ctrl")
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
