From: bmarzins@redhat.com (Benjamin Marzinski)
Date: Tue, 21 Feb 2017 18:01:24 -0600
Subject: [dm-devel] [PATCHv2] Fill NVMe specific path info
In-Reply-To: <1487715151-1179-1-git-send-email-keith.busch@intel.com>
References: <1487715151-1179-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170222000124.GD22981@octiron.msp.redhat.com>

ACK

-Ben

On Tue, Feb 21, 2017@05:12:31PM -0500, Keith Busch wrote:
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1->v2:
>   Removed explicitly setting the wwid path information. We get that with
>   through exported udev attributes.
> 
>   Added default retain_hwhandler to off for NVME devices. This has the
>   kernel not call into scsi specific APIs that don't exist for NVMe.
> 
>  libmultipath/discovery.c | 35 +++++++++++++++++++++++++++++++++++
>  libmultipath/hwtable.c   | 10 ++++++++++
>  libmultipath/structs.h   |  1 +
>  3 files changed, 46 insertions(+)
> 
> diff --git a/libmultipath/discovery.c b/libmultipath/discovery.c
> index d1aec31..39dd92a 100644
> --- a/libmultipath/discovery.c
> +++ b/libmultipath/discovery.c
> @@ -1187,6 +1187,36 @@ scsi_sysfs_pathinfo (struct path * pp, vector hwtable)
>  }
>  
>  static int
> +nvme_sysfs_pathinfo (struct path * pp, vector hwtable)
> +{
> +	struct udev_device *parent, *nvme = NULL;
> +
> +	parent = pp->udev;
> +	while (parent) {
> +		const char *subsys = udev_device_get_subsystem(parent);
> +
> +		if (subsys && !strncmp(subsys, "nvme", 4)) {
> +			nvme = parent;
> +			break;
> +		}
> +		parent = udev_device_get_parent(parent);
> +	}
> +	if (!nvme)
> +		return 1;
> +
> +	snprintf(pp->vendor_id, SCSI_VENDOR_SIZE, "NVME");
> +	snprintf(pp->product_id, SCSI_PRODUCT_SIZE, "%s", udev_device_get_sysattr_value(nvme, "model"));
> +	snprintf(pp->serial, SERIAL_SIZE, "%s", udev_device_get_sysattr_value(nvme, "serial"));
> +	snprintf(pp->rev, SCSI_REV_SIZE, "%s", udev_device_get_sysattr_value(nvme, "firmware_rev"));
> +
> +	condlog(3, "%s: vendor:%s product:%s serial:%s rev:%s", pp->dev,
> +		pp->vendor_id, pp->product_id, pp->serial, pp->rev);
> +	pp->hwe = find_hwe(hwtable, pp->vendor_id, pp->product_id, NULL);
> +
> +	return 0;
> +}
> +
> +static int
>  rbd_sysfs_pathinfo (struct path * pp, vector hwtable)
>  {
>  	sprintf(pp->vendor_id, "Ceph");
> @@ -1405,6 +1435,8 @@ sysfs_pathinfo(struct path * pp, vector hwtable)
>  		pp->bus = SYSFS_BUS_SCSI;
>  	if (!strncmp(pp->dev,"rbd", 3))
>  		pp->bus = SYSFS_BUS_RBD;
> +	if (!strncmp(pp->dev,"nvme", 4))
> +		pp->bus = SYSFS_BUS_NVME;
>  
>  	if (pp->bus == SYSFS_BUS_UNDEF)
>  		return 0;
> @@ -1420,6 +1452,9 @@ sysfs_pathinfo(struct path * pp, vector hwtable)
>  	} else if (pp->bus == SYSFS_BUS_RBD) {
>  		if (rbd_sysfs_pathinfo(pp, hwtable))
>  			return 1;
> +	} else if (pp->bus == SYSFS_BUS_NVME) {
> +		if (nvme_sysfs_pathinfo(pp, hwtable))
> +			return 1;
>  	}
>  	return 0;
>  }
> diff --git a/libmultipath/hwtable.c b/libmultipath/hwtable.c
> index f5a5f7b..8409261 100644
> --- a/libmultipath/hwtable.c
> +++ b/libmultipath/hwtable.c
> @@ -1073,6 +1073,16 @@ static struct hwentry default_hw[] = {
>  		.prio_name     = PRIO_ALUA,
>  		.no_path_retry = 30,
>  	},
> +	/*
> +	 * Generic NVMe devices
> +	 */
> +	{
> +		.vendor	       = "NVME",
> +		.product       = ".*",
> +		.uid_attribute = "ID_WWN",
> +		.checker_name  = DIRECTIO,
> +		.retain_hwhandler = RETAIN_HWHANDLER_OFF,
> +	},
>  #if 0
>  	/*
>  	 * Copy this TEMPLATE to add new hardware.
> diff --git a/libmultipath/structs.h b/libmultipath/structs.h
> index 6edd927..dfd65ae 100644
> --- a/libmultipath/structs.h
> +++ b/libmultipath/structs.h
> @@ -53,6 +53,7 @@ enum sysfs_buses {
>  	SYSFS_BUS_CCW,
>  	SYSFS_BUS_CCISS,
>  	SYSFS_BUS_RBD,
> +	SYSFS_BUS_NVME,
>  };
>  
>  enum pathstates {
> -- 
> 2.5.5
> 
> --
> dm-devel mailing list
> dm-devel at redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
