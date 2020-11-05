Return-Path: <SRS0=H+rW=EL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9802BC388F7
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:29:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B8420719
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2020 23:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WpY3dJDM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bgCqxSmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B8420719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W9G6Tb8VDyZORpSdUanKoBmcAtAfvv5TNiORqcAC9mo=; b=WpY3dJDM8/NVBmrnuGdQjmMg1
	E4KZfhmf44bfiqf0cYUOlx3MihErPcaAIxzLKqowXJdd/P7vXHBZEMy7IuLSlWWzBVcO5/xDAVe+1
	tPtshX8N0SkUs/3NYMUMdLUsK9OK0uwfYFC8DZOAs3hvP5zITtgLFRusqmQqoX2pXmyGMiv/AjAvO
	th7fHph8LTGozakR1YY4DlBaEaAwdEPA0QZkSAuTnkDy87sfJ8TU0waLtpl+8oqYRuIdSO6/sbSZo
	iz0hIF5nsOtTK+vSeVqTKU7tww+BHJQvDERio2LQEax/35hMgv5o0K7X4gzjhAjQDuL8vUApY1kW8
	403fyXndw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kaogj-00009M-7c; Thu, 05 Nov 2020 23:29:05 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kaogg-000082-K2
 for linux-nvme@lists.infradead.org; Thu, 05 Nov 2020 23:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604618942; x=1636154942;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jT7GzWGGv5Z8TTik7tcP7zZrQNxCFiDLjPie+9wpX/E=;
 b=bgCqxSmKkn3+lwli7AV7modvUPJtH4mlOWB7h41HZD5ca5k26Wt0lLJa
 EJz+yJ/gyOrj/+sSsp8fbQVBV/Qky+ososNTFsiE14nJDM1xbQ3n09GY0
 pX6uccm7JgAafJGxthxFb7SHoyRyg/lmEp3pJO4c43bSWYS6ymVbolxti
 h101Egmq5ibBCXfvFU3uRLrOhGq2dqM+xHfcLLlbxwyBnvHJrDijbVNEA
 qV2e4W0eSE8FFJEBI9akiU00dQMp8uKIJuhfz8OUqW++FTxUefsjTxuPr
 SoWBw8ggTAHcfUkJaBrHNh1PiaQc8AuL5ksY+2M1N6bCJ6FjJNLePP5FP A==;
IronPort-SDR: uotjCbACJlJHl3JGrHEohoSGJcp7DO3H6OHFcx06SyTBcuKTMHBdVDWl+FN+pccAZUWaeCUSms
 M+haCtcksoq83bH6rES1IGEDg2FCi1ed3nrRR/YRb4FlKQfjemDolF3nBCoLUCAli9RqnN+G5K
 FZZ/gfWZ7Bac3D0YFqOeaHqB8Zn1YbRNhGLnZTh9rpXh0aPGNKl+W8Ia9b0FfknVS3tU6AtTQo
 ZHEZVtpfvm4f/DsZGCnCbisTOr1tyqLeZvfFwqsFHky6GkMGj08gR3e4f+NVPrVA2pmUj7NrkS
 A8o=
X-IronPort-AV: E=Sophos;i="5.77,454,1596470400"; d="scan'208";a="261967936"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 07:28:59 +0800
IronPort-SDR: An34Ynie7nl93oZiEuWIvhGlhCZENwFNWf1jl5+mkUlLatO/uWrtU70mILJszDAkaLt740R3BN
 vdpNfUnbwFmNAx9KXCiKeyCPNsCrsZ8BPqXNEyj7f/MSipMTY+HlH89uSGeH+P+6oYnxjKReBH
 SDpWhVvyHST65qzrErl4OsMvxWPKO39Tm0g9s1N3hlhcPx1tY+sQJQpFJk7vF6XVmfNoG+Vi8x
 2ftIua0ATEKuV/Pmbg74ABt3BcJNt4rbsBhv9D4e+vTlISHym/HjggqD8GF/7n0D5rGCBcfHUF
 8RGCgbp21dGf85kl4Y7UpuGU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2020 15:13:56 -0800
IronPort-SDR: gMFp0PoG0cZlKJupRP/tE6Nt30tnFzgXT7p33H6PQk/smL9PIAyOIEiuHwQsj55RELmi3dScqV
 L/SYmmUCeTKVl8CwDzVElq1aPvnvzk9qWTOYO19Dvr+km2ILNUcWNE/ovrXJX90L/FiDexUA3b
 BS2KQcCtF0ZrE9B1gegTfq0KWkOTppg1ERwPLMLj8HlyHmgap6J6a9hq4o8wgECoXAJNnKAjGn
 wPOb7YcZJkeFXYUiEWI4me1CrPfi7Uj1D7tG8njioikMCIor5vBr/yC1knnJqMal4y1zn/Txnu
 LoM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 05 Nov 2020 15:28:59 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V7 3/4] nvmet: add passthru io timeout value attr
Date: Thu,  5 Nov 2020 15:28:31 -0800
Message-Id: <20201105232832.21216-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
References: <20201105232832.21216-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201105_182902_799611_810FE1C0 
X-CRM114-Status: GOOD (  16.96  )
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
Cc: kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMeOF controller in the passsthru mode is capable of handling wide set
of I/O commands including vender specific passhtru io comands.

The vendor specific I/O commands are used to read the large drive
logs and can take longer than default NVMe commands, i.e. for
passthru requests the timeout value may differ from the passthru
controller's default timeout values (nvme-core:io_timeout).

Add a configfs attribute so that user can set the io timeout values.
In case if this configfs value is not set nvme_alloc_request() will set
the NVME_IO_TIMEOUT value when request queuedata is NULL.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/configfs.c | 24 ++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    |  1 +
 drivers/nvme/target/passthru.c |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 67e231e3df2b..160fdad3ac39 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -759,10 +759,34 @@ static ssize_t nvmet_passthru_admin_timeout_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_passthru_, admin_timeout);
 
+static ssize_t nvmet_passthru_io_timeout_show(struct config_item *item,
+		char *page)
+{
+	return sprintf(page, "%u\n", to_subsys(item->ci_parent)->io_timeout);
+}
+
+static ssize_t nvmet_passthru_io_timeout_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_subsys *subsys = to_subsys(item->ci_parent);
+	unsigned int io_timeout;
+	int ret = 0;
+
+	if (kstrtouint(page, 0, &io_timeout)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	subsys->io_timeout = io_timeout;
+out:
+	return ret ? ret : count;
+}
+CONFIGFS_ATTR(nvmet_passthru_, io_timeout);
+
 static struct configfs_attribute *nvmet_passthru_attrs[] = {
 	&nvmet_passthru_attr_device_path,
 	&nvmet_passthru_attr_enable,
 	&nvmet_passthru_attr_admin_timeout,
+	&nvmet_passthru_attr_io_timeout,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a0c80e5179a2..2f9635273629 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -250,6 +250,7 @@ struct nvmet_subsys {
 	char			*passthru_ctrl_path;
 	struct config_group	passthru_group;
 	unsigned int		admin_timeout;
+	unsigned int		io_timeout;
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index ef07b447d136..8c7dd0c63ba6 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,6 +243,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
+		timeout = req->sq->ctrl->subsys->io_timeout;
 	} else {
 		timeout = req->sq->ctrl->subsys->admin_timeout;
 	}
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
