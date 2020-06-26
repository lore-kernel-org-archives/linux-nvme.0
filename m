Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED51C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E4E6206A1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J7SiI2P2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kCac7LXZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Z2XS58E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E4E6206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IIrz3WBkG6CBnZSyVNtGfXzEGHe3lfmNDC+S4nANkI0=; b=J7SiI2P26BILa3Jmu6n15Sp2t
	QTI/6mmegIpTI/2S4JI+oNCGiTirDl2eEeN8CeqHavMobQS+e9dOL+EjJ2oFutiYZYO0RlBVPEBmj
	d27fUmTTVoX0ct8woYDBpS07QgDkLE33r/3YnNZ87xn187PNnKPkiQ+C+OiIV/GmgrC94aFmgYzVl
	uXBMK/YBIJdWEl6V+/rmHM1/g3X/qalAPSPXatNi7mKr5mquyCowtnFVjPI2xxjL+iqSAScmmiRCQ
	ECGIsnfzSzYAgoNPwPBc89eRGURi0T1k8KmH5NHjaesZ9PnftENXniqSfQ2S4ZU61xMLO9z3v0t2E
	cONzclVDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqSm-0001DH-Ik; Fri, 26 Jun 2020 15:40:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSi-0001C9-4u
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 15:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=L7cWSfK/Iv8UF6YZL4ZPTnIiXT+AsLVh6DlV/q1XyNs=; b=kCac7LXZaPGSi09XXVnpEwEAtD
 +FzpzJ0wPkv2SiOUBfqAVo3+XYmIH7u6nrY2C2z7LB8ve0X3DAuzZ80Ll7diQeEOsaeSnDs4jYJrs
 DN/SK3m909JtHtXHx1ZWg8zMyXYtHlMWhb5iimoK3DhpeTQNycStj+ig6AKSiio+jU/WoxALiGlmt
 NLyRGSJhP2iJM3nUdNSeMpuQlGIewzdNwUuCe/EnG4NcVEi5+QAuL2dR631NlN3UjK31RR1D0SH+z
 5y6GCFN8A6qxnXSY3sJ8fKEGNwPso8Arkr9sKy63doSoia9zswQVcI2L0RHubR+HbrPwr61YXOkxh
 ZplQBBKw==;
Received: from ale.deltatee.com ([207.54.116.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSX-0004iP-4y
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L7cWSfK/Iv8UF6YZL4ZPTnIiXT+AsLVh6DlV/q1XyNs=; b=Z2XS58E2UK2OcuqEnmLfq0FyLx
 wkHmOmo3jllETwpdt7onXH7FzVEa+kRUl9DXS8rYZpXzWDzk6ZGSiXpRWilsCWm0Q8DLcQm0S4R9z
 hhOzjpp61rZsGYEOFZ7QbALr/IDJTI3v58qSj8SgQOVlYn/Yym7OYVYom8MxMMQmH+HjutKrqG58B
 Xj04k3zVREctgA/v0IapglJ18M+T9xkegPlKlrvSGpPiFaLsRmSYJUyX5ZqtvMWIvylR7kMPQMCuA
 47fufThGqRTDVLQvdhx2Ea14FEsUkZJX6Y2jhinS1arUP0F22nBiP/2bobvm1RlylATzmZtLPjbri
 yrk8PrWw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1joqRu-0000oT-4A; Fri, 26 Jun 2020 09:39:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1joqRn-0007Hc-Cx; Fri, 26 Jun 2020 09:39:23 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 26 Jun 2020 09:39:15 -0600
Message-Id: <20200626153918.27929-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626153918.27929-1-logang@deltatee.com>
References: <20200626153918.27929-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com,
 Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 6/9] nvme: Export existing nvme core functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_164013_798280_683C8F1B 
X-CRM114-Status: GOOD (  14.04  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Export nvme_put_ns(), nvme_command_effects(), nvme_execute_passthru_rq()
and nvme_find_get_ns() for use in the nvmet passthru code.

The exports are conditional on CONFIG_NVME_TARGET_PASSTHRU.

Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 14 +++++++++-----
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index acd5af305f4b..7c35583ef9ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -450,7 +450,7 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
@@ -886,8 +886,8 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				u8 opcode)
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode)
 {
 	u32 effects = 0;
 
@@ -974,7 +974,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
-static void nvme_execute_passthru_rq(struct request *rq)
+void nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
@@ -3606,7 +3606,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -4367,6 +4367,10 @@ EXPORT_SYMBOL_GPL(nvme_sync_queues);
  * use by the nvmet-passthru and should not be used for
  * other things.
  */
+EXPORT_SYMBOL_GPL(nvme_put_ns);
+EXPORT_SYMBOL_GPL(nvme_command_effects);
+EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq);
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7074afadb5f..5bab4dff1516 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -716,6 +716,11 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
  * These functions are only for use by nvmet-passthru and are only exported
  * if CONFIG_NVME_TARGET_PASSTHRU is set.
  */
+void nvme_put_ns(struct nvme_ns *ns);
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode);
+void nvme_execute_passthru_rq(struct request *rq);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned int nsid);
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
 
 #endif /* _NVME_H */
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
