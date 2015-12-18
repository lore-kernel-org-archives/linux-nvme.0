From: sujith_pandel@dell.com (Sujith Pandel)
Date: Fri, 18 Dec 2015 00:19:42 -0500
Subject: [PATCH for-4.4] NVMe: IO ending fixes on surprise removal
In-Reply-To: <1449864868-8216-1-git-send-email-keith.busch@intel.com>
References: <1449864868-8216-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151218051936.GA9107@localhost.localdomain>

On Fri, Dec 11, 2015@02:14:28PM -0600, Keith Busch wrote:
> This patch fixes a lost request discovered during IO + hot removal.
> 
> The driver's pci removal deletes gendisks prior to shutting down the
> controller to allow dirty data to sync. Dirty data can not be synced on
> a surprise removal, though, and would potentially block indefinitely.
> 
> The driver previously had marked the queue as dying in this scenario
> to prevent new requests from attempting, however it will still block
> for requests that already entered the queue. This patch fixes this by
> quiescing IO first, then aborting the requeued requests before deleting
> disks.
> 
> Reported-by: Sujith Pandel <sujith_pandel at dell.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Tested this patch against linux-4.4-rc4.
I/O terminated successfully everytime and hotplug-removal is clean i.e
no remnants of the removed NVMe disk is present.

Tested-by: Sujith Pandel <sujith_pandel at dell.com>

Thanks and Regards,
Sujith
