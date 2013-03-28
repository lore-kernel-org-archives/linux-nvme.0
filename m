From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 27 Mar 2013 21:17:17 -0400
Subject: [PATCH v3 0/3] NVMe: Add support for SG_IO
In-Reply-To: <1362447658-25695-1-git-send-email-vishal.l.verma@intel.com>
References: <1362447658-25695-1-git-send-email-vishal.l.verma@intel.com>
Message-ID: <20130328011717.GJ4671@linux.intel.com>

On Mon, Mar 04, 2013@06:40:55PM -0700, Vishal Verma wrote:
> These patches allow the nvme driver to handle the SG_IO ioctl.
> Applications may send any supported SCSI Command through the
> SG_IO framework. The supported command list as well as the
> translation reference is available on www.nvmexpress.org
> 
> Vishal Verma (3):
>   NVMe: Rename nvme.c to nvme-core.c
>   NVMe: Move dev, ns, iod structs to nvme.c
>   NVMe: Add nvme-scsi.c

I ended up modifying these patche before committing them.

 - I split out the addition of the format command into its own patch.
   It's significant enough to be worth doing separately.
 - The comment on nvme_free_iod() was part of the second patch instead of
   the final patch, for some reason.
 - I moved the additions to the nvme_ns data structure to the final patch
   (was part of the second patch).
 - Instead of storing the vendor_id from the identify result, just use the
   pci_dev's ->vendor element.

Hope I didn't break anything in the process :-)
