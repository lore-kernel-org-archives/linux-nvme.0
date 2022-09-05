Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677D1ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 17:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I8Q0C7Vb0Guo5Mn6EMEYgVv2l3TETtNqiz3fWAmCjXY=; b=xNQAS8XsMxZTpat/crbdWzEQcB
	ZdCZOJ27kmXBsDpCrJpwuR+9LvDf1bXgRfjascbOB8g4/CZjSyMhfHpW+TR6LUqsFTHSCoa4Hftpm
	iZxGVcxCGNL9FOrN/lO/BYc85Q13uMET88BK/SnpjavK5O5VhMhVHul4PcBFqtzCpJfsVuNutIXWX
	PomKIt7140gE7QlniGRXLSSM1DpETVpOsruciZ23G1MRHPRlU+bd0tRqb73RWhLvFDJ0LzxcxScdX
	bJaT64lgCGiSKe7mWeyGFQkPd3LLmQTgTGrSQ3KUzCJgx5YkPOFhunC9h51vJFPlknRvKqb2S+Kfw
	0+CaIiqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFph-007VKC-B3; Mon, 05 Sep 2022 17:24:25 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDgt-005TL0-Hl
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 15:07:25 +0000
Received: by mail-wr1-f52.google.com with SMTP id w5so11718969wrn.12
        for <linux-nvme@lists.infradead.org>; Mon, 05 Sep 2022 08:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=I8Q0C7Vb0Guo5Mn6EMEYgVv2l3TETtNqiz3fWAmCjXY=;
        b=wLRfFNTRpk9zw8pXwRcGgy/c8USDkP8UxzJ3OqfYGF9mZjqn/JwxH2qoSQoy8vMruu
         rQfuQivGrqJUYrUXrECrmPifH6tfdeFGfeHIc5+dib6iSXBmuntIMniqJKqSq+A85oui
         7hadOAyeNZcw/oeQi6TT/EKNHideCfiefe/vP6OksJpoDasY0RLl/dODM/kD+dhRfMNO
         zcX0AhlBdpBX89ibzvAzZrvni1RxkuD+GNTw69LPMpw6vr88p81vWOJii2kjOEfl9FLG
         pCAxkeFKhXySRc3ycQxcjBs8iWY8W2wUvT5XbpJUPcMFYbdAPCMSlDYV9LOPdlRVuecP
         RIiQ==
X-Gm-Message-State: ACgBeo03HTckLgE5gOHBNEvYcLqOGE4xh1qcvFjg5kFVW9t/ADET709p
	qc7G3CWk+E8PtsQBNFDmFo3G5M+rdGs=
X-Google-Smtp-Source: AA6agR6e5FyEeTCSOfPSK3UsIjFVl01M1Oditm9cRog7kWAZeXh4rlyE+cW2tCMP9r1AcIFBneNWAQ==
X-Received: by 2002:a5d:6301:0:b0:226:d87b:b55c with SMTP id i1-20020a5d6301000000b00226d87bb55cmr20916793wru.560.1662390428607;
        Mon, 05 Sep 2022 08:07:08 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003a502c23f2asm18625211wmq.16.2022.09.05.08.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 08:07:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: [PATCH] nvme-tcp: Fix regression that causes sporadic requests to time out
Date: Mon,  5 Sep 2022 18:07:06 +0300
Message-Id: <20220905150706.1529358-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_080723_502510_9F39F751 
X-CRM114-Status: GOOD (  14.94  )
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

When we queue requests, we strive to batch as much as possible and also
signal the network stack that more data is about to be sent over a socket
with MSG_SENDPAGE_NOTLAST. This flag looks at the pending requests queued
as well as queue->more_requests that is derived from the block layer
last-in-batch indication.

We set more_request=true when we flush the request directly from .queue_rq
submission context (in nvme_tcp_send_all), however this is wrongly
assuming that no other requests may be queued during the execution of
nvme_tcp_send_all.

Due to this, a race condition may happen where:
1. request X is queued as !last-in-batch
2. request X submission context calls nvme_tcp_send_all directly
3. nvme_tcp_send_all is preempted and schedules to a different cpu
4. request Y is queued as last-in-batch
5. nvme_tcp_send_all context sends request X+Y, however signals for
both MSG_SENDPAGE_NOTLAST because queue->more_requests=true.
==> none of the requests is pushed down to the wire as the network
stack is waiting for more data, both requests timeout.

To fix this, we eliminate queue->more_requests and only rely on
the queue req_list and send_list to be not-empty.

Fixes: 122e5b9f3d37 ("nvme-tcp: optimize network stack with setting msg
flags according to batch size")
Reported-by: Jonathan Nicklin <jnicklin@blockbridge.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 54b4e8a7fe42..d5871fd6f769 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -121,7 +121,6 @@ struct nvme_tcp_queue {
 	struct mutex		send_mutex;
 	struct llist_head	req_list;
 	struct list_head	send_list;
-	bool			more_requests;
 
 	/* recv state */
 	void			*pdu;
@@ -320,7 +319,7 @@ static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
 {
 	return !list_empty(&queue->send_list) ||
-		!llist_empty(&queue->req_list) || queue->more_requests;
+		!llist_empty(&queue->req_list);
 }
 
 static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
@@ -339,9 +338,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
 	 */
 	if (queue->io_cpu == raw_smp_processor_id() &&
 	    sync && empty && mutex_trylock(&queue->send_mutex)) {
-		queue->more_requests = !last;
 		nvme_tcp_send_all(queue);
-		queue->more_requests = false;
 		mutex_unlock(&queue->send_mutex);
 	}
 
-- 
2.34.1


