Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FE4C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6644E20706
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 15:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hvgNsmjl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCG2UXEV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="A27IIaLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6644E20706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OoIXd5K7Ric9mHSwjWSQzIPlpP5XTieofrXMb4EqIrs=; b=hvgNsmjlGi1E+Uiu4bcvyHvrU
	Q58DM6maZTNLnlvfCKqVOLgqZcY2q8ZcKStVs3QFwXgfNDKtETSwZz9wVOtdfigwRNYMyD0Oo9bmO
	wLueisl+YEH5MPAehLW5qMkIYWuhVo6rvaqlodDMSrm583A2Ny+wD/Gme7e8MDnMOLYbewFtbHnLt
	nY7PCzNvWsr+QXZ50TZA7VD3FVoClBAN5BRztGu6HuQxuLEzbFT1uJOg4tXrC3Hhv+m/O2ikKyZwX
	m9ToHRzHntuLHkxXoZs9EUWH8KsFa2zpqfuvuLafyDFH2XC8caFfgxHLc1LCvWoT9vt2J0LfpjLHd
	Mel0jErdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joqSt-0001Ft-Kq; Fri, 26 Jun 2020 15:40:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSo-0001Dx-HA
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 15:40:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=0P+V/GA6kjnmOazXS4i5E7J/ATNToBo60mTEbmyeGr4=; b=gCG2UXEVXudzwQ0D2nVBy47z+X
 iEsaQSE03sxOubK1icisELIqxyPsVGsoihv4z1xA31q+V5BtOHQPnjMhUoxda6iBO8RGx4detzgGZ
 XV15sRycgWY+brqOI67rGrCwpAI8XsPe6FLpZ0kO58A1cfHCh02HJBEerKJ/jUezp/VHjLvq+9SAV
 W/Cjgg+vpU75aIBieX10XBiS1ajwQ8nkwqvU8lnmQWjo6woG602jSdcNCGQK4dOT0G4DtaIyF7dfn
 OqtYNSxO5UuVDjlQ+HowkZbW7yLZcL+pz11sEHEa3qVY2nqwYqXsR9ZG4jKURMtiY4rENoYx5DYAK
 41IzvFDw==;
Received: from ale.deltatee.com ([207.54.116.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joqSY-0004iY-4Y
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 15:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0P+V/GA6kjnmOazXS4i5E7J/ATNToBo60mTEbmyeGr4=; b=A27IIaLXnyNF8UdImF34dOisAD
 x9pkO7HyLOHEDFoGFKlfYZ+2APXPAkFEDxvdw2KKLpAVHbbcullx51P6C4uixlDQCyVsefvOPHkLr
 LssN7jKTRz/0HSqTAVQkx6w3FV4lkTlHpaEXUQeIYx/VVb3jdxqxhcDOEo63ya96HbAYuuur3sgSe
 Z3RS4+99DneUgj+mu8vYhQBrMYRNHKhCK4UVCCrg1s27cbUHGo1vmZmmagq1PY663ucw+mijd22RB
 jy5P6svwJ8m6tVxfj9T2UijyhS1xqYl+pXh4u52bitU5QrAIKIOO1cpU2crl/VFQQgWNC4vJnt6Jo
 qTrBV8ow==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1joqRu-0000oS-43; Fri, 26 Jun 2020 09:39:34 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1joqRn-0007HZ-92; Fri, 26 Jun 2020 09:39:23 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 26 Jun 2020 09:39:14 -0600
Message-Id: <20200626153918.27929-6-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626153918.27929-1-logang@deltatee.com>
References: <20200626153918.27929-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com,
 Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v14 5/9] nvme-core: Introduce nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_164017_179163_1FF38C39 
X-CRM114-Status: GOOD (  16.23  )
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

nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
It makes use of filp_open() to open the file and uses the private
data to obtain a pointer to the struct nvme_ctrl. If the fops of the
file do not match, -EINVAL is returned.

The purpose of this function is to support NVMe-OF target passthru.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4171e07f1fc9..acd5af305f4b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4361,6 +4361,37 @@ void nvme_sync_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_sync_queues);
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+/*
+ * The exports that follow within this ifdef are only for
+ * use by the nvmet-passthru and should not be used for
+ * other things.
+ */
+
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
+EXPORT_SYMBOL_GPL(nvme_ctrl_get_by_path);
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
 /*
  * Check we didn't inadvertently grow the command structure sizes:
  */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ef8d501e2a8..e7074afadb5f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -712,4 +712,10 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl);
 static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 #endif
 
+/*
+ * These functions are only for use by nvmet-passthru and are only exported
+ * if CONFIG_NVME_TARGET_PASSTHRU is set.
+ */
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
+
 #endif /* _NVME_H */
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
