Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556E0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:49:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2679D61B29
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2679D61B29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IU5fgI8tf8n4JPQ6IkxWg0JDThvWeHAoz+erDFwPAOw=; b=xwtreL65rAlMBPM3wg3B1wOMwK
	1oI9JnzVpR07Vu2xWJr2zosTeGV3uvkkFaMch3RIl3Vm7yljRuG4Z+od0Y240LVc1rpwHZodLY4wU
	yZjkZ+oqaO1IaRMJgAKiIw8/FXCqa3J/5zRllLkp10kd87PMGV+5XD04ET66QHtg0RYLI4jpnUf8w
	cCoCg43tzGnzaUHQF8itDZ1WDprNNGbABJxOtI8LKKc8pvVPrl5zIbAy37ZnDN+lSkF+2sl/us1oQ
	X/lwDuyyC+2+vYFjyP6epdARG8b6A1J9zrrQCcTkPSReyqy05J5K43pcLazx0u0RazGj4Ra3g4nq1
	CJInRcTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn0iP-002CCp-3s; Tue, 16 Nov 2021 15:49:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn0iC-002C6m-Uo
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 15:49:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637077772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IU5fgI8tf8n4JPQ6IkxWg0JDThvWeHAoz+erDFwPAOw=;
 b=bnuPXLFvGngiDEgErvoeA87d7GGwI4rFbiGaHUlB2RpoCkakmCU9ekFSYCgqVy0TXmRN8H
 p27t8yavWhb59H4FzIMn+tpv16PZLB3e0ZokeVOUdw6gdNmaV7mQZg8iO9Phq+NSJ1j8mU
 akUaxFBlkf5CP3I2Awdg26VxZKIwmvw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-zHb9WigpOaarIb5vb8xlVw-1; Tue, 16 Nov 2021 10:49:26 -0500
X-MC-Unique: zHb9WigpOaarIb5vb8xlVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96469101F000;
 Tue, 16 Nov 2021 15:49:25 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C6695D6BA;
 Tue, 16 Nov 2021 15:49:23 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH V3 1/3] nvmet-tcp: fix a race condition between release_queue
 and io_work
Date: Tue, 16 Nov 2021 16:49:18 +0100
Message-Id: <20211116154920.87279-2-mlombard@redhat.com>
In-Reply-To: <20211116154920.87279-1-mlombard@redhat.com>
References: <20211116154920.87279-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_074933_113210_73BD80C8 
X-CRM114-Status: GOOD (  13.26  )
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

If the initiator executes a reset controller operation while
performing I/O, the target kernel will crash because of a race condition
between release_queue and io_work;
nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
is running, calling flush_work() was not sufficient to
prevent this because io_work could requeue itself.

Fix this bug by using cancel_work_sync() to prevent io_work
from requeuing itself and set rcv_state to NVMET_TCP_RECV_ERR to
make sure we don't receive any more data from the socket.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 84c387e4bf43..18f36256095f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1437,7 +1437,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
-	flush_work(&queue->io_work);
+	cancel_work_sync(&queue->io_work);
+	/* stop accepting incoming data */
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-- 
2.27.0


