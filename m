Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93894C6FD1C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 22:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnSxla/0BEH6PZuoWbjHSNazWXOTRsx5Q63TW+ixvLo=; b=kvMJe4BhHh5WAWz8pKYVGRixAQ
	/ziRD4/dyWG9iAvcApYKlVLShL8QY59mqeu3o8UowGWyeh/kaIog+9AOSbQcftNZ6xoqSUawv4hxw
	wzgNcTmKXja/05gaPXse5akhDAlox07hA7ATEzE1hGJm07uiIo3EogRLbcQVHPZlp0b5hyqnOnGUF
	s23qP7OEQjXEHnFIQ2NEceZvOpSKZBNkIe0voMJXplrZun2fz23mG6ZQ9gs3vj9Kp4dfjD/z0cXcn
	yUY1LkCX2M5VDfM/kboztQh/FofOV0PC7STQmTavuGapBaxceYmQguRhXEVgUrNxAybRtexDtOPOY
	HD7X0F1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peNjf-00AbSn-33;
	Mon, 20 Mar 2023 22:12:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peNjc-00AbRt-2B
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 22:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679350326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EnSxla/0BEH6PZuoWbjHSNazWXOTRsx5Q63TW+ixvLo=;
	b=cCf6ZtL7x+wBzplop7oYB5svFZB3E9x8rFeH24dF33LrACtCLqRKRZCM50z63cM9KEIgEu
	JXOiknGYtiYQBd3b676vSWTT5FSLZL8DepSV/aeGHtpju2VZ8gnSydOSOhMa16Go6ztTis
	uHXzoKzayX7qXjLxQ/HBcVQIU0cZFAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-3WD4uND2MsG5mcCukzaFuA-1; Mon, 20 Mar 2023 18:10:28 -0400
X-MC-Unique: 3WD4uND2MsG5mcCukzaFuA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5022858F09;
	Mon, 20 Mar 2023 22:10:27 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.204])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 32E402166B29;
	Mon, 20 Mar 2023 22:10:26 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH 1/1] nvme-tcp: fence TCP socket on transport error
Date: Mon, 20 Mar 2023 15:09:47 -0700
Message-Id: <20230320220947.3244247-2-cleech@redhat.com>
In-Reply-To: <20230320220947.3244247-1-cleech@redhat.com>
References: <20230320220947.3244247-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_151208_806936_602DFAD4 
X-CRM114-Status: GOOD (  12.18  )
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

Ensure that no further socket reads occur after a receive processing
error, either from io_work being re-scheduled or nvme_tcp_poll.

Failing to do so can result in unrecognised PDU payloads or TCP stream
garbage being processed as a C2H data PDU, and potentially start copying
the payload to an invalid destination after looking up a request using a
bogus command id.

Signed-off-by: Chris Leech <cleech@redhat.com>
---
 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..49e8eb576527 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -888,6 +888,13 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 	size_t consumed = len;
 	int result;
 
+	if (!queue->rd_enabled) {
+		/* io_work or polling happening after receive error
+		 * waiting on error recovery
+		 */
+		return -EFAULT;
+	}
+
 	while (len) {
 		switch (nvme_tcp_recv_state(queue)) {
 		case NVME_TCP_RECV_PDU:
-- 
2.39.2


