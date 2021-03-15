Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7ABC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:08:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0E9164F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 21:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0E9164F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6pedXlNiGrhvFqV7RBKtsahjobCJR/56s9orYKCP2Mo=; b=YfhNx086IEKVkV
	K/hrKZJYKcnphj7N6Epj0wWW1HU7+Qqty+IKZfnTU4BGhnM9FduY2Ng+94lh4RpllhzPiAM7fLwbT
	ta0godp69h7aIZFSgMKqlYN1kyE3GEQpIkRlZ7gRDhHRtq13i3UePFPyyCyo7xkaO2FZDIPbhVtnd
	YYwqIqi0T8fzueH62VhUwYW/XMPkJvnUzNJUTVTQrmm/5A2CuThjEwJ6b42tkJmxgNCFu/ZY+NQFM
	d8668wjT9FziQ3I3GRa24WPWe4dK1IhfDgNw9PK0FVKekFz43pqZdvNVxcqvPJBzwvVpSfp9y5ckZ
	YmPDvZeEXkT3frju0L2w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuRn-00Gu5E-Tp; Mon, 15 Mar 2021 21:08:20 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuRi-00Gu4l-Gj
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 21:08:16 +0000
Received: by mail-pj1-f43.google.com with SMTP id t18so9475502pjs.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 14:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMuGJerBz0cDq2LmVN0R03xw+Z+L8ejyitj2QTMbtMI=;
 b=qucnZOQn1vS7AHgq7FqrquJtTtMoAK7A6rbwQIxFOztXi6+5T06m66Prsy0QO48FbP
 5v/oSzwumK/iEd3WcrU1KSrSj2Ki0buba0XR8OrvcEOLGfxWdH6QYg2/ybFR2kwJX3df
 7a9gabDFfe+9AyNFTLHciWbH+p33MaTos3/GXb1GAnbEPqQ5XqbePLRYGhr/6w/46Blw
 QmgvexW/6Qll4kX0hAQiOoZEjqSp9bY/DVuFa2ZWXER6u2XW0LACqpCP3qd3MBimv250
 PcwIqTEuw9M/ZwXPJ4ko/HAoQIQORf1Bacf1V93xIe4gGuvPL8vocnALtorPPnE/o8bp
 sxSA==
X-Gm-Message-State: AOAM530pz9EOFyvVp7TjS5LK7tYnjqfr1TgStJ4T45QI0LkrqRePWLmE
 gmXNG2KD6SOkuGjV/OZg9oqV23Nm660=
X-Google-Smtp-Source: ABdhPJzzQk1VTSIE22LZSXmF5edKTb7hPxnD6u3vSnaEUml672FPF76SgWMeDoP3nBru8j/64xyFqA==
X-Received: by 2002:a17:902:a707:b029:e6:52fd:a14d with SMTP id
 w7-20020a170902a707b02900e652fda14dmr14055960plq.34.1615842492848; 
 Mon, 15 Mar 2021 14:08:12 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id 11sm4781552pfn.146.2021.03.15.14.08.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 14:08:12 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvme-tcp: Fix a NULL deref when receiving a 0-length r2t PDU
Date: Mon, 15 Mar 2021 14:08:11 -0700
Message-Id: <20210315210811.359217-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_210814_992847_6E6EC86F 
X-CRM114-Status: GOOD (  11.52  )
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

When the controller sends us a 0-length r2t PDU we should not attempt
to try to set up a h2cdata PDU but rather conclude that this is a buggy
controller (forward progress is not possible) and simply fail it
immediately.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Reported-by: Belanger, Martin <Martin.Belanger@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 18749090b926..850816b8b077 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -568,6 +568,13 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	req->pdu_len = le32_to_cpu(pdu->r2t_length);
 	req->pdu_sent = 0;
 
+	if (unlikely(!req->pdu_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len is %u, probably a bug...\n",
+			rq->tag, req->pdu_len);
+		return -EPROTO;
+	}
+
 	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
