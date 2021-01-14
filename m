Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 783F323A50
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 21:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783F323A50
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Le9GZTbrY+cHbskInruF1x73LRQMxcGUTCkw2Hp4K+Q=; b=nPdvkPU+RyRXivIz//76/WWCmO
	DM2yGruqAnmTkMBpUkV1pq26Ocz7QO0hWg8mT4r0QLT/q0ubbBwZ7Yq8K4GT6f5LgItdyobWgNieO
	eAX9uvsYwUuDoPeJfHUCa7qe8fFLB66vrXGDiOV7HUZvB48AMyGuzQq1dZlrm+68UEg2zloEldDHL
	obB7EwziJ3opwpQWEj3h9f3TGpe1ndaYnDXTcHP9VDuiP9xyrSwUu191Yk5QcHCHJqgzEJRh1bzIg
	KhK9e592uQ6kweMXItNfZqRHyQMd7Pc6cDgGI0vQkqdhivnUiL2RN9Yw4LejADWg8qCnEySDPJ4Ed
	fBOXJ2Ng==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l09xx-0004QV-1Y; Thu, 14 Jan 2021 21:15:37 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l09xs-0004Of-4g
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 21:15:32 +0000
Received: by mail-pg1-f171.google.com with SMTP id p18so4601523pgm.11
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 13:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t5jOdIdgyjFqVUYXJM9q0uTTpm0xRJyqMY0ZQh8tWL4=;
 b=YiH2KocxAe3xkiR3ZfbqLyFDBwZm1/4YaXVt7A1EQQbgLuF2p/IQlqVon8eCAtGIVd
 kMYxOCEZWsZLmNsHMPqRgsal4s+g3tC1mXWUHYjHa74qu9/pf4YqyfWaUCISyBIjgXFj
 PA+US85oElE8AQ+TQTUOmNrzdeLpc39G72XYBp1vEH/+OJ7cS4IAHvys7PJbfaOfbbW1
 Nr/NmDT67qWy92X0Hf3jpHmii2s0lzVQBUYrVdwUPN1AXAIWDMpr6R1xeIydmdli3VgS
 QkUJSlIWDEwUwU62MvPM4YnAeA2kcPWw9KMAT/1ae3IVKAynydy9cVb6VXmXrBrQWPOr
 ujkg==
X-Gm-Message-State: AOAM530dOIh9PZzEygt7TuyyLFcSo+UHt/RdJ99z6tzZ6XfKeh4J5rou
 JV2wmmP6ANFVDUHq2BW2GJQ=
X-Google-Smtp-Source: ABdhPJwot5e21AnDV6ZuXEOkSeXguGjotdQiZEkw54VHEcf/1cYGClPCo22/IoKf9WLmsFPIOrA64w==
X-Received: by 2002:a63:c84a:: with SMTP id l10mr9455780pgi.159.1610658930809; 
 Thu, 14 Jan 2021 13:15:30 -0800 (PST)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:9240:50d6:cd00:1b14])
 by smtp.gmail.com with ESMTPSA id s24sm5901165pfh.47.2021.01.14.13.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 13:15:30 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme-tcp: fix wrong setting of request iov_iter
Date: Thu, 14 Jan 2021 13:15:24 -0800
Message-Id: <20210114211526.86946-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114211526.86946-1-sagi@grimberg.me>
References: <20210114211526.86946-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_161532_205371_C74EF839 
X-CRM114-Status: GOOD (  13.78  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

We might set the iov_iter direction wrong, which is
harmless for this use-case, but get it right.
Also this makes the code slightly cleaner.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 216619926563..acf41f50a9dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -982,7 +982,6 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 			req->state = NVME_TCP_SEND_DATA;
 			if (queue->data_digest)
 				crypto_ahash_init(queue->snd_hash);
-			nvme_tcp_init_iter(req, WRITE);
 		} else {
 			nvme_tcp_done_send_req(queue);
 		}
@@ -1015,8 +1014,6 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 		req->state = NVME_TCP_SEND_DATA;
 		if (queue->data_digest)
 			crypto_ahash_init(queue->snd_hash);
-		if (!req->data_sent)
-			nvme_tcp_init_iter(req, WRITE);
 		return 1;
 	}
 	req->offset += ret;
@@ -2262,12 +2259,12 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
+	if (req->curr_bio)
+		nvme_tcp_init_iter(req, rq_data_dir(rq));
 
 	if (rq_data_dir(rq) == WRITE &&
 	    req->data_len <= nvme_tcp_inline_data_size(queue))
 		req->pdu_len = req->data_len;
-	else if (req->curr_bio)
-		nvme_tcp_init_iter(req, READ);
 
 	pdu->hdr.type = nvme_tcp_cmd;
 	pdu->hdr.flags = 0;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
