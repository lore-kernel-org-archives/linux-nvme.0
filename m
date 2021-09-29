Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527C6C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CAE56135D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1CAE56135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=//Lr0FHU1/DzgF02gIA1JjJG6BDjhdOzlBeYpz3HPxg=; b=OX6TUiHsElaIDZ
	y7I6dmYL1GM9dPTfIiDAKQ2rKcR7IgMZp3UDUpcDdXMA53T3jqmaeVHMISwt6/AM7JMTzvIQvs8tM
	+TvbyWpUxe1Ie8TdQzG2nbKxCWeKZ7l1D/Qhy5PeEQMv7F35m3W3tFvi0gcqcjTfVVeThrkhXitF/
	RWtmxCTnW5dsGv1pkKNRUHyDNmvX5fUIWS6WTvwhqoZ+2W0u8+v7x+78zkC/6BzFQ4+2yVH1dSpA3
	bx9FDpBUs6NDwbcVC+y4W1B5TNOdnkaXU/Xw025TpanPnDqLx9BnyUoMWHH5wwG4wwVgxou84vPnC
	EpPKEef4g0oG3gZlYNMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVR1U-009u9c-4y; Wed, 29 Sep 2021 04:16:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVR1R-009u8b-Cz
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 04:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632889003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=D19V9XJqvkGN4+zC8heJ/oDgXubPN0A+TqtDJvrseY4=;
 b=EKhZ5qrFEBh4Vxs52L3G9Y3u3vXR5V3ZeI0xQYHp1yLU9wnkLiQwOpxlIeRC23SNbxnu4Z
 OgBXjpLcaZF531IjxneFerFYIMaHujJfuR68xJvnM7kjbK9dHZlItGcSxNHFYB4mumvH0S
 EIH2hm9u0CfXA/jmQR4DOXIibUy7sSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-kjtJyvqbP3K6uAbv7Q2s3A-1; Wed, 29 Sep 2021 00:16:42 -0400
X-MC-Unique: kjtJyvqbP3K6uAbv7Q2s3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE51802947;
 Wed, 29 Sep 2021 04:16:40 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEDE5E255;
 Wed, 29 Sep 2021 04:16:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] blk-mq: support nested queue quiescing
Date: Wed, 29 Sep 2021 12:15:54 +0800
Message-Id: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_211645_672460_34C7ED02 
X-CRM114-Status: GOOD (  13.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

request queue quiescing has been applied in lots of block drivers and
block core from different/un-related code paths. So far, both quiesce
and unquiesce changes the queue state unconditionally. This way has
caused trouble, such as, driver is quiescing queue for its own purpose,
however block core's queue quiesce may come because of elevator switch,
updating nr_requests or other queue attributes, then un-expected
unquiesce may come too early.

It has been observed kernel panic when running stress test on dm-mpath
suspend and updating nr_requests.

Fix the issue by supporting nested queue quiescing. But nvme has very
complicated uses on quiesce/unquiesce, which two may not be called in
pairing, so switch to this way in patch 1~4, and patch 5 provides
nested queue quiesce.


Ming Lei (5):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  blk-mq: support nested blk_mq_quiesce_queue()

 block/blk-mq.c             |  20 +++++--
 drivers/nvme/host/core.c   | 107 +++++++++++++++++++++++++++++--------
 drivers/nvme/host/fc.c     |   8 +--
 drivers/nvme/host/nvme.h   |   6 +++
 drivers/nvme/host/pci.c    |   8 +--
 drivers/nvme/host/rdma.c   |  14 ++---
 drivers/nvme/host/tcp.c    |  16 +++---
 drivers/nvme/target/loop.c |   4 +-
 include/linux/blkdev.h     |   2 +
 9 files changed, 135 insertions(+), 50 deletions(-)

-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
