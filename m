Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E48CCFA02
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Nov 2025 15:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wk/svKLpQpTJaPyIcUcxbaltetzoE2T249FQcQcziYE=; b=WqQfcEfMDnIe/mlLQSTYaxVHvX
	KWuIRaXBKze+QIDLhc6W5p+aS6ZW2ymEby79T93jZmLNNNG+SD+gMlR629js36H3A79nWPevWubi+
	N+IxI/cIz2MSvu91j21t84PeRtqpx0yBZEaxnVV7SwfwC7qvK5SCUoNQ3+Cq8phGbVofDiF+hs56H
	k6FA+CGdkH8P2K4kviCFZMHmEgiizWU1TkHACe6jdf+fnYrd/IkctueoyXuuB6u97cfiPtyrp8spX
	3vRNzCGxbUwEPTC+B6p+OQtP7AIEFCdIrCNYuGGdTAg7wLKeaS7TbFb5UmGv8ghSfzNRZInF2iZkM
	zhAIOZCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFZoj-00000008bQB-0OrC;
	Sun, 02 Nov 2025 15:16:29 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFZoc-00000008bPr-3CLm
	for linux-nvme@lists.infradead.org;
	Sun, 02 Nov 2025 15:16:23 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso537305b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 02 Nov 2025 07:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762096582; x=1762701382; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wk/svKLpQpTJaPyIcUcxbaltetzoE2T249FQcQcziYE=;
        b=R2QKRfiX9Yd5m+AZy78DkAYsrxqeCRQhb7yUeUTKpd1jxg389kuqiFq9ltPyPLBFVJ
         hQ51BOfz5Fq9/KlqP7MiN6fa3Qy/EujcSYb2QBGHy+Id/o2yLC/Lj/kavj/Sv7Fe14wt
         JqhC5qNBiIG9vkUhWPkLFGAnfJq+hcP4YLpErA78cl8TIET+N6Oyh9+z57IxBtc8Kzng
         V2QW1Vo2cgwGHyk1+11ouDX5S+W5QjznGuj5beEhuV/22LkMR2M/m0XRx/4xSaOtXY9H
         KMq6jYpHFr0x83focJWVoXGRUpYSdl5ceyngA5xOqkwfwC4xINZKTQV3cIQK/yIQCay9
         814g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762096582; x=1762701382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wk/svKLpQpTJaPyIcUcxbaltetzoE2T249FQcQcziYE=;
        b=pA5v5QJ3lma3r8aWQ/UTX2u7O2AcvuylR7ioYC/yvD15jHsa1/WdBE+hCb5hgk+KtA
         L831J6ylITl1Rg1gSwwuXlu3XVzVkC4IU4l3NbSbbHSI6bWkJM1uP5bIOjy4Blmlxmcq
         H3EQUC41g0QtGhbtqki6/toYhs3MQEVuVz1qimFa1px4whUdD5AFh9vn6mNhqhkz98kH
         jCYGW9+ZZQ6EILWUmKdsXiCYT787+IapNHV1WIU4+PPvU1X3dFbsvFm1F+hlxmIigAeV
         pEPjR9pBTYqn2ULDrdu79nNqPVSP5BuTKnFY1xjz99JmCJ9nhsTyUq/PnOIZfL8mvlfT
         VSGw==
X-Gm-Message-State: AOJu0YzoPcpTVfVFtbpGicyYW7AkSDkQ7UAbpprERB7ELmjEzsAYDjvH
	jkN2wuB3+JBKfIBDyOU1N+fp39dt+oyxxfheB/48MSXhbTFN5T95K1Drjs66mQ==
X-Gm-Gg: ASbGnctBIli9d49M55s2ZFASCJvBBp8XTqwJNu9OHcx1geJFCfSHftkEwTJ8ObDCdiY
	wOMAvVJYJvRYKw5RyX/GNCsJUSIrdIInL0zB/wHEyn5NtCK9tpPrtftGeSOOOZ468PHIYoNc607
	rOqQukr//UdAfmAJVuJJNUQohwgE78ykkuQ43U+zt6js17dEyMKTxvZirP1D4dWeeC6O0FdqWE2
	juqZSvkqdM+BKqV0yWvQG/IJY38tBTtcoekgwu+rVB80rXIcdg/ejMpypYZ8XMHVlOqyIc5Z3w1
	d4RLcq5l6dxzrND40RiEAIbJ8ThrNbFiqNjnKPFyob+95uvC4M/BwaEKwxIDy/obDAj10+Ftkpq
	DCDMmWgo8LyvopNzD72JIBKB+QN1MlUyRQKUiP9J0zQHrBTNzztHshnmZwKmVRaKjgGpQT7orqM
	YJMicJMpxapCE5LZ+6B0JTvvi7aND2Yys0Pw==
X-Google-Smtp-Source: AGHT+IF53HqM9DkJju28Bv3nFc4utwMeSA2Nzhx5WIrLa3gJnB5IUtrADxvTwqMNurpFoChHzSIYRw==
X-Received: by 2002:a05:6a00:1820:b0:7a3:455e:3fa5 with SMTP id d2e1a72fcca58-7a77416b3cbmr12474274b3a.0.1762096581517;
        Sun, 02 Nov 2025 07:16:21 -0800 (PST)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:f97:7b5a:bdfc:ed55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7db197335sm8262325b3a.47.2025.11.02.07.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 07:16:20 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme/ioctl: fix nvme_user_cmd() to check command allowed with flags
Date: Mon,  3 Nov 2025 00:16:08 +0900
Message-ID: <20251102151615.12587-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_071622_803222_BF3EFDB5 
X-CRM114-Status: GOOD (  11.61  )
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

Since only checked the flags by nvme_user_cmd64() but both functions
called by nvme_ioctl setting NVME_IOCTL_PARTITION via nvme_ns_ioctl().
Also fix to pass the flags into nvme_submit_user_cmd() as same.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..b335345d08a3 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -308,7 +308,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
+	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -316,7 +316,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, &result, timeout, 0);
+			cmd.metadata_len, &result, timeout, flags);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
-- 
2.51.0


