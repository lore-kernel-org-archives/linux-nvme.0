Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81248C43381
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:20:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116AD64F48
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 09:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116AD64F48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qOg8pR9iBaiuPMqSFdKLGDu7gz/APTq3rUVQDfM7rns=; b=jINXTWs1z1slFZ9Kdmaa7nG09C
	mbL2B7Q9Sn1muwvTW/BzKEnT5//44ZDBL1rRKN24j9AM6qO7/J7g+rdTHvULhBBG0f55Bnxl6CgxH
	nXa9NMBEguwBoNCB5giKQz+AI6vDwXBjllvCkgURyRFNazYo+8O5O/ehUFkpHK1sDkzYLS/jGS/mz
	uG+5vSir+yIna9n2IILUkt5ZdMNiICyqaIpYXGKMFibBcaBz0bgmNQZSrdFlXAdIAY7U0nCTIwery
	sLs+5CYlaJzXbfjqNgCW1kKvWw1Qo8CzepJOEZaBQxuGfkQAiFavzd6h8aQicfCoJEutW6c43pI7s
	HeT1FzGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7EKz-0002vY-SO; Wed, 03 Feb 2021 09:20:37 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7EKu-0002sx-8T
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 09:20:36 +0000
Received: by mail-wm1-f51.google.com with SMTP id y187so4487807wmd.3
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 01:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=6J8DaEmMWji95vUTGij6qst+IjjHSWXXXHjmFMoIbVk=;
 b=Vi6fe8dXH7SdnUzhD/aDbT15c6SPX6Ykc/us/YFI0VhiLpMdmty9KvHNTAGqSlwkjO
 Cw7QEBmImbMEwCqMnTAP21hRfCFFts5N0kbDSgvmts/V4QLnmD3NnrzJ0Ihe7N/WhrtV
 Nq59vFs9JP7RRCN6ijQIb4g9Q5dU3wsgIeSSpEUz8LcAa11spzDm7cY1luv96mEIzyEz
 VFK4+Md0Iyd890kuIQCb+hqt7u7WSc7HT+on97GzqXwatWO2dVLkzEqvYhIRW4+sgqnO
 gFaEPdpptF8DJL3JnSBzKp75xGALzxNVtCqxpU5ccpIZ2oZnjxbADk2ddn3KNSoQf9ou
 EoSA==
X-Gm-Message-State: AOAM5333AU6nI0zBKKnppBukmhWByBl+Iua7NcEqbb0nItey0ETYomYN
 WAGPrmY7MD4PDP4fFlWLdfngwrGbbf8=
X-Google-Smtp-Source: ABdhPJzK+a//E+v83FH9C0eyePM608kRC7ul+99XU/bczMvAMlmAiECvZGVmKagV8ORkMm6aPE7nUQ==
X-Received: by 2002:a05:600c:1911:: with SMTP id
 j17mr1866499wmq.63.1612344031194; 
 Wed, 03 Feb 2021 01:20:31 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:819b:e1e8:19a6:9008])
 by smtp.gmail.com with ESMTPSA id n187sm1868533wmf.29.2021.02.03.01.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 01:20:30 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvmet-tcp: Fix out-of-bounds access when receiving multiple
 h2cdata PDUs
Date: Wed,  3 Feb 2021 01:20:25 -0800
Message-Id: <20210203092025.437839-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_042032_360004_BD28A6E6 
X-CRM114-Status: GOOD (  14.48  )
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

When the host sends multiple h2cdata PDUs, we keep track on
the receive progress and calculate the scatterlist index and
offsets.

The issue is that sg_offset should only be kept for the first
iov entry we map in the iovec as this is the difference between
our cursor and the sg entry offset itself.

In addition, the sg index was calculated wrong because we should
not round up when dividing the command byte offset with PAG_SIZE.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Tested-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..aacf06f0b431 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -305,7 +305,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	length = cmd->pdu_len;
 	cmd->nr_mapped = DIV_ROUND_UP(length, PAGE_SIZE);
 	offset = cmd->rbytes_done;
-	cmd->sg_idx = DIV_ROUND_UP(offset, PAGE_SIZE);
+	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
 	sg = &cmd->req.sg[cmd->sg_idx];
 
@@ -318,6 +318,7 @@ static void nvmet_tcp_map_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 		length -= iov_len;
 		sg = sg_next(sg);
 		iov++;
+		sg_offset = 0;
 	}
 
 	iov_iter_kvec(&cmd->recv_msg.msg_iter, READ, cmd->iov,
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
