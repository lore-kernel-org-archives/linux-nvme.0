Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0796BC4345D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 13:23:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C947F2072D
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 13:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UFDAnIFs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kC1a/6Y3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C947F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jtp0u+lH3bU1K+txR3VpMIPt4G6teDWZJFD3ht8wWqo=; b=UFDAnIFsJcKmC6inY5erXSzzlC
	eUDZ02IentshREonFE+J8xBBReLste9MoKDSQvYEu6C3L9dRdOfrq7d6nDVxGyNc03sEKrRwKRkMM
	2HCi16HAnONUncss1hD4qGCwsZ9tIqhBMH1+jsx0udhz4uLv+FnoExHV07q0OgfS7qQBA6i2+dqzp
	skxrVjAEoS9iuYtDmzSNXE5uB4I0qR6GvLfbYoMAa3eX0QgYeo/9iYrgbCoTapja5BByI/in/+9gP
	j+Ipw21cNFHCR9gcXeA2IfqFOtzv0TZYe5992hzONEWEpFdwgUVywa972wfUpguLynKuCwfLIcXBS
	TKJ5ujnA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juyQ8-0006OK-2H; Mon, 13 Jul 2020 13:23:00 +0000
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juyPy-0006Jo-RB
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 13:22:51 +0000
Received: by mail-ed1-x542.google.com with SMTP id a8so13695349edy.1
 for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2020 06:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3p7ZQxDsqAw6bxRKCsTTKpFTwnHOWTrmwbcNce8gSD0=;
 b=kC1a/6Y3ti+3Edy+d+cQbMBh/qldnRPwLHoSl2H23Cjje6H3rWM5692t38HrMqgY5A
 p1s+PqqNo+5RJ1dsUaLO/o5atjQ5iwPsNylHtq4N71vpa7Ravr+SjTHFmCGF2RNGVtz1
 8grrGtS5fONExEzjvRwgkpnWiQSkXOqP+gu6uFJCY9CpTcNWRqKPPF4WQFX33thviMtu
 ZgQF1sl7N4Ol14HkF07patZboGe159hLEnRA8+C4BSQbknyJ9Wvo1B5TgHzQwmrrY4ka
 Ykaw7YcDuIa/pxfpmu3FfVjiWooxaEDWeaIztQdb2ec4JMk0kXnxi/RG1NJQ7mTJx21I
 a2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3p7ZQxDsqAw6bxRKCsTTKpFTwnHOWTrmwbcNce8gSD0=;
 b=fvLZkrxZs7u2j3onzYPzsnC4N2ONR9t0rHPiCVH5cNbucMpzlS9/n9biqCC8geoAr4
 HZ0l6VaefeQgKR/v1y5O+xHe22GA4TnGJNawaNMtBCkPAbib2kYGzt6pS50xn9FkKAwz
 5CmsJzjgHFI5Hle+z7dlmhmRCpSBDaDtxHJe7u9UyTyTwlAZ42wPzt36jlDMSWrxvFPo
 8fLLzf2LMPPXEZirRDVLd8ATIaAjVue4gmNZYGk1PB40M7/JvgzvJaF2to7TLiEV7kXi
 /K2X+MQCB+egH058pACHaXb/PNfK7okhTlymrWaRh0KV8wueMZs9OWKgfNmN1167sNgU
 3v6Q==
X-Gm-Message-State: AOAM533oyy2ou89/D6G5ejlzLzYJ3XZpkltO7MZL94nFdXAcRQjmB2PG
 gih5hxAEA6cq3yGD/ICYgZo=
X-Google-Smtp-Source: ABdhPJwmht5srHkaTBLjOCr2Ce2Xe22jTAEZQo7y4UlcZf5gkxKXM5zk7Ce/DGTX6LLjYHYrZk6MDw==
X-Received: by 2002:a50:ee87:: with SMTP id f7mr93706702edr.355.1594646569663; 
 Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
 by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 06:22:49 -0700 (PDT)
From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To: helgaas@kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [RFC PATCH 09/35] nvme-pci: Change PCIBIOS_SUCCESSFUL to 0
Date: Mon, 13 Jul 2020 14:22:21 +0200
Message-Id: <20200713122247.10985-10-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_092250_941164_0F02FDA8 
X-CRM114-Status: GOOD (  12.96  )
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
Cc: "Saheed O. Bolarinwa" <refactormyself@gmail.com>, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, bjorn@helgaas.com,
 linux-kernel-mentees@lists.linuxfoundation.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b1d18f0633c7..d426efb53f44 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1185,7 +1185,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
-	if (result == PCIBIOS_SUCCESSFUL)
+	if (result == 0)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
 			 csts, pci_status);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
