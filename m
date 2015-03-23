From: David.Sariel@pmcs.com (David Sariel)
Date: Mon, 23 Mar 2015 20:42:57 +0000
Subject: NVMe controller reset
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B93BA99F32@fmsmsx104.amr.corp.intel.com>
References: <BN1PR0401MB0931875120224BBDA5E32A4AF2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <alpine.LNX.2.00.1503172024170.32385@localhost.lm.intel.com>
 <BN1PR0401MB093179FFC1C61856942C2DD0F2030@BN1PR0401MB0931.namprd04.prod.outlook.com>
 <B58D82457FDA0744A320A2FC5AC253B93BA99F32@fmsmsx104.amr.corp.intel.com>
Message-ID: <31FEE40556302F408590926A3C4AC65FED54F404@BBYEXM01.pmc-sierra.internal>

Hi 
As a matter of fact I was also paying around with reset recently.
And Keith's note about the pre-3.15 lack of safety explained all the strange things I saw on 3.14.16.

I have installed v 3.16.2 and played a little bit more. Particularly, I have added the NVME_IOCTL_RESET to 
See that reset works. What I did is to call the nvme_dev_reset upon the NVME_IOCTL_RESET. 
And resets are working just fine. Even sending multiple resets under traffic only slows the traffic a little bit, but eventually fio 
Manages to run to the completion. 

Then I tried to investigate a little bit what happens with reset entry in sysfs on v 3.16.2 and it will be great if somebody could answer the questions I have:

1) making echo 1 > /sys/class/misc/nvme0/device/reset cause no call to the nvme_dev_reset. And no controller reset was caused in the NVME controller as well. So the question is why resets were implemented via the reset_work? Currently resets are delivered to the controller (turning CC enable to 0 etc) under a several conditions:
readl(&dev->bar->csts) & NVME_CSTS_CFS && dev->initialized and then the work is only scheduled. What is the rational? Can't we just read the /sys/class/misc/nvme0/device/reset  and call to the nvme_dev_reset (of course subject to take the rcu_read_lock/ rcu_read_unlock)

2) Is it ok to add NVME_IOCTL_RESET in case the rational for resets with sysfs/ reset_work combination is not intended to work with multiple resets under traffic? The code I have tested is very simple:

In the driver:

/* 0x43 is used by nvme-cli */
#define NVME_IOCTL_RESET  _IO('N', 0x44)

static int nvme_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
							unsigned long arg)
{
	struct nvme_ns *ns = bdev->bd_disk->private_data;


	switch (cmd) {
	case NVME_IOCTL_ID:
		force_successful_syscall_return();
		return ns->ns_id;
	case NVME_IOCTL_ADMIN_CMD:
		return nvme_user_admin_cmd(ns->dev, (void __user *)arg);
	case NVME_IOCTL_SUBMIT_IO:
		return nvme_submit_io(ns, (void __user *)arg);
	case NVME_IOCTL_RESET:
		nvme_dev_reset(ns->dev);
		return 0;
	case SG_GET_VERSION_NUM:
		return nvme_sg_get_version_num((void __user *)arg);
	case SG_IO:
		return nvme_sg_io(ns, (void __user *)arg);
	default:
		return -ENOTTY;
	}
}


In the nvme-cli:

