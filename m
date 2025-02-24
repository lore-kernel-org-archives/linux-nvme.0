Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BA8C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 15:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x+6zpUoVmSt7mVVtidfrr/RSt6Xh/y+rsJiknX6zYf4=; b=L1L5/jPaypUVqa5L9ht07fST7i
	IqKSMKDBnR/UUcpeOofbwPAZtv/OpbDPCEJtJdk0rCE241pmGEnp7UgsWoXzFW1ksUPSRT3Tworaf
	36ogiq2bk1lUXzc6wX+2ZwXuI/M7xwlGm/0aj3TbJppYm9qtb8f217yJfjA9iKoKSR6pVuFVD/puY
	USKRz/rMweadl7iRrYi1GfvXxLyBRRSV1HT96iycC2G9fuDkbqTbd1PJyc3oXR3UiYZJf+mU3HqOA
	koG5eQEJdC6EXsgRohN/hXRUvXdfBiq92WUJjuvxHJ2W4TJFFPqR5M2umwv7viOOOUVx4UuyB/SQt
	MIRiMKrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tma4e-0000000EE3t-2ZCB;
	Mon, 24 Feb 2025 15:08:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZdr-0000000E8fI-3xdO
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:41:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740408065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x+6zpUoVmSt7mVVtidfrr/RSt6Xh/y+rsJiknX6zYf4=;
	b=gBNtIVHbBUZn0CxSVds38IQf5KBmbhQN4hecdXOahVm0GX+MkwWVKQPvVvTf18LAEU0DuO
	qS4txaelz8elM9FoXv07+uiARuFPFuMmPKpoydjOeQWLVDoC2c0eRhuoSKYgLVfgFw5olv
	Rx54EQIfNHqIg2hKrXJ2H9SQJRbub3c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-g1kzwIgaOduV8hn2jkZIXg-1; Mon,
 24 Feb 2025 09:41:03 -0500
X-MC-Unique: g1kzwIgaOduV8hn2jkZIXg-1
X-Mimecast-MFC-AGG-ID: g1kzwIgaOduV8hn2jkZIXg_1740408062
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97041801A1E;
	Mon, 24 Feb 2025 14:41:01 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0FD51800359;
	Mon, 24 Feb 2025 14:40:59 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	hare@kernel.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH] nvme-tcp: Fix a C2HTermReq error message
Date: Mon, 24 Feb 2025 15:40:58 +0100
Message-ID: <20250224144058.693927-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fdSU0yQT0vQgRJu7sabL8oaEyKdDZugYlFLaAkXOwaY_1740408062
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_064108_052094_199EE898 
X-CRM114-Status: GOOD (  11.29  )
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

In H2CTermReq, a FES with value 0x05 means "R2T Limit Exceeded"; but
in C2HTermReq the same value has a different meaning (Data Transfer Limit
Exceeded).

Fixes: 84e009042d0f ("nvme-tcp: add basic support for the C2HTermReq PDU")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8a9131c95a3d..183cc58ecded 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -775,7 +775,7 @@ static void nvme_tcp_handle_c2h_term(struct nvme_tcp_queue *queue,
 		[NVME_TCP_FES_PDU_SEQ_ERR] = "PDU Sequence Error",
 		[NVME_TCP_FES_HDR_DIGEST_ERR] = "Header Digest Error",
 		[NVME_TCP_FES_DATA_OUT_OF_RANGE] = "Data Transfer Out Of Range",
-		[NVME_TCP_FES_R2T_LIMIT_EXCEEDED] = "R2T Limit Exceeded",
+		[NVME_TCP_FES_DATA_LIMIT_EXCEEDED] = "Data Transfer Limit Exceeded",
 		[NVME_TCP_FES_UNSUPPORTED_PARAM] = "Unsupported Parameter",
 	};
 
-- 
2.43.5


