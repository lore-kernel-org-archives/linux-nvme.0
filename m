From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Sat, 05 Nov 2016 11:07:24 -0700
Subject: [PATCH v4 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <581cf3c5.i79zcsb/mXCT8ar6%james.smart@broadcom.com>
References: <581cf3c5.i79zcsb/mXCT8ar6%james.smart@broadcom.com>
Message-ID: <1478369244.17308.4.camel@linux.intel.com>

On Fri, 2016-11-04@13:47 -0700, James Smart wrote:
> Add nvme-fabrics host support for FC transport
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host
> adapters
> to send/receive FC-4 LS operations and FCP operations that comprise
> NVME
> over FC operation.
> 
> The T11 definitions for FC-4 Link Services are implemented which
> create
> NVMeOF connections.??Implements the hooks with blk-mq to then submit
> admin
> and io requests to the different connections.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v4 mods:
> - added HAS_DMA to Kconfig
> - Changed to support Christophs nvme_request update
> - addressed return code in __nvme_fc_abort_op()
> - fixed possible op->rq NULL reference in nvme_fc_start_fcp_op()
> - FC-NVME v1.11: process transferred length in ersp iu and rsp iu
> mandates
> - Add comments on teardown flow
> - fix bad cqe reference in fcpio_done


Looks good, nice work James,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
