Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5696CC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:30:26 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7966B6113D
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966B6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aClpCEsFgS3GKh+I87AjUtA+hpluOpca3gQEReuPlrY=; b=ETID0YlIM/aO9nU5VY8KjB0Ej
	1Q2PMDSDe93NIwfCC2v5rg5C9mBx6Em/gmqxuvqaIaDEYwICrxsyuHAMcy5BaJ2qLRtk8vcfEZzx4
	aFzlzqwNb28qRkmZdreLMj5FBu/vdRfBGFSI54JmyPY91BxbDBQieq3jR7I5GX6P1VJN9zJkKcR/4
	nagtSbsd9K4qxVsmmMWR66v1oxU/eGDkvPlifrA3bImfEW86Y2dLoLvrGg0yKBFIypLykUgxzfPbB
	+3K+RikiXocYIOAJ29VnclT4U6YqqUuhn+tsCe8Rn4HKQHzWVflXIXX7ZGgHP/CPxxT/9b/DNqWVF
	THUS3lLgQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX7gk-00H8Ww-6z; Thu, 15 Apr 2021 19:30:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7gU-00H8TN-Tw
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 19:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=EeteqPTi/GSAAT5aI2Ci07RBz7Od0ieH0w40Fxnfylw=; b=kTT486F9vDEAbwqARkvaLIP6fV
 mVI38e0aPIzzvr5mDVGpOzBOExe4RdbhlXb3v/06+MxHXrzqTKr1teB9vNOryE6ZNb2sawblHdejg
 +hbK6P57cMb8VZ0w7Bfemim3Yv9l67pj++8LLBFxujBzmUIfEJQ01rL4ocOEQbsBgkxFTjCUSd02s
 ZOCX0NgjwEjKoET+2kDaozs4nckqgvNcuXOsVuN8131bXX8SGQHdArH3nO5Qs6fBZr05CDn805oYl
 Y/4S5rxtSqgFu0SrjcgoiLkP0vuhBc2Ywp0uL28W4gxfWaNJRCDi4WR5Go4ZlbakJJWyjwDmpGFQi
 kz90f/lw==;
