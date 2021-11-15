Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5540DC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 16:31:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDD861BE1
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 16:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EDD861BE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3MjeopfwFNZmXqND85TkTJOjVCqliiqImeIRLMMsI9k=; b=yITj1n2Gqoisj8m0CVUnDZkLuI
	fQxTiBl89WxotW2ofge2NYCzj95Gi4daIyoWwBwGdAsGLwDeuMNfcvoGwblH+Av9SyQA2026QY/Gr
	uKGHCavehDDLPjaIY23c8UJtrEcyOAshQcYLhXcJquPdJLiizCo2ZHCm5CTLNE+rlHqxHWfl+CWHH
	qkbsbXZ1q/QyFX+/vF5sSX0ri8nWJVeB5WGHm/XBeQG1r3Qp91bb6efT+7tmdeZ970mvAVZe5nDT1
	TQYVbhEp8MgBTDDVNnYWCM8dyoJTpsRCVTZkZptWqCo2flC4x1je8M60WUh/P3UZtDMZmDFpNCYGp
	A2aor4XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmetB-00GKsg-7V; Mon, 15 Nov 2021 16:31:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmet8-00GKrV-0y
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 16:31:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636993881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3MjeopfwFNZmXqND85TkTJOjVCqliiqImeIRLMMsI9k=;
 b=Z7MHDg8R3xTz/WW2OMFeK93vlTFRK5+LP9U2kIP1H0wcGCRnHYkWNON5feOfTk5xwPaJ1L
 Pf7b9TNP4mU27oGV6uFG8olaJVRnMyd4ot429tUpz8IRnNvufr4R3AEDaNKtO87B4xOzvN
 qJs+EPfs/tNT9Q+GmtAAYlcnXCqi8sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-BGtxhSDLPuCjDOhzhqTnRA-1; Mon, 15 Nov 2021 11:31:18 -0500
X-MC-Unique: BGtxhSDLPuCjDOhzhqTnRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9DAA1006AA1;
 Mon, 15 Nov 2021 16:31:16 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B3FE019D9F;
 Mon, 15 Nov 2021 16:31:15 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH V2 0/3] Fix a race condition when performing a controller reset
Date: Mon, 15 Nov 2021 17:31:11 +0100
Message-Id: <20211115163114.48716-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_083122_184122_1462C59F 
X-CRM114-Status: GOOD (  12.51  )
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

Memory leaks and kernel panics involving the nvmet driver
have been observed when an initiator executes a reset_controller
operation while doing I/O.

The problem is due to a race condition between io_work
and release_queue, the latter may end up destroying the
commands while io_work is still running, causing use-after-free
and memory leaks.

V2:
  - Use "queue->rcv_state" to prevent the race condition, as suggested
    by Sagi Grimberg.
  - Dropped the changes to nvmet_tcp_queue_response() because they are
    no longer necessary.
  - Fix the memory leaks in a separate patch (PATCH 3/3).

Maurizio Lombardi (3):
  nvmet-tcp: add an helper to free the iovec
  nvmet-tcp: fix a race condition between release_queue and io_work
  nvmet-tcp: fix memory leak when performing a controller reset

 drivers/nvme/target/tcp.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
2.27.0


