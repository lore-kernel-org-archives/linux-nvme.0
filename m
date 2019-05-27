From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 27 May 2019 13:01:44 +0300
Subject: [PATCH 3/9] fabrics: Fix memory leak of subsys list
In-Reply-To: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
References: <1558951310-31066-1-git-send-email-maxg@mellanox.com>
Message-ID: <1558951310-31066-4-git-send-email-maxg@mellanox.com>

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fabrics.c b/fabrics.c
index 511de06..b42a3ce 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1203,5 +1203,6 @@ int disconnect_all(const char *desc, int argc, char **argv)
 		}
 	}
 out:
+	free_subsys_list(slist, subcnt);
 	return ret;
 }
-- 
1.8.3.1
