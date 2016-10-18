From: bart.vanassche@sandisk.com (Bart Van Assche)
Date: Tue, 18 Oct 2016 13:10:24 -0700
Subject: [PATCH 2/6] nvme-fabrics: Adjust source code indentation
In-Reply-To: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
Message-ID: <8755441c-b962-f476-bb15-1700963a8653@sandisk.com>

Adjust indentation such that arguments are aligned.

Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5a3f008..716d9e2 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -576,7 +576,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			nqnlen = strlen(opts->subsysnqn);
 			if (nqnlen >= NVMF_NQN_SIZE) {
 				pr_err("%s needs to be < %d bytes\n",
-				opts->subsysnqn, NVMF_NQN_SIZE);
+				       opts->subsysnqn, NVMF_NQN_SIZE);
 				ret = -EINVAL;
 				goto out;
 			}
@@ -665,7 +665,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			nqnlen = strlen(p);
 			if (nqnlen >= NVMF_NQN_SIZE) {
 				pr_err("%s needs to be < %d bytes\n",
-					p, NVMF_NQN_SIZE);
+				       p, NVMF_NQN_SIZE);
 				ret = -EINVAL;
 				goto out;
 			}
-- 
2.10.1
