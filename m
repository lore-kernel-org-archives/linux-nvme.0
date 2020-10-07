Return-Path: <SRS0=DCfI=DO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500EAC4363D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 01:07:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E310E20760
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Oct 2020 01:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lbp3Vptx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqNg2jW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E310E20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qBFQtaS5e3nAp7KRRIscifcBSCBP7zghjQV2ddDOvwg=; b=lbp3VptxmrPbUAR9p76cOIa5rK
	0QYBQljc8IoG5YAMG1YfZyW2SNNvPvGoupGw8FNI+V8vUBvVGqqFnFmgczkS/fRVPPKRHvK3l3GbI
	E8wRqN5qsnwHsF1MXftJVHtOK6cXSSalNVEoGWH5tsPL25+qy8g4alVj7DqD9MxKqVaBwX3hw4HEu
	oMIJvq1YiBPttLvcq+a0dSA1x9pZn2LU4rzGOGtReR9PIwO/yHzKRWKljN6Pkp/NwiX46zX2DnEsw
	MSAovIUyGJuLN8i5n0C7vDm6eU5z9HiOBSxrh8RsFsWxJRD/FUfUlvZVw3ducoXJrXFXJP3nYI/di
	AIkaTbGA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPxv8-0005iJ-0j; Wed, 07 Oct 2020 01:07:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPxv5-0005hL-Fx
 for linux-nvme@lists.infradead.org; Wed, 07 Oct 2020 01:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602032823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RLiZ9gLZbkl9AWDrkT72DWvj86qtm9c61Et1HUVAglI=;
 b=CqNg2jW1wSCOvsYhi1sFeQ/7wSzOeeeb0DWZDdds1uga9aRzi11sNptpWv/CopIqkPnJS2
 hGI9YNZzQTHtTY42ubtUzSZlFbPb22GvzG/Cr6PJQ8mGQ/GSdcVWDeAG+MtvQZgiNsausn
 3ueJ5QRZjnTT6mWaBpF9Tgt/4cFBwLg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-SInF7xUQN5emSD5gWYjDIQ-1; Tue, 06 Oct 2020 21:04:54 -0400
X-MC-Unique: SInF7xUQN5emSD5gWYjDIQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E45CF803F6A;
 Wed,  7 Oct 2020 01:04:52 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B83045C1BD;
 Wed,  7 Oct 2020 01:04:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V7 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Date: Wed,  7 Oct 2020 09:04:39 +0800
Message-Id: <20201007010443.71456-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_210703_757990_8EFCEE28 
X-CRM114-Status: GOOD (  14.00  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
and prepares for replacing srcu with percpu_ref.

The 2nd patch replaces srcu with percpu_ref.

The 3rd patch adds tagset quiesce interface.

The 4th patch applies tagset quiesce interface for NVMe subsystem.

V7:
	- base on latest for-5.10/block, only there is small change on 2/4

V6:
	- base on for-5.10/block directly, instead of being against on patchset of
	'percpu_ref & block: reduce memory footprint of percpu_ref in fast path',
	because these patches don't depend on that patchset. 

V5:
	- warn once in case that driver unquiesces its queue being
	  quiesce and not done, only patch 2 is modified

V4:
	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
	avoiding duplicated quiesce action
	- pass blktests(block, nvme)

V3:
	- add tagset quiesce interface
	- apply tagset quiesce interface for NVMe
	- pass blktests(block, nvme)

V2:
	- add .mq_quiesce_lock
	- add comment on patch 2 wrt. handling hctx_lock() failure
	- trivial patch style change


Ming Lei (3):
  block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
  blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
  blk-mq: add tagset quiesce interface

Sagi Grimberg (1):
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-core.c         |  13 +++
 block/blk-mq-sysfs.c     |   2 -
 block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
 block/blk-sysfs.c        |   6 +-
 block/blk.h              |   2 +
 drivers/nvme/host/core.c |  19 ++--
 include/linux/blk-mq.h   |  10 +--
 include/linux/blkdev.h   |   4 +
 8 files changed, 154 insertions(+), 84 deletions(-)

Cc: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chao Leng <lengchao@huawei.com>
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
