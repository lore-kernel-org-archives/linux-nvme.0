From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 02 Apr 2019 22:57:31 -0400
Subject: [PATCH v3 7/7] fs/ext4,
 jbd2: add support for passing write-hint with journal
In-Reply-To: <1553846032-4451-8-git-send-email-joshi.k@samsung.com> (Kanchan
 Joshi's message of "Fri, 29 Mar 2019 13:23:52 +0530")
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075800epcas2p4731f10eabf7d70dc7096117d161b05a3@epcas2p4.samsung.com>
 <1553846032-4451-8-git-send-email-joshi.k@samsung.com>
Message-ID: <yq14l7fokx0.fsf@oracle.com>


Kanchan,

> For NAND based SSDs, mixing of data with different life-time reduces
> efficiency of internal garbage-collection. During FS operations,
> series of journal updates will follow/precede series of data/meta
> updates, causing intermixing inside SSD. By passing a write-hint with
> journal, its write can be isolated from other data/meta writes,
> leading to endurance/performance benefit on SSD.

Why not just introduce REQ_JOURNAL and let the device driver decide how
to turn that into something appropriate for the device?

That's what I'll need for SCSI. Existing SCSI streams are not a good
fit.

-- 
Martin K. Petersen	Oracle Linux Engineering