Received: from mail-dm6nam11olkn2051.outbound.protection.outlook.com
 ([40.92.19.51] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7gR-008qXF-V1
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 19:29:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INwLacCLM8pmypWWQe7zRS6EiGIdM1ryIYbu18iCioHBBmwZ6K1IqysFtiNsA8zooXe40qaHjVfAwPAb2d8+hMY1muZ337XTjJQHf5zG9TFx4Y3hhJDjMP3SF4P07aX47ndL7H0gJTwCy9GENgXXAg++R3e6fV5uHKY0yRD+GEX7NOmiOrvKl51o3mwu1FUWSo1U0hDHEyiPRTtHss8BtLra+1M6QGMYfG3bKQBHjqQn1ulck39yIqAxgjn2x8f7RGk9PcAfbFAOIe0Yx3m4Q/v5AI0SN1ew7WpCL5/j8I0s6l76lDz8S9g/v9YG2zA57ZVahNtvBaEneSqADpbNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeteqPTi/GSAAT5aI2Ci07RBz7Od0ieH0w40Fxnfylw=;
 b=k7NmOwn5tYHtVO/okN+cwIDG+Mc4Zi5agbQ92fiS+O5zFZzuuF/VP69GPjlm4+ZSdCQ6Sf89M7YvBGoJrBtFh6TWWwXPhdEC3wD9t3ommSUMEFvOaMJx89gWZpc8IwPFmXryf5WqWs0M/Z2LhJ4hLbLCXP1qOqTyIpm0lX/IJK0Q17h1ngD+4fk1/EHONG8IMRZyNNDyX9StZrPD5PTI3cDpw6K9PXOiGy0/XeIomh1XHpKH2PfGgvq5x99lvyc7EB7FHZSUspEnUn+qwReSYa9FijGLR7pU+ZMxGjDTy/mhlEUm/mUE47rzTCUbTobXDYrMCAV1/hf+IZCPvdKlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeteqPTi/GSAAT5aI2Ci07RBz7Od0ieH0w40Fxnfylw=;
 b=DYr2pGDIxNGxnr0VUhtPsmR2LIMeGILhuefsbWwix2dT0mHMj5PgmUpXCi2OQCysMYG9nj1QBJSuRuOq/naatl4lHpXltdOxmZDwPocrZ2iswkFTGRnVtZd98B6MDKPxVPLuaDn3UY/O95S6GAEL7qQPpoBuwf/VZw01UZ/NyLeOgql7YO/PgnIG4UNGDl4o64SKhSApv5Xe1Lzx/P8CoFYkGw3wUYD4JGxfsmp027ZXuf+DraVP75YQv0PbUsW7R5kG17ZOOzA0GZbbapdOsv3FjCrDUDyw/edM45hXgI48IsCJGwbclHoBc/Gz4O/Yuq0Zpau8edZLzT40/jNSMg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3869.namprd13.prod.outlook.com (2603:10b6:208:1e0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6; Thu, 15 Apr
 2021 19:29:46 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 19:29:46 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 1/1] Add 'Transport Interface' (triface) option. This can be
 used to specify the IP interface to use for the connection. The driver uses
 that to set SO_BINDTODEVICE on the socket before connecting.
Date: Thu, 15 Apr 2021 15:28:48 -0400
Message-ID: <BL0PR13MB42917AC33BFFC7DB2440D1149C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210415192848.962891-1-nitram_67@hotmail.com>
References: <20210415192848.962891-1-nitram_67@hotmail.com>
X-TMN: [TnmSXNViGK0Q2nitTTS59KNHui7IKcgr]
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210415192848.962891-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 19:29:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c34993-f292-4d7b-353f-08d90044d345
X-MS-TrafficTypeDiagnostic: MN2PR13MB3869:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zx5KfrM9+IZqQDERjuzBjT4CK5+Zup6VU2Z/iaJkrkA+RFHkL0Rc7Ey73bL1gON+ZVMxI+GsJB4f3WbkqRdQrdZDEZcyGuudTBxC1arPbKSfWmIB0JcLO/pfoE9LQvOZCychsY2D5UkRgQ3GM6zUMUDA0nXJfhawhH6DLMGkM5dqZmiMrbpKtNgPs+bOSNms+E0m7s899zwIDWTMYlOsxJKtCP2VYiR/ZHLpF3Wn3j5FxwLoc2QiLpUsNOjIJ0IcJJmhfY4YntzLGLiJLWqEF5irt7ITc7LA77dr31kMxHm4VB19fOTO6D+l+ZHNO1nDaJjBhmfUrtB4QbtSNup93EcABKmrNGmrXIgOKEhFe+YHmFeEBXe3MNfjfbYw5kImEriTH/8rmEd/FRixN+Gjbw==
X-MS-Exchange-AntiSpam-MessageData: myjvKYKA0VMwa4TIsYfOax7nOpO04Cwq+cUhpW08Yo/WIrNxns8s97PL3k5oHQZYfayovhxaJDy3Ed7g22p4k9q9BeFzfMzriy3PYx7FdlCGzYWYrw2ylfpOOXQk3ImFFTsMJmb7cki/nqNDiBGtCA==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c34993-f292-4d7b-353f-08d90044d345
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 19:29:46.1924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_122948_030142_0E350528 
X-CRM114-Status: GOOD (  19.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Belanger <martin.belanger@dell.com>

---
 drivers/nvme/host/core.c    |  5 +++++
 drivers/nvme/host/fabrics.c | 14 +++++++++++++
 drivers/nvme/host/fabrics.h |  6 +++++-
 drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 288ac47ff5b4..91ae11a1ae26 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3961,6 +3961,11 @@ static int nvme_class_uevent(struct device *dev, struct kobj_uevent_env *env)
 
 		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
 				opts->host_traddr ?: "none");
+		if (ret)
+			return ret;
+
+		ret = add_uevent_var(env, "NVME_HOST_TRIFACE=%s",
+				opts->host_triface ?: "none");
 	}
 	return ret;
 }
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 604ab0e5a2ad..f5d0d760b53b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -112,6 +112,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
 		len += scnprintf(buf + len, size - len, "%shost_traddr=%s",
 				(len) ? "," : "", ctrl->opts->host_traddr);
