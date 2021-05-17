Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9285BC43460
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 21:08:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFA8611CC
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 21:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFA8611CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rJHI66SnFnJckn7YPbGib6NXrvKxSHJ6IvTPr/XAO6g=; b=XkEF9O+fXSaGhdvC9J2+c+mnmz
	CRjjyfMuNSX1+3xd2VHfZBTvACi3I13MmbX0cI+k8TdSjqs2eM9vYYHkFZB6iR5p2K2QEjgr2WMEy
	kwRTDeciOH9BBHO4X2Dg/7vXqAYjA0xoJ2uj/BmlgLGOvezCnMfspUbrOXGpZpcvPKAHIDKPptQCZ
	/mGg/zTjjeJc1UIvO63m19Eq/JQEfjwHbKf2bHX9cUWJfFqlE8dyIs7GYuimQdTk1g+sUbgh1BsB2
	697xPUePLCXerH83GgAOD4ocPaU3RkrCmzDTxOYiJnIHLI/L6KxXR77Q/ClBvqZj857TerxaVnS2s
	cQEf8d+w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1likSw-00GAhV-Dm; Mon, 17 May 2021 21:07:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1likSs-00GAh1-S6
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 21:07:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=kWY8XEOI7xeDzVBmhaOwyaafvzZW9hWvjL+x4k9S4Hw=; b=BgvW17ALaOZPR4t9TrV3XsQhWM
 K4CYqkBNJkKYlqDN4g2zka0oBLppuvnlq0N39/5odUW2YSxxejYb0TYMwUSZAeOmq2CjKy9kKQy38
 Xf8xfvxph60UJVklAZc5ujph4hZuV9QTzNnku/lCP6qZ737wmNriWgcDb7RdEOsQtrj20kL56v5+5
 g/yjV+0w/YVCBEzfupAjXKdTOsH9pkAJrPt2qN2wTnWiHYpNx3DepolZV+XfJMDVINY84wmVjA2d1
 beYkuvy/VYfjFbfTGxHFaH+CNbf6UFMLpW0IaODGL/lvCO2Kr9JYnjqeDEW5PhIYTTlZVRqiEZNJq
 j0wou1ww==;
Received: from mail-pj1-f51.google.com ([209.85.216.51])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1likSq-00E9UG-5A
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 21:07:49 +0000
Received: by mail-pj1-f51.google.com with SMTP id
 j6-20020a17090adc86b02900cbfe6f2c96so356740pjv.1
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 14:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kWY8XEOI7xeDzVBmhaOwyaafvzZW9hWvjL+x4k9S4Hw=;
 b=pOYipG6aZAjRk4FtjpqVrVNp0QPsn0wmsmnvVhKcFpzNmr5Jn4/msQv86msD2e69TU
 aOY3nLHwueQuQaw4IK1/FFPuyQoNEbi4zWLo1Vu+M9UqEe1kGzZx35MlBXWO4lTAKU1B
 jRjylIg2jMcLFmzMtC922QMIrt/kI+CG6qQ3nxmE4y3vKw4XqQ2K1QMN7MLdCcSmTubx
 KYmwJAoEju5IHnVXm4pVM2Mjup6coeN4ejGhaVSLd7t4GRA4vnsjed/H5CZaptOcyhjU
 Xmjs+RpXo3LJr1xakeu4qv4A5PECt5BIiId0B/Yr4DwnwpKku/rUJoN8ODfUncGx6uvF
 YmJQ==
X-Gm-Message-State: AOAM532/WHNS0QvVd0xXBXOexCO2OByx2POK7Wc+cwubo34OhgvlZNSl
 rj8ozcS125KynIHEC+DSWWgJ/TYg9Vc=
X-Google-Smtp-Source: ABdhPJxbzRVilxt2XlGPL3F8bQq9Fc55HF94sqrfRs+88shI6Y8vXvGk7kQgSsG7iHJc/7i5fuyI5Q==
X-Received: by 2002:a17:90a:5b06:: with SMTP id
 o6mr1420991pji.125.1621285666951; 
 Mon, 17 May 2021 14:07:46 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id c15sm10747769pfo.176.2021.05.17.14.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 14:07:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Narayan Ayalasomayajula <narayan.ayalasomayajula@wdc.com>
Subject: [PATCH] nvme-tcp: Fix possible use-after-completion
Date: Mon, 17 May 2021 14:07:45 -0700
Message-Id: <20210517210745.634778-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_140748_223303_25938BFF 
X-CRM114-Status: GOOD (  19.37  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Commit db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq
context") added a second context that may perform a network send.
This means that now RX and TX are not serialized in nvme_tcp_io_work
and can run concurrently.

While there is correct mutual exclusion in the TX path (where
the send_mutex protect the queue socket send activity) RX activity,
and more specifically request completion may run concurrently.

This means we must guarantee that any mutation of the request state
related to its lifetime, bytes sent must not be accessed when a completion
may have possibly arrived back (and processed).

The race may trigger when a request completion arrives, processed
_and_ reused as a fresh new request, exactly in the (relatively short)
window between the last data payload sent and before the request iov_iter
is advanced.

Consider the following race:
1. 16K write request is queued
2. The nvme command and the data is sent to the controller (in-capsule
   or solicited by r2t)
3. After the last payload is sent but before the req.iter is advanced,
   the controller sends back a completion.
4. The completion is processed, the request is completed, and reused
   to transfer a new request (write or read)
5. The new request is queued, and the driver reset the request parameters
   (nvme_tcp_setup_cmd_pdu).
6. Now context in (2) resumes execution and advances the req.iter

==> use-after-completion as this is already a new request.

Fix this by making sure the request is not advanced after the last
data payload send, knowing that a completion may have arrived already.

An alternative solution would have been to delay the request completion
or state change waiting for reference counting on the TX path, but besides
adding atomic operations to the hot-path, it may present challenges in
multi-stage R2T scenarios where a r2t handler needs to be deferred to
an async execution.

Reported-by: Narayan Ayalasomayajula <narayan.ayalasomayajula@wdc.com>
Tested-by: Anil Mishra <anil.mishra@wdc.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Cc: stable@vger.kernel.org # v5.8+
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e6bd74cabc6d..00284bbb3bed 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -930,7 +930,6 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		if (ret <= 0)
 			return ret;
 
-		nvme_tcp_advance_req(req, ret);
 		if (queue->data_digest)
 			nvme_tcp_ddgst_update(queue->snd_hash, page,
 					offset, ret);
@@ -947,6 +946,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 			}
 			return 1;
 		}
+		nvme_tcp_advance_req(req, ret);
 	}
 	return -EAGAIN;
 }
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
