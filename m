Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF4DC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9593260FD7
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 23:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9593260FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XH9wVSoHCSlY12o3QqXdTcxrZLYrDtte+LIls3UHoMs=; b=hexERaZyVhMQHySntZRs6peYor
	Or/Xrvrw8JAAZxPO37s93m92I4JvfaTmX2xN8B2aLHBTLvV456DYc4Ds9ObF/2Ek6pmWft9VAEUAV
	BX7jufCKkUwsk3kbKi8N+Ya2ZKLk0wTWfZgCue1M+h2BME/sX9/2a62cbBi+sVzsjVEdBeciWe+Qf
	MekgTQjeMZTkQIMc76KkXqD+FTfdIONWGy3BXIbaYOXDCmZkEQF1tZeQcL2vacQSV/o185X/SzT/o
	hh5H7SZwN2DS8sB5XLFRLxCOHp9PcPaQt63bBwvTqxFaFfrXEJSfQP0+6dIWj5jx96f6+FIQIma6K
	NAa9lYhQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXBDk-0002q7-CP; Thu, 15 Apr 2021 23:16:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBD0-0002gd-9l
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 23:15:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=; b=q5yxdz2hfEEXMEKD9hdH1CL7z9
 +huBXx2M3FNpRSJ9eEEM/GqK1Q/zx3KINGUgCFE1torx8FDxdEuFxjBqJMij2lcpaPUwrdnBa4yVu
 hIBLYZG05VSMomWdUmiOH3cQ1HLAoQKk2JKWWfZ//EhF7OxbPHRBHq4DoVS4kaaDGtTLi9iaUvE2j
 TQgbEzDBxBnFY79mTlDfFjDBjMKdDxv9tj1xZk7H/PzlfF6X+jpAWV8Ri8jlb6CrLi0Zy/SqvKDQ2
 B4yjMW/qhM+qnXBWNC2amDOwLISP7CxVzJBDA3H9DP2cKGBcUiYUMoKNaOChZYXYkncsTEfN2ZE7k
 BW41eK+g==;
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXBCx-008xv8-OQ
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 23:15:37 +0000
Received: by mail-qv1-xf30.google.com with SMTP id bs7so12094624qvb.12
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
 b=PVZxMAKpqiXZzHl9BvxQp24AQZguptUtV/s7pogFbPpcCHpzTMwNsz4MVcnFxXLRHE
 im2pdKP2a/tlVrydPANj0R7tLy6LWbzS1ixH6wR/+ZBe8EjQ00zD5SQ/Ixwo9k387AG1
 JciNZ5cfTRC/6gcwjJj7adY8VWCWQGXB6dambvdN84bwaBWg4UGP3FflRBxbfIg7IgGl
 LcAyJKk+7P/PawzP2Dk52Y407mQ0hD/hqF0hMIk5PHulscOdODexLXmKovlD1he7tN5p
 XW8a3FTwIJCh5EHvqSqzsadfXhbJNXMe5rAV7D5XNnsR5xJjC6tR++10MpvILvA0tLXx
 Z6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=T/JS0tPFuGx026nisaFi9hJiA3/ZXWO6l+YekczmOw4=;
 b=EbT2c+DNTmw3epIfJiCQdK2Kz31cBz5qnYH+BTxsFdReD/QR66AYoDQJpARNdbiJSq
 U5sALZB3CNNgJNn3mn9otBfv221vbolIRbkllJetUTSsCbGBBF2/N6xBUTgnn2sCx79h
 VMK/eBJgdIeM4PULHo1ku6b7umKhs4HfcQrpnV35vsm2/lRGWrwbdTCwyVcE/JBekCUU
 iVOFs8Lf8Gc+XPva7KtCUukjOjTFC9Q4Repq3ZgIfk6A75Db/Q3qWELd+81Wxt+D23q1
 EDch9AhZqK/wXKN4C3R5dwIhQqMUkblwvtKjO0A7R5LnRyvx4P1FYpumZNqg/V8sPkHq
 WbYA==
X-Gm-Message-State: AOAM532DnH+9V2gLJ5N+7oah8uDa2Qibo95oPkQJOuLB46NfJeE7thSX
 OHLgiqFfG7gjfI+kkdCuo0g=
X-Google-Smtp-Source: ABdhPJypcPvBNABtyi60w7ZSs8nt8uydx8Z2UbVEMidzcXwJJfkUfTv11ayzAABKZ6UGP/UZ2UlWeA==
X-Received: by 2002:ad4:5630:: with SMTP id cb16mr5609781qvb.40.1618528534657; 
 Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id h7sm1656528qka.39.2021.04.15.16.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 16:15:34 -0700 (PDT)
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
Subject: [PATCH v2 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Date: Thu, 15 Apr 2021 19:15:28 -0400
Message-Id: <20210415231530.95464-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210415231530.95464-1-snitzer@redhat.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_161535_816901_F558989D 
X-CRM114-Status: GOOD (  15.72  )
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
