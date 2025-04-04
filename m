Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497D2C3601E
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 08:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MvT00/RWpf80sg+JUj9MUqfQT7nMdp2WhII75QwdOIw=; b=WMTOXiJh7fRctlDiN7eq7t79On
	oRk4c832oXiPdFYaNDZ6MY8YacxeMFhBa4n5tT3zoOtl2hY+nmGApVCsyDjmAZDUZDq2vYGHF5vpz
	TjIKrLvsRq9wwu5nhdw8UHovyg0UJ/ETVRFesUrZTwi0FYSQpZe1rmMc+pUCGzq4qYgg9Yz9gPGqn
	gs4MaLBT4M6tfdlflhmgiQ5oiTEdHczmfei3kbuo/ED6vy6O/uN90+73A7X1nqGAXrdC5zLsIXrf7
	AgUqtDeADBmMQB3Pt+hlAkKVfPOYTLjzBibEWME5/aq2a3TjgJth1YHmwC1eqVy8ZFZWhiziuaKpU
	Aum33RhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPS-0000000B8Z2-30ue;
	Fri, 04 Apr 2025 08:28:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0cPQ-0000000B8Xb-2g0x
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 08:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743755295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MvT00/RWpf80sg+JUj9MUqfQT7nMdp2WhII75QwdOIw=;
	b=Ch68UQ/YxLdQBSa8vJGDX2pv7kKBdz/xwaFli7TX3rD3DqwDQ1LydfBW1L/hSUgZJPahWm
	pz+QbyDrdrMPIODJNP3X7tnz3A4j+GltTLwZmKY7kdVYy4jp+GxgfmTDA+X1N4JxW1bYZz
	oGacW2+BFEdsPKJqxGaaFPYVyKTzD78=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-YBklH6GfP_6crHhomPreJQ-1; Fri,
 04 Apr 2025 04:28:14 -0400
X-MC-Unique: YBklH6GfP_6crHhomPreJQ-1
X-Mimecast-MFC-AGG-ID: YBklH6GfP_6crHhomPreJQ_1743755293
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 523FA1801A06;
	Fri,  4 Apr 2025 08:28:12 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5DB741955BF8;
	Fri,  4 Apr 2025 08:28:07 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@meta.com
Cc: hare@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu,
	zhang.guanghui@cestc.cn,
	loberman@redhat.com
Subject: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes during CONNECTING state
Date: Fri,  4 Apr 2025 10:28:00 +0200
Message-ID: <20250404082801.1614252-2-mlombard@redhat.com>
In-Reply-To: <20250404082801.1614252-1-mlombard@redhat.com>
References: <20250404082801.1614252-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uWPgm6JWbkT7aQMg9zUf0cUKxctwV98VUYgvXA8987c_1743755293
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_012816_744884_4D5F45F7 
X-CRM114-Status: GOOD (  10.90  )
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

Fix the bug by initiating the error recovery process to correctly
handle the disconnection in case we missed this event
while transitioning from CONNECTING to LIVE.

Tested-by: Laurence Oberman <loberman@redhat.com>
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 26c459f0198d..f1e2b0417b39 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1329,6 +1329,7 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *queue)
 			"failed to send request %d\n", ret);
 		nvme_tcp_fail_request(queue->request);
 		nvme_tcp_done_send_req(queue);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
 	}
 out:
 	memalloc_noreclaim_restore(noreclaim_flag);
-- 
2.43.5


