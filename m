Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F03C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 05:42:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C4320792
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 05:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jEGeZq+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C4320792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=80+kxtqybDcndlUEkzfujqNpDHwTyTiejSDOVynhJdI=; b=jEGeZq+I1mJnFt/vl0IqnCvoll
	4KRwp/9qELIGm6Iyu21z5jDxtqdeV79fp2DElqkaNcvs5rHeyoKYPyr2voiSB5C1NkY7bgagspBi2
	4SFx9kstuem31Gx9uEh5XUU/bRmfPPCRFM1GzIVMliT85VYlVzugaDzjCOyBl6y1IbIHy4f+FizDA
	lKc8oXEl2y7G3WWYY7q+Bs/HbuNCujO+L/olXArKpO38RL3JcVdjENbAuPrlSodV2FoWNwKzQw2+w
	fT19oRJzcPx9qVmjIzJfMPxd9m5fWj6YONBzTtPbmVriIbhTUDbaXnPYZO/WqcH1TSucJkwdGKA6g
	D3G+JvIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0INL-0004Mc-JW; Tue, 28 Jul 2020 05:42:07 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0INI-0004MG-Vn
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 05:42:05 +0000
Received: by mail-pf1-f195.google.com with SMTP id w126so10134566pfw.8
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 22:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=y6R7+OMK/IIU039g35a1aFD9/L0StFe56oEm+wU+0oQ=;
 b=NWJgru3X7FA6aZ4I7Uhz4cnrWPr6f+OS3xMG3hDo/9u9PFV1/yrPNp41XoZqDVaAlK
 kIlVT9uzwia1eCZ5ewa8SUteYAurhBmCdhH0V1xVwziXeW4T2NIZa83I/FBoG63cBuUc
 iAm+M0jfgQhcKQlM4nFAbMMmplWaksxcKzu6b6yi7x0X0vYb1xFq1/RnnkQ/ODLOkc/C
 68NdHHwWRg1RZkv+RKsRpCLqpatsHTw2DuhQchFS/vovDIEv7HQjYL+OzbC83k4pZLAp
 PmIS2NibdTTjFr8rrnzLxLDWxR9I83qzb1cQyh1JfzUVpZViMzYVkntLl1IS1roD9/RS
 DMyA==
X-Gm-Message-State: AOAM530detAjobOCAZKKokFQFU+jAIEoXfpd0gYLegHLdy8Oc/1UdY0A
 wZ0AFh4CyA3oTg5gfMFczkDXhWfX
X-Google-Smtp-Source: ABdhPJxhikap7+09KgX/FZb7L5Y5sNZslx5/LNc1BBG4znbagXWwzjhRYy7aPbY6cnNeiAWIJXCFVg==
X-Received: by 2002:a63:571b:: with SMTP id l27mr23443068pgb.417.1595914923281; 
 Mon, 27 Jul 2020 22:42:03 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id b82sm17180488pfb.215.2020.07.27.22.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 22:42:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-fabrics: fail non-ready command only for
 NVME_CTRL_DELETING_NOIO
Date: Mon, 27 Jul 2020 22:42:01 -0700
Message-Id: <20200728054201.23184-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_014205_058757_AC1D9D7F 
X-CRM114-Status: GOOD (  13.91  )
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

We allow NVME_CTRL_DELETING to accept I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Christoph, another patch we want to fold into
97e9bb2b27bc ("nvme: fix deadlock in disconnect during scan_work and/or ana_work")

thanks...

 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c8190eeb7..4ec4829d6233 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -547,7 +547,7 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *rq)
 {
-	if (ctrl->state != NVME_CTRL_DELETING &&
+	if (ctrl->state != NVME_CTRL_DELETING_NOIO &&
 	    ctrl->state != NVME_CTRL_DEAD &&
 	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
 		return BLK_STS_RESOURCE;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
