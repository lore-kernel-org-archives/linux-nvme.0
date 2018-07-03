From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  3 Jul 2018 15:09:25 +0300
Subject: [PATCH 2/2] fabrics: omit newline character when reading nvme host nqn
In-Reply-To: <20180703120925.1095-1-sagi@grimberg.me>
References: <20180703120925.1095-1-sagi@grimberg.me>
Message-ID: <20180703120925.1095-2-sagi@grimberg.me>

This breaks the command string.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fabrics.c b/fabrics.c
index fadbc95b6daa..9aee8f8c5ee5 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -452,7 +452,7 @@ static int nvmf_hostnqn_file(void)
 	if (fgets(hostnqn, sizeof(hostnqn), f) == NULL)
 		goto out;
 
-	cfg.hostnqn = strdup(hostnqn);
+	cfg.hostnqn = strndup(hostnqn, strcspn(hostnqn, "\n"));
 	if (!cfg.hostnqn)
 		goto out;
 
-- 
2.14.1
