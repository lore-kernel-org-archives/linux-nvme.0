From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:32:08 +0200
Subject: [PATCH v2 2/2] nvmet: preserve controller serial number
 between reboots
In-Reply-To: <20170714120517.13552-3-jthumshirn@suse.de>
References: <20170714120517.13552-1-jthumshirn@suse.de>
 <20170714120517.13552-3-jthumshirn@suse.de>
Message-ID: <20170714123208.GE26187@lst.de>

This patch itself looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>

>  static struct configfs_attribute *nvmet_subsys_attrs[] = {
>  	&nvmet_subsys_attr_attr_allow_any_host,
>  	&nvmet_subsys_attr_version,
> +	&nvmet_subsys_attr_attr_serial,

but the new version attribute really needs the attr prefix so that
nvmetcli can pick it up.  And we should also add nvmetcli support
for it.  Can you do the rename before your series to ease backporting
as that should go into 3.12 (just like your serial number fix).