#define COMMAND_LIST \
	ENTRY(LIST, "list", "List all NVMe devices and namespaces on machine", list) \
	ENTRY(ID_CTRL, "id-ctrl", "Send NVMe Identify Controller", id_ctrl) \
	ENTRY(ID_NS, "id-ns", "Send NVMe Identify Namespace, display structure", id_ns) \
	ENTRY(LIST_NS, "list-ns", "Send NVMe Identify List, display structure", list_ns) \
	ENTRY(GET_NS_ID, "get-ns-id", "Retrieve the namespace ID of opened block device", get_ns_id) \
	ENTRY(GET_LOG, "get-log", "Generic NVMe get log, returns log in raw format", get_log) \
	ENTRY(GET_FW_LOG, "fw-log", "Retrieve FW Log, show it", get_fw_log) \
	ENTRY(GET_SMART_LOG, "smart-log", "Retrieve SMART Log, show it", get_smart_log) \
	ENTRY(GET_ERR_LOG, "error-log", "Retrieve Error Log, show it", get_error_log) \
	ENTRY(GET_FEATURE, "get-feature", "Get feature and show the resulting value", get_feature) \
	ENTRY(SET_FEATURE, "set-feature", "Set a feature and show the resulting value", set_feature) \
	ENTRY(FORMAT, "format", "Format namespace with new block format", format) \
	ENTRY(FW_ACTIVATE, "fw-activate", "Activate new firmware slot", fw_activate) \
	ENTRY(FW_DOWNLOAD, "fw-download", "Download new firmware", fw_download) \
	ENTRY(ADMIN_PASSTHRU, "admin-passthru", "Submit arbitrary admin command, return results", admin_passthru) \
	ENTRY(IO_PASSTHRU, "io-passthru", "Submit an arbitrary IO command, return results", io_passthru) \
	ENTRY(RESET, "reset", "Reset the NVME controller", reset) \
	....
	

static int reset(int argc, char **argv)
{

	.... getopt staff ...


	err =  ioctl(fd, NVME_IOCTL_RESET);

	if (err < 0)
		perror(devicename);
	printf("NVME Controller reset retval %d\n", err);
	if (!err) {
		printf("NVME Controller reset.\n");
	}
	else if (err > 0)
		fprintf(stderr, "NVMe Status: %s\n", nvme_status_to_string(err));

	return err;
}


Thanks
David


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Busch, Keith
Sent: Tuesday, March 17, 2015 10:59 PM
To: Brandon Schulz
Cc: linux-nvme at lists.infradead.org
Subject: RE: NVMe controller reset

You could do remove + rescan with sysfs if you don't have open references on your drive.

Here's a different proposal from 18 months ago:

http://lists.infradead.org/pipermail/linux-nvme/2013-September/000391.html

I still think it's a good idea.

On Tue, 17 Mar 2015, Brandon Schulz wrote:
> I see.  Thanks for the response.
> 
> So this won't work for the back-ports to 2.6.32-ish kernels, as you 
> mentioned, so does anyone have a preference for how it is done there?
> 
> We're going to have to implement a mechanism, and if there are strong 
> opinions against implementing it as an ioctl, I'd like to hear them 
> before we go write the code and submit the patches.
> 
> My objective here is to find an acceptable mechanism that can 
> eventually be pulled into the older distro kernels.  If I'm going about this the wrong way, please let me know.
> 
> Thanks,
> Brandon
> 
> 
> 
> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Tuesday, March 17, 2015 3:30 PM
> To: Brandon Schulz
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: NVMe controller reset
> 
> On Tue, 17 Mar 2015, Brandon Schulz wrote:
> > What is the preferred way (if there is one) to force a controller reset from user-space?
> >
> > If, for example, a user-space tool was going to do a firmware 
> > activate that required a
> controller reset, how would one trigger the reset?  I do not see an 
> ioctl defined for this today, or am I missing something?
> 
> Like this:
> 
>    # echo 1 > /sys/class/nvme/nvme<#>/device/reset
> 
> This assumes you're using kernel >= 4.0. Before that'd, the entry was 
> under "class/misc" instead of "class/nvme". It was moved to a new 
> class because 'misc' wasn't giving us enough minors to have more than several dozen NVMe drives in a system, but I want hundreds.
> 
> It also assumes you're using a kernel >= 3.15. While the sysfs entry 
> exists pre-3.15, it wasn't safe to use because there was no notification callback for drivers to subscribe to.
> 
> Had I known what a pain it was to back-port the pci callback to older 
> kernels (it apparently breaks kABI), I would have used an nvme specific sysfs entry, but that's where we are today.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
