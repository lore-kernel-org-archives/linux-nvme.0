From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Fri, 6 Nov 2015 00:06:46 -0500
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
In-Reply-To: <alpine.LNX.2.00.1510051924020.23840@localhost.lm.intel.com>
References: <20151004223222.GA4280@localhost.localdomain>
 <alpine.LNX.2.00.1510051924020.23840@localhost.lm.intel.com>
Message-ID: <20151106050639.GA3186@localhost.localdomain>

Hi Keith,

On Mon, Oct 05, 2015@02:24:19PM -0500, Keith Busch wrote:
> On Sun, 4 Oct 2015, Sujith Pandel wrote:
> > Hi,
> >>> nvme driver does not show the model attribute of disk in sysfs.
> >>> nvme_dev already has this attribute populated during nvme_dev_add().
> >>> Group model and other the device attributes as an attribute group
> >>> and create sysfs files for the group using sysfs_create_group().
> >>
> >> Any updates on this? Can this be considered for inclusion?
> >
> > Any thoughts/feedback on this?
> 
> Looks good to me, thanks.
> 
> Reviewed-by: Keith Busch <keith.busch at intel.com>

Can you let me know the status of this patch? I could not find this either in
linux-block nor in linux-next.

Regards,
Sujith
