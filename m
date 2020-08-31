Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AAC433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 908712083E
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fkGO4Vr/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kyun1Oug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908712083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2NYPn/iBeHSnNS7ATQLI1QqM1+DDeVkY2NCSUkq023o=; b=fkGO4Vr/yR5THgYrwG7ohvP/R
	ES08bThQaas7gcoUUH2SQ+C/zon0mRca6BfOVpEO4DgcLkhC/V9/LvFJStKLUTDETDMGfXjSCWlil
	tpIw7/ZDV0/5+etevXyske/0RkrydheBCnEPHcl8ozp5k+U6z5Of9PuK/ti+/k8aA1qq/n66O4wqa
	P5coY7fQDCcutJGHGwwRwaQ9Gqd+RSz0YiCo9MJj7Gq5BdVAgmNsC4Lt4RJGnaAsbbcEH6IddGZfU
	Jxux6JVSvS8a/A4BAWCTyJQtCYKxegrVTK2aCjRC+JFsyxue6siQclXP9q3To9SWiVgJ1tgXXFJZW
	ivjxFy1FA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCsHO-0005hN-64; Mon, 31 Aug 2020 22:27:58 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCsHD-0005Vg-AK
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 22:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598912867; x=1630448867;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jdEl2zLmkPrGAXXHm1FItxTcXKzRvguUu/7CPP/fmls=;
 b=kyun1Ougm2QI2h1lojLf3KmikJek4DukX/0ySeqI5sg/yH4HfpQ9vbSJ
 LbrxnyoNPejtPA5+4z6YdHWGycAEOfP6elO0QT3Ojkh5B2fMY4TNb47m5
 /DhZl52rTXVFM2LTleHMnsD1B9eMa56Iz2LSE5XH2lYjlD6Wa/jPLcNij
 bnXBA566ci8ZHVRl2Ow0QWP2AU+7xj22djgr3zRea3+ptrEeTrWHhk2Cf
 KJVEth4ZGbieKa5NLgnELNiF0SZXWwJIlA1/TyVdu2Ybl65snMsarnC8l
 Dp09fpuRU4mPm2GpfG/KLD4HDSOWnC4n9UvIp1sR6aXuopiaTLlGr4PKs A==;
IronPort-SDR: EMVGC4/2Q+shz2EMXRFmRunHfwIB5TpEmPTipAo/vRyLJTYZpOSKXVYuW7CGiLYJkHSkIJfZWn
 OkyFnlS7t/pZhgF5FeBeq57nbj4utJDR0Zovql4mrK6tTWq27svjwmCCKeRVrxIkYIduQjnexm
 x3GRI/YuhQ84wu2/p1yKgio68bSJoy+Mqlu+aGyOhYmzzbESZ8M7WAqCk7hBgZYsZR4dQjXo2S
 ZzMpxYplxJevfwJzGGmyxzI0eivKHYC3mcSKjWG531GYhU1QRtu7UIQCJy9liSvnyN0JpJUjbo
 AnE=
X-IronPort-AV: E=Sophos;i="5.76,376,1592841600"; d="scan'208";a="147482865"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2020 06:27:47 +0800
IronPort-SDR: 7NZdpWlDM/ME9nVBOrFzaqv9OcEc0Xg+Hj9iVF4YDPQGbXsauACDYFO8Sdbe4xgigG+XZ+yjf3
 GLPcA3DLcbMg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2020 15:15:15 -0700
IronPort-SDR: I1tTMWTPQMAk1M6D11ax7gEKQBFIdfLmRkp3n1/JpwCiAg70SwOWWPG5OxOBaTbNnqD8sAbNgG
 /1Nfzsqq/a3Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Aug 2020 15:27:46 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 08/12] nvmet: move get/put ctrl into dev open/release
Date: Mon, 31 Aug 2020 15:27:03 -0700
Message-Id: <20200831222707.35611-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
References: <20200831222707.35611-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_182747_640268_8C80B488 
X-CRM114-Status: GOOD (  16.56  )
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
Cc: kbusch@kernel.org, logang@deltatee.com, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Introduce nvme_dev_release ctrl file release callback and move ctrl get
and put operations from target passthru into host core in ctrl open and
release file operations respectively.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 12 +++++++++++-
 drivers/nvme/target/passthru.c |  7 ++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 425a3c16d5a5..f82c6a283b15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3262,6 +3262,16 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
 	}
 
 	file->private_data = ctrl;
+	nvme_get_ctrl(ctrl);
+	return 0;
+}
+
+static int nvme_dev_release(struct inode *inode, struct file *file)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
+
+	nvme_put_ctrl(ctrl);
 	return 0;
 }
 
@@ -3327,6 +3337,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
+	.release	= nvme_dev_release,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
@@ -4651,7 +4662,6 @@ struct nvme_ctrl *nvme_ctrl_get_by_file(struct file *f)
 	}
 
 	ctrl = f->private_data;
-	nvme_get_ctrl(ctrl);
 
 out_close:
 	return ctrl;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b121f532a6ff..20944c48095c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -505,11 +505,11 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 			 subsys, GFP_KERNEL);
 	if (xa_is_err(old)) {
 		ret = xa_err(old);
-		goto out_put_ctrl;
+		goto out_put_file;
 	}
 
 	if (old)
-		goto out_put_ctrl;
+		goto out_put_file;
 
 	subsys->passthru_ctrl = ctrl;
 	subsys->ver = ctrl->vs;
@@ -524,8 +524,6 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	mutex_unlock(&subsys->lock);
 	return 0;
 
-out_put_ctrl:
-	nvme_put_ctrl(ctrl);
 out_put_file:
 	filp_close(subsys->passthru_ctrl_file, NULL);
 out_unlock:
@@ -538,7 +536,6 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 	if (subsys->passthru_ctrl) {
 		xa_erase(&passthru_subsystems, subsys->passthru_ctrl->cntlid);
 		filp_close(subsys->passthru_ctrl_file, NULL);
-		nvme_put_ctrl(subsys->passthru_ctrl);
 	}
 	subsys->passthru_ctrl = NULL;
 	subsys->ver = NVMET_DEFAULT_VS;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
