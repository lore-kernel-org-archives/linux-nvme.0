Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B767AC2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 02:09:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33BF62168B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 02:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DBKxfxbS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCTwfvFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33BF62168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3Do4fWof317DD+LSOIs6jCXNR7so2UjpOe+xJbXUE04=; b=DBKxfxbSIWopyE06neHFlNgdvg
	gZYZdCDcxTP8Uay03CsCpcfzqsff6qewVTjIyVA50mUiWYhRDhjJYQ7jc/37dzl9dKu1qgdFquwXB
	uHPcUqtvPdgL8YC5JDDCj+4Wphmh+U1VOJVRjXN9g68b+n2th5lUkkNwTo0mBUu2YGzooKy6E8lvz
	jtkiBOS17NMsn8WEWOCjBnN/GdOVtW/jCe/gkI99xN7FrpI8hme1eTteeAeS2RatqN3nG/ZiGYmU2
	Hhk/DsoQRFMBRTZ0Cr57wAQzSb9xGn+HkUQ8v0ALs6viKDSwhAQebVkki5Hs9TVhwmeLvKLdjASKV
	THnu5hHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHdvL-0006y0-PF; Mon, 14 Sep 2020 02:08:55 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHdvH-0006x8-EO
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 02:08:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600049329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NtOlulbKFTK9JonRL8oELSnBW6UyODni1m5uQCkqvZI=;
 b=NCTwfvFikK0r3ZP1hIWwwG7mIhTvv2FncN5RXEGYYQQltwj/syHemmQxLNmOt8CMvBAjfS
 lALvfdFXNWS66H04RvG+H6MLkAArHRmeDvtrh1yrfuaab47/qWRhbenlgMykqtbXRVB8fJ
 gMltUaKHfoSV213EUhL802I7UnTU5QQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-wIIG7ZKuNYuf8Y72qMCxNg-1; Sun, 13 Sep 2020 22:08:45 -0400
X-MC-Unique: wIIG7ZKuNYuf8Y72qMCxNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3B721005E62;
 Mon, 14 Sep 2020 02:08:42 +0000 (UTC)
Received: from localhost (ovpn-12-38.pek2.redhat.com [10.72.12.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61F5560CD0;
 Mon, 14 Sep 2020 02:08:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V6 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Date: Mon, 14 Sep 2020 10:08:23 +0800
Message-Id: <20200914020827.337615-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200913_220851_683995_FC623D59 
X-CRM114-Status: GOOD (  14.47  )
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
