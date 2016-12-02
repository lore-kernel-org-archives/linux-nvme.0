From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 2 Dec 2016 10:16:44 +0100
Subject: [PATCH v6 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <584130bb.wO2ZMznRirRaByPC%jsmart2021@gmail.com>
References: <584130bb.wO2ZMznRirRaByPC%jsmart2021@gmail.com>
Message-ID: <20161202091644.a5qobhueby3mroeq@linux-x5ow.site>

On Fri, Dec 02, 2016@12:28:43AM -0800, James Smart wrote:
> 
> Add nvme-fabrics target support for FC transport
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host adapters
> to send/receive FC-4 LS operations and perform the FCP transactions
> necessary to perform and FCP IO request for NVME.
> 
> The T11 definitions for FC-4 Link Services are implemented which create
> NVMeOF connections.  Implements the hooks with nvmet layer to pass NVME
> commands to it for processing and posting of data/response base to the
> host via the different connections.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
