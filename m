Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5D6CCD18B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 08:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b2cqOX2dSMOJQpwfNpcENwnMnrm9vyfSvRfrGoQ5NYI=; b=sVByOxQp58TxFM6YmjmvW/cSi4
	d6TEiYS6uvzV2ikPZUYIURW5xpTd7iPBGnVzSm8rZJ2mNqhj36dfFSQlmWLWxapjdUW7PJomJrazC
	MEDk5+eQCKV35PIRBpk1jyta2yRi9sBI9HofWb5Xuspm1CP0LQEIgYbeJTRc+NTKjC2xIsjef2h+k
	JlQUeV3JyyFjhY8MUsbE079hXGC2xgq59z/LySSqZHWVqAvuQ2Y+PonUUBjORpkt+ByjEoOtvZf8V
	PnC48emEXtWTQWkJg6bk9Qgkv7xiFdLtUSw/GlcOCPLmFukCdTKx9VXPoKpCBd652kdrx56b7MGoN
	xRClgoXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpoD-00000007l0j-3AA6;
	Wed, 18 Sep 2024 08:13:09 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqpn7-00000007kmZ-3pnV
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 08:12:03 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2d88690837eso5360147a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Sep 2024 01:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726647120; x=1727251920; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2cqOX2dSMOJQpwfNpcENwnMnrm9vyfSvRfrGoQ5NYI=;
        b=XOt9xAFr8QKHxbWW+zQR8LtiyKIVv9J8fw9C67v1IB7NBnwpGsTyLUPArgXj74+XMy
         +xsLoRagpM9Ye77cndys2mYZnKX1024+gmHvfSJd3NqsLiMPkmf5vf5QGKTHaKBIjXys
         0+VPViGgcS8OmX3r981Cxo3WS7Jz4jRdN+AnbK1Bh9cSFzPK1+GdT2g3CfAvMtWhfvQw
         C/B77NpwtxlpbG3zPEHp0BHYJclWiVgWZnU2nBDs3x42YOYCsKErRDx/S/hjKUDG9wMs
         mrxbhfSYIa2YtOWAkuDM0wt+CGpqGWP1OnwnOpySLrNn9FOzyhPVEC7FD955XG+0CSdw
         +PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726647120; x=1727251920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2cqOX2dSMOJQpwfNpcENwnMnrm9vyfSvRfrGoQ5NYI=;
        b=bYWAULwSXQAPH6wXCYtynkUNCiAi9r0vhKtYFpZl4CeAfjyRaZ1dzfPfzG08JAEY+G
         YKjPI4j+jb1R/T3akCCwHV6oNj8zrfVf3E6bwrZGepzpyw14XKFpWrvMPAJXhKsN8pPU
         M7Cr3ZoQPzFZIAVC6TD5EvcJiSDane/NXrO8obQDhiqYD15u3e/OuqcCVatHwc9bUu9m
         KPAAf+8kNVVzsf0A8UdFFp6vTgRgIFmt/VpcslThbtPFOufTMkc5DAlxZz9yDfCWUQfD
         Eipkg9vJyYG0bovPg6MvbC3TRaJAXH6b9+6eagB+GfKWeNS/IcS6Qm4qTHp9RNSdGbfA
         MLRg==
X-Forwarded-Encrypted: i=1; AJvYcCX9zTH3otIizxJdQbNUtvIA3Fm4cDRAZUucX/2GByHCI0xjTVKvIt+/dH27liRdsuLX0n5EfrmIvuDo@lists.infradead.org
X-Gm-Message-State: AOJu0Yyc5VXeUlhMWlpkj5wMHuaEQx7eWq0gEPRMnLzUMPUw0w0RszAz
	+9ovprod6dUH+dAfLGqP2mUxTm3R8O9VUk5Jcl81L/YXRAuibJlC
X-Google-Smtp-Source: AGHT+IF3TbuagLRJ5khlQ0Ro6XlrWxJIZHhyFFdaMnXUyxVG9aYDTi47WYS9w9Id5VWpekDFXOryDQ==
X-Received: by 2002:a17:90a:d791:b0:2cb:5112:740 with SMTP id 98e67ed59e1d1-2dba0062abemr22277547a91.26.1726647120029;
        Wed, 18 Sep 2024 01:12:00 -0700 (PDT)
Received: from dev.. ([129.41.59.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dd608d1939sm904648a91.33.2024.09.18.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:11:59 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] nvmet: Fix warnings given by checkpatch
Date: Wed, 18 Sep 2024 13:41:34 +0530
Message-Id: <20240918081134.908075-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240918_011201_970386_E17A4D50 
X-CRM114-Status: GOOD (  12.57  )
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

This patch addresses below issues produced by checkpatch script.

ERROR: space required before the open brace '{'
drivers/nvme/target/debugfs.h:25

WARNING: please, no spaces at the start of a line
drivers/nvme/target/debugfs.h:35

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/nvme/target/debugfs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index cfb8bbf6a297..166de8c7fc49 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -22,7 +22,7 @@ static inline int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys)
 {
 	return 0;
 }
-static inline void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys){}
+static inline void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys) {}
 
 static inline int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
@@ -32,7 +32,7 @@ static inline void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl) {}
 
 static inline int __init nvmet_init_debugfs(void)
 {
-    return 0;
+        return 0;
 }
 
 static inline void nvmet_exit_debugfs(void) {}
-- 
2.34.1


