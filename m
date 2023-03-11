Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A228BC6FD1C
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Mar 2023 17:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NfAbuBX7oiQ3pJ8JdexOMIk9UWeOac/dKnRzpzjPBoM=; b=Xwmqg26JfdRdx1Ul8R0Yjahc6A
	b7HBM72zRFMCOj2VnxTycXCcIqoc/oErS9KIA03oXY70YR7CmXZXObsA2SfkolPMvoxpEKfsXJ6US
	R6KSIHoPWmqA0GdOa8Wpn2qnQVjrfBfe/tk331YRmLfAdXVW5WV2uV20ZfR9iOejaBkZlhLLoHD6N
	pzZTY2Ytkh9wVjQ6rhodsDbTWJpL4891lvvcg+HmV9zQgvMHZ+g0ejxOpInSWBYz+qPDqaiHEDZTy
	j/nIhi/Gm6at/8WbQwvSB7uK3p64FBWDxaoLE0aQDzousLuQ1mUQ3ybvl1nhPrz45y9mjxyevKFH7
	n2j1X+kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb2zV-000xMR-6j; Sat, 11 Mar 2023 17:26:45 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pb2zS-000xLO-UN
	for linux-nvme@lists.infradead.org; Sat, 11 Mar 2023 17:26:44 +0000
Received: by mail-pj1-x1030.google.com with SMTP id q65-20020a17090a17c700b0023b3ad9572cso1310493pja.5
        for <linux-nvme@lists.infradead.org>; Sat, 11 Mar 2023 09:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678555600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NfAbuBX7oiQ3pJ8JdexOMIk9UWeOac/dKnRzpzjPBoM=;
        b=UE4pk3XjFLwXQ2cv00OHePOJuZuQj6A7S3wcty1ByrsuJmnYjMjnnfqMgTCwdswpky
         5hsnvy2fbxuc3uP2M1rLV2p7IvKL99ZhUW+8+52F+uZlf3jrW0ZuwU1XHmbnICxSc599
         6KUCLIZxUZpW41LVKPRFVT0MlD+5foSvxNJeBGemPSp2TS13Yij1ZJJysLBZvmH2Rzfx
         9bVG6h0Q2F3Mpu8GcKZ0zUqwAnKgsABg+kL3TXsZ85+I1zoAIPl8fa6xSqTHjt9Blh8F
         gML2oaJpjWJgaCIPdHl3JxN/Q+N49LNR3NMwfmjJ2ytdnCNF+P23592yVLpPr8GkGspq
         H7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678555600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfAbuBX7oiQ3pJ8JdexOMIk9UWeOac/dKnRzpzjPBoM=;
        b=3w4FhXzc4rFfXHnCnGNLkaIPQGHlDtCRtEWrWBfxxAZb+T35/9tpaTSphbLLrkrAlR
         4EDo9VnbVMX/g4swJ/QhT4NFbIixA0nM8uIuT6YMsun5BAG9MzJLM54hlImzuMI8v05h
         ttTXADEu7/MCxiA7dw/H8Ka+I5OXPQ1zuS0030cDPxcIDjIe1IM82ZkqXRFyP1LOJqGU
         grYtZh0gGxpeyE80x/ACpeuGJMKILL/U427T73PN1D5fB2LgTzg8osknyhEFO++J61qg
         8D7tPteLMVREDs0qQ9PaB5mX5QWalrpC6FI8muw8a44ECaLRATtaco3MPg9VZOXujcY9
         T+aw==
X-Gm-Message-State: AO0yUKUChXN4Gbea4xTf58JOSbdRyFHwkoHwwgYJLMEkSAChWyoxWO8J
	d8cqrSPIBJYpYZXhyrufyfssae9/Lrs=
X-Google-Smtp-Source: AK7set9vk3OxWM+8psxISfBSyUJSLxcJrOYmaMww8LhgWafqdnfjiWLdr0JlqhNq0DoP17D2fYAJoA==
X-Received: by 2002:a17:902:dad0:b0:19e:b6b0:6b3 with SMTP id q16-20020a170902dad000b0019eb6b006b3mr25733211plx.15.1678555600358;
        Sat, 11 Mar 2023 09:26:40 -0800 (PST)
Received: from gooner.. ([171.76.81.229])
        by smtp.gmail.com with ESMTPSA id u9-20020a17090341c900b001967580f60fsm1741651ple.260.2023.03.11.09.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:26:40 -0800 (PST)
From: Martin George <martinus.gpy@gmail.com>
X-Google-Original-From: Martin George <marting@netapp.com>
To: linux-nvme@lists.infradead.org
Cc: Martin George <marting@netapp.com>
Subject: [PATCH] nvme-core: avoid identify with CNS 06h to discovery controller
Date: Sat, 11 Mar 2023 22:56:03 +0530
Message-Id: <20230311172603.3800-1-marting@netapp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230311_092643_001272_36490D45 
X-CRM114-Status: GOOD (  11.59  )
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

nvme_init_non_mdts_limits() currenty invokes an identify command with
CNS 06h to both discovery and i/o controllers. But as per the NVMe-oF
specification, this is not supported on discovery controllers:

"The Discovery controller shall support the Identify command with a
CNS value of 01h (Identify Controller data structure); all other CNS
values are reserved."

So ensure this identify command with CNS 06h is sent to i/o controllers
alone and not to discovery controllers.

Signed-off-by: Martin George <marting@netapp.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..62d1048c6506 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3063,7 +3063,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	else
 		ctrl->max_zeroes_sectors = 0;
 
-	if (nvme_ctrl_limited_cns(ctrl))
+	if (nvme_ctrl_limited_cns(ctrl) || nvme_discovery_ctrl(ctrl))
 		return 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-- 
2.34.1


