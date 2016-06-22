From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Jun 2016 15:06:01 +0300
Subject: [PATCH 2/2] nvme-fabrics: Remove tl_retry_count
In-Reply-To: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
Message-ID: <1466597161-5242-3-git-send-email-sagi@grimberg.me>

The timeout before error recovery logic kicks in is
dictated by the nvme keep-alive, so we don't really need
a transport layer retry count. transports can retry for
as much as they like.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 14 --------------
 drivers/nvme/host/fabrics.h |  3 ---
 2 files changed, 17 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index b86b6379ef0c..0a5a4c4684bc 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -503,7 +503,6 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NQN,			"nqn=%s"		},
 	{ NVMF_OPT_QUEUE_SIZE,		"queue_size=%d"		},
 	{ NVMF_OPT_NR_IO_QUEUES,	"nr_io_queues=%d"	},
-	{ NVMF_OPT_TL_RETRY_COUNT,	"tl_retry_count=%d"	},
 	{ NVMF_OPT_RECONNECT_DELAY,	"reconnect_delay=%d"	},
 	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
@@ -521,7 +520,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	/* Set defaults */
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
-	opts->tl_retry_count = 2;
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
@@ -605,18 +603,6 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->nr_io_queues = min_t(unsigned int,
 					num_online_cpus(), token);
 			break;
-		case NVMF_OPT_TL_RETRY_COUNT:
-			if (match_int(args, &token)) {
-				ret = -EINVAL;
-				goto out;
-			}
-			if (token < 0) {
-				pr_err("Invalid tl_retry_count %d\n", token);
-				ret = -EINVAL;
-				goto out;
-			}
-			opts->tl_retry_count = token;
-			break;
 		case NVMF_OPT_KATO:
 			if (match_int(args, &token)) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index b54067404963..89df52c8be97 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -69,8 +69,6 @@ enum {
  * @trsvcid:	network port used for host-controller communication.
  * @queue_size: Number of IO queue elements.
  * @nr_io_queues: Number of controller IO queues that will be established.
- * @tl_retry_count: Number of transport layer retries for a fabric queue before
- *		     kicking upper layer(s) error recovery.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
@@ -84,7 +82,6 @@ struct nvmf_ctrl_options {
 	char			*trsvcid;
 	size_t			queue_size;
 	unsigned int		nr_io_queues;
-	unsigned short		tl_retry_count;
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
 	unsigned int		kato;
-- 
1.9.1
