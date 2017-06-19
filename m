From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 19 Jun 2017 12:28:12 -0400
Subject: [PATCH v2 2/2] nvme: use a single NVME_AQ_DEPTH and relax it to 32
In-Reply-To: <1497791759-5754-2-git-send-email-sagi@grimberg.me> (Sagi
 Grimberg's message of "Sun, 18 Jun 2017 16:15:59 +0300")
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
 <1497791759-5754-2-git-send-email-sagi@grimberg.me>
Message-ID: <yq1poe0lz6r.fsf@oracle.com>


Sagi,

> No need to differentiate fabrics from pci/loop, also lower it to 32 as
> we don't really need 256 inflight admin commands.

That's fine with me. I was about to submit a patch quirking it to 64 due
to a controller problem.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
