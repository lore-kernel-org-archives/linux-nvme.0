Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4452BECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yPaITRDUkaoJxPTT4S3sr3xcr8M8/X7EgR8nLQDIS88=; b=eJNd42gpdGfkbwM9WXR0BgHap7
	gY3ZlDcJDoFCJemjrVUWch0NPwSx16riqqUtTgKoH7Ike6yYGApXuXVmCGmqi2EwnFd7C+i9xxr8I
	qFGLW/xtdIZzn4FFo9S2LuAP+2dmI3sf34APZuasERcdLQ05pjQ4OTp8BCj+m/cUSkLhUsbYwsM3V
	8OiLwplF5mMzhbE3O40K/i/bmL86kB4dlghPCrokOwuNDVvGfG/8VnlKUkp4YHx0o52z/yhJboQjE
	YMFXn+x2Ybg+3pA5yN9ipVl/8gSLbPFZttn3v31dVwkLBNxcx9aGR15PRS9g/trcP8wwlqT4jqWco
	6qJysm1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSe4N-009bvi-Ic; Mon, 29 Aug 2022 12:40:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSe4F-009bG9-Uz
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 12:40:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661776835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yPaITRDUkaoJxPTT4S3sr3xcr8M8/X7EgR8nLQDIS88=;
	b=Q6oDmVgEMv9jVLFHUsfICFegZCyoUYwlO9nR5cic8veycToKjIaEPTvYHhfsaHEi+Tdypw
	s3IEPv3fqBq9Uf/rZzdyM4FIcdHJmECQuT9rZniHU96YLqoIdflFV2OZGDjX4Deq70nWDd
	Z0V/bdkg3YxDgmt5842k2jVizN6bvjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-F-GjphNINAa497vetGZYkA-1; Mon, 29 Aug 2022 08:40:32 -0400
X-MC-Unique: F-GjphNINAa497vetGZYkA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1829485A58C;
	Mon, 29 Aug 2022 12:40:32 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1213CC15BB3;
	Mon, 29 Aug 2022 12:40:30 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	hch@lst.de,
	kbusch@kernel.org
Subject: [PATCH v2] nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Mon, 29 Aug 2022 14:40:30 +0200
Message-Id: <20220829124030.1194759-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_054040_108716_FD1307FD 
X-CRM114-Status: GOOD (  11.30  )
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

TCP_FIN_WAIT2 and TCP_LAST_ACK were not handled, the connection is closing
so we can ignore them and avoid printing the "unhandled state"
warning message.

[ 1298.852386] nvmet_tcp: queue 2 unhandled state 5
[ 1298.879112] nvmet_tcp: queue 7 unhandled state 5
[ 1298.884253] nvmet_tcp: queue 8 unhandled state 5
[ 1298.889475] nvmet_tcp: queue 9 unhandled state 5

v2: Do not call nvmet_tcp_schedule_release_queue(), just ignore
the fin_wait2 and last_ack states.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 5f9303232e86..3ee106ca7fe8 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1523,6 +1523,9 @@ static void nvmet_tcp_state_change(struct sock *sk)
 		goto done;
 
 	switch (sk->sk_state) {
+	case TCP_FIN_WAIT2:
+	case TCP_LAST_ACK:
+		break;
 	case TCP_FIN_WAIT1:
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSE:
-- 
2.31.1


