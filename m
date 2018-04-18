From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:06 -0400
Subject: [PATCH 15/20] fs: export kern_path_locked() to reuse the code
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-16-chaitanya.kulkarni@wdc.com>

We export kern_path_locked to reuse the code.
We use this API when deleting the file when host
calls nvme-delete-ns command.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 fs/namei.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/namei.c b/fs/namei.c
index cafa365eeb70..9a57e33175c4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2398,6 +2398,7 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 	putname(filename);
 	return d;
 }
+EXPORT_SYMBOL(kern_path_locked);
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
-- 
2.14.1
