From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 25 Jul 2018 21:11:58 -0400
Subject: [PATCH v4 1/3] block: move ref_tag calculation func to the block
 layer
In-Reply-To: <1532533577-1600-1-git-send-email-maxg@mellanox.com> (Max
 Gurtovoy's message of "Wed, 25 Jul 2018 18:46:15 +0300")
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
Message-ID: <yq1o9eu3in5.fsf@oracle.com>


Max,

> Currently this function is implemented in the scsi layer, but it's
> actual place should be the block layer since T10-PI is a general
> data integrity feature that is used in the nvme protocol as well.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
