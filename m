Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5CC433ED
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 585C461152
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 23:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 585C461152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YfjVv1xbKFl0rxlVCRxMujzq6JqXgx+PTyuyuUzMn9o=; b=CL1mR6SYiF4sV6iVzPWni6ravF
	ipRROYHZ1Tg6XeGP9oi0I0GwLU4fKg/Kvx5qlZJrPRcaqhlmqk+pE53YuXXGNB+aw0oPiyLW6vzH9
	9OqVUM5iA1F8mKXTxTX81DomJVGe6oaw/J3JqWQUSwmazPvC2znevOnGl8uAzQC7D6DGLL1V/RDTG
	1ti7xr1NRHSpEkDapTU4mjpc8RDOBhXvRa/aWghv2K597FoYDfs8uTCQfjaojuE8rVO7gAaqBBT2q
	mLAgOzQGVzifZkjI43Bq5ria5rfDYk0Du1oOpEU23BvjC0qWvxrHFb684TFI2mF3EkT6Hj8DeJq/F
	rKZJ+E0g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXYHa-003m5Y-H4; Fri, 16 Apr 2021 23:53:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHK-003m41-OY
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 23:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=; b=KSoxXXC0awC2LmvoWnHRG0FVA5
 QVAjtRVqxQCN87y0tRPGLdCA9wXBlV6SJi6eSf5EExXAt0xBNGYTx3ThaAFA+h5sAMTwymF7Mwyla
 kIqA/ljOoBkjnOauYVYaZ0gzxvhIhp3nvwXVJaD/foyilIFiDY9Z8HWmidjgg7HokZg4OvbmXc4dN
 bwdHvnkkpNRykQglxPiVd/zYYvxx03bwuXkPx0uDgTYYl97IkV7TQLcQ7NuLXRbNJgQjZ/Tq60Moj
 FQ+3LMwzSsursHiK341v8XipZEBuWMBM9A1X7aIFI4Fg+gyOBB4Gxj3R8WMPyjNEPJYeuUrNErL6n
 P1QBoXxQ==;
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXYHH-009n0i-9m
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 23:53:37 +0000
Received: by mail-qv1-xf34.google.com with SMTP id j3so14300477qvs.1
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
 b=ha/P7mAF80uD2DCWBuD7cEf0koTIbyLMQrHYlG+ZU/QEW4lsNqilMzcDUqE0lS19Vg
 zxbnXv/bKTtHtl5lR31XDYKi+AFVsKgP7z7Z8zAiKlRCsx9qfOv7IaI48Oj9OPXAE2Qd
 ZYR3wqRxDXNi6H9DIfnQwsYzSSW7Spg5gJeSg3jYJJIIMwZLEoohww7jq4Inve6K9JMp
 X9cwoqysjNxzBva5jaH+RKu7XgLa/pmkH4iL8Evwvc9mAsomBSqD28JL5Q+ljnAcrYpd
 a3G5nNNSGci4QPRiPPYZ0F5yGlSQHJH9X8ux9IHZLUqCOCqAOr2Ay+MP182+vsgWGkOf
 F+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=TPYpDSq8Mf6GV23A4rg39jSHse9EX5i3mfgaOsbHzoU=;
 b=UH+bAKwS430xRtI6PqvzvkGN02qb+luyqBGAo5ZSi69SbsyDKRx5hA+XrjxHWpCh9w
 yoGU6S9MLjeeRmfbh1UfuEIwUCscLBizZeLfT3sHcY9iW3x0tiMiHa7grtlKBKGBrhnw
 VWvgBSK3qtFreN1j+k+b89q53Ks8Ev5Uo47FNcdP5CPg5Sig3qq8TP8gxTeXLRER2RGx
 dw43JX1upKICaMWO0j+TE9/Eyu9R4bBVrFYKW/bSrfB+SVRJtntyL90aEeV6TL9Ir2cy
 Ct1akHZvEKnHY0nFIR8oFMJKoSoDOy4y2JrVrL4TF3Smk/cyO+tZLp2WpmSGrwP3t8/p
 XvDg==
X-Gm-Message-State: AOAM532LelU5UPXGUm401/tiuB6l0hj7Cu+0SXr8aIgYr2RS5FJDatzV
 85+injURX+02tgGYB90BvQM=
X-Google-Smtp-Source: ABdhPJwbSaN8dqhGfKHuFj1wuJyFMhfU+pYxWICW3qhsOj3SwzeXkdQVt1y3wjQ6z92Mt6gOTZGp7w==
X-Received: by 2002:a05:6214:1470:: with SMTP id
 c16mr11115642qvy.60.1618617212158; 
 Fri, 16 Apr 2021 16:53:32 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id o23sm5037866qtp.55.2021.04.16.16.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 16:53:31 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/3] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date: Fri, 16 Apr 2021 19:53:27 -0400
Message-Id: <20210416235329.49234-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416235329.49234-1-snitzer@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_165335_346379_04AB87D2 
X-CRM114-Status: GOOD (  17.95  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the DNR bit is set we should not retry the command.

We care about the retryable vs not retryable distinction at the block
layer so propagate the equivalent of the DNR bit by introducing
BLK_STS_DO_NOT_RETRY. Update blk_path_error() to _not_ retry if it
is set.

This change runs with the suggestion made here:
https://lore.kernel.org/linux-nvme/20190813170144.GA10269@lst.de/

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c  | 3 +++
 include/linux/blk_types.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0896e21642be..540d6fd8ffef 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,6 +237,9 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 
 static blk_status_t nvme_error_status(u16 status)
 {
+	if (unlikely(status & NVME_SC_DNR))
+		return BLK_STS_DO_NOT_RETRY;
+
 	switch (status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return BLK_STS_OK;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index db026b6ec15a..1ca724948c56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -142,6 +142,13 @@ typedef u8 __bitwise blk_status_t;
  */
 #define BLK_STS_ZONE_ACTIVE_RESOURCE	((__force blk_status_t)16)
 
+/*
+ * BLK_STS_DO_NOT_RETRY is returned from the driver in the completion path
+ * if the device returns a status indicating that if the same command is
+ * re-submitted it is expected to fail.
+ */
+#define BLK_STS_DO_NOT_RETRY	((__force blk_status_t)17)
+
 /**
  * blk_path_error - returns true if error may be path related
  * @error: status the request was completed with
@@ -157,6 +164,7 @@ typedef u8 __bitwise blk_status_t;
 static inline bool blk_path_error(blk_status_t error)
 {
 	switch (error) {
+	case BLK_STS_DO_NOT_RETRY:
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
