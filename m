Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86236C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 20:54:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2595664F0F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 20:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595664F0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EGnzGiBnZvAOf8XaMr747Wmq8TS9sH6ejCymsg85a8c=; b=CCz5pylFMLMt5t
	Fwc2gCG4Uqcph/hmeh0MRTTIDFNoN6+xqbAkIXXFt+Pk7DA+x/m29RjOLcCeeUN8QEkhy4y3VRNK1
	OqbBvb1n7zv8qFG53SJMyf3lwrLbYl0yZ/TXWxiP7gUgWpFxu+TkzmAkvIvFytHKT4mTRzazf/jBc
	JgF9Oj09hzWCdleZZWSLc40Wvc53B3AwuV4+K1KPGPpOBZdjI2ofzEsRg+UqcNiO2kQdtAZnSFLL6
	pm81oDOD+fFSnmFLU23z+EDBEcHTsRR4Cj69cmp72J4CxeHzIVGu7fVgsuPC2JtNdyL5ByCM8Puj3
	1jt3rtVGs/IztkGOUISw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLuDz-00GsU3-S7; Mon, 15 Mar 2021 20:54:03 +0000
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLuDm-00GsS5-Om
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 20:53:54 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 k23-20020a17090a5917b02901043e35ad4aso151856pji.3
 for <linux-nvme@lists.infradead.org>; Mon, 15 Mar 2021 13:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=as/WKlNSoG/8s/gpwvCuxHXdZ7v7PuzkdDIlse8VQ44=;
 b=VEMYXI1OPu+i4AsQaJciPmJ8stIaJ1MJnF56Vy6BYBYX0000o/sXDH9nPVKx60sTjq
 FM9etSfkR2/2zeHKdJRTrHBpSrZEby9VlYgHeNRppaGwiD4UWZ9MuSlUmGoTi8YELHGl
 OdC3pQ30im16mBwwLCK9CqRGoaE5m+cGwNT3nKdZvy9f+Hdw8Jee4maQ2msXFCQ4Bzg5
 y6bBrjycaSSQ7avpAe44iQVh0AFp+o63RX+qzBVKlzl8XiOpmP4fHRPylVmQBhl2Idm4
 JVF1K1Vt4kcyu40i6+DLlnmJWnlLbL7oWCCHw0JGoHUQ9vK4PS4zJTvhZK0y9FZ9k7Pe
 8R3Q==
X-Gm-Message-State: AOAM532RzX0qkIVfizNUqz3az3ih6TD0JCWBBB8QAOYKpN4M7ObnAc+x
 TDgn331uD4Ex0GLSkAa85ZKW3Oo+aNU=
X-Google-Smtp-Source: ABdhPJyTxCeHvls8cJzXQBtkwNBlGbvKFjjzjNj5oUE9RUEFvhLd7iEj/oHqTkYivoxsluNVr0n39g==
X-Received: by 2002:a17:90b:20c:: with SMTP id
 fy12mr986035pjb.41.1615841629073; 
 Mon, 15 Mar 2021 13:53:49 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:4faf:1598:b15b:7e86])
 by smtp.gmail.com with ESMTPSA id bb24sm528117pjb.5.2021.03.15.13.53.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 13:53:48 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: Fix misuse of __smp_processor_id with preemption
 enabled
Date: Mon, 15 Mar 2021 13:53:47 -0700
Message-Id: <20210315205347.353806-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_205350_980863_8F272B2D 
X-CRM114-Status: GOOD (  13.76  )
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

For our pure advisory use-case, we only rely on this call as a hint
so fix the warning complaints of using the smp_processor_id variants
with preemption enabled.

Fixes: db5ad6b7f8cd ("nvme-tcp: try to send request in queue_rq context")
Fixes: ada831772188 ("nvme-tcp: Fix warning with CONFIG_DEBUG_PREEMPT")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bd931de44d6c..0ef72568a4dd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -287,7 +287,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 * directly, otherwise queue io_work. Also, only do that if we
 	 * are on the same cpu, so we don't introduce contention.
 	 */
-	if (queue->io_cpu == __smp_processor_id() &&
+	if (queue->io_cpu == raw_smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
 		queue->more_requests = !last;
 		nvme_tcp_send_all(queue);
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
