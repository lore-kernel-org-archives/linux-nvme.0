From: keith.busch@intel.com (Keith Busch)
Date: Tue, 11 Jul 2017 10:43:53 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <6e6d624b-4749-7b72-9ebc-58ba328adc64@broadcom.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-8-git-send-email-keith.busch@intel.com>
 <6e6d624b-4749-7b72-9ebc-58ba328adc64@broadcom.com>
Message-ID: <20170711144353.GB4604@localhost.localdomain>

On Mon, Jul 10, 2017@04:57:43PM -0700, James Smart wrote:
> On 7/7/2017 9:23 AM, Keith Busch wrote:
> > +void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> > +{
> > +	char buffer[20]; /* NVME_AEN=0xffffffff\0 */
> > +	char *envp[2] = {buffer, NULL};
> > +	u32 aen = ctrl->aen;
> > +
> > +	ctrl->aen = 0;
> > +	if (!aen)
> > +		return;
> > +
> > +	snprintf(buffer, sizeof(buffer), "NVME_AEN=%#08x", aen);
> > +	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
> > +}
> > +
> 
> Passing on a comment from Christoph received on a similar fc udev event:
> "Please use kasprintf so that we have a dynamic allocation and don't need to
> hardcode buffer sizes"

I agree that usage for dynamic strings is better, but this is a fixed
sized string that will always be 20 bytes.
