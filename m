Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EF8C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108326124B
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 22:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108326124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XH9wVSoHCSlY12o3QqXdTcxrZLYrDtte+LIls3UHoMs=; b=mshT4JXTddS5AbuxpBi6oYs+U0
	LzIDye5bsqHeqvXEVX5Q9HLzPL6pe3haToLcFRvG+9jLS2MCxcaB4a29XcuhxVYsbY0cRP7g0tbkC
	ff3ceAt0NLp0ZQcLqtmZbdlCHdAN4bqAWD/Xwzjz7HLh9SEsSglkV+fyXQuA89aQy/24yq12IIG0a
	EDD/5NfGzplM8UHICdHLbU6wMl6YghKsUjXLsKINOtd/JBsDGXJhq2SR9x+ps79peFBxvm2Oolr1y
	tazYiDc8JzJL44IQnxOba4empFjcwyFhnsss/9NeGMjJ/Kuna6165e2kd8GEmmzgdtGES5WwpYufz
	+xEI/mgw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXWcd-003XHP-SP; Fri, 16 Apr 2021 22:07:31 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWby-003XBf-4X
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 22:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=; b=WtmujQAsefqTw8HyUyR0vF3EKu
 C50HvsFeg6sizbZnKR+Isg6zeP5aIffDozMben9eL68Y88AsCdnasLG7RMt8jItXUovBuCo/AmcdB
 zV0UcpfaAnjN3RRXwOn0/CNsSTDvdAkcoDO/SF4yWmSfyKVq4dupBzsTqP7wDw4zVpfsCa1oiqeaX
 SjZ4r1yYwT2VCjnY+pYfVsxW3QVAYC4JekF9V1ebrloWakTuSQH9SKzzHQGOQ1n2pUewNbxuQl+sP
 CACYMo5RA15XTeCunbKB/D/BV6V8QrvR5WifNKMc04K4/czcIPbRuWmPDEG0ktXFIbHUTmLZgMXjJ
 fKR4rFPA==;
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXWbq-009jk0-OV
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 22:06:48 +0000
Received: by mail-qt1-x830.google.com with SMTP id t11so13357349qtr.8
 for <linux-nvme@lists.infradead.org>; Fri, 16 Apr 2021 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
 b=A5OY46EW0Bi2mszyQA/M6FH31LsD9a02pRqwcxcfjKCMFnRgWnOWR5QFY7iHAy16zF
 mrcEm/1grade7bnJ1u01dFs4y6Zq8pY1cdA8ILzMDrVnd6Gu35NYl0GQeJw5wkAl42sj
 QX7eo8m30g/d80fPahymTwZgbIZ7eNGjhDslt75qhi2bvq00qh+cCzjFDx7Fh1FeJK64
 iqkc2yH+FPOGqptvoB0JfBA9ZF7/84N193cRbCnFTDr6vH33hQuys4QSq5hlMhm3/YmX
 fEyDAAXY2CWCMrwLrmyt8UHpsAAawgck9LQFdt5rQZfjqtyyjftlyDr3zCVTUIozni1D
 PqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
 b=kgRGFwyZZwQxFB+tX/WVPsesBCjyup88UwCN3YfF5qZkp7kfXE8hlOW8+qq0sNceEE
 Ga3ntN+zn56i4OtBfo8yaSVY7liy38gg6ADBGTe7K9InvBqc+y11rUm6JLwOqJkR4PCb
 LKwcNrz3THIcExIeOWncwOdtkZkZQ/fhqM+7+cBNj8gAsP9/aA8k/8tIsJgmOlxIOyN0
 b8ZECyHm761arIH0QEcNLY/dVe+8dj3OiUhqYVdtBJvssnQcUbheBuK+Yd2VuXy3E7m3
 4fZxbkmpQhwZsBJIQu0vN0VTjvpHLpZ7+AhC0NQWQJB9PLoc5oBZDR0KY2ffi1PFQxuC
 Lduw==
X-Gm-Message-State: AOAM5303h9xplIZQojTSHe2vAQY6b+Q6sXDB6vb3+TFwIqNoR/oFiZgO
 LRMcQ/TuGBF0Z7+BK3RMjg8=
X-Google-Smtp-Source: ABdhPJxyJrj306zuvVTg3nzFruQmMJ8VK2i/9VkWSo3aiQx5V9FJ+qx4C2zKZCnzibF9TMCU9sAExA==
X-Received: by 2002:a05:622a:52:: with SMTP id
 y18mr1219038qtw.216.1618610801550; 
 Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id o62sm5165833qkd.81.2021.04.16.15.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Apr 2021 15:06:41 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v3 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Date: Fri, 16 Apr 2021 18:06:35 -0400
Message-Id: <20210416220637.41111-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210416220637.41111-1-snitzer@redhat.com>
References: <20210416220637.41111-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_150642_821226_6BC64737 
X-CRM114-Status: GOOD (  15.55  )
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

From: Chao Leng <lengchao@huawei.com>

REQ_FAILFAST_TRANSPORT was designed for SCSI, because the SCSI protocol
does not define the local retry mechanism. SCSI implements a fuzzy
local retry mechanism, so REQ_FAILFAST_TRANSPORT is needed to allow
higher-level multipathing software to perform failover/retry.

NVMe is different with SCSI about this. It defines a local retry
mechanism and path error codes, so NVMe should retry local for non
path error. If path related error, whether to retry and how to retry
is still determined by higher-level multipathing's failover.

Unlike SCSI, NVMe shouldn't prevent retry if REQ_FAILFAST_TRANSPORT
because NVMe's local retry is needed -- as is NVMe specific logic to
categorize whether an error is path related.

In this way, the mechanism of NVMe multipath or other multipath are
now equivalent. The mechanism is: non path related error will be
retried locally, path related error is handled by multipath.

Signed-off-by: Chao Leng <lengchao@huawei.com>
[snitzer: edited header for grammar and clarity, also added code comment]
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 540d6fd8ffef..4134cf3c7e48 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -306,7 +306,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if (blk_noretry_request(req) ||
+	/*
+	 * REQ_FAILFAST_TRANSPORT is set by upper layer software that
+	 * handles multipathing. Unlike SCSI, NVMe's error handling was
+	 * specifically designed to handle local retry for non-path errors.
+	 * As such, allow NVMe's local retry mechanism to be used for
+	 * requests marked with REQ_FAILFAST_TRANSPORT.
+	 */
+	if ((req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER)) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
-- 
2.15.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
