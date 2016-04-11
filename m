From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 11 Apr 2016 16:28:06 -0400
Subject: [PATCH] nvme/host: Add missing blk_integrity tag_size + flags
 assignments
In-Reply-To: <20160410145930.GA21909@lst.de> (Christoph Hellwig's message of
 "Sun, 10 Apr 2016 16:59:30 +0200")
References: <1460171082-7212-1-git-send-email-nab@daterainc.com>
 <20160410145930.GA21909@lst.de>
Message-ID: <yq1d1pv3n6x.fsf@sermon.lab.mkp.net>

>>>>> "Christoph" == Christoph Hellwig <hch at lst.de> writes:

Christoph> Does NVMe really force ATO=1?

It does.

-- 
Martin K. Petersen	Oracle Linux Engineering
