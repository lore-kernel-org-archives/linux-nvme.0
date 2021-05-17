Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3987C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F92D61285
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F92D61285
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P6hg+CvrMW3z6+vDZOSvJDNb45vIHFjGhcKBHpCH+fk=; b=M3VEzcrvcFVf/KJVcvSVYw/zb
	VYIobP6jLkWT8D8mc1q1jyy0YYhPm8Y1aF3OP7drmDxEJwCd/EoLPm7x7tTF7BW5vdIRH+YgcsftD
	9mNN4VOZpcorcuP/hAAy9d89Ad9gzmI+PS7TgquaAOQ1fyB13BDW6ICV3T7Zg9aasPsIIijfxNDIB
	AAh3pIHIdKt2tKCeBz1NgiG7Gh6oShHmyE7+oJChbU7PcsQJDNYmuR0k3v0BusZ4hCHIv9xKfiuP3
	rlsrqhtb5jDXekhjYRiZpastEaVDUgLaoGfeJNbd8ovIf02jnhbBF3/SIBxi4/GAum7TtEQv+HEum
	mCp7LCdgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihXQ-00FjsD-7G; Mon, 17 May 2021 18:00:20 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX8-00FjpV-0q
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=W9LrmHieMFXqimBkJ5BffMpXfsGaUXunLecCAhB18jk=; b=YY2SzBZwsQ3KgGCuYTDd8jrO+6
 F+VzRFpfNK2oWBFLzERYh9OrW4rc40m//yYaiVACMrfuzgZD0XfRBguSmIfbN1bHGhNEOBRVwQ7uC
 y+FrKu6sYm5Iq6aDaIytOyrURhZkrK9HSB8L4JIK9Ju+byHyNrmfR7EMgUJhT0EpKUV3W5vr+jZAC
 6GShowcv2xzFJI2saAxm/657AoxlwIbA159keJyA0L/cPrdLNP5J0hXwKoglG39eux6HKlDf7DyOk
 98algjyifReWr490mkrSZHQ4DXVmc9YTf+AUFeNTkUD7dAibensYS22rDGved3qe77aXncLBDM9aq
 bg7hgVpQ==;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX5-00E2NI-JO
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 18:00:00 +0000
Received: by mail-pf1-f169.google.com with SMTP id k19so5504715pfu.5
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 10:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W9LrmHieMFXqimBkJ5BffMpXfsGaUXunLecCAhB18jk=;
 b=FJzUKX5veI8UDY0DiyJU7gQlVPWNWDlyA+GTHlM0pyDYWmPtbrg/wmCEHft88MgpxZ
 mdp2vMeTRDQXAgyWdzkzLj1TVD5MlObFEoRroPVjw4xE4E06TJ+bShtUMJ7S7AejRO1j
 qap1WNHMrJkBwbpFbBz8Wvib7j/FvW+ZWSOBua9xTgRmEi3mI7GGgH9LkdjN1FRG6BvC
 1E6sYSAb46rIlVEoN9Qa5vMPpS7mDfkywpvTb2/OFuPnP53YJvgsTIiBvZtrEudi4AIb
 2636q+152SYXViHR+ksq7NwbF1OcF4vbAvO11Q4TE+r9fuxFWisGLToStnwftSbUYLqv
 MN7A==
X-Gm-Message-State: AOAM532OGI3C3Lhfi95jCJiV7MKVKG7quKCxTgXTi7mhxhvyCPKXuet4
 A1UPTzqXUSUpRSlGQ3BB2hFqWaMztCo=
X-Google-Smtp-Source: ABdhPJy+jIYYS2qJ77HGHladnwnBksDlMBY5ZKQIkQuWZHI3Ao2sWnq6kyrvDH3Ys+/O+zxS4r6rWw==
X-Received: by 2002:a05:6a00:14d1:b029:2dd:4fff:204 with SMTP id
 w17-20020a056a0014d1b02902dd4fff0204mr816177pfu.46.1621274398584; 
 Mon, 17 May 2021 10:59:58 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id mp21sm97196pjb.50.2021.05.17.10.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 10:59:58 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 1/3] nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu
 data
Date: Mon, 17 May 2021 10:59:53 -0700
Message-Id: <20210517175955.602725-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517175955.602725-1-sagi@grimberg.me>
References: <20210517175955.602725-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_105959_653123_49ED872C 
X-CRM114-Status: GOOD (  10.87  )
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
 drivers/nvme/host/tcp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6bd5b281c818..1d184c06c575 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -699,12 +699,6 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	struct request *rq;
 
 	rq = blk_mq_tag_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	if (!rq) {
-		dev_err(queue->ctrl->ctrl.device,
-			"queue %d tag %#x not found\n",
-			nvme_tcp_queue_id(queue), pdu->command_id);
-		return -ENOENT;
-	}
 	req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
