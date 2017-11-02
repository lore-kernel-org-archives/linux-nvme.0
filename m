From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 02 Nov 2017 16:09:43 -0400
Subject: [PATCH 5/5] lpfc: Add sysfs interface to post NVME RSCN
In-Reply-To: <20171028172114.2045-6-jsmart2021@gmail.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
 <20171028172114.2045-6-jsmart2021@gmail.com>
Message-ID: <1509653383.4090.120.camel@localhost.localdomain>

On Sat, 2017-10-28@10:21 -0700, James Smart wrote:
> From: Dick Kennedy <dick.kennedy at broadcom.com>
> 
> To support scenarios which aren't bound to nvmetcli add port scenarios,
> which is currently where the transport invokes the nvme_subsystem_changed
> callback, add a syfs attribute to lpfc which can be written to cause
> an RSCN to be generated for the nport.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc.h      |  1 +
>  drivers/scsi/lpfc/lpfc_attr.c | 62 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
> index 157788f0bc10..52d403548a3a 100644
> --- a/drivers/scsi/lpfc/lpfc.h
> +++ b/drivers/scsi/lpfc/lpfc.h
> @@ -781,6 +781,7 @@ struct lpfc_hba {
>  	uint32_t cfg_use_msi;
>  	uint32_t cfg_auto_imax;
>  	uint32_t cfg_fcp_imax;
> +	uint32_t cfg_force_rscn;
>  	uint32_t cfg_fcp_cpu_map;
>  	uint32_t cfg_fcp_io_channel;
>  	uint32_t cfg_suppress_rsp;
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index c17677f494af..6e8e54e65e25 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -4469,6 +4469,66 @@ static DEVICE_ATTR(lpfc_req_fw_upgrade, S_IRUGO | S_IWUSR,
>  		   lpfc_request_firmware_upgrade_store);
>  
>  /**
> + * lpfc_force_rscn_store
> + *
> + * @dev: class device that is converted into a Scsi_host.
> + * @attr: device attribute, not used.
> + * @buf: unused string
> + * @count: unused variable.
> + *
> + * Description:
> + * Force the switch to send a RSCN to all other NPorts in our zone
> + * If we are direct connect pt2pt, build the RSCN command ourself
> + * and send to the other NPort. Not supported for private loop.
> + *
> + * Returns:
> + * 0      - on success
> + * -EIO   - if command is not sent
> + **/
> +static ssize_t
> +lpfc_force_rscn_store(struct device *dev, struct device_attribute *attr,
> +		      const char *buf, size_t count)
> +{
> +	struct Scsi_Host *shost = class_to_shost(dev);
> +	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
> +	int i;
> +
> +	i = lpfc_issue_els_rscn(vport, 0);
> +	if (i)
> +		return -EIO;
> +	return strlen(buf);
> +}
> +
> +/*
> + * lpfc_force_rscn: Force an RSCN to be sent to all remote NPorts
> + * connected to  the HBA.
> + *
> + * Value range is any ascii value
> + */
> +static int lpfc_force_rscn;
> +module_param(lpfc_force_rscn, int, 0644);
> +MODULE_PARM_DESC(lpfc_force_rscn,
> +		 "Force an RSCN to be sent to all remote NPorts");
> +lpfc_param_show(force_rscn)
> +
> +/**
> + * lpfc_force_rscn_init - Force an RSCN to be sent to all remote NPorts
> + * @phba: lpfc_hba pointer.
> + * @val: unused value.
> + *
> + * Returns:
> + * zero if val saved.
> + **/
> +static int
> +lpfc_force_rscn_init(struct lpfc_hba *phba, int val)
> +{
> +	return 0;
> +}
> +
> +static DEVICE_ATTR(lpfc_force_rscn, 0644,
> +		   lpfc_force_rscn_show, lpfc_force_rscn_store);
> +
> +/**
>   * lpfc_fcp_imax_store
>   *
>   * @dev: class device that is converted into a Scsi_host.
> @@ -5218,6 +5278,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
>  	&dev_attr_lpfc_nvme_oas,
>  	&dev_attr_lpfc_auto_imax,
>  	&dev_attr_lpfc_fcp_imax,
> +	&dev_attr_lpfc_force_rscn,
>  	&dev_attr_lpfc_fcp_cpu_map,
>  	&dev_attr_lpfc_fcp_io_channel,
>  	&dev_attr_lpfc_suppress_rsp,
> @@ -6238,6 +6299,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
>  	lpfc_nvme_oas_init(phba, lpfc_nvme_oas);
>  	lpfc_auto_imax_init(phba, lpfc_auto_imax);
>  	lpfc_fcp_imax_init(phba, lpfc_fcp_imax);
> +	lpfc_force_rscn_init(phba, lpfc_force_rscn);
>  	lpfc_fcp_cpu_map_init(phba, lpfc_fcp_cpu_map);
>  	lpfc_enable_hba_reset_init(phba, lpfc_enable_hba_reset);
>  	lpfc_enable_hba_heartbeat_init(phba, lpfc_enable_hba_heartbeat);

So, with this sysfs interface, if someone accidentally or intentionally
issues RSCNs in a loop at high frequency, what is this going to do to
the FC fabric?

Most people know to use single-initiator zoning, but the affected target
ports would still get the RSCN, correct?

-Ewan
