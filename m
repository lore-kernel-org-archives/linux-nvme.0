From: keith.busch@intel.com (Keith Busch)
Date: Mon, 11 Mar 2019 16:05:00 -0600
Subject: [PATCH v3 1/3] nvme: fail namespace revalidate if block size
 exceeds PAGE_SIZE
In-Reply-To: <20190311211608.16628-2-sagi@grimberg.me>
References: <20190311211608.16628-1-sagi@grimberg.me>
 <20190311211608.16628-2-sagi@grimberg.me>
Message-ID: <20190311220500.GA11409@localhost.localdomain>

On Mon, Mar 11, 2019@02:16:06PM -0700, Sagi Grimberg wrote:
> If our target exposed a namespace with a block size that is greater
> than PAGE_SIZE, fail it as we do not support it.
> 
> This issue encountered when the nvmet namespace was backed by a
> tempfile.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Thanks, looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
