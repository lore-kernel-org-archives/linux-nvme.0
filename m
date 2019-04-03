From: joshi.k@samsung.com (kanchan)
Date: Wed, 3 Apr 2019 19:12:00 +0530
Subject: [PATCH v3 7/7] fs/ext4,jbd2: add support for passing write-hint
 with journal
In-Reply-To: <yq14l7fokx0.fsf@oracle.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075800epcas2p4731f10eabf7d70dc7096117d161b05a3@epcas2p4.samsung.com>
 <1553846032-4451-8-git-send-email-joshi.k@samsung.com>
 <yq14l7fokx0.fsf@oracle.com>
Message-ID: <11cd01d4ea23$1bb6b260$53241720$@samsung.com>

Hi Martin,

> Why not just introduce REQ_JOURNAL and let the device driver decide how to
turn that into something appropriate for the device?

It began with that kind of thought/goal i.e.  introduce something just for
FS journal. But it seems to have evolved for good. 
Current approach extends write-hint infra so that whole thing becomes
extensible for other kind of use-cases (than FS journal) as well. 	
Also in this approach, driver will do little, while block-layer will do
majority of the work.

> That's what I'll need for SCSI. Existing SCSI streams are not a good fit.

Do you see that it's difficult for SCSI to use write-hint infrastructure for
streams? 


  
-----Original Message-----
From: Martin K. Petersen [mailto:martin.petersen@oracle.com] 
Sent: Wednesday, April 03, 2019 8:28 AM
To: Kanchan Joshi <joshi.k at samsung.com>
Cc: linux-kernel at vger.kernel.org; linux-block at vger.kernel.org;
linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org;
linux-ext4 at vger.kernel.org; axboe at fb.com; prakash.v at samsung.com;
anshul at samsung.com; joshiiitr at gmail.com
Subject: Re: [PATCH v3 7/7] fs/ext4,jbd2: add support for passing write-hint
with journal


Kanchan,

> For NAND based SSDs, mixing of data with different life-time reduces 
> efficiency of internal garbage-collection. During FS operations, 
> series of journal updates will follow/precede series of data/meta 
> updates, causing intermixing inside SSD. By passing a write-hint with 
> journal, its write can be isolated from other data/meta writes, 
> leading to endurance/performance benefit on SSD.

Why not just introduce REQ_JOURNAL and let the device driver decide how to
turn that into something appropriate for the device?

That's what I'll need for SCSI. Existing SCSI streams are not a good fit.

-- 
Martin K. Petersen	Oracle Linux Engineering
