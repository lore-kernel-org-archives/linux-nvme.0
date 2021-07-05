Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA272C07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:13:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAD3613F3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 10:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAD3613F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eBD1DTqhs94sQTjSdAEydp9jivojwGrJQP9PctNSANw=; b=Dw2GNoQJq6lfo5
	6jLVGDcB6hL3r/jQIOhAs/LA6gTSUAilFMSM37uawNmIdvJprod6Fsze2lJC0+8DQOK1j/XOjpnTp
	IBOQ/SFBlF6d7gfwbyLsnuEgs09KjI5Oq2iOALlL/dnqiZ3X6oCty+TeKbGZaUyIZLWyIAZwasNXg
	BracZ4+EI3HzFLyYIxfGy5uVWxkR8n5D3W7tVIyGKNpsRIKGDeK2gVAV5cr1Cm01dpNqjIOwFixsn
	Mi+RfRmjBgzbpeVV47PTEHyxr4PTuBjr+aw6gzAmC1uT8NII2sbBfV9X4oRgYz6ebJ0/LKqWAe6kU
	glGCHauTd/n38Z/aZkEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0Lbf-008Xm0-7B; Mon, 05 Jul 2021 10:13:39 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0Lbd-008Xl4-3K
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 10:13:38 +0000
Received: by mail-ed1-x536.google.com with SMTP id k17so5272602edq.2
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 03:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yfApOJf6iNwbtrrm1KAOBk3yCtPkxEl1HuVkK7ORmOg=;
 b=maNjMWMV0zGqSac+rmBYuT37noUL/ENcvD3/pfxliDhS6X5AJ0jrgWBVqYlXJR/vkN
 mJd+xfZT0ptpfxrEY3vwF4oLgKYQruC0Ig0JTPoNxGR/Xq9FmXUN9dtlz4a2aLeKVHyq
 XH+kSZpBO4mBw/tORjJvIO9+a5gAZwP1VljyCWdtwFw0y7SKQChVlFFzFbUI5H6wz+g7
 bUn4Qo/5mNaQuFcm8Q0vDT4GWY7FLtfNpzTPCWF7DHF32nlcJul4/P46i9US/PDTSZ8M
 SYiqspFlmml0qRTtDyh8nEb5tE4+cFnw+VkUfzZ4ab199iL6FRQbv3S3UKqOhWrZaiXv
 vQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yfApOJf6iNwbtrrm1KAOBk3yCtPkxEl1HuVkK7ORmOg=;
 b=tIcGDEVxm14PhWa0dHBamO2nauduhPqHl8Ol3OWj3UsNMXGSpTTFRsRDqEwR6SJRao
 1rJaZNHehzWnWIZh8MM6qXlI55Ftn4jt8NDVH1OmYoeR5VzKpUUkWhWIr651zKmZDjeS
 ENWGzLF0d9xX2aMxwc23fshdGFjEEpW0HRo0jluV4VOJT4tqWVJA/bz1/hvs+x1H1RT2
 8xFsDBHdv0eBimdpVrl6ZNZx5BjRMSAH7pRvp84KGNhOICFLi2fkYcDUNMbXUs7KWc2t
 jzzwkVXr6vA1J60tKxy+oyrfH12BBnDY65eW9E+0TCld1k/U8HfevrpzMiGmfcGUmVRM
 0cpg==
X-Gm-Message-State: AOAM532dzjWzRaALmMluGei9gN3AGO3skx6BYKiT06AZT25xgAC/WEuS
 TBe5N2S4RhOalHsPrIMni6E=
X-Google-Smtp-Source: ABdhPJxkP8qchOdSVpdGrxAayKDo/r+qVmc/CK+svjxEsBC0S27vbV4zTPSaO/DGXem3UsqCuJg6mg==
X-Received: by 2002:a05:6402:11cd:: with SMTP id
 j13mr15176267edw.154.1625480014585; 
 Mon, 05 Jul 2021 03:13:34 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de.
 [95.90.192.255])
 by smtp.gmail.com with ESMTPSA id k21sm5119648edo.41.2021.07.05.03.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jul 2021 03:13:33 -0700 (PDT)
From: shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH] nvme: Add abrupt shutdown support
Date: Mon,  5 Jul 2021 10:11:57 +0000
Message-Id: <20210705101157.1009135-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_031337_187774_DF131B2A 
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

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Enabling the abrupt shutdown support. In this shutdown type host does
not need to send Delete I/O Submission Queue and Delete I/O Completion
queue commands to the device.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 drivers/nvme/host/core.c | 11 ++++++++++-
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  5 +++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 80c656dcbbac..c1d1bd6a03af 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -40,6 +40,11 @@ module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
+bool shutdown_type;
+EXPORT_SYMBOL_GPL(shutdown_type);
+module_param(shutdown_type, bool, 0644);
+MODULE_PARM_DESC(shutdown_type, "Type of controller shutdown");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -2166,7 +2171,11 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	if (shutdown_type)
+		ctrl->ctrl_config |= NVME_CC_SHN_ABRUPT;
+	else
+		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75420ceacc10..af14ee1cd7d8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -23,6 +23,8 @@
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
+extern bool shutdown_type;
+
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..6a78233d9645 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2474,13 +2474,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && shutdown && !shutdown_type && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (!shutdown_type)
+			nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
