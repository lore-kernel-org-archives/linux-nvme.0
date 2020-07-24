Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC1AC433E5
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C04C206F6
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3JOVT/UE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="fW5eJ/mg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C04C206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JQuilPcvK9tWK6TFTXgt6vAyYm4vNzsnHA88JUv8vno=; b=3JOVT/UE8traoEX1mb8f9zDRq
	0WkIQ8UnFsMZMBDM0tS41Wm8DEUhmn7F3ZD6P9MV+7c0AhPBc3lQ2+VwhX3zMo0CYN8alCvubDejK
	JHlP/PC8Y3+hOdIKPvly47mVxFsGM4onXUTjbZPNE36qalNTDqrtl3l9W6OSOhLGgjbbmcVKDNeHl
	gZVnKNli4WFGNDmiS3MTCxATVcJ7qnOTiU0I92pyHmF/1i/l7SpHdnBfTdpnffVSLoWHzw+va9e0O
	0HOToDdVhcWTKqdnTp6Qhrf2jVTKZvRf9+yGuhLj2ip6mViIDg9GCsXkk04cPNDzO/3HTsNM1fbKH
	itnlx0PUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz1Rs-0003eL-Iw; Fri, 24 Jul 2020 17:25:32 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz1Rn-0003bl-MG
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 17:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=90mIqs/Rdt7ebnBY9w+aJugKi/FPdGKSj5lvcFCwxT4=; b=fW5eJ/mgZqfOmzmtqgMINjanWs
 aUSSem16BLiBaT3iXXkqXW42tIrokQTfVsoBE4AvsZ7nRYZTmNd3Ew/QhX+K3Mm4M9JCijb9baJYp
 yj3n4XrrS5mY1e25g+0UaNuynPozLISm6IIkrrye6uIq3yGZJbmTd/ZVaLVOeKzUmchC3Uk2i+LK6
 kofA/QR8U6pYTYEnA2n91VU74AyGJxS7I92zooPXruTEh/jqq6MtP6jPCfACGze5DkYGshxkhwOnF
 JkNvHIqVz6g2qDhbNCGfV2JoFJln5UArItOY8xcY8mccE8vsXIu+LRrFmzkuMnKn25z7WYJ50iLDD
 mI16Ji1Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1jz1Rk-0006yq-5m; Fri, 24 Jul 2020 11:25:26 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1jz1Ri-0004GF-AA; Fri, 24 Jul 2020 11:25:22 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 24 Jul 2020 11:25:15 -0600
Message-Id: <20200724172520.16318-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 4/9] nvme-core: Introduce nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_132527_786853_F748BDC7 
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
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_ctrl_get_by_path() is analogous to blkdev_get_by_path() except it
gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
It makes use of filp_open() to open the file and uses the private
data to obtain a pointer to the struct nvme_ctrl. If the fops of the
file do not match, -EINVAL is returned.

The purpose of this function is to support NVMe-OF target passthru
and is exported under the NVME_TARGET_PASSTHRU namespace.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 23 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccca36f881d6..35b1d13db2e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4575,6 +4575,29 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
+{
+	struct nvme_ctrl *ctrl;
+	struct file *f;
+
+	f = filp_open(path, O_RDWR, 0);
+	if (IS_ERR(f))
+		return ERR_CAST(f);
+
+	if (f->f_op != &nvme_dev_fops) {
+		ctrl = ERR_PTR(-EINVAL);
+		goto out_close;
+	}
+
+	ctrl = f->private_data;
+	nvme_get_ctrl(ctrl);
+
+out_close:
+	filp_close(f, NULL);
+	return ctrl;
+}
+EXPORT_SYMBOL_NS_GPL(nvme_ctrl_get_by_path, NVME_TARGET_PASSTHRU);
+
 /*
  * Check we didn't inadvertently grow the command structure sizes:
  */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c43e0e4e0b97..4bec44ab5a96 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -787,5 +787,6 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 void nvme_execute_passthru_rq(struct request *rq);
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
 
 #endif /* _NVME_H */
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
