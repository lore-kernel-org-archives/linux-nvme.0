From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 03 Sep 2015 23:24:40 -0400
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page
 to a bio
In-Reply-To: <1441297703-10753-4-git-send-email-sagig@mellanox.com> (Sagi
 Grimberg's message of "Thu, 3 Sep 2015 19:28:22 +0300")
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
 <1441297703-10753-4-git-send-email-sagig@mellanox.com>
Message-ID: <yq1a8t2amtj.fsf@sermon.lab.mkp.net>

>>>>> "Sagi" == Sagi Grimberg <sagig at mellanox.com> writes:

Sagi> This is only theoretical at the moment given that the only
Sagi> subsystems that generate integrity payloads are the block layer
Sagi> itself and the scsi target (which generate well aligned integrity
Sagi> payloads). But when we will expose integrity meta-data to
Sagi> user-space, we'll need to refuse appending a page with a gap (if
Sagi> the queue virtual boundary is set).

Code looks fine but my concerns outlined in:

http://lists.infradead.org/pipermail/linux-nvme/2015-July/002063.html

still stand.

-- 
Martin K. Petersen	Oracle Linux Engineering
