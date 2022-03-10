Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99302C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 12:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dSUA1ehXKOf68uhxMiCAiN4dZDcBQJbhxv26JeNbsGs=; b=O3kWAXzTtWKkk6S6174ZT4a/ON
	1WR8qcawPgqtyjP3PnWJMyq95vTwTC1dBBy9DXX27RCxk+1FT5xxIwQ2U5B0diK8sFeG3ID4w9g8d
	8br2rOOCFplSi3RS1fudE/S9YBDh5xhWALSWzSo3XXQKb3yA1fky9rM7Nz5fHUchpAa8Rs4txpMlI
	kFb0TPqXSjt8nkRWtL86MXCqOB/lVXyZwm38RvWhNSpcgD231Wqmtx2tIZOPTHnv9xEf1Y9Z87T3b
	VmOmm8UMsJEz6DZGLU4raLcAJ5nPn/29gFvUta+xMAWhLa3Umo3U3jpWpVyi2K7QykS0L0wP4T9Rg
	RP+TKJog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSIH5-00CqAN-I2; Thu, 10 Mar 2022 12:52:11 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSIH2-00Cq8a-K5
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 12:52:10 +0000
Received: by mail-ed1-x52d.google.com with SMTP id c25so4681806edj.13
 for <linux-nvme@lists.infradead.org>; Thu, 10 Mar 2022 04:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dSUA1ehXKOf68uhxMiCAiN4dZDcBQJbhxv26JeNbsGs=;
 b=cR/lQS+HHh8+mEFEFSvmzAkeziOAz6FLXcFliEqCLbhB6vdDPj2i+bilTqExHAWaYL
 I3jGpTaFC3uiKLGtrKMGWu/lxOcehq5brL4TdHxPKzYwryTCjQw31vkCNemClId24xF3
 vr8tqG2lsHsjZORGp/1hYim404YC7ZS36c+LKyhU+uP66cMoBFT14jTg5ZbRK29eQiE+
 5k1FBRZW4KCp3yTRGZw6WQj2wQOS5z6zwvNDqBTzcpn8t7SmaC4NKywKtrzAaqYrvwIC
 dEKcGdkuuB2GG5zKFcHg48AgEDlzx5m7qHPkCkEnbYqTw4RepB7nfbN588cIRCmwSf94
 jFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dSUA1ehXKOf68uhxMiCAiN4dZDcBQJbhxv26JeNbsGs=;
 b=Y9IlnrswezjpWQeLhG8rRZYH8BXjCXOISdDfQo9OOOtvL1XWvd1V9Xnj9v5271MG+t
 v77rQwz6ewNlqV1S8CMomouNSxLI3NkeWNwwOxCV0jJK/sriUVVZG65cNXp3/Zr4tLrf
 +FeLcqsH5zPcfXLtse5J883ficnzcpiadiA54PpKgcvEAtd0L545/ikYMzp1Es+upC7m
 2yN+fdE5VixfpUtu/tUMMV8sPi5oaKp6I0hFtwuFan02D88C0WwXSWMYX5Dr3dvhsuM3
 susgF8L9CAvA/17VhNdEq5AzLb+notvTFfJc9SwTNMPoP1ukv9h2S/YWhacIFHZUhYiz
 spKQ==
X-Gm-Message-State: AOAM532EW97mBsPPgozC5DnIYGhfKDM/HRRD14wXTJnp5WVl3PT3CLBN
 XK/VXp8CoXC/f4VWNODFUvd/hQtMjHqtdA==
X-Google-Smtp-Source: ABdhPJwjyhdNYCRnWbd63NSo76zRD56HUhXTPnXvm5shgoD3KnBfC8GCDX0IAVCuYonnHoWqrECgkA==
X-Received: by 2002:aa7:cb18:0:b0:413:3a7a:b5d6 with SMTP id
 s24-20020aa7cb18000000b004133a7ab5d6mr4147826edt.254.1646916727141; 
 Thu, 10 Mar 2022 04:52:07 -0800 (PST)
Received: from nlaptop.localdomain
 (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
 by smtp.gmail.com with ESMTPSA id
 x12-20020a50d9cc000000b0040f70fe78f3sm2071722edj.36.2022.03.10.04.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Mar 2022 04:52:06 -0800 (PST)
From: Niels Dossche <dossche.niels@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Bart Van Assche <bvanassche@acm.org>,
 Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v3] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Date: Thu, 10 Mar 2022 13:51:31 +0100
Message-Id: <20220310125130.16786-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_045208_683642_DF5F3E3C 
X-CRM114-Status: GOOD (  17.65  )
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

nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
held. The only caller of nvmet_ns_changed which does not acquire that
lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers, of which
2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns and
nvmet_execute_identify_ns. The other caller
nvmet_ns_revalidate_size_store does acquire the lock. Add a parameter to
nvmet_ns_revalidate to indicate whether the lock was already taken or
not, and thus whether the function still needs to take a lock when
calling nvmet_ns_changed.

The alternative solution is to let nvmet_ns_revalidate return a bool
which indicates whether nvmet_ns_changed needs to be called and let the
callers handle the locking responsibility. This however places the
responsibility with its callers and causes more duplicate code and
potential to forget to check the return value.

Both of those identify functions are called from a common function
nvmet_execute_identify, which itself is called indirectly via the
req->execute function pointer.

This issue was found using a static type-based analyser and manually
verified.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Changes in v3:
 - improve commit description
 - do the locking locally

Changes in v2:
 - added sentence about how the issue was found.
 - added missing &

 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/configfs.c  | 2 +-
 drivers/nvme/target/core.c      | 9 +++++++--
 drivers/nvme/target/nvmet.h     | 2 +-
 drivers/nvme/target/zns.c       | 3 ++-
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..efa462374783 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -511,7 +511,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	nvmet_ns_revalidate(req->ns, true);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..a803cd66dc4b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -586,7 +586,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
-	nvmet_ns_revalidate(ns);
+	nvmet_ns_revalidate(ns, false);
 	mutex_unlock(&ns->subsys->lock);
 	return count;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..0ceef97e4093 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -531,7 +531,7 @@ static void nvmet_p2pmem_ns_add_p2p(struct nvmet_ctrl *ctrl,
 		ns->nsid);
 }
 
-void nvmet_ns_revalidate(struct nvmet_ns *ns)
+void nvmet_ns_revalidate(struct nvmet_ns *ns, bool should_acquire_lock)
 {
 	loff_t oldsize = ns->size;
 
@@ -540,8 +540,13 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	if (oldsize != ns->size)
+	if (oldsize != ns->size) {
+		if (should_acquire_lock)
+			mutex_lock(&ns->subsys->lock);
 		nvmet_ns_changed(ns->subsys, ns->nsid);
+		if (should_acquire_lock)
+			mutex_unlock(&ns->subsys->lock);
+	}
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10b..e4f20fe95613 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -542,7 +542,7 @@ u16 nvmet_file_flush(struct nvmet_req *req);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns);
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns);
-void nvmet_ns_revalidate(struct nvmet_ns *ns);
+void nvmet_ns_revalidate(struct nvmet_ns *ns, bool should_acquire_lock);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 46bc30fe85d2..1987358bc855 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -123,7 +123,8 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 		goto done;
 	}
 
-	nvmet_ns_revalidate(req->ns);
+	nvmet_ns_revalidate(req->ns, true);
+
 	zsze = (bdev_zone_sectors(req->ns->bdev) << 9) >>
 					req->ns->blksize_shift;
 	id_zns->lbafe[0].zsze = cpu_to_le64(zsze);
-- 
2.35.1


