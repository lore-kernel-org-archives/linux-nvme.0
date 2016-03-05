From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Sat, 05 Mar 2016 16:55:52 -0500
Subject: [PATCHv2] NVMe: Create discard zero quirk white list
In-Reply-To: <1457122517-18658-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Fri, 4 Mar 2016 13:15:17 -0700")
References: <1457122517-18658-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1mvqc4mjb.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> There is no specification defined way to determine device
Keith> behavior on discarded blocks

*sigh*

Keith> We can only know behavior based on individual device models, so
Keith> this patch adds a flag to the NVMe "quirk" list that vendors may
Keith> set if they know their controller works that way. The patch also
Keith> sets the new flag for one such known device.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
