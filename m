From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 09:54:01 +0100
Subject: [PATCH v3 06/16] lpfc: NVME Initiator: Base modifications
In-Reply-To: <58a0d91e.dhVNcGxwBsHs5tB5%jsmart2021@gmail.com>
References: <58a0d91e.dhVNcGxwBsHs5tB5%jsmart2021@gmail.com>
Message-ID: <6abb2864-0127-4d12-fafd-6d82f75aba7a@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> NVME Initiator: Base modifications
> 
> This patch adds base modifications for NVME initiator support.
> 
> The base modifications consist of:
> - Formal split of SLI3 rings from SLI-4 WQs (sometimes referred to as
>   rings as well) as implementation now widely varies between the two.
> - Addition of configuration modes:
>    SCSI initiator only; NVME initiator only; NVME target only; and
>    SCSI and NVME initiator.
>    The configuration mode drives overall adapter configuration,
>    offloads enabled, and resource splits.
>    NVME support is only available on SLI-4 devices and newer fw.
> - Implements the following based on configuration mode:
>   - Exchange resources are split by protocol; Obviously, if only
>      1 mode, then no split occurs. Default is 50/50. module attribute
>      allows tuning.
>   - Pools and config parameters are separated per-protocol
>   - Each protocol has it's own set of queues, but share interrupt
>     vectors.
>      SCSI:
>        SLI3 devices have few queues and the original style of queue
>          allocation remains.
>        SLI4 devices piggy back on an "io-channel" concept that
>          eventually needs to merge with scsi-mq/blk-mq support (it is
> 	 underway).  For now, the paradigm continues as it existed
> 	 prior. io channel allocates N msix and N WQs (N=4 default)
> 	 and either round robins or uses cpu # modulo N for scheduling.
> 	 A bunch of module parameters allow the configuration to be
> 	 tuned.
>      NVME (initiator):
>        Allocates an msix per cpu (or whatever pci_alloc_irq_vectors
>          gets)
>        Allocates a WQ per cpu, and maps the WQs to msix on a WQ #
>          modulo msix vector count basis.
>        Module parameters exist to cap/control the config if desired.
>   - Each protocol has its own buffer and dma pools.
> 
> I apologize for the size of the patch.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
Apologies accepted :-)

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
