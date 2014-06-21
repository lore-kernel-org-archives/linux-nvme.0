From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 21 Jun 2014 12:19:08 -0400
Subject: [PATCH] NVMe: Mismatched host/device page size support
In-Reply-To: <1403299663-31721-1-git-send-email-keith.busch@intel.com>
References: <1403299663-31721-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140621161908.GQ12025@linux.intel.com>

On Fri, Jun 20, 2014@03:27:43PM -0600, Keith Busch wrote:
> Adds support for devices with max page size smaller than the host's.
> In the case we encounter such a host/device combination, the driver will
> split a page into as many PRP entries as necessary for the device's page
> size capabilities.

That was a considerably smaller patch than I was expecting for this
functionality!  Nicely done.

> @@ -1450,6 +1451,15 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
>  	u32 aqa;
>  	u64 cap = readq(&dev->bar->cap);
>  	struct nvme_queue *nvmeq;
> +	unsigned page_shift = PAGE_SHIFT;
> +	unsigned dev_page_shift = NVME_CAP_MPSMAX(cap) + 12;
> +
> +	if (page_shift > dev_page_shift) {
> +		dev_warn(&dev->pci_dev->dev,
> +				"host/device page size mismatch %u/%u\n",
> +				1 << page_shift, 1 << dev_page_shift);
> +		page_shift = dev_page_shift;
> +	}

Let's take on another possibility here:

+	unsigned page_shift = PAGE_SHIFT;
+	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12;
+	unsigned dev_page_max = NVME_CAP_MPSMAX(cap) + 12;
+
+	if (page_shift < dev_page_min) {
+		dev_err(&dev->pci_dev->dev,
+				"Minimum device page size (%u) too large for "
+				"host (%u)\n", 1 << dev_page_min,
+				1 << page_shift);
+		return -ENODEV;
+	}
+
+	if (page_shift > dev_page_max) {
+		dev_info(&dev->pci_dev->dev,
+				"Device maximum page size (%u) smaller than "
+				"host (%u); enabling work-around\n",
+				1 << dev_page_max, 1 << page_shift);
+		page_shift = dev_page_max;
+	}
