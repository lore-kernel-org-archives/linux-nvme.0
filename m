From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 13 May 2019 22:06:13 -0400
Subject: [PATCH V4 0/3] scsi: core: avoid big pre-allocation for sg list
In-Reply-To: <20190428073932.9898-1-ming.lei@redhat.com> (Ming Lei's message
 of "Sun, 28 Apr 2019 15:39:29 +0800")
References: <20190428073932.9898-1-ming.lei@redhat.com>
Message-ID: <yq1a7fpg57u.fsf@oracle.com>


Ming,

> Since supporting to blk-mq, big pre-allocation for sg list is
> introduced, this way is very unfriendly wrt. memory consumption.

Applied to 5.3/scsi-queue with some clarifications to the commit
descriptions.

I am not entirely sold on 1 for the inline protection SGL size. NVMe
over PCIe is pretty constrained thanks to the metadata pointer whereas
SCSI DIX uses a real SGL for the PI. Consequently, straddling a page is
not that uncommon for large, sequential I/Os.

But let's try it out. If performance suffers substantially, we may want
to bump it to 2.

-- 
Martin K. Petersen	Oracle Linux Engineering
