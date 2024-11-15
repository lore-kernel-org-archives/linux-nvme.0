Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAC6D6DDDB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Nov 2024 07:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p99ODvIJPrktbcv8eF11YBYTGZSaidlg1QybrmKvuyQ=; b=TwkUguQgaWLfSmW+JOuKUPzrtL
	lv/jASPsABeoEr7AIoaCFV5izgJ2NhVCubYjx23ERQVDms/E4rz2Anu7riD0wOWutS1lura6rpSBq
	7xHTjHUS5ZIM3/xwQkZ6Y4hs7p9BfJhXeCHRPsTbrzyvITLJHy700x0+qWRZDdNq3EDjKlaVuhhPt
	6IBUq3qxQh/2rBjnSX1auxgg/yLJFb2OvdmzZbRHRVIr5nnjGEm+BZS+qSKfqHDKKWkDA9l9AcSvs
	bAnyRaBUpDmotvXNUY4k+c8Z4WebF5WDog37v58C8LhcGuIhgZ4xUDEZMDtiZzgHLBcrgXX6YwCLI
	vw0lO2kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBr9C-00000001xob-0YNg;
	Fri, 15 Nov 2024 07:53:42 +0000
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBr99-00000001xnl-1nCV
	for linux-nvme@lists.infradead.org;
	Fri, 15 Nov 2024 07:53:40 +0000
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-7e9e38dd5f1so1157611a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 23:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731657218; x=1732262018; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p99ODvIJPrktbcv8eF11YBYTGZSaidlg1QybrmKvuyQ=;
        b=Ioal3DG0hwgarpc4kDNCUsvzS2KO83+xehyMc2lu+IOlwne+NTbVFfhNnKttGcC1oQ
         qFqt36zMD3WVlMMZJ9IclvsuW7QTsGZwYsNrlM5jxUfJZQUEyW78dkZ9vletNfkO53B0
         UGnMhcqrNPd1RTzJrqJs3AvJ03YDs4FZ5OChYI9kam8cerHPYk7kFSSx7PU8gMDO5lR1
         ho1ad19YHpd5kdDPuiHYWVH1IbZYzjZ4WpYnH9jn0yUVH6TD/RpmC8hHPCzkYFqUs/SX
         LjRWyL4YOrkVVWzO1fovndmWuIEcTLwmd3C/71xwUTFHdL4C9XKByTQztAt8mTOA7vIx
         yDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731657218; x=1732262018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p99ODvIJPrktbcv8eF11YBYTGZSaidlg1QybrmKvuyQ=;
        b=u8wVOeM0Tmqw5mcIkgYzxBr4sNcbdwbl4xUzMP8ZqISl2I6seKNiueU96ZeB1Dx0fZ
         YlRIJEkFnjvrDz7/CNk46w1oMzL9V+ZwrW1MO5GETKYYVpDeFSeK43c9vtuKN/NUTePm
         VKVr9yG1i/FwOccLrsIilSlY27aIdJzhfVp5ZOe43OQJSpGM3FbAPG79umAQxqaOp+5U
         C9pOMUd4Tly+t7ut5yABmQaaUjkxnWguYfvYnMx4IQXbLyxQvTix2e/gI5Zt6PEETjpu
         gW/RwYxMpPkNX6axjvLHIbSyywSIxZ+nwto+znMwtVhmZBP1BVX8/0eIosk5ajH+ybxg
         C+Og==
X-Gm-Message-State: AOJu0YynfAO7iGh5Xac2Uc2rj08ac+N96e7oKiZ5zTkyozc7vJ570GMv
	ZzRcIeg0P53e4v52UTeNysaT0JRNGTATmTOz/55RL73XjN1aAPU5
X-Google-Smtp-Source: AGHT+IFCNHN4gZOTQPJBOR8vXGarFpDWwt0EKC2lT0y1pesBteQ3zcoQe0k3zXMAysbZymytCRDFrw==
X-Received: by 2002:a05:6a20:7484:b0:1d9:c753:6bad with SMTP id adf61e73a8af0-1dc90b1c045mr2236352637.10.1731657217960;
        Thu, 14 Nov 2024 23:53:37 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1fdbsm773825b3a.154.2024.11.14.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 23:53:37 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-core: auto add the new ns while UUID changed
Date: Fri, 15 Nov 2024 16:29:15 +0800
Message-Id: <20241115082915.22380-1-brookxu.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_235339_497632_084E97F3 
X-CRM114-Status: GOOD (  17.80  )
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

From: "Chunguang.xu" <chunguang.xu@shopee.com>

Now spdk will change UUID of ns while restarted if we have not
specified one. At this time, while host try to reconnected to target,
as UUID have changed, we will remove the old ns, but not add the ns
with the new UUID. As a result ctrl with no ns, and we need to
disconnect and connect to get the new ns. Here try to add ns with the
new UUID automatically.

Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
---
 drivers/nvme/host/core.c | 45 ++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 855b42c92284..425f59fc80d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3991,28 +3991,6 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
-{
-	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
-
-	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
-	}
-
-	ret = nvme_update_ns_info(ns, info);
-out:
-	/*
-	 * Only remove the namespace if we got a fatal error back from the
-	 * device, otherwise ignore the error and just move on.
-	 *
-	 * TODO: we should probably schedule a delayed retry here.
-	 */
-	if (ret > 0 && (ret & NVME_STATUS_DNR))
-		nvme_ns_remove(ns);
-}
-
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
@@ -4051,11 +4029,28 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &info);
+		if (!nvme_ns_ids_equal(&ns->head->ids, &info.ids)) {
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n", ns->head->ns_id);
+			nvme_ns_remove(ns);
+			nvme_put_ns(ns);
+			goto alloc;
+		}
+
+		ret = nvme_update_ns_info(ns, &info);
+		/*
+		 * Only remove the namespace if we got a fatal error back from the
+		 * device, otherwise ignore the error and just move on.
+		 *
+		 * TODO: we should probably schedule a delayed retry here.
+		 */
+		if (ret > 0 && (ret & NVME_STATUS_DNR))
+			nvme_ns_remove(ns);
 		nvme_put_ns(ns);
-	} else {
-		nvme_alloc_ns(ctrl, &info);
+		return;
 	}
+ alloc:
+	nvme_alloc_ns(ctrl, &info);
 }
 
 /**
-- 
2.25.1


