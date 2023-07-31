Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8146C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 10:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yQqwaJKJ+ZwyeHeSwTfWnXBAA0fnPi+TPNv6aKisjNs=; b=R9XoOhK7kpC6lEYwpFP3K71F1d
	ssA9+5XdMfrcr9qDF1S26e6f+qKqVAOlNo93n9w/OnTkEiq4MYqzEB/74RRfSL9Svjfc42g/TjEdT
	5GP+WqwvT+3xDRFPGyp21p4NSPi+nojhxrcp7VPmxNzRdsqej+i/A4eHBdTboPZyc6aUZoFxpzQs0
	JqGfZgmW8MIm8ywk62b240CQwWD/G4mphhMTdpv0vi3n+F0jcFg4oSymbCstY2KN2yjMrn1oVrFIS
	yhu6dZhjVvRSCVOtkpTxPgo8f3tT1x9aISZTYhHS8BAaEYwciAIrUHrcYXG8jPfD3fUDSRJY4U4gj
	VgE/GeDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQJs-00F8H7-2H;
	Mon, 31 Jul 2023 10:40:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQQJo-00F8GQ-2A
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 10:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690800001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yQqwaJKJ+ZwyeHeSwTfWnXBAA0fnPi+TPNv6aKisjNs=;
	b=i3ahU6QKnqPrb6oiZEdO2VcJ3rg5+5ANgWvuzhZIAuc8sm+76PA7PnoPExYJo7jt8DbNn+
	Qq4TidTkMoTQcqRK1Sf/hnF9eT4hErEpOCLqjMADILyOQQApzJDqKKFnh7CiYAJmsXLHbl
	3jkC3OZTh/Vd10mKWAnnl0tBS1V8l+8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-B1FpbEqaN8CBeFGpTSqE8A-1; Mon, 31 Jul 2023 06:38:01 -0400
X-MC-Unique: B1FpbEqaN8CBeFGpTSqE8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B4923810B0E;
	Mon, 31 Jul 2023 10:38:01 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.35.206.21])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C67FF200BA63;
	Mon, 31 Jul 2023 10:37:59 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-rdma: do not try to stop unallocated queues
Date: Mon, 31 Jul 2023 12:37:58 +0200
Message-Id: <20230731103758.117533-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_034004_810595_F8C721B3 
X-CRM114-Status: GOOD (  11.51  )
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

Trying to stop a queue which hasn't been allocated will result
in a warning due to calling mutex_lock() against an uninitialized mutex.

 DEBUG_LOCKS_WARN_ON(lock->magic != lock)
 WARNING: CPU: 4 PID: 104150 at kernel/locking/mutex.c:579

 Call trace:
  RIP: 0010:__mutex_lock+0x1173/0x14a0
  nvme_rdma_stop_queue+0x1b/0xa0 [nvme_rdma]
  nvme_rdma_teardown_io_queues.part.0+0xb0/0x1d0 [nvme_rdma]
  nvme_rdma_delete_ctrl+0x50/0x100 [nvme_rdma]
  nvme_do_delete_ctrl+0x149/0x158 [nvme_core]

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d433b2ec07a6..00b13336125e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -638,6 +638,9 @@ static void __nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+		return;
+
 	mutex_lock(&queue->queue_lock);
 	if (test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
 		__nvme_rdma_stop_queue(queue);
-- 
2.39.3


