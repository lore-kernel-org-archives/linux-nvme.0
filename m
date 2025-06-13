Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5476C7114A
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:Cc:To:MIME-Version:Date:Message-ID:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bo5nWmy19RyKy1oXr7IHTFWeIrByfn8pX6krGmK9vw4=; b=TgBhO7ROXBQskto0LTRcGx+6/b
	XyTALWazKwTguBVxv2XQJ4WHyb90EWLc41ugdOujEF20BnrG16MuQsbrEpEo/iRM+k1ECvc4B6/MX
	fYySQU94qk9SbQC4I/DY8mGHQi0DcLC6TbHB9YC/HS1JieYZ+c2YdTo8jDs+Aw/gyjjF88xty10aL
	jeVtQqW6AsLY4BXUOGAecCyPAQEiHRVLunUcJCn11OyVxA67hVQkk6d4tC3kGPRErMXVTb0qRV+2I
	cyEVTucIrM16QlP7+aMpSXwYRbl1kmHWVACXFaKHWo0Ogt9LUw5ycJtlK4fi4sjT8NYRHt2pqDeND
	WCmc+nPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQBsN-000000007HK-27dv;
	Fri, 13 Jun 2025 21:23:51 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQBrt-000000007GY-1Cv6
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 21:23:22 +0000
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-86cf9f46b06so83318439f.2
        for <linux-nvme@lists.infradead.org>; Fri, 13 Jun 2025 14:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749849800; x=1750454600; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bo5nWmy19RyKy1oXr7IHTFWeIrByfn8pX6krGmK9vw4=;
        b=QG92RLogCHywNFvMgCL0H/Fv8wx43b9pcJz4gLynRuXSJdLPzRt0DQjYlHQZI7kv2H
         a3NIK4BP5gWqjgR+hphUbjSb9b5Vmejon+n+Jm9rnhRTf+xnMyhr/u2UJundZUo5v/7Q
         HP8mOlHDUY7vxbLiifweesqNMgRJTb3qeJG3e3pg8IOlov90p1bJUI5s/uXNfSfuocHf
         WXRWo6i/TzuTxR3GR9U2fuCRUi2gRQKos3pXh+Q2nIOhKTkhnF4I0RUbLukqCBY3MAt5
         b+qTFzyYmIGIcrSz2yFaT1TzEsHFFcC4rm3I7RSXoVMCLNJwK4U2FjtUA1aokUGwShXo
         lYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749849800; x=1750454600;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bo5nWmy19RyKy1oXr7IHTFWeIrByfn8pX6krGmK9vw4=;
        b=wj+GnTVE+ZmQm0PXwondFrr+tLRmMYklEcu47UuEWQcL/uMoXb+rmTYKEQWw3c+U8A
         GFRBSBz4TI+2sXftbuDMB4SZcqEUn84jRxEIHY44AH2jUJzlYhD8xBY7uEvtegp+7S2I
         Jm8qG4pZ81IT83Uxu3yH3SNzK9hrZWRS/6R7zKu5E2LMvvcjdPevPcRSjJTyETRlcox3
         6jLor6YUVeQb0XZIChTjMDgLlPRq/ISPws5pJvpD4KuociuAsfiJCwGgkznuYkENTuR0
         LqBTaw8C6w5/YgmoXqaBCF33zoO4XJgFpxLnqa0DR5/SgIWpBurmBtszBJvI6VeNx47l
         D4Uw==
X-Gm-Message-State: AOJu0YyinFSjlhFZU3OI6INDnKnnhsxkRLaTaaCbG9M9MxjTErYMOUgW
	vwijPUiF7jsU2Ld9KqbJo7sQyw0qzFUUIIxTLLUqZlYl5S0HQwCw9pE2pbfoX/lpE0o+vA0rjMQ
	zh0ag
X-Gm-Gg: ASbGncuu2PdJzJ0WupRlB1qY5CKincD5sVCubsGxyLROxwEcFFjzeLUbkwVWzUef2jV
	t30EL0TBQVcI6yYTx0QYt0wRDbbCVLJ8S8291QcgWLQrZx31T7PWvMh8u8YwwVYVCZ/p2E5skz9
	BbFAhJbPZzccIOaS4SX3XnfovSkE19s2PMqyKs0fXsYeXVa+jRiKuBiBtCvlNEIrsUZFOMvfctG
	JokTbfm8xnLiNmesVRbch8Ypr8BE7Ld56+pDclXFBnaw3eoTg7GFayODwgO23hH6104Z/Ys7aXG
	i3R6xQAvwjbGV3goCTHwAfiFIB9bpIbcLnyZO/z+jCSGKT1ttaPpIA2mPLrpADhvTN1ANw==
X-Google-Smtp-Source: AGHT+IFBhT8eHGZD0oXN0bYlFE+7M/ElPZ/yu+MPUfc1AWQuBvacW1PdiA0lDGCHAXcZDF9QQiCtcQ==
X-Received: by 2002:a92:cda8:0:b0:3dc:8b29:30b1 with SMTP id e9e14a558f8ab-3de07d50d7amr13004575ab.14.1749849799844;
        Fri, 13 Jun 2025 14:23:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149c859f9sm468379173.114.2025.06.13.14.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 14:23:19 -0700 (PDT)
Message-ID: <3b6f518a-2753-460c-bfd5-ea332323d85c@kernel.dk>
Date: Fri, 13 Jun 2025 15:23:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: always punt polled uring_cmd end_io work to task_work
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_142321_437960_703FB6D0 
X-CRM114-Status: GOOD (  13.18  )
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

Currently NVMe uring_cmd completions will complete locally, if they are
polled. This is done because those completions are always invoked from
task context. And while that is true, there's no guarantee that it's
invoked under the right ring context, or even task. If someone does
NVMe passthrough via multiple threads and with a limited number of
poll queues, then ringA may find completions from ringB. For that case,
completing the request may not be sound.

Always just punt the passthrough completions via task_work, which will
redirect the completion, if needed.

Cc: stable@vger.kernel.org
Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 0b50da2f1175..6b3ac8ae3f34 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -429,21 +429,14 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-	 * For iopoll, complete it directly. Note that using the uring_cmd
-	 * helper for this is safe only because we check blk_rq_is_poll().
-	 * As that returns false if we're NOT on a polled queue, then it's
-	 * safe to use the polled completion helper.
-	 *
-	 * Otherwise, move the completion to task work.
+	 * IOPOLL could potentially complete this request directly, but
+	 * if multiple rings are polling on the same queue, then it's possible
+	 * for one ring to find completions for another ring. Punting the
+	 * completion via task_work will always direct it to the right
+	 * location, rather than potentially complete requests for ringA
+	 * under iopoll invocations from ringB.
 	 */
-	if (blk_rq_is_poll(req)) {
-		if (pdu->bio)
-			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_iopoll_done(ioucmd, pdu->result, pdu->status);
-	} else {
-		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
-	}
-
+	io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	return RQ_END_IO_FREE;
 }
 
-- 
Jens Axboe


