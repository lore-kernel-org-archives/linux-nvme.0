Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951CCC47DA9
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QsV0bPTVTh2lFnOr261ffOvBKPsLcJ5oUs+eZRCRluE=; b=j7CP2TTaYCjA4RFCOi+3JwyzRe
	B2QVLO4BNCKhx0JUGhQY1ZSNQls+OL0/L/gjsDiNXCbmTbY2KlqNOZlGSPaPinMCBw8aepI8CMXWI
	jSe8iHZrYgGlc3+BM/TzTXQTsr80eEzzwdkujHOaem7F2iUjIOkZ9gckZ0NukkqdYgB3Bmk66OZB9
	GZNND9uoaih8G/P1UC2wxE/KFHHRDn94gR2VuchAc3togaYyKcZ2isZOqcHEPEjhn1dYIs4V56mSH
	rNii4XElYx2vGop6YUrUJZg84XEspgtzNqSo71prOZQ0ex1vbdSXAXcPGRdc94N7HsY3/aapzoSGF
	7JoduqJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2I-0000000CFGA-2dzZ;
	Mon, 29 Jan 2024 10:38:42 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUP2E-0000000CFFa-2VN6
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 10:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706524717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QsV0bPTVTh2lFnOr261ffOvBKPsLcJ5oUs+eZRCRluE=;
	b=TbwwVNNQCkbbAtkdi6IGy+D0bem2sFYxqvK4zZBjn7o/49Iu/buGfWRr4FQdOL6KgTCgQB
	Ng3+a2+9fd3xrXzyLop0FaU2Ohr0AF7NqmqH6LdbO6U0GIB0o0BOLwwbGg0t1jp7gGFor5
	U/oLsCAERsQptXa9rfij4MK4fRkj/50=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-PkMPiwHhPFmnRxWpKDeCVA-1; Mon, 29 Jan 2024 05:38:36 -0500
X-MC-Unique: PkMPiwHhPFmnRxWpKDeCVA-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3be50f0d379so535394b6e.3
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 02:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706524714; x=1707129514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QsV0bPTVTh2lFnOr261ffOvBKPsLcJ5oUs+eZRCRluE=;
        b=k17lXdpRQ79aAQMOxafPJPyvRUBSizDPe6odMMe0b9BGUzEXJpvdxkshNd/TdBj64t
         fVXTdwcRSF2IKY/Hl1kni32T6FYop1J+9JnfoV5oXEIg56RMo/9I8BEc9INdxviKdPwt
         dKJCu1stMU1gR+oGjkRBQmlh9+/YBPLgJFYbpytjs2LVeqWK7YYe795AF2fJUaNEmaG1
         Q8nrFljZpR0AW1MdkdxsFPR075GBtewO1O3mKZkC4AJqYPBxyi1fQ+HshX9LD/h+FdbT
         0EQ8/7am2WdGbU41t8AfOA3TvpOLIEgpB8v5qNbWHFZAWVC1mK4ntwBlUCR+xxaLW6p7
         c+AQ==
X-Gm-Message-State: AOJu0Ywcais9A17qt6M6GA4Gl6yqN1N3dPwNb3mQVghK45zKbYYfm3Br
	tUy2gxJXyuzbKSNMlkCYVF/4dXpdPxIvWRU1auZPKLtu7KZSR9MXbhNl+O3Z5N9CZBIhXNCXwrf
	4WQjnl39UYjXoYR3oSd0Fw986Ws/UwZUb5E33RpPEqhhkzBuCDr92fWWZOMvjVDIPRNp9Ye57qp
	E52PdiQMgn6+NDgwBeaIQQIaHJKfAwTeHCAbQv4HpfPy0j2M+8fg==
X-Received: by 2002:a05:6808:2381:b0:3bd:dcdb:db4d with SMTP id bp1-20020a056808238100b003bddcdbdb4dmr4809926oib.31.1706524714162;
        Mon, 29 Jan 2024 02:38:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlo8VDHa6Y2K4aQ+HabrB86NbPSADmuINfxtZ08wBoHb6SRiNva2UtU3nDmQ7tDeeNK5rbXQ==
X-Received: by 2002:a05:6808:2381:b0:3bd:dcdb:db4d with SMTP id bp1-20020a056808238100b003bddcdbdb4dmr4809916oib.31.1706524713920;
        Mon, 29 Jan 2024 02:38:33 -0800 (PST)
Received: from nyewale.pnq.redhat.com ([171.48.38.219])
        by smtp.gmail.com with ESMTPSA id u26-20020aa7849a000000b006dddc3e298esm5521654pfn.150.2024.01.29.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:38:33 -0800 (PST)
From: "Nitin U. Yewale" <nyewale@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	jmeneghi@netapp.com,
	loberman@redhat.com,
	nyewale@redhat.com
Subject: [PATCH 1/3] nvme-tcp: show hostnqn when connecting to tcp target
Date: Mon, 29 Jan 2024 16:07:57 +0530
Message-Id: <20240129103759.42653-1-nyewale@redhat.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_023838_753917_4E214C2D 
X-CRM114-Status: GOOD (  10.76  )
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

Log hostnqn when connecting to nvme target. As hostnqn could be changed, logging this information in syslog at appropriate time may help in troubleshooting.

Signed-off-by: Nitin U. Yewale <nyewale@redhat.com>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d058d990532b..5eb53c2566d8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2753,8 +2753,8 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_uninit_ctrl;
 
-	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp\n",
-		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr);
+	dev_info(ctrl->ctrl.device, "new ctrl: NQN \"%s\", addr %pISp, hostnqn: %s\n",
+		nvmf_ctrl_subsysnqn(&ctrl->ctrl), &ctrl->addr, opts->host->nqn);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
 	list_add_tail(&ctrl->list, &nvme_tcp_ctrl_list);
-- 
2.39.3


