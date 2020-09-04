Return-Path: <SRS0=O63G=CN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCC7C43461
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01E9220775
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2020 02:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f4jzl8gT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CrEc51iG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01E9220775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wRtAmupYF+2OG2pr9qCWSha/hJXmPMWn/45Lc376f2o=; b=f4jzl8gTgbUbhRb9toUXYz7O2
	R4TW0DF48OvkKhxWabs4KMsQAg6d5n4i3Hmos1kIuusrlCwPjz/jNwpkJ4uENTKcAxHRLqqueza+N
	o/sQos4XUlFqVIghJNjE8UZOLiX9rd/4I1tNj7aKYN9k4LRLKlfN4mbJh6ENVOkqBumJJIRUsROGf
	E3tCE0eUzR7LOfolfcNXsVMXqMFLLYlwsQ/E/AMDQYuvWjBk8bJhTvswDuiZA5ey8r2XBOUOTtgBr
	OLThSJdHhqFZvzWuc+KZ8ec5VtkU/bZt9TDFwGIqwEfNRPoa7C955yAY+LfbCyOGtLEAWJIjz0umm
	KxdHKQJDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kE1eN-0005yj-Dq; Fri, 04 Sep 2020 02:40:27 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kE1eK-0005yA-TU
 for linux-nvme@lists.infradead.org; Fri, 04 Sep 2020 02:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599187236; x=1630723236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dYcuQCRcV4Nxh5FXhtRj8ndGx7vw58HPiwDkzEAG8lQ=;
 b=CrEc51iGH9hz5bbyREJeylhBsCHnSrrSGVWRysa4hx7UTCbAleSEs2H6
 5/Y1UgB82tPG7y9Z/+1dMp5rhifn8m2+TmuJDA/PahJyr34N3uuee1mJo
 72z0Pgfc4fAS76TtJkgpLhNVYdgqZ4mIzIKjCE7LI5SQlWk9GZGIzOsge
 qwhnDvdBlJ9w72DsjoCf82K+Q9UE8vIOPMZUK7J3Pxb7Px5u+29ioo8Zn
 GE6k8ENb9OUb5/3NFLfmztdu3WFoLVwPS0ojPWydLa05Ro5XX582vaR6y
 YDilFTzXHESAEmrwzZMy2R68f58L8dwwzRqVm9+OC6xoERUyeBm5bjlEl w==;
IronPort-SDR: MuK9UuvwMRlL/SE4WiT5vMa8y2CRaCYo/20fOCeKCMflWZ/cvjTBJjcXDw8BpuePItrGytbbpB
 pkRicNMpTl6t+8IHB1a4m5Y7MLMNHkQ3BSH3Gp4uPxRWMVsJn7LSO5ARfhTlmtCqolumC8RAys
 qTQCNYXsWzBYpJUtFNpOs01UgMiDNtITITKqoRfUcVgLJBMkH/wgvcJ+0VPPxLBJgQGn6bsjm6
 LNsjv4mEPvFMp/JyrshAbx8rRQa0E8u7GLEc1HwEHFgBvF2fpGN+qJnPZ4f7nx1zGA8wvkJXln
 jno=
X-IronPort-AV: E=Sophos;i="5.76,387,1592841600"; d="scan'208";a="249822438"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2020 10:40:35 +0800
IronPort-SDR: VyJ1oheidUThlCVye08qp+74cik2/4Adx6FteERozAuk3+DBIwgGdnIjGTUjGiQPy1tW1iJiLZ
 Ru4zDXRtUU5Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2020 19:27:48 -0700
IronPort-SDR: 8oG4114zicMPEW9mODQMse3A2T3O0yXPNESoZ/N3j/+V8Wvu4OzGjcFUX40oy60vsotvIWzHbz
 VxiIHLKdZ5Mw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Sep 2020 19:40:24 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme: move get/put ctrl into dev open/release
Date: Thu,  3 Sep 2020 19:39:28 -0700
Message-Id: <20200904023929.5320-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
References: <20200904023929.5320-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_224025_055678_6A237804 
X-CRM114-Status: GOOD (  14.76  )
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
release file operations respectively. This is needed to atomically
get/put ctrl and get/put ctrl module refcount without using any locks.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c       | 12 +++++++++++-
 drivers/nvme/target/passthru.c |  7 ++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7c0def9184..a1707afcb710 100644
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
index 14a842408035..9cd8fd2ddc72 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -507,11 +507,11 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
@@ -526,8 +526,6 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 	mutex_unlock(&subsys->lock);
 	return 0;
 
-out_put_ctrl:
-	nvme_put_ctrl(ctrl);
 out_put_file:
 	filp_close(subsys->passthru_ctrl_file, NULL);
 out_unlock:
@@ -540,7 +538,6 @@ static void __nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
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