+	if (ctrl->opts->mask & NVMF_OPT_HOST_TRIFACE)
+		len += scnprintf(buf + len, size - len, "%shost_triface=%s",
+				(len) ? "," : "", ctrl->opts->host_triface);
 	len += scnprintf(buf + len, size - len, "\n");
 
 	return len;
@@ -604,6 +607,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_KATO,		"keep_alive_tmo=%d"	},
 	{ NVMF_OPT_HOSTNQN,		"hostnqn=%s"		},
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
+	{ NVMF_OPT_HOST_TRIFACE,	"host_triface=%s"	},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
@@ -813,6 +817,15 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			kfree(opts->host_traddr);
 			opts->host_traddr = p;
 			break;
+		case NVMF_OPT_HOST_TRIFACE:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			kfree(opts->host_triface);
+			opts->host_triface = p;
+			break;
 		case NVMF_OPT_HOST_ID:
 			p = match_strdup(args);
 			if (!p) {
@@ -997,6 +1010,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->trsvcid);
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
+	kfree(opts->host_triface);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 733010d2eafd..17c64ff4db8c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -59,6 +59,7 @@ enum {
 	NVMF_OPT_NR_POLL_QUEUES = 1 << 18,
 	NVMF_OPT_TOS		= 1 << 19,
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
+	NVMF_OPT_HOST_TRIFACE	= 1 << 21,
 };
 
 /**
@@ -76,7 +77,9 @@ enum {
  * @trsvcid:	The transport-specific TRSVCID field for a port on the
  *              subsystem which is adding a controller.
  * @host_traddr: A transport-specific field identifying the NVME host port
- *              to use for the connection to the controller.
+ *		to use for the connection to the controller.
+ * @host_triface: A transport-specific field identifying the NVME host
+ *		interface to use for the connection to the controller.
  * @queue_size: Number of IO queue elements.
  * @nr_io_queues: Number of controller IO queues that will be established.
  * @reconnect_delay: Time between two consecutive reconnect attempts.
@@ -101,6 +104,7 @@ struct nvmf_ctrl_options {
 	char			*traddr;
 	char			*trsvcid;
 	char			*host_traddr;
+	char			*host_triface;
 	size_t			queue_size;
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8e55d8bc0c50..28eb7f88b487 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1447,6 +1447,20 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		}
 	}
 
+	if (nctrl->opts->mask & NVMF_OPT_HOST_TRIFACE) {
+		char *iface = nctrl->opts->host_triface;
+		sockptr_t optval = KERNEL_SOCKPTR(iface);
+
+		ret = sock_setsockopt(queue->sock, SOL_SOCKET, SO_BINDTODEVICE,
+				      optval, strlen(iface));
+		if (ret) {
+			dev_err(nctrl->device,
+			  "failed to bind to interface %s queue %d err %d\n",
+			  iface, qid, ret);
+			goto err_sock;
+		}
+	}
+
 	queue->hdr_digest = nctrl->opts->hdr_digest;
 	queue->data_digest = nctrl->opts->data_digest;
 	if (queue->hdr_digest || queue->data_digest) {
@@ -2457,6 +2471,10 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
+	const char *iface_key = "";
+	const char *iface_val = "";
+	const char *srce_key  = "";
+	const char *srce_val  = "";
 	struct nvme_tcp_ctrl *ctrl;
 	int ret;
 
@@ -2502,6 +2520,22 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 			       opts->host_traddr);
 			goto out_free_ctrl;
 		}
+		srce_key = ", src-addr ";
+		srce_val = opts->host_traddr;
+	}
+
+	if (opts->mask & NVMF_OPT_HOST_TRIFACE) {
+		struct net_device *ndev;
+
+		ndev = dev_get_by_name(&init_net, opts->host_triface);
+		if (!ndev) {
+			pr_err("invalid interface passed: %s\n",
+			       opts->host_triface);
+			ret = -ENODEV;
+			goto out_free_ctrl;
+		}
+		iface_key = ", iface ";
+		iface_val = opts->host_triface;
 	}
 
 	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
@@ -2530,8 +2564,9 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp%s%s%s%s\n",
+		 ctrl->ctrl.opts->subsysnqn, &ctrl->addr,
+		 srce_key, srce_val, iface_key, iface_val);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
@@ -2560,7 +2595,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_TRIFACE,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
