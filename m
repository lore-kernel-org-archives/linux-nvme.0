Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B66FE6C5F8
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 03:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmxvTcrzfwp5mh+amZ33Odw2AKzrv2TrqCm0sLIaCwc=; b=jagpdtkVt5ClOjDrqmgzT7Cq7z
	uIJLgj2v+M/jB67kDr3Ci5EvWwVDplYU7K+Au5W25CJHMPvo9HtaohvfK0LPR/JJFXDajrovnU5Uk
	4P1068L3+v/UkTBoX22bDFZbi2aEhtOBaVh9ModDa/l4HsUBAIGXCaT/YEfhP0TD1ZfLPHIaXSNXe
	OktNdEkzZHrCwVEiN7Okboxp9lVkM6duwVhcwpJNqRLDGeavYzxUmxli/HeB+WflyFOWh5PkQPFgb
	0EeiZ79o5JovTubA6XbDMG5RqmpwZnjNkXw1I6wRO+pBH5uhVc64Vld7cs1mX6qlHR6m+wURY+CgY
	WnjS214A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJge-000000087Ym-1z0x;
	Tue, 03 Dec 2024 03:34:56 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIJgb-000000087XM-3x2c
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 03:34:55 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7fbce800ee5so4978112a12.2
        for <linux-nvme@lists.infradead.org>; Mon, 02 Dec 2024 19:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733196893; x=1733801693; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmxvTcrzfwp5mh+amZ33Odw2AKzrv2TrqCm0sLIaCwc=;
        b=V4+XT++lCqzcx/jurobURKG4u6dxH6kyHnjlk7GwPAAaMxNkFYDxsbF9vcWqMpLzNI
         BtI3gqvVnA9nqm3ZD1z5QqC5rm23Y5KUTZtGONYYIrDIdPreYZ5lFOhc7+V8U1fBkik9
         mH3CB1yWjpIWtar68/xqM1M2Z5pOPjSXAy9mpjybElg3maaf8/aX0gRbtJ9Ddagp75zC
         EMTZH44Y+dBW/uToPppOtbaXBOAF6gcicL1uJxijTxJq0blHm4fdh8o2XmA76M7ff3ox
         SWtEiFsUP5W9JAT5wa5cou5vH/Xed3OvLpJW7Fd7nnmrsX/OpUXA27ytZ7JOW46Cyg4Q
         V/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733196893; x=1733801693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmxvTcrzfwp5mh+amZ33Odw2AKzrv2TrqCm0sLIaCwc=;
        b=nqqwcMsZ7NvN+0PQEVVyju/+apAN8t27qDMjlGzYJiRv7i8TpoyK7YP+b3SMeyFY3z
         3VqmqVIxg44W+XLhVPHqvmzGtIA3kJ98L+zIvTIisT757MAmCHk5+n/+uM6SiPcIO1jy
         81PrKVVpIlHECjNHf91hj1l++9T5Qg/XOLjpesrCscgLXTW3tmJFWlvZsDo83PPphSr2
         F26LRiuIi/CcjQo/Mdg9hdRH7xv7Snycpjlshj3hUKCgmd+5ppWNHNiEK1pIoiWDmzkk
         odPrqcgpt4ETTLAu9kJA8ZJrLkYGKUzUqc1rcsLRZ2tCu3vYKuyJ2Oll+e84eC72H/AY
         WqYw==
X-Forwarded-Encrypted: i=1; AJvYcCV1NklUOpy7kJF2CVZy43HR51o+OHaIkkJxx4PzgMuEzSPU2oZWTvrcvJz6T377tWbSm8PnDxXcK6fz@lists.infradead.org
X-Gm-Message-State: AOJu0Yyz2PYMvYZDwTIlB8a/sBC/gjjxva5b7b3BfXDhlMujiDnOvplT
	CP5VY2L1mM8NbfKDLplI3ueP58267Q+rXGUxICKiu6mZ7hC4ysu9
