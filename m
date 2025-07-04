Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682AAC83F03
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WEQN28PgSCt2E0E6PSOSZjhpNXIlfargc5c9nOn+u0E=; b=XGjHAJIOYoKvG+uBo9nfbsB01Z
	KNF4EFGxmJHxuP8Ya9+qS5mnJY/AMXg5nW5DHzCHYmoaP9vrmXpM92bpwZfK9HAbe9ju/RnPXPMlw
	iSBgZveveu1woCimfGmUk4NSowLhljf/wlHoJGo6JSH2hGbPW97DF0UAR00cVv4HcJ6oQEx/Tfsj1
	7tkjv0W9F2b4CVt1bCeiuaIf9zWhezWFNlNByNHdfpA7cRVWmgs9unxNqkgj/03MX9iD4eaYVPdeM
	pZCcUnAcrmlo/8OFNIYP+ITH9LVEi3VqlgJTgxOGD+HQNoaIfuHwIzi2g+2VtsmTBf6Y7l4hFwX0e
	+EDNyqSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhhw-0000000EiM1-1Tcf;
	Fri, 04 Jul 2025 14:48:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXhf4-0000000Ehhf-2TOo
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 14:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751640308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WEQN28PgSCt2E0E6PSOSZjhpNXIlfargc5c9nOn+u0E=;
	b=aWGH9hYv63uurgJyS0XawbMYJCOh+MwMovlPgwxNUBFWTWAlNrpoMQlyyz4uyFQ6vmuZ+i
	wF1PX317dDO5cXGYWHDzeO2XPAYH80JtCvAQhVIG+KFPuU7Qrx4vo0TiyIH2+Hvj42hIeE
	ooCqjFj5WQQf5dDbLbdlfr4QYPYdXig=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-F8ukIByWNlSQoyISm_DdMg-1; Fri,
 04 Jul 2025 10:45:03 -0400
X-MC-Unique: F8ukIByWNlSQoyISm_DdMg-1
X-Mimecast-MFC-AGG-ID: F8ukIByWNlSQoyISm_DdMg_1751640302
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF8F4195422F;
	Fri,  4 Jul 2025 14:45:00 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.33])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9B16919560A7;
	Fri,  4 Jul 2025 14:44:56 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvmet-tcp: fix callback lock for TLS handshake
Date: Fri,  4 Jul 2025 16:44:54 +0200
Message-ID: <20250704144455.244359-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pIx0D9ewdgaeAMPDj-T-TB0DGowOxyXt_QSfQgf2r4k_1751640302
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250704_074510_698021_A2FCBFCF 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When restoring the default socket callbacks during a
TLS handshake, we need to acquire a write lock on sk_callback_lock.
Previously, a read lock was used, which is insufficient for
modifying sk_user_data and sk_data_ready.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 688033b88d38..470bf37e5a63 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1928,10 +1928,10 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct sock *sk = queue->sock->sk;
 
 		/* Restore the default callbacks before starting upcall */
-		read_lock_bh(&sk->sk_callback_lock);
+		write_lock_bh(&sk->sk_callback_lock);
 		sk->sk_user_data = NULL;
 		sk->sk_data_ready = port->data_ready;
-		read_unlock_bh(&sk->sk_callback_lock);
+		write_unlock_bh(&sk->sk_callback_lock);
 		if (!nvmet_tcp_try_peek_pdu(queue)) {
 			if (!nvmet_tcp_tls_handshake(queue))
 				return;
-- 
2.47.1


