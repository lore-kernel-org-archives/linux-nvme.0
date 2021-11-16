Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC0FC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:49:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63BA61414
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E63BA61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uPmh6xiUxIKc09lwQYW26wnfU/DnebSZi9pXjr56V9A=; b=Sd0+jfz+lSwNP0U69ZOtHj/Azl
	3xbhi0EC3zMElwl7nwf+cpNbYTHvEG/UM/Iak/3eswL07rMqF3EEv/cKwYN2FRmQySTa8qJe2fdaX
	be9Z5BbUtOsCzPD5Xkgx62BTSyoVbP2cz6IFNH5mFLjgzkfcj7EFyrnlXhPGLqvTfCwdms9OEnrBT
	WDGu5gypGIMrhL/qkNZuYvhNLIyZuK0bbEIblsSOmWZK+E90qip6fBA40hMg2WqESghVO7sP6f3Rd
	MqkZRg+kj0+2WBB6o5b8cGCBCK8hDnes27hZh1I+EFJw2EaHWqUX4EHYkLiBYTe8X3yqzoLgHq2x8
	rp0tx62g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn0iC-002C6X-71; Tue, 16 Nov 2021 15:49:32 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn0i9-002C4q-DR
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 15:49:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637077768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uPmh6xiUxIKc09lwQYW26wnfU/DnebSZi9pXjr56V9A=;
 b=N6WG/E8pIRZoHG90CEOTTSOdU1yU/27eTKdD8nnY6fQJRYMqH2+C6uxR4ieDLUCwLuA2er
 cryL9Kl3o8xRZbmZISQLazm+0uMAZuV+hoVsaKkRmnLI0hUlmtWHQ0Jg1au0yQTm3Q1n45
 +mVvH1g3Ywj+wKD6SSIJXhbQYKtzCAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-6n0IvxJiONu8SKgkFxN0xA-1; Tue, 16 Nov 2021 10:49:25 -0500
X-MC-Unique: 6n0IvxJiONu8SKgkFxN0xA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3FC61923762;
 Tue, 16 Nov 2021 15:49:23 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D64F5D6BA;
 Tue, 16 Nov 2021 15:49:21 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH V3 0/3] Fix a race condition when performing a controller reset
Date: Tue, 16 Nov 2021 16:49:17 +0100
Message-Id: <20211116154920.87279-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_074929_554034_D6AFF7FE 
X-CRM114-Status: GOOD (  12.46  )
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

V3:
  - rename nvmet_tcp_free_iovec() to nvmet_tcp_free_cmd_buffers()

V2:
  - Use "queue->rcv_state" to prevent the race condition, as suggested
    by Sagi Grimberg.
  - Dropped the changes to nvmet_tcp_queue_response() because they are
    no longer necessary.
  - Fix the memory leaks in a separate patch (PATCH 3/3).

Maurizio Lombardi (3):
  nvmet-tcp: fix a race condition between release_queue and io_work
  nvmet-tcp: add an helper to free the cmd buffers
  nvmet-tcp: fix memory leak when performing a controller reset

 drivers/nvme/target/tcp.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
2.27.0


