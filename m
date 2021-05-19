Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3789C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA4E61007
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 17:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA4E61007
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DCk2faEj0pdkQsBSklf1jtUX7CTjjw23SbYEYK3RFpg=; b=ifBGIaj1EmANkWSAHHZv27SS7
	4WcsUcz1oQVxGBQBnrIByQPBj1aFcbfC0UHNgSyr42y/Y40orgRe4gVF3ZIL4f8NvAyKdk4Of7ago
	VK6PKUh6HPHk8JOqKwA2ggHvqaGstswKTddWLzr2FHbItMYVJOnX825+XmaEJHAwK2wRuENwCGiQS
	d3wId/BqjtYmpmNPYXyLGiyzWW+n2g+XNKWoNY0p19Ay8rgbNhCDi1insV8sIrA+HOUl/5fFIZoQA
	iMYqd1+M4JN5Ch/p6BpnXskByDDtsKpG0Q38twlICAvfIT2HMNVX3CPBJYR0PbfRr2txW45bHqxju
	VkGckYbSQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljQF7-004gLt-Ms; Wed, 19 May 2021 17:44:25 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEY-004gBT-FY
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 17:43:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=4WYw/7NVn/OVhyqxrr7s8TwdLKt45chuA/gQEgk1zRM=; b=tKxNZcwcx9wYdE/9A4NfhQd9GF
 +gLSGK2MNTrr5yGq8MfZHu8L9GkyTUpNuaRLsSYgMyqQAO18WZyKQ3ClzkTMzo9PwPVkGZ1VZY4mO
 EI9uBiTa6uCvY8FA3Tv2xpsp0hcmt1D3/07H5ZcqTIi5iHQkJezz2lg/jhLP3dARn/4yfhwgeisoE
 ggtayclC5ral9+Q3+cbYHvh8caakHEFBbM+BgMo0sEuaCgzD5fmuntY9WGVQjC32RQB8wFqdKBJvT
 Jg8AIBY3ewHOslDTuKDoxLyERe3vaLWpKJ04T+c66D8IT3ATVLLJ4Ipvw+dtMePidafX9Y8UxfWbU
 9EwHjyHQ==;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljQEW-00FfTh-3U
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 17:43:49 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 cu11-20020a17090afa8bb029015d5d5d2175so3921159pjb.3
 for <linux-nvme@lists.infradead.org>; Wed, 19 May 2021 10:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4WYw/7NVn/OVhyqxrr7s8TwdLKt45chuA/gQEgk1zRM=;
 b=DKSW2oG8acpwKSIXS9XehtiTEgbiVCY8ItSY1Ve0PJX/mDFxjNXF/s5cwjXZhpTQ/N
 s7s7O4YadQLejco5wRmHM12SVeD1FtvmyyILmij80Ayr56XIqUN7R5jTAlvoozGXGLC2
 77glbPM8fz2CrfP62cOxL+3Pz9auua13qCW3czEU1ihTbrqgvSJYpjW7V3fVMQ6Z14n/
 gecLQHEjsb0+A3hYCCqxgqNOB23U45PV9B3KugkS+c/4jFQaJ7MllFdtD3rZSATUPZpu
 KOg3a1XBHrSQ9p+SIL55J9kAiJsgV7RZPPXH+pIy3X0pCTC/29MIKpky2i9ZiW1OYQlj
 72Sg==
X-Gm-Message-State: AOAM530C3H5hUIBesorwYUlGUasw7kJwbB0x5TvGY3ODXliXq+HTtLSW
 oG12+Wl7Ob91S8KjoBlFFcmMo8H33gg=
X-Google-Smtp-Source: ABdhPJwcveh2T7spJ0GZX8uGrQtAVggZ1bgvPqQC+nzyjtQw+79tT2f7jbEThyY4fNYF7w7LTP8qFw==
X-Received: by 2002:a17:90a:d193:: with SMTP id
 fu19mr109164pjb.103.1621446226787; 
 Wed, 19 May 2021 10:43:46 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:a498:37ce:5a01:2259])
 by smtp.gmail.com with ESMTPSA id l10sm46639pfc.125.2021.05.19.10.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 May 2021 10:43:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/4] nvme-tcp: don't check blk_mq_tag_to_rq when receiving
 pdu data
Date: Wed, 19 May 2021 10:43:39 -0700
Message-Id: <20210519174340.1144806-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519174340.1144806-1-sagi@grimberg.me>
References: <20210519174340.1144806-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_104348_161066_1E9751F6 
X-CRM114-Status: GOOD (  13.56  )
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

We already validate it when receiving the c2hdata pdu header
and this is not changing so this is a redundant check.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6bd5b281c818..e189715ceca7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -695,17 +695,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
-	struct nvme_tcp_request *req;
-	struct request *rq;
-
-	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
-		return -ENOENT;
-	}
-	req = blk_mq_rq_to_pdu(rq);
+	struct request *rq =
+		blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
 		int recv_len, ret;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
