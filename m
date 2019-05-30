From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 30 May 2019 12:43:24 +0300
Subject: [PATCH 3/5] fabrics: Fix memory leak of subsys list
In-Reply-To: <1559209406-713-1-git-send-email-maxg@mellanox.com>
References: <1559209406-713-1-git-send-email-maxg@mellanox.com>
Message-ID: <1559209406-713-3-git-send-email-maxg@mellanox.com>

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fabrics.c b/fabrics.c
index 573a6ef..9ed4a56 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -1205,5 +1205,6 @@ int disconnect_all(const char *desc, int argc, char **argv)
 		}
 	}
 out:
+	free_subsys_list(slist, subcnt);
 	return ret;
 }
-- 
1.8.3.1
