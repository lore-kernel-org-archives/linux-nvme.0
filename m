From: okaya@kernel.org (Sinan Kaya)
Date: Mon, 5 Nov 2018 18:24:14 -0800
Subject: [PATCH 2/2] nvme: add quirk to not call disable function when
 suspending
In-Reply-To: <20181106020402.21120-2-acelan.kao@canonical.com>
References: <20181106020402.21120-1-acelan.kao@canonical.com>
 <20181106020402.21120-2-acelan.kao@canonical.com>
Message-ID: <733fc135-dfef-f70e-b854-3ad553c67e9b@kernel.org>

On 11/5/2018 6:04 PM, AceLan Kao wrote:
> +	{ PCI_DEVICE(0x1c5c, 0x1527),   /* Sk Hynix */
> +		.driver_data = NVME_QUIRK_NO_DISABLE, },

Now that you added PCI_VENDOR_ID_SK_HYNIX to pci_ids.h, you
could use PCI_VENDOR_ID_SK_HYNIX above instead of 0x1c5c.
