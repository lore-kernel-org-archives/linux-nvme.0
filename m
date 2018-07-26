From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 25 Jul 2018 22:00:51 -0400
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180724115009.731-6-hch@lst.de> (Christoph Hellwig's message of
 "Tue, 24 Jul 2018 13:50:05 +0200")
References: <20180724115009.731-1-hch@lst.de> <20180724115009.731-6-hch@lst.de>
Message-ID: <yq1r2jq21t8.fsf@oracle.com>


Christoph,

> The gendisk for a ns_head is only registered once a life path for it

Minor nit:

s/life/live/

-- 
Martin K. Petersen	Oracle Linux Engineering
