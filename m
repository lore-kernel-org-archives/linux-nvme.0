From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 06:20:20 -0800
Subject: [PATCH v4 5/6] nvme: Add Support for Opal: Unlock from S3 & Opal
 Allocation/Ioctls
In-Reply-To: <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-6-git-send-email-scott.bauer@intel.com>
Message-ID: <20170108142020.GC25986@infradead.org>

> +config BLK_DEV_SED_OPAL
> +       bool "Enable support for Opal Enabled NVMe Device"
> +       depends on BLK_SED_OPAL
> +       default n
> +       ---help---
> +       This enables support for an Opal enabled NVMe device.

I'd like to hear an opinion from Keith as well, but I personally would
drop this confif option and just enable NVMe OPAL support if core block
OPAL is supported.

> +	struct nvme_command cmd = { 0 };

This creates a warning for me:

../drivers/nvme/host/core.c: In function ?nvme_sec_submit?:
../drivers/nvme/host/core.c:771:9: warning: missing braces around initializer [-Wmissing-braces]
  struct nvme_command cmd = { 0 };
         ^
../drivers/nvme/host/core.c:771:9: warning: (near initialization for ?cmd.<anonymous>?) [-Wmissing-braces]

maybe just follow the other examples of nvme_command initializations
in the file.

> +	struct nvme_ns *ns = NULL;
> +
> +	if (send)
> +		cmd.common.opcode = nvme_admin_security_send;
> +	else
> +		cmd.common.opcode = nvme_admin_security_recv;
> +	ns = container_of(ctx, struct nvme_ns, sed_ctx);
> +	cmd.common.nsid = cpu_to_le32(ns->ns_id);

Until we support the configurable namespace locking extension we should
have the sed_ctx in the nvme_ctrl structure, and not be tried to a
namespace here.  I hope to get some concensus out of the working group
about which value to pass exactly soon.

> +#ifdef CONFIG_BLK_DEV_SED_OPAL
> +		if (is_sed_ioctl(cmd))
> +			return sed_ioctl(&ns->sed_ctx, cmd, arg);
> +#endif

To avoid these ifdefs I would suggest to provide an always false
inline version of is_sed_ioctl and a no-op inline of sed_ioctl
in the header.
