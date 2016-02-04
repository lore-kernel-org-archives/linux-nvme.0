From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 4 Feb 2016 17:59:41 +0200
Subject: [PATCH 4/4] blk-mq: End unstarted requests on dying queue
In-Reply-To: <1454515543-21683-5-git-send-email-keith.busch@intel.com>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-5-git-send-email-keith.busch@intel.com>
Message-ID: <56B3756D.7040500@dev.mellanox.co.il>


> Go directly to ending a request if it wasn't started. Previously, completing a
> request may invoke a driver callback for a request it didn't initialize.

Looks good,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
