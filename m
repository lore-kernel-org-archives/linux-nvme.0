Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDE6C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B2B61103
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B2B61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ljpF3Rd37zqQ9q+Es3M3MmWawBKwkTlDJQk7DVaiiJw=; b=g5Lu9ZueDXcmjDkVp+9E6109MS
	Z9d9rTP71IIoKUqdm+P3y8N7heMq39prCFf6WZ2p5U4UB7rlNWJ9ZZBd3PyUCuQjfBGumvwBhafIK
	iPrvxz0z1id4qcILc5UHBH94PWXltF6HDTvJZD/FiOch/DRHD59lKaLSJXePfljXV53QE34TPkfhr
	pkyA3GKzP6lFK6GBYUMQa45+4Dh6a1ZzUaZLSGY8nHndJylby+N7lG30csTbO0LJ+pmzzAKCJqrwq
	7nQy3ktHqV2PVU8SpJc+FLmJJkFJUXvby5+hMSdYJeYQHPLqtpjFD8wDQ8FtXTfLV4LQHk4+q+tV3
	ta++rfqQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBDN-0002km-Mb; Thu, 15 Apr 2021 23:16:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCz-0002gB-6n
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:15:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0e+GUnuCpe8QCvStaw0mUR7nWzw75w2F948YZAEt28Q=; b=nDywm6+NJMNepLrkTfY8Cjtf9q
 ycjSKRTqn0ZO5A/t7WXPYF5YIGQovUnHXTAU8Pa9YIfAdguD7wF5L82N+VVGQ5tkYjgH11Ou4R2YP
 Dfn+mIYSbQizYIwT1cPzJySaHtcA2OMbKXn05qEkcVUAn+DqFHb0r4KQ2Z3DERjs4zKPRMHOR+EPL
 q3o0tRLLGnXavUcmQ7tslvXqOk6wA/wQygSL4sDgNr7kOyJbKkVxTp20OsTqvdR+ptdjcGK1c/0HD
 yC+t/Hhq09EKCQ0Zh4QZuVxPaU/Plm1CgsDSG5ce8rw8YXL4Yq8uslEqwkV+9jEOlbRwwTD/WX8xZ
 im/YC5RA==;
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCw-008xuc-Fl
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:15:35 +0000
Received: by mail-qk1-x734.google.com with SMTP id o17so18607612qkl.13
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0e+GUnuCpe8QCvStaw0mUR7nWzw75w2F948YZAEt28Q=;
 b=gpzaqMNTFlFilz2e3S5iD/m2OFN8Lm8z7jY1WAdGZPLXGTkFBuxo9V0fj8MwWesr7h
 3ZPtRchAXubkQeYXwGu90Ic8J6XaMy/00CP3Q7vnlOfP0yCEGguCX2hvktmCO1jl031p
 6lEHBiKMIqWojpylJ/7+1Ct8NM0am+lnWE7p0XD84VHrxT3Z7ql5GETkkCVYNWxIU6H/
 VoCOnVTv4fcuxnboKsXk0sUm1mW8j0JWHRDVKg981Q/bDwK7aoaBg4JOhnTuaYMJgS/J
 6a9HUewDk7G1lqS2bjy83ZBkBNPBZFZKVv7VDSZj61bjKABqRfsY8AIbLFYxrqnng86B
 0l/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=0e+GUnuCpe8QCvStaw0mUR7nWzw75w2F948YZAEt28Q=;
 b=kS9kzfnLxf7dP6SPCC7B9eimplFdhFmMqejGLLuUVpomAXDd+JrrKt9t/+YSAcKnkw
 foWRZ0C2AMHGNwokkcBem1bVLwodnOHiSrWHCCJq3CLvOGC3Ev+nRCAxS5w8DuHDfwcA
 Eg5/utBn+4o0Q5UVdHi9epNRJfn2j6/LorAk4oXHQ+l/bFuGsiRp/0itDpchtN7bZgep
 tt7aiWg9FidKq6Gs8+DNwT9dOXAQQEo4+VNjpVP8rcx5Hvr/mItXKhulLgt66eHiHXmr
 TcuziBWbfxay3t9sZEnuEOTOeY2kq8phXGuSP7vUI3wJsGq3Cu7ATcJN9Eiy/aKhHwvZ
 7sQA==
X-Gm-Message-State: AOAM530LbOyGOK2YlMpLVaWay/voYorap5ZsEjsOmFFyAMhURyOGKcTx
 EKz7vwAunqWZSQSAc3U1xpE=
X-Google-Smtp-Source: ABdhPJyItbrqK2zs8RtBIkzXLNW5V+kFE3mMQiJR8+zeLyi/3FrV8WPxvWweLdOctd9XT9tRHGx3wA==
X-Received: by 2002:a37:a104:: with SMTP id k4mr3716326qke.149.1618528533257; 
 Thu, 15 Apr 2021 16:15:33 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id d62sm3100679qkg.55.2021.04.15.16.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 16:15:32 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/4] nvme: return BLK_STS_DO_NOT_RETRY if the DNR bit is set
Date: Thu, 15 Apr 2021 19:15:27 -0400
Message-Id: <20210415231530.95464-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161534_542927_29B6A6D9 
X-CRM114-Status: GOOD (  18.27  )
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
