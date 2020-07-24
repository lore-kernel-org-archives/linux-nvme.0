Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1907C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 01:14:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D3B420825
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 01:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KRULQ7vg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3B420825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SsV4GPasL0LH7DMFPtfqQI+afnWdvKvEj0H7C2uZtYQ=; b=KRULQ7vgSb0Op30wxchKjTbYJj
	gsRwAigTOzCeMT7jUc/ATf8KqQunUHti3Dgl1nfi5MCXSInv1bfjwYUnOoJnqBl5OzoML5YiiaT5D
	q566LMjzLQDLSAa+m1P9KzKuytv/mncsl0wG47ruUr+x2lHibCfx/pGnV3o504FcxQDgeYct6N9OF
	KfLZXQbRMDA2Hu3Qo982rEHVUMWP/KMEeB++bQtR0/Pw3aqOacC0jElzZ3suPOmmZEetR2I2JurU+
	hWidXD28vA3bAITcV9AyqVhrFQg/p7yde3k9XrUMzePYypl5dXIdz8fKXXRMTzTrdUc71wX5dqEMW
	yPJjzKoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jymIA-0007SX-FG; Fri, 24 Jul 2020 01:14:30 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jymI8-0007Ry-BC
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 01:14:28 +0000
Received: by mail-wr1-f65.google.com with SMTP id a15so6804132wrh.10
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 18:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=LZpVvioCrWeKzM+rCyo4gtpR1m8S1mMIbFddpezwBNs=;
 b=Kn3EeWRjbtmyP0UztnRRQLBUnX9HhW70AY65yOrStSp4VAqBkFG4/UqIh6U+cJ5eGh
 58cJumUm16kAXjQpWDY3QtrHmKNmhCZViyf/MnR2pSlHV75gXU2QRBKDVa8wnBPijDE+
 d5aRJMHK5n/NqFSHHhrdj7juPdAfa3IEhTIPD7Q/3wOMvIaPkuaHo3Av5Dk87tOt2Vsc
 xmfoXyG7w1WF87GR7f76JUeT0glhPYuELwEvyblSsFSnnymanLjNMw70EyzTk+PO1iVP
 xvWjz36mqOi7/byU25bPERuDu6SLKg9Kvfg4/zhSfmuxbkCr8OHnEdu6gi81VyNiBCuI
 d5ig==
X-Gm-Message-State: AOAM533AtdllLnYye9s379kjWPpVyF7OKGbpxxM+jE440tIRIDkR9wEz
 JjWrEvA59O2hWv79vxbT2veRcAnA
X-Google-Smtp-Source: ABdhPJzVUSAIrYPf+zfR7n2dwKsPA/cevUIYLUFOiVpT0JfgtzaLcz+kRcpxc1xkZONaISktBgtHoA==
X-Received: by 2002:adf:9cc9:: with SMTP id h9mr3991226wre.343.1595553264240; 
 Thu, 23 Jul 2020 18:14:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id b23sm5272071wmd.37.2020.07.23.18.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 18:14:23 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-hwmon: log the controller device name
Date: Thu, 23 Jul 2020 18:14:10 -0700
Message-Id: <20200724011410.495900-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_211428_417202_9B5DE586 
X-CRM114-Status: UNSURE (   9.84  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Stay consistent with the rest of the driver

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/hwmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 23ba8bf678ae..412a6c97c0d8 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -241,7 +241,8 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
-		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
+		dev_warn(ctrl->device,
+			"Failed to read smart log (error %d)\n", err);
 		devm_kfree(dev, data);
 		return;
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
