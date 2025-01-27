Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B78C02188
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jan 2025 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CXfB+yV9TcEW0wdAMKhp9BVBYDPPmVgXmrfuhZCpPIM=; b=fvL8mxGNhZ+2KvR2RT4owKEIOE
	BLXVe2oAcx/9BhIV2G+VT312yxHCVWE0jzcwgd33ND3Qppq3irxJc0FWJKUNl44J673pYTkdIfNU1
	M9MWETdhXlTYLjHMFDRa75x7XtI8KbC0U1Jr2Gw9ni2D+2WY2TkyfHvWFOWDJ7mAeSDQooAvB+RKq
	4Zxb4EaQlmePIi2cGXmQRVTXo/y4e4wsOF8/l/Oh2AX0KmE7NjqIWl2u48epV3hyy4C8XF0D7qTbN
	wmSri+2Oce6xfUhGm5+DfboQKqK+JhB7lUXQIUPIt5W8/EI7H2VFGLCc+OJBalXSVw2ozvRiIFCaH
	2/PVo12g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tcSKp-00000002oqv-1tR0;
	Mon, 27 Jan 2025 16:51:39 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tcSKm-00000002oq3-37Ts
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jan 2025 16:51:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737996694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CXfB+yV9TcEW0wdAMKhp9BVBYDPPmVgXmrfuhZCpPIM=;
	b=X85bq6I2LS3sg/3leye3HZn10uefGslSLwAcloRKeoPi2P1oXN5PBn9hYorEK7etkdD8eB
	LSbu+TiDzYQ/dVEtzqwwWJnGjGnpbfOATsUNw/6ytan5exgZAExsARaOdKqJifwtnPpk33
	JKgQMMHWh0A0tGX6yq3qdIJU3oRFGrA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-CbUxfGTONji0daHY6FmC0w-1; Mon,
 27 Jan 2025 11:51:27 -0500
X-MC-Unique: CbUxfGTONji0daHY6FmC0w-1
X-Mimecast-MFC-AGG-ID: CbUxfGTONji0daHY6FmC0w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 325E31955F26;
	Mon, 27 Jan 2025 16:51:25 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 604FA1800348;
	Mon, 27 Jan 2025 16:51:22 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	hare@suse.de
Subject: [PATCH V2] nvme-tcp: Prevent infinite loop if socket closes during CONNECTING state
Date: Mon, 27 Jan 2025 17:51:20 +0100
Message-ID: <20250127165120.1631552-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WS3uhRBvBiVv02kIfykj-TZbh7bZ4rDz5AWewULIvQ_1737996685
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250127_085136_856607_494962F4 
X-CRM114-Status: GOOD (  11.61  )
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

There is a potential race condition that can occur if
the target closes the socket while the host is in the CONNECTING state.

If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
function is invoked. However, nvme_tcp_error_recovery() is unable
to transition the controller state to NVME_CTRL_RESETTING because
the controller is still in the CONNECTING state. As a result, error
recovery is bypassed, and the controller incorrectly transitions
to the LIVE state with closed sockets.

Subsequent attempts by the host to communicate with the target
will result in an infinite loop.

Fix the bug by checking for the -EPIPE error in nvme_tcp_try_send()
function and initiating error recovery to handle disconnection cases
missed during the CONNECTING-to-LIVE transition.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: commit message: clarify where the error code is checked

 drivers/nvme/host/tcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..d0bb225dca23 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1261,6 +1261,8 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 			"failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		if (ret == -EPIPE)
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);
-- 
2.43.5


