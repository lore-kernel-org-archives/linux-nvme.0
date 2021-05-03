Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6984C43460
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:24:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E64A061176
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E64A061176
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cIFuHOoUcAmkkYCPTNxaMEgNoYRbYYOeRfnhDKnjfts=; b=nsHhV6XOw3Av7UORvcGlWnlb9
	Lg89u5Q9T+jEtxkvf+Er7+g0Tm5B1L725o9Mu5z8YnXmlTD1hlSncui1dWHBr3j+WysfhFG/QolK2
	/5LhO16DGlPJ2YJ3kHRzZPTjv/Xf58yTccVg/1ryzlBVkbVjmuoG4xS0lLpX4vZ4pPQoITuyojUvk
	QEdBv99AVoBRSXCoOGj+9UwWF871xois+XA2fLVs+VZvG7ZPH1Vgh2sVM3oIzsiH75SNuk+ygx0IF
	YvkuNS5f/8wjNl8NGHSAxrdzR+oVgRjXNxeQ+iF/XUp6Bp7FkVxCgR/ur6yJ7WHcAHnx5hLd3v+KP
	tbAJhc1FA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldaQL-00EDcj-Js; Mon, 03 May 2021 15:23:53 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaQ3-00EDai-8i
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=pWausm9GMz5JtzJq9vmo8HaRLtcioaAz/i+Xg8xIvBQ=; b=P93xGsDCdUmdy55kzCRjJWWZcx
 Irrb59BZJx3W02RS2w9eBrd+l8EmZoTExcEOiTeMYNGmVd/kXDZ1jjkaKuYfj/tsx4MM40A4/9egA
 xB9K1wgF1qzyohBT7Gv8GZHImvMFbog1GIaEMWi1X0W7wT69hSdPfilpPCeVN4oecyM9CFVEElvd9
 uNluzUuheokXvFi56Ym0PMzPQldu3YrM9vZuAHS3kwezQxibxtTEyPLjdRNPzy+OV89MazQidWXOD
 5wBHUn59kodMV8LrhX4X9TwPE1YcN1T00t2aENA6JodWHOyRs6dGuD87nBK1+OB3hGLfJf1+7PxCO
 MCcjIckA==;
Received: from mail-mw2nam10olkn2078.outbound.protection.outlook.com
 ([40.92.42.78] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaQ0-003Abw-DA
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:23:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJhie7+uBcdRAQVHGBoDvAmISHjIIynP90RaGVGKZ4AnmsP/YYIP0gsh/CLcucby2RpvfvLK+3fXZMM1sEYPYAHQOxvhavKA0NDkti2OimFFGBoGzOSKv2JyH6AdajfdzgzpEU7vdhsdBHYXYt2rCIGfNfHLGQEe+lnihGLXrSwSynV5vWc4UjpkbWIehLS2525pwcO/RmQlxcUzIsfY5Zyl/r/vQg+i+rNqscieEpWOj8dG4+lkDsRI/Ljftgcz6gubiEL+z4lB3UA9KKHkaLg0aCzQVZAJFu5kVj6CG2d5lGNWy6c0fYAfAPQHqAi6SqK8tTo0YB22DvZVLJG4tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWausm9GMz5JtzJq9vmo8HaRLtcioaAz/i+Xg8xIvBQ=;
 b=cj7Bfs2GHdepmyXrTqE3Nqqg9eJEOCutPa30GADRuCPPmWzXyyoqde4wSHg0XLDtRy9gRyuEdo2wkG75C68v6vcZVxNEJJgGKkXNu74L4NSNnb7YuGtvzTQt90S5CN6HzyGtftfzwIokXNyJwkJFGDFuF+A3iSJAa0GJD5WHtltVPiTCgYLGbzX8FW/gQCyuLZpg/zsi1yaxR6EwIv1VBU6a56THnwjmNqAO7mdHgoHN03YBhpOMBS/AJcT0NWDCsTxVugqKLpUow+MVo9Q2bAK+QCoaskzML5CUVgoJrqS3RlhaG0T7Px0UqB53Z7ICvZAD7exfPkge3rcDRCueDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWausm9GMz5JtzJq9vmo8HaRLtcioaAz/i+Xg8xIvBQ=;
 b=R4BqQym99vmdFBEpKq1piHbv1oFrLo111ypn1GogAqfExVD41453cbg1MZUcSYI6o1TpXzCMn7hmcPuSWDe+DITCLkVybNsWAlo7ZEdAJTug4bGRYQz/jKS+X3Z61PN/r3EoezT29I4/SYaAd6hd/Zmi2bkJqFdw40LDaW/nm3NQqeVyzcdB+oLXf3gA3zUypNvZMTE2ZpN4I7dmcFnBNr9aFuVGmgfovPnX6Yg55KPLiFseAe196/c+NYCMM8sjXHoFIBZR1fj9B/KkWEyDv3NDSoQIOc4iX2EItd64EzZHClnZ8FHIVDMgr7SSwo7ZVbkc0JvyZN5ezmZPxl2DSA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BL3PR13MB5091.namprd13.prod.outlook.com (2603:10b6:208:33e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.17; Mon, 3 May
 2021 15:23:25 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b%5]) with mapi id 15.20.4108.024; Mon, 3 May 2021
 15:23:25 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 1/1] nvme-tcp: Add option to set the physical interface to be
 used when connecting over TCP sockets.
