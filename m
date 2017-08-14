From: mwilck@suse.com (Martin Wilck)
Date: Mon, 14 Aug 2017 22:12:37 +0200
Subject: [PATCH v4 1/3] nvmet_execute_identify_ctrl: don't overwrite with
 0-bytes
In-Reply-To: <20170814201239.15255-1-mwilck@suse.com>
References: <20170810084541.bawqaebfycnguomx@infradead.org>
 <20170814201239.15255-1-mwilck@suse.com>
Message-ID: <20170814201239.15255-2-mwilck@suse.com>

The merged version of my patch "nvmet: don't report 0-bytes in serial
number" fails to remove two lines which should have been replaced,
so that the space-padded strings are overwritten again with 0-bytes.
Fix it.

Fixes: 42de82a8b544 nvmet: don't report 0-bytes in serial number
Signed-off-by: Martin Wilck <mwilck at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 2d7a98ab53fbf..a53bb6635b837 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -199,12 +199,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	copy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1);
 	copy_and_pad(id->fr, sizeof(id->fr), UTS_RELEASE, strlen(UTS_RELEASE));
 
-	memset(id->mn, ' ', sizeof(id->mn));
-	strncpy((char *)id->mn, "Linux", sizeof(id->mn));
-
-	memset(id->fr, ' ', sizeof(id->fr));
-	strncpy((char *)id->fr, UTS_RELEASE, sizeof(id->fr));
-
 	id->rab = 6;
 
 	/*
-- 
2.14.0
