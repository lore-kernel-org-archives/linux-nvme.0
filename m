Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2548C3DA49
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 23:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DeG4eb8Y5br3dH1pBUtx7z005Iy8HOERVybFExv8bNw=; b=HUfCMe8/NdkukHIEnb9webFikX
	OYeMEtzFKIuHzStzIWsdZeL0ivldog0inmsvhTw1iwRad6pl4DlLxYlxg/zfHdBzKVNgaHV8j3DCY
	YywPjO1iFOCKycIas85KIQ1R9CdMjc99iW4zmRaMYWPzpM1/1WSmOvae4tq48+8pl3p0PWpo9ySDb
	1hjOHpxLtpPQ+47pdY0SocQlr8+YLjTUEt4w+QkkIJTWEs7o2G8lqF+NcPeqZRdwILj0A6ZuLfBYN
	48fuojxdLYhxEwOFp2SvZskoSACsnvnFru7jsg88EwJydV8ca7agGHBsOoyaomIrGoGnWTtn4IrSk
	IFcBGGGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWOrv-0000000Dme3-0Qp0;
	Tue, 23 Jul 2024 23:24:31 +0000
Received: from out28-54.mail.aliyun.com ([115.124.28.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWOrq-0000000DmdA-1ZWh
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 23:24:28 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.8909427|0.07495253;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.0875666-0.00283312-0.9096;FP=3808151967992990902|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033023108233;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.YXiNnRf_1721777059;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.YXiNnRf_1721777059)
          by smtp.aliyun-inc.com;
          Wed, 24 Jul 2024 07:24:20 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: linux-nvme@lists.infradead.org
Cc: Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH RFC] basic RMEDIA support for nvme host
Date: Wed, 24 Jul 2024 07:24:19 +0800
Message-ID: <20240723232419.19753-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_162426_609641_8267AB1C 
X-CRM114-Status: GOOD (  10.29  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Rotational media(RMEDIA) support is added the NVMe 2.0 specification.
We firstly add Rotational media(RMEDIA) support to nvme host, then we can add
the support to nvme target later if the backstore is a Rotational media(RMEDIA)
block device.

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 drivers/nvme/host/core.c | 5 +++++
 include/linux/nvme.h     | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19917253ba7b..f4c41bf70b19 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,6 +40,7 @@ struct nvme_ns_info {
 	bool is_readonly;
 	bool is_ready;
 	bool is_removed;
+	bool is_rmedia;
 };
 
 unsigned int admin_timeout = 60;
@@ -1622,6 +1623,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
 		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
+		info->is_rmedia = id->nsfeat & NVME_INDEP_NS_FEAT_RMEDIA;
 	}
 	kfree(id);
 	return ret;
@@ -2164,6 +2166,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
 
+	if(info->is_rmedia)
+		lim.lim.features |= BLK_FEAT_ROTATIONAL;
+
 	/*
 	 * Register a metadata profile for PI, or the plain non-integrity NVMe
 	 * metadata masquerading as Type 0 if supported, otherwise reject block
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c12a329dd463..2c259d126f80 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -546,6 +546,7 @@ enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
 	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_INDEP_NS_FEAT_RMEDIA = 1 << 4,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
-- 
2.36.2


