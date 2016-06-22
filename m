From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 Jun 2016 10:40:02 -0400
Subject: [PATCH] nvme: Limit command retries
In-Reply-To: <576A68C8.2060408@grimberg.me>
References: <1466444691-29448-1-git-send-email-keith.busch@intel.com>
 <576A68C8.2060408@grimberg.me>
Message-ID: <20160622144002.GF1448@localhost.localdomain>

On Wed, Jun 22, 2016@01:30:32PM +0300, Sagi Grimberg wrote:
> >The struct request's 'retries' field is used to track the number of
> >retries attempted. This is in contrast with scsi's use of this field,
> >which indicates how many retries are allowed.
> 
> Why not follow the same scheme?

It's not documented to mean what scsi thinks it means, and it saves some
space from yet another field to track how many retries have occured. For
the pci driver, that field could be added to struct nvme_iod, but
that's not used for fabrics. Using req->retries can be consistent with
all nvme transports.

> >+unsigned int nvme_max_retries = 5;
> >+module_param_named(max_retries, nvme_max_retries, uint, 0644);
> >+MODULE_PARM_DESC(max_retries, "max number of retries a command may have");
> >+EXPORT_SYMBOL_GPL(nvme_max_retries);
> 
> This looks like its a per-controller attribute, it might be better to
> make nvme-cli pass this via the vendor extensions? This way we can have
> it on a per-controller basis.

If we need per-controller, I'd like a sysfs attribute. nvme-cli mostly
does ioctl's, but it also does some sysfs stuff too.
