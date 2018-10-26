From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Oct 2018 16:58:07 -0600
Subject: [PATCH] nvme-pci: Add Write Zero support to Intel 660p
In-Reply-To: <20181026224146.198311-1-gwendal@chromium.org>
References: <20181026224146.198311-1-gwendal@chromium.org>
Message-ID: <20181026225807.GA10621@localhost.localdomain>

On Fri, Oct 26, 2018@03:41:46PM -0700, Gwendal Grignou wrote:
> Given Intel 660p returns 0 when reading discarded data,
> allow Write Zero.
> 
> nvme id-ns /dev/nvme0n1
> ...
> dlfeat  : 1
> ...
> 
> Check Write Zeros is now enabled:
> cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
> 2199023255040
> 
> Signed-off-by: Gwendal Grignou <gwendal at chromium.org>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7e09e45b0b28d..b81ad51d78b72 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2694,6 +2694,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_MEDIUM_PRIO_SQ },
> +	{ PCI_VDEVICE(INTEL, 0xf1a8), /* Intel 660P */
> +		.driver_data = NVME_QUIRK_DEALLOCATE_ZEROES, },

The quirk is for devices that pre-date the ability to discover the
capability. Now that we have a spec defined way to know a device's
deallocate behavior, and this particular device implements that method,
we should use that instead of a quirk.
