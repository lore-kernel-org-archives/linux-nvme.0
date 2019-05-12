From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 12 May 2019 11:58:20 -0700
Subject: [PATCH 6/6] nvme-cli: use uniform if .. else format
In-Reply-To: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
References: <20190512185820.20098-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190512185820.20098-7-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-lightnvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/nvme-lightnvm.c b/nvme-lightnvm.c
index 37bd24b..ee21d6b 100644
--- a/nvme-lightnvm.c
+++ b/nvme-lightnvm.c
@@ -459,8 +459,7 @@ int lnvm_do_id_ns(int fd, int nsid, unsigned int flags)
 			d_raw((unsigned char *)&nvm_id, sizeof(nvm_id));
 		else
 			show_lnvm_id_ns(&nvm_id, flags);
-	}
-	else if (err > 0)
+	} else if (err > 0)
 		fprintf(stderr, "NVMe Status:%s(%x) NSID:%d\n",
 			nvme_status_to_string(err), err, nsid);
 	return err;
-- 
2.17.0