Date: Mon,  3 May 2021 11:23:03 -0400
Message-ID: <BL0PR13MB42911B0AC62F1C9C0633D1599C5B9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210503152303.23166-1-nitram_67@hotmail.com>
References: <20210503152303.23166-1-nitram_67@hotmail.com>
X-TMN: [KkRPo2vU88Idgrvmdak2/GAQR+Hj4fNa]
X-ClientProxiedBy: MN2PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:c0::35) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210503152303.23166-2-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.10 via Frontend Transport; Mon, 3 May 2021 15:23:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bab7ff01-70b5-471f-021d-08d90e4764df
X-MS-TrafficTypeDiagnostic: BL3PR13MB5091:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oDkCDyrAfHq5seLmByTwQRG4lctcebtv7QVB6n1o9bXNq889IIwPvlHRzdKKcUhpnPmWQOFe45lx46aW9i4v8oNWUbtvjcy9ERBGvzDqLJnm1xf7pXhFn5c9DpL4QoS4uExhimWWEsMgEpxqFGWqY26gkQoAlm/hJqwbrPhCnLr300Ky9sjm5oqUES7PdnGliykhdqxf+7x9ln7FhJGB3PsNv2mAtvf+7TBEY/lMU8dZvflGmZH5exjNjQeHvVpC3zGar1a/0duFRfLnmyRp0H2VoMCFsscLHfhGNsTQ2DUXlgIoEgMJjPKZ7q0Jy/LXQuyRgTfBC2KuziPm6goQvabtXsSe7XWljMdKR2UkbR0Ut1s512b2cqsEfQYBQUcAkxVIJ7B9e72M5Pfez/fFg==
X-MS-Exchange-AntiSpam-MessageData: FQDCyT141iR2ZvMOn2y3+WjEupaOfHSikGzpUTnTWjeJQoYakDVfQQ8JTLPcUXpAQlrz8PAUKjti4uJUajCO2yPmD0gSkZaKEJ+T0q5BkWe2/Xr8pxx+Y0resySKtutnwXuewBAoAboSAyKIiMix1Q==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bab7ff01-70b5-471f-021d-08d90e4764df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 15:23:25.4485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_082332_475791_1D4BBD9D 
X-CRM114-Status: GOOD (  21.20  )
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

Add 'Host Transport Interface' (host-triface) option. This can be used
to specify the IP interface to use for the connection. The driver uses
that to set SO_BINDTODEVICE on the TCP socket before connecting.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
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
