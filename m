From: sbates@raithlin.com (Stephen  Bates)
Date: Mon, 8 May 2017 18:35:04 +0000
Subject: [PATCH] nvme: Unmap CMB and remove sysfs file in reset path
In-Reply-To: <20170505204603.4000-1-jonathan.derrick@intel.com>
References: <20170505204603.4000-1-jonathan.derrick@intel.com>
Message-ID: <44A7A12B-6267-46C6-AE66-F95F8905A509@raithlin.com>


> CMB doesn't get unmapped until removal while getting remapped on every
> reset. Add the unmapping and sysfs file removal to the reset path in
> nvme_pci_disable to match the mapping path in nvme_pci_enable.
>
> Fixes: 202021c1a ("nvme : Add sysfs entry for NVMe CMBs when appropriate")

Good catch?

Reviewed-By: Stephen Bates <sbates at raithlin.com>
