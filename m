From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Oct 2017 08:04:02 +0200
Subject: [PATCH v3 3/5] nvme_fc: add a dev_loss_tmo field to the remoteport
In-Reply-To: <20171017233248.6769-4-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-4-jsmart2021@gmail.com>
Message-ID: <ee0d6875-843f-103e-fa1e-825bf18acf48@suse.de>

On 10/18/2017 01:32 AM, James Smart wrote:
> Add a dev_loss_tmo value, paralleling the SCSI FC transport, for device
> connectivity loss.
> 
> The transport initializes the value in the nvme_fc_register_remoteport()
> call. If the value is not set, a default of 60s is set.
> 
> Add a new routine to the api, nvme_fc_set_remoteport_devloss() routine,
> which allows the lldd to dynamically update the value on an existing
> remoteport.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v3:
>  Removed the expected reconnect time and min devloss defines. They
>  were not that meaningful.
>  Incorporated the new nvme_fc_set_remoteport_devloss() routine
>  which was in a different patch in v2. New routine no longer
>  touches controllers. It only modifies the remoteport.
> ---
>  drivers/nvme/host/fc.c         | 31 +++++++++++++++++++++++++++++++
>  include/linux/nvme-fc-driver.h | 11 +++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 5afb518c39ad..3ac49e670c38 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -45,6 +45,8 @@ enum nvme_fc_queue_flags {
>  
>  #define NVMEFC_QUEUE_DELAY	3		/* ms units */
>  
> +#define NVME_FC_DEFAULT_DEV_LOSS_TMO	60	/* seconds */
> +
>  struct nvme_fc_queue {
>  	struct nvme_fc_ctrl	*ctrl;
>  	struct device		*dev;
> @@ -587,6 +589,11 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
>  	newrec->remoteport.port_id = pinfo->port_id;
>  	newrec->remoteport.port_state = FC_OBJSTATE_ONLINE;
>  	newrec->remoteport.port_num = idx;
> +	/* a registration value of dev_loss_tmo=0 results in the default */
> +	if (pinfo->dev_loss_tmo)
> +		newrec->remoteport.dev_loss_tmo = pinfo->dev_loss_tmo;
> +	else
> +		newrec->remoteport.dev_loss_tmo = NVME_FC_DEFAULT_DEV_LOSS_TMO;
>  
>  	spin_lock_irqsave(&nvme_fc_lock, flags);
>  	list_add_tail(&newrec->endp_list, &lport->endp_list);
> @@ -690,6 +697,30 @@ nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport)
>  }
>  EXPORT_SYMBOL_GPL(nvme_fc_rescan_remoteport);
>  
> +int
> +nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *portptr,
> +			u32 dev_loss_tmo)
> +{
> +	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
> +	struct nvme_fc_ctrl *ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rport->lock, flags);
> +
> +	if (portptr->port_state != FC_OBJSTATE_ONLINE) {
> +		spin_unlock_irqrestore(&rport->lock, flags);
> +		return -EINVAL;
> +	}
> +
> +	/* a dev_loss_tmo of 0 (immediate) is allowed to be set */
> +	rport->remoteport.dev_loss_tmo = dev_loss_tmo;
> +
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_fc_set_remoteport_devloss);
> +
>  
>  /* *********************** FC-NVME DMA Handling **************************** */
>  
> diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
> index 4ea03b9a5c8c..3de268bf86bf 100644
> --- a/include/linux/nvme-fc-driver.h
> +++ b/include/linux/nvme-fc-driver.h
> @@ -40,6 +40,8 @@
>   * @node_name: FC WWNN for the port
>   * @port_name: FC WWPN for the port
>   * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
> + * @dev_loss_tmo: maximum delay for reconnects to an association on
> + *             this device. Used only on a remoteport.
>   *
>   * Initialization values for dynamic port fields:
>   * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
> @@ -50,6 +52,7 @@ struct nvme_fc_port_info {
>  	u64			port_name;
>  	u32			port_role;
>  	u32			port_id;
> +	u32			dev_loss_tmo;
>  };
>  
>  
> @@ -202,6 +205,9 @@ enum nvme_fc_obj_state {
>   *             The length of the buffer corresponds to the local_priv_sz
>   *             value specified in the nvme_fc_port_template supplied by
>   *             the LLDD.
> + * @dev_loss_tmo: maximum delay for reconnects to an association on
> + *             this device. To modify, lldd must call
> + *             nvme_fc_set_remoteport_devloss().
>   *
>   * Fields with dynamic values. Values may change base on link state. LLDD
>   * may reference fields directly to change them. Initialized by the
> @@ -259,10 +265,9 @@ struct nvme_fc_remote_port {
>  	u32 port_role;
>  	u64 node_name;
>  	u64 port_name;
> -
>  	struct nvme_fc_local_port *localport;
> -
>  	void *private;
> +	u32 dev_loss_tmo;
>  
>  	/* dynamic fields */
>  	u32 port_id;
> @@ -448,6 +453,8 @@ int nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *remoteport);
>  
>  void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
>  
> +int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
> +			u32 dev_loss_tmo);
>  
>  
>  /*
> 
Is this exported to sysfs somewhere? If not, can we have it in sysfs?
It surely made live _so_ much easier when configuring the odd device...

Other than that:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
