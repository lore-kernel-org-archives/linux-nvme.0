From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 14 Aug 2018 21:23:43 +0000
Subject: [PATCH] nvmet: free workqueue object if module init fails
In-Reply-To: <20180809172456.5728-1-chaitanya.kulkarni@wdc.com>
References: <20180809172456.5728-1-chaitanya.kulkarni@wdc.com>
Message-ID: <BYAPR04MB4502F296A5BA4E064064028986380@BYAPR04MB4502.namprd04.prod.outlook.com>


Please ignore this, Iet me resend this patch.




From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Sent: Thursday, August 9, 2018 10:24 AM
To: linux-nvme at lists.infradead.org
Cc: Chaitanya Kulkarni
Subject: [PATCH] nvmet: free workqueue object if module init fails
? 
 
This patch frees the buffered_io_wq workqueue object when module init
fails to complete the initialization.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
?drivers/nvme/target/core.c | 1 +
?1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14b4c4916a8e..feaec53543ef 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1220,6 +1220,7 @@ static int __init nvmet_init(void)
?out_exit_discovery:
???????? nvmet_exit_discovery();
?out:
+?????? kfree(buffered_io_wq);
???????? return error;
?}
?
-- 
2.17.0

    
