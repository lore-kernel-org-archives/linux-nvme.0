Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38EDC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32E520739
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yoN1AUn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32E520739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NqT1g3eO4tZc3L0bwtrgLLgDjywC/E+u7zGumSlSsMI=; b=yoN1AUn/nm/06TwQu/erZtVkMy
	xWVaHGoB4hTiRhPTsS4eW/CoeQ4IZfAy3e3KJTAn4ngdF6JNjdiKYK9GKUDIcWaqOi/xXTjcKVuBL
	TcBhc7X3CpdSvfglL478sJcQgVmJkHIcoJ1GnHQNHW9Of4BVEw5JERFUsieozV6ip/jAxcB06rbkT
	eRClsheLoIL6DJONRz3A+Mv12Ibx4Z9ERqffRRBuVrdGEOp+rP3akHU8hRBOBLQ3SYVvXbFrgcGry
	FrHkN9OXO4oZJ240t5vUmeSYbtNgtw3EudOkem+migeXQoBKLlVDzS9XExIuVSVIhdL7keCP4oBsz
	SVeAug7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCi-0003pz-Fy; Tue, 22 Sep 2020 12:15:28 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCU-0003ld-LU
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:17 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9B970AF34;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/7] nvme-fcloop: use IDA for port ids
Date: Tue, 22 Sep 2020 14:14:57 +0200
Message-Id: <20200922121501.32851-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081514_982501_669DB3EC 
X-CRM114-Status: GOOD (  18.67  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use an IDA to register port IDs to avoid duplicate port IDs. It
also will generate a unique port ID if none is specified.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 51 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 082aa4dee406..e56f323fa7d4 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -12,6 +12,7 @@
 #include <linux/nvme-fc-driver.h>
 #include <linux/nvme-fc.h>
 
+#define FCLOOP_MAX_AL_PA 0xEF
 
 enum {
 	NVMF_OPT_ERR		= 0,
@@ -63,6 +64,9 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
 	int token, ret = 0;
 	u64 token64;
 
+	/* Default setting */
+	opts->fcaddr = 1;
+
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
 		return -ENOMEM;
@@ -102,6 +106,10 @@ fcloop_parse_options(struct fcloop_ctrl_options *opts,
 				ret = -EINVAL;
 				goto out_free_options;
 			}
+			if (!token || token > FCLOOP_MAX_AL_PA) {
+				ret = -EINVAL;
+				goto out_free_options;
+			}
 			opts->fcaddr = token;
 			break;
 		case NVMF_OPT_LPWWNN:
@@ -203,11 +211,13 @@ fcloop_parse_nm_options(struct device *dev, u64 *nname, u64 *pname,
 static DEFINE_SPINLOCK(fcloop_lock);
 static LIST_HEAD(fcloop_lports);
 static LIST_HEAD(fcloop_nports);
+static DEFINE_IDA(fcloop_portid_ida);
 
 struct fcloop_lport {
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
 	struct completion unreg_done;
+	u32 port_id;
 };
 
 struct fcloop_lport_priv {
@@ -949,6 +959,8 @@ fcloop_nport_free(struct kref *ref)
 	list_del(&nport->nport_list);
 	spin_unlock_irqrestore(&fcloop_lock, flags);
 
+	ida_free(&fcloop_portid_ida, nport->port_id);
+
 	kfree(nport);
 }
 
@@ -1047,7 +1059,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 	struct fcloop_lport *lport;
 	struct fcloop_lport_priv *lport_priv;
 	unsigned long flags;
-	int ret = -ENOMEM;
+	int ret = -ENOMEM, port_id;
 
 	lport = kzalloc(sizeof(*lport), GFP_KERNEL);
 	if (!lport)
@@ -1067,11 +1079,22 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		goto out_free_opts;
 	}
 
+	port_id = ida_alloc_range(&fcloop_portid_ida,
+				  opts->fcaddr, FCLOOP_MAX_AL_PA, GFP_KERNEL);
+	if (port_id < 0) {
+		ret = port_id;
+		goto out_free_opts;
+	}
+	if ((opts->mask & NVMF_OPT_FCADDR) && opts->fcaddr != port_id) {
+		ret = -EINVAL;
+		goto out_free_ida;
+	}
+
 	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = opts->wwnn;
 	pinfo.port_name = opts->wwpn;
 	pinfo.port_role = opts->roles;
-	pinfo.port_id = opts->fcaddr;
+	pinfo.port_id = port_id;
 
 	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
 	if (!ret) {
@@ -1086,7 +1109,9 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		list_add_tail(&lport->lport_list, &fcloop_lports);
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 	}
-
+out_free_ida:
+	if (ret)
+		ida_free(&fcloop_portid_ida, port_id);
 out_free_opts:
 	kfree(opts);
 out_free_lport:
@@ -1115,6 +1140,8 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 
 	wait_for_completion(&lport->unreg_done);
 
+	ida_free(&fcloop_portid_ida, lport->port_id);
+
 	kfree(lport);
 
 	return ret;
@@ -1162,7 +1189,7 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 	struct fcloop_ctrl_options *opts;
 	unsigned long flags;
 	u32 opts_mask = (remoteport) ? RPORT_OPTS : TGTPORT_OPTS;
-	int ret;
+	int ret, port_id;
 
 	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
 	if (!opts)
@@ -1182,13 +1209,21 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 	if (!newnport)
 		goto out_free_opts;
 
+	port_id = ida_alloc_range(&fcloop_portid_ida,
+				  opts->fcaddr, FCLOOP_MAX_AL_PA, GFP_KERNEL);
+	if (port_id < 0)
+		goto out_free_newnport;
+
+	if ((opts->mask & NVMF_OPT_FCADDR) && opts->fcaddr != port_id)
+		goto out_free_ida;
+
 	INIT_LIST_HEAD(&newnport->nport_list);
 	newnport->node_name = opts->wwnn;
 	newnport->port_name = opts->wwpn;
+	newnport->port_id = port_id;
 	if (opts->mask & NVMF_OPT_ROLES)
 		newnport->port_role = opts->roles;
-	if (opts->mask & NVMF_OPT_FCADDR)
-		newnport->port_id = opts->fcaddr;
+
 	kref_init(&newnport->ref);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
@@ -1226,8 +1261,6 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 				nport->lport = lport;
 			if (opts->mask & NVMF_OPT_ROLES)
 				nport->port_role = opts->roles;
-			if (opts->mask & NVMF_OPT_FCADDR)
-				nport->port_id = opts->fcaddr;
 			goto out_free_newnport;
 		}
 	}
@@ -1241,6 +1274,8 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 
 out_invalid_opts:
 	spin_unlock_irqrestore(&fcloop_lock, flags);
+out_free_ida:
+	ida_free(&fcloop_portid_ida, port_id);
 out_free_newnport:
 	kfree(newnport);
 out_free_opts:
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
