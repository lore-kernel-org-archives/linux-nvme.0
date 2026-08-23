Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C7F9C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 08:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/KwyUz8+jwsvagZHWmoRXIA94Q5mvdjdC35oIGeJJg=; b=tPZybbIAx8A4TilChoNE+DFYxg
	dFkkc/bdJLa8Ng7oE41R56bb/47shgj2liZNSJjd90WhzWMWjG9GVBN4i0OZ8DG2wmbzB5nGHNfXA
	lJgHcOzQ5zGqFdRxHqRF9jsklTFmmoCEUskP5skMHP0liafM9Jke7BiVtFM0y1x31FQqmt3lY57kL
	r/yMBjS7+C5a+pW3JR0a7Jwa/mcPkI1/Gpe48TSVNM3lXac5/FAToEASxWQc/eOkaYSmvcNfq+M6G
	3qf2+CUQTdn5HLPS3tq1J52lPVDaxIkNtZYkj1Y3/dy8gBj2XxskY/Z4XxuG2dUEL3kZw+iXksTm8
	3QdJpaeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3tC-0000000FBV8-0sxN;
	Sun, 23 Aug 2026 08:49:14 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy3t7-0000000FBTG-3Gji
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 08:49:10 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so5240999a12.0
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 01:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787474948; x=1788079748;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a/KwyUz8+jwsvagZHWmoRXIA94Q5mvdjdC35oIGeJJg=;
        b=NVQQXNEhsKtUJ6SLYi1kOqg2Vk0G5kgjB8bDZAfP/ROIakreQvJD2E2Ke1+xbk5tVk
         5BbN9Dhyh1LwXnVDZSnkWcYbIWvCAy1hqS76AlnIJlW6QWXSJAc2UuNkNeYrr7GfVngg
         o5SN3oIr2CL3MFoHAFXt2V1ITSckuPput2z9KHLRmFEAJAM/n9wMr0Tq5jfNEuxQx8Qp
         nk9QZklrIktgYwJ1E2sO+2LLRUI79x36XTNuq6ihKMR4g4AzkDVzkxrvvf/UxbMOvmhM
         7b2iCFMi+oZO8MDnWpxsPZsm3m1egR66NwnW6xSv+nyzMPdfFqFP2HfNtDdnlbmNipb2
         9PlA==
X-Gm-Message-State: AFuF++m7rVJxrubQNyoX2nHAjeCUAUxQDSt45bpRSSwYuYaTjih/KqkJ
	slaHTLrhv3YMAHoptgmug28xAzlbxhp+1KKJZhx7mNo7yzWiC0v87TpdYoJ4gQ==
X-Gm-Gg: AR+sD12I0sXGa47FN8oP/U/1cDmM5keVkKusUiDPL2iOkJYJbaDr1HeQzF4a1YHyWmh
	pbk29v8oGtjxc1Nr/AxNnkTCMC5RFRz/7E0U6JESKxUfaaJKzxLnia/Mo4BC9ITG7Tiz6hR0vcA
	9XsvONjZpaeic4oEfbWp5JtCUAElZyyBBrRksIA+VA4A0o3t9CmtQ6eTEZ/l2wCAI21mtczisiP
	unNz3bkY9qCMiCE+E1sWGV8jnUc21ohH54XZrG6zMLTR8z9yqMm8+pZ2JsW6aGZUvlmT+vjhNyg
	FpqoKaCaLqnshBxpYlwyvKw98cICh2ibODFjQ6wXZJ4teaeOEN63/Vwfe60o5ZWH6t1H2/mQLnN
	Xi3Slm7gaWq/rbYe2PtkcZWY1V+3OmJHmYl5hCdzLOPInfs83wYDAxggauV6dDwfenK9RTE56Ph
	OFvjzaWEEPimnjCXJRYyBLrja5YHDoXJm7PIvymr81HpK3aACt6LnablkRc/V/QRRxfcS/lTYMe
	KjsvFTZ313DweCyy+LMc99eazdMtZUwrPvPszFmwbEamiFbjx+e
X-Received: by 2002:a05:6402:27d2:b0:6a3:ebc7:60b0 with SMTP id 4fb4d7f45d1cf-6a411286605mr20334973a12.3.1787474947688;
        Sun, 23 Aug 2026 01:49:07 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e00129fsm2566761a12.1.2026.08.23.01.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 01:49:07 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/6] nvme-mpath: No need to protect req->bio with requeue_lock
Date: Sun, 23 Aug 2026 11:48:57 +0300
Message-ID: <20260823084903.193188-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260823084903.193188-1-sagi@grimberg.me>
References: <20260823084903.193188-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_014909_821083_044F1C5E 
X-CRM114-Status: UNSURE (   9.64  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

requeue_lock protects the retry_list, no need to hold it while
iterating request bios.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/multipath.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..b5501217303c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -164,9 +164,10 @@ void nvme_failover_req(struct request *req)
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next)
 		bio_set_dev(bio, ns->head->disk->part0);
+
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-- 
2.43.0


