Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF55F8E49F
	for <linux-nvme@archiver.kernel.org>; Sat, 18 Apr 2026 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nhO9k5hRkc5XsEk7HHGwbjhBp4VezrPvI7ZN4hGepUQ=; b=H+OJf4IfypX0W0aib/1iANkYoX
	rSA4vwJRWDM67KArmlXkVWpP8VWEsyuM0btKdlCZ9uNpRy6zCcOh0zdzk75l9wUagbcQ20XDcShYq
	Hw1YiJNkt74ZviqXCYiIDGPVyFhmI1ywtcqBNVLxVTV7AgWMsIAyij0qCb3c8VJHGy0uxZsvoCld+
	ckxzxXI79sUr8g5gYKY6TmUNui17dCztWdbbV06kkPjIwmjq0avVtOYaim79/521YLNqT/F6QUIeL
	/gm0oP9N4z05RgY9w1G83oOxo2aqlY2Ja2EJCyJhBn+q2h2azFfatgCQ505YYIm50lbFd/0Y3njmN
	G7mF7Yog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE5NE-00000004zTd-38wX;
	Sat, 18 Apr 2026 13:06:12 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE5NC-00000004zTJ-1CKW
	for linux-nvme@lists.infradead.org;
	Sat, 18 Apr 2026 13:06:11 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so733653b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 18 Apr 2026 06:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776517569; x=1777122369; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nhO9k5hRkc5XsEk7HHGwbjhBp4VezrPvI7ZN4hGepUQ=;
        b=AhtBDNDqW7xerWR1pBJcVJ+tqrIiUZI7u/R3+Ou0ntAPkOE657jnBXJ9IyBsn5E5FN
         HwMlr6IOibzurVek4Y/MF6ve080kJt0IbVJA9i435IMwxhX1OMsYvmY6Eh974YhlzjTC
         NuHB/goCJ7y+hf4OwIgWkxvnnmuLde81xbms2vanq6ASIuTH+2c93720XBIs8lbfdTYd
         Bm5XotsdBQXs6SiFugRd2dwIywk1/pUKGpatkbjVP0Q/pbPyqBMDvOh11UaU99+pl5tv
         2gxNSC/nH+v6z3+oKmL2MK00TUMAESN+/i7Lxq59h0BBZzhEyGVEAVB6IOGGz6Gmyla4
         BbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776517569; x=1777122369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhO9k5hRkc5XsEk7HHGwbjhBp4VezrPvI7ZN4hGepUQ=;
        b=tEtIz7tXK179xb7a3XDlyuFHwgcljP7A2qpZw5lEZZL03v2nEMKahs+NP0UfArf8pG
         0uW6Ns8xibRQUgGoXbjPJBtaJdE7S87O80J/UYuewR4E3OiCVhn5zPtG+OVqv+Ie/xyn
         OSKHbVMVfQRYTVDlRypIlwfOv96AMwspzBKy6yUbM4aWppLCPUcnzu+Xv9HYD7WCLYGc
         AYKMafrVM+h9qptzE9MQZAaV9dgrZOdZOnNuzZ0CqQG7fJLTy6JVqqm6F1Aa/N711EG9
         AqEm+ZY94/3ewehW4fwBeHe3VTShj+1VxhongXT0oeSWBqNBBK+Bvan5IWv3lVKgASVw
         NhIQ==
X-Gm-Message-State: AOJu0YzrR+vIqlf4nMZ3WAJKXdAjsaj9ePe8KIvWa+UPozi0EKkq/sMl
	ZzOhLBcM/t14vxwtoGP0JChLt+hfmQJnt9FTUJRsmNwCxjM33GjFAJ1Qd4XMpA==
X-Gm-Gg: AeBDieuI1lXJibyC/osWHSP1jqHwvnsRQQ8m6IjMRbFxl/2G7ptzNqgr/6kabOTxhmZ
	XStU4ijvfmdSYysTir7HEUEw1QZFEO6aYNAvq/Xc5e6j5DikAbwQZoFyOf4uXMUcEs+ZflDCoWH
	goDOvqoAjKsW85FTnQ9GLqm8VJt/R0rW44bYYf2ljw9JXJPQDIpn1TwTZsu3P0FTAkITO6f1E14
	WJXZzvzk0vaGZcW2hEvDYjMrmgWNwzuaC4oyJmpG1L5iJNaO6CYgWj8tM8wHh6qK1LxIhyoKZLH
	nbCFwfv27AX7tZoB09XMYKDNyyZ6FmV2P9kxJKdQ7LMeZK0Tn7n1TiEwQbkvy2HwJzqA/NZJWfw
	FHJZPALQIiCPr18Ufzq8krDk43QOD+PL45krGXAiUXccAQ+VlTXYs7Bye6H4B1ykw2D84LBDX2p
	jftZwDjAM2SE4zp/PJ5Xq01vJFKeGpiyFW+ujkBHRPTgwIt8o=
X-Received: by 2002:a05:6a00:4408:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-82f8c84d3aamr6912086b3a.3.1776517569056;
        Sat, 18 Apr 2026 06:06:09 -0700 (PDT)
Received: from tokunori-X570-Taichi ([240b:10:2720:5500:9a84:5d43:e9e2:a5d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9819fesm5064550b3a.4.2026.04.18.06.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:06:08 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme: set NCC and NIC effects for NS mgmt and attach
Date: Sat, 18 Apr 2026 22:05:59 +0900
Message-ID: <20260418130604.23441-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_060610_323315_34DABC18 
X-CRM114-Status: UNSURE (   9.60  )
X-CRM114-Notice: Please train this message.
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

This is to make sure scan_work done for the commands.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1f973d88c830..1ed1fc866f3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3448,8 +3448,10 @@ static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
 
 static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
 {
-	struct nvme_effects_log	*log = ctrl->effects;
+	struct nvme_effects_log *log = ctrl->effects;
 
+	log->acs[nvme_admin_ns_mgmt] |= cpu_to_le32(NVME_CMD_EFFECTS_NCC);
+	log->acs[nvme_admin_ns_attach] |= cpu_to_le32(NVME_CMD_EFFECTS_NIC);
 	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
 						NVME_CMD_EFFECTS_NCC |
 						NVME_CMD_EFFECTS_CSE_MASK);
-- 
2.51.0


