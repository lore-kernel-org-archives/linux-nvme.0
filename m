Return-Path: <SRS0=8cAR=IF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA20AC433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 14:01:29 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E99650F5
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Mar 2021 14:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E99650F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8n2XHsObwJy6oyPv7txk+cTpiQ9TqhMrmyXfLTf0A/s=; b=ZJeFwISWZ2oC9TzI4kqkUCuxJ
	PdSxIXhXeTuoppuv+J0Am9hg+FQV2KrWADEZgIFGxG7IcsjpmhZbnuyaLAWtW49kMz6BIXImjHDZK
	wbw+UKUqRhK7jYw34CnHBUetmppZ3XuET11MqFjbatkcqmradpDuwVtwgeJ3XOtGtPRIEkjIMRnM7
	3EmYzl3lJhAGUZASv1IeG665hWtcd2AGjRoDK6G+6XTUPc2Y/GoXkoXTpf1p5BuSg7i7Phg1lEYyI
	n3HDFu7nM9f1cgBw8NIWG5cxmtLUhSn9bakg5xM8tziLvKmMqN3KtPvtmv0pHow/ZuhvtlqTtPnU7
	6q4TlJeLA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIty9-00AK3M-In; Sun, 07 Mar 2021 14:01:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lItvL-00AJC4-R1
 for linux-nvme@lists.infradead.org; Sun, 07 Mar 2021 13:58:25 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1A3165101;
 Sun,  7 Mar 2021 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615125502;
 bh=jaUmMwmVYCRnp9svEsc7ZpSLfgL1jERqWvO9zwQYwuw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JsZLcvZsCh0Zhwgp11aeF5Pe00GnmEwtA+YlaV30YTcx2QPMmJegGv854Y32qkywV
 ylcMI0Qsn3rYS87+P3mgsMjXv1G14/ro/scRJKCWrc1AaKa69B98LCHfeYqrWAC6Ep
 QFcJXg7/pm107lmpzaEX1wy9X4B+IVW7XEhc+oWCLg2XCj+o94Xww1zDQmEHzKnCAW
 gwj0MJg+wPge4YOOHmXyf1UxyJZQc8npGNM7szcXc8iMbWL5RLwC10g2ObQmFvpU9h
 2rZqEjUzMLZh7ms/ahlzUXADp0ZmVdDKbD4i3Sv9qRz8yqoRHkx8Gwzr8GWCGX63M9
 tDOUs+8xnZY4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Martin George <marting@netapp.com>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 3/3] nvme-fabrics: fix kato initialization
Date: Sun,  7 Mar 2021 08:58:18 -0500
Message-Id: <20210307135818.967800-3-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307135818.967800-1-sashal@kernel.org>
References: <20210307135818.967800-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210307_135824_183826_6EF7E37F 
X-CRM114-Status: GOOD (  12.46  )
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

From: Martin George <marting@netapp.com>

[ Upstream commit 32feb6de47242e54692eceab52cfae8616aa0518 ]

Currently kato is initialized to NVME_DEFAULT_KATO for both
discovery & i/o controllers. This is a problem specifically
for non-persistent discovery controllers since it always ends
up with a non-zero kato value. Fix this by initializing kato
to zero instead, and ensuring various controllers are assigned
appropriate kato values as follows:

non-persistent controllers  - kato set to zero
persistent controllers      - kato set to NVMF_DEV_DISC_TMO
                              (or any positive int via nvme-cli)
i/o controllers             - kato set to NVME_DEFAULT_KATO
                              (or any positive int via nvme-cli)

Signed-off-by: Martin George <marting@netapp.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 05dd46f98441..e76137a02636 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -623,7 +623,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
 	opts->nr_io_queues = num_online_cpus();
 	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
-	opts->kato = NVME_DEFAULT_KATO;
+	opts->kato = 0;
 	opts->duplicate_connect = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
@@ -828,6 +828,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		opts->kato = 0;
 		opts->nr_io_queues = 0;
 		opts->duplicate_connect = true;
+	} else {
+		if (!opts->kato)
+			opts->kato = NVME_DEFAULT_KATO;
 	}
 	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
