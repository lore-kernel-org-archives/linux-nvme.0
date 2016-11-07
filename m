From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 7 Nov 2016 09:45:53 +0100
Subject: [PATCH v5 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <58201df4.eHDpXvb36YEr/bgi%jsmart2021@gmail.com>
References: <58201df4.eHDpXvb36YEr/bgi%jsmart2021@gmail.com>
Message-ID: <20161107084553.tzbnmnbdxpftvcxb@linux-x5ow.site>

On Sun, Nov 06, 2016@10:23:48PM -0800, James Smart wrote:
> 
> Add nvme-fabrics host support for FC transport
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host adapters
> to send/receive FC-4 LS operations and FCP operations that comprise NVME
> over FC operation.
> 
> The T11 definitions for FC-4 Link Services are implemented which create
> NVMeOF connections.  Implements the hooks with blk-mq to then submit admin
> and io requests to the different connections.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