X-Gm-Gg: ASbGncv1ysGTocbVvoCvuxuYxl380dO74x9wBqSLXnCuqdRvw5V8NQQY+J8xH5s2QB6
	r6CvWcMWNwL8u0Z80dZOuZMxNYGh3SuwhAaV10vnNyyGO4l61at4Whhe/nYdCty9N3ClSHV+HbE
	DsPaSTcvwwUMyWwWbonQo0+r66aaANJ520mtpcLy0SYLZ2NRrdzy+tGXZ3LnqYdX7EDkcKVN5cP
	BN8kJlGouJRoVPlcEFGs2aACR1xBJVkkB5wudLESeW9jlfZTPcn6ryPFNM1yw==
X-Google-Smtp-Source: AGHT+IFm0LGFirXaTvKZaSoFvKfpRDLZlmiFQ/VjBQ22pAFs7108tr2ExxyERlRXw4lHHOX4mkDyBg==
X-Received: by 2002:a05:6a20:6a28:b0:1db:f01a:cf12 with SMTP id adf61e73a8af0-1e1653f28e6mr1801738637.34.1733196893014;
        Mon, 02 Dec 2024 19:34:53 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215a17a7be1sm20749645ad.255.2024.12.02.19.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 19:34:52 -0800 (PST)
From: "brookxu.cn" <brookxu.cn@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: hare@suse.de,
	lengchao@huawei.com
Subject: [PATCH v3 2/4] nvme-rdma: unquiesce admin_q before destroy it
Date: Tue,  3 Dec 2024 11:34:41 +0800
Message-Id: <4ba9a8547c5cce3ee358e26890e16edbba94f789.1733196360.git.chunguang.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1733196360.git.chunguang.xu@shopee.com>
References: <cover.1733196360.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_193453_985156_5C1C53C0 
X-CRM114-Status: GOOD (  12.36  )
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

Kernel will hang on destroy admin_q while we create ctrl failed, such
as following calltrace:

PID: 23644    TASK: ff2d52b40f439fc0  CPU: 2    COMMAND: "nvme"
 #0 [ff61d23de260fb78] __schedule at ffffffff8323bc15
 #1 [ff61d23de260fc08] schedule at ffffffff8323c014
 #2 [ff61d23de260fc28] blk_mq_freeze_queue_wait at ffffffff82a3dba1
 #3 [ff61d23de260fc78] blk_freeze_queue at ffffffff82a4113a
 #4 [ff61d23de260fc90] blk_cleanup_queue at ffffffff82a33006
 #5 [ff61d23de260fcb0] nvme_rdma_destroy_admin_queue at ffffffffc12686ce
 #6 [ff61d23de260fcc8] nvme_rdma_setup_ctrl at ffffffffc1268ced
 #7 [ff61d23de260fd28] nvme_rdma_create_ctrl at ffffffffc126919b
 #8 [ff61d23de260fd68] nvmf_dev_write at ffffffffc024f362
 #9 [ff61d23de260fe38] vfs_write at ffffffff827d5f25
    RIP: 00007fda7891d574  RSP: 00007ffe2ef06958  RFLAGS: 00000202
    RAX: ffffffffffffffda  RBX: 000055e8122a4d90  RCX: 00007fda7891d574
    RDX: 000000000000012b  RSI: 000055e8122a4d90  RDI: 0000000000000004
    RBP: 00007ffe2ef079c0   R8: 000000000000012b   R9: 000055e8122a4d90
    R10: 0000000000000000  R11: 0000000000000202  R12: 0000000000000004
    R13: 000055e8122923c0  R14: 000000000000012b  R15: 00007fda78a54500
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

This due to we have quiesced admi_q before cancel requests, but forgot
to unquiesce before destroy it, as a result we fail to drain the
pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
simplify the code.

Fixes: 958dc1d32c80 ("nvme-rdma: add clean action for failed reconnection")
Reported-by: Yingfu.zhou <yingfu.zhou@shopee.com>
Signed-off-by: Chunguang.xu <chunguang.xu@shopee.com>
Signed-off-by: Yue.zhao <yue.zhao@shopee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/rdma.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index baf7d2490152..86a2891d9bcc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1091,13 +1091,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(&ctrl->ctrl);
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_teardown_admin_queue(ctrl, new);
 	return ret;
 }
 
-- 
2.25.1


