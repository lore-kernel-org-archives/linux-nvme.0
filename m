From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 14 Jul 2015 11:03:10 -0700
Subject: [PATCH] NVMe: Allow reserved minors
In-Reply-To: <1436896652-27332-1-git-send-email-keith.busch@intel.com>
References: <1436896652-27332-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150714180310.GA10203@infradead.org>

On Tue, Jul 14, 2015@11:57:32AM -0600, Keith Busch wrote:
> The patch is to aid users transitioning from SCSI to NVM-Express. Some
> storage applications inherited from scsi have fixed minor requirements
> for partitions, so this patch allows a user to specify a number of
> minors they want reserved per namespace, defaulting to 0 to match
> existing functionality; set to 16 to match scsi.

NAK.  Different block devices always hard different minor number
schemes.

Symantec should fix their broken application if they want to take
advantage of new storage hardware.
