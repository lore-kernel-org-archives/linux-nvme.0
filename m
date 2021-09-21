Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D66C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D1E61165
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 94D1E61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ofq5EzTmJalolA+gBcm0V9XXnAp6A61AyvF1w6FLvc8=; b=EPcdTcqmIu11pX
	ff81D4bnlFFyacXSCR+ea4tYmg2HR8Qg3Uv5owT4AdzGKLu8qSfrt7na/AV3RFrIQaYQUmLOn3+sB
	HumDtuIVrUSCaiXYyhgxWcmgfU5dareSpXnPzv5FmqWGrR8aEU+3wnzfGXiYVBcC5Y6UaHrClP6bR
	Rfz84WSnb8IYjVdnNl+FAGO+Isk8pFDg9Rajj3CoXfobsHFLrhzH6niPhGxEdZskcDw05Q/KYFxjG
	PbwMgNOOhhse4eIZUpfwGttC0OGCIWUv4Dh0+JIxT6dsfGyBoLEhoWraagjeoHclefN3OJGiV6AU3
	dd80uFGZUd2DQipZ1WUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mShWa-004rYt-CN; Tue, 21 Sep 2021 15:17:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mShUq-004r9c-Oc
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 15:15:50 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7CED520158;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632237341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fl5iCwJKF3DgrTRwHlXQ9dHas/dQ/RTXCid88zl06G4=;
 b=d/wm18YWLUJI2GJj7pnVzYzhLHv23k3lPrG+En1Vgd7srffuOkdHPIK3G2tplmDtv2rwR8
 jPi+1uJoIYxKHZlfuQVvtGy3h0z+gZIcPXvVnuaiAoF7LtHSqkWx5VT8eehD0ZrZnoXFCN
 vkQBtxNHYr5ToktGX4CaxTAFX0z5ujs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632237341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fl5iCwJKF3DgrTRwHlXQ9dHas/dQ/RTXCid88zl06G4=;
 b=CdRnYiwcDQ3ekHiZYojf91KBwWlmwmSfh6HR1S+sV5hhrmhFSzMH7kl8951a8kmU8z2GAL
 SMrRFnFZarAAtaDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 75331A3BA8;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 836AE518EA93; Tue, 21 Sep 2021 17:15:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] nvme: Add connect option 'discovery'
Date: Tue, 21 Sep 2021 17:15:28 +0200
Message-Id: <20210921151529.29419-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210921151529.29419-1-hare@suse.de>
References: <20210921151529.29419-1-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_081549_006947_766F2379 
X-CRM114-Status: GOOD (  14.57  )
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

Add a connect option 'discovery' to specify that the connection
should be made to a discovery controller, not a normal I/O controller.
With discovery controllers supporting unique subsystem NQNs we
cannot easily distinguish by the subsystem NQN if this should be
a discovery connection, but we need this information to blank out
options not supported by discovery controllers.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c    | 7 +++++++
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1ed1b7be2812..ad01e2778cb6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2715,6 +2715,13 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	else
 		subsys->subtype = NVME_NQN_NVME;
 
+	if (nvme_discovery_ctrl(ctrl) && subsys->subtype != NVME_NQN_DISC) {
+		dev_err(ctrl->device,
+			"Subsystem %s is not a discovery controller",
+			subsys->subnqn);
+		kfree(subsys);
+		return -EINVAL;
+	}
 	subsys->awupf = le16_to_cpu(id->awupf);
 #ifdef CONFIG_NVME_MULTIPATH
 	subsys->iopolicy = NVME_IOPOLICY_NUMA;
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 668c6bb7a567..c5a2b71c5268 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
+	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -823,6 +824,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_DISCOVERY:
+			opts->discovery_nqn = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -949,7 +953,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES | \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
-				 NVMF_OPT_DISABLE_SQFLOW |\
+				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO)
 
 static struct nvme_ctrl *
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index a146cb903869..b61b666e10ec 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_TOS		= 1 << 19,
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
+	NVMF_OPT_DISCOVERY	= 1 << 22,
 };
 
 /**
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
