From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Mar 2019 16:06:27 -0600
Subject: [PATCH v4 1/3] nvme: set 0 capacity if namespace block size
 exceeds PAGE_SIZE
In-Reply-To: <20190311220227.23656-2-sagi@grimberg.me>
References: <20190311220227.23656-1-sagi@grimberg.me>
 <20190311220227.23656-2-sagi@grimberg.me>
Message-ID: <20190311220627.GB11409@localhost.localdomain>

On Mon, Mar 11, 2019@03:02:25PM -0700, Sagi Grimberg wrote:
> If our target exposed a namespace with a block size that is greater
> than PAGE_SIZE, set 0 capacity on the namespace as we do not support it.
> 
> This issue encountered when the nvmet namespace was backed by a tempfile.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

I responded to the v3 with the review by mistake. :)

Reviewed-by: Keith Busch <keith.busch at intel.com>
