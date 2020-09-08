Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3086C2D0A7
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B79221D20
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mbw/5Fay";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KvfNA9+8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B79221D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YUomFQ33y5LTfaYaZ7fYv/icID5j5eNGX9CzSTggvWE=; b=Mbw/5FayAdrs1O6XpHf2VVgc6c
	LrY/zrA47MpbCvNoJzn8apTHHjrVGE88e75nxxGTH7d6r3vihzQLXIdQRY3rBD4QbMDWRoyIS3nT5
	v9BjRu0xVAMmjGAMYfR8dyxbD5SN2R8NIbtedd5mdorfzIr5qGF0JEZ6nRgqhYujIbeZGRi0ChcZP
	RwI2c7UcJzPYaOiBkX3idLPdj9GvQPds6L7/VqjOtaH3Y65vosav9R0EaebYDiAveliKnIRuiQqND
	gdvqYiFFkLytP+za0p+LZw/7c0f4xz0awFfJNG2fp/PNHjhBjLQ4PAcUmR/FnoNFAhOA3LgE+UMeo
	Wp7t8OXQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFYnO-0002ca-9z; Tue, 08 Sep 2020 08:16:06 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFYnI-0002b1-O3
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:16:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599552958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=v/qoO+cW63IFyXyKdkhTXirdCmiDWixghNnIQtyM35A=;
 b=KvfNA9+8hTIv8aUkqdCJPaguxoGAXFWZ32FuEYnALNRU+3kMDztFiFaKDVtKCsGHcrK7mn
 sfesra9x1VZ/KH6XOuv+2DUN0JKtTp59joThqW51+4zgdsVU04omdpMjoZjvtCUw6WHA0B
 iMMkjT/OJQy+YRDXDh/2ZdL/QvRbr1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-5Rjh-0qAOM-QTqaL-GuGvA-1; Tue, 08 Sep 2020 04:15:54 -0400
X-MC-Unique: 5Rjh-0qAOM-QTqaL-GuGvA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B094393B4;
 Tue,  8 Sep 2020 08:15:53 +0000 (UTC)
Received: from localhost (ovpn-12-217.pek2.redhat.com [10.72.12.217])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16DF071775;
 Tue,  8 Sep 2020 08:15:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V3 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Date: Tue,  8 Sep 2020 16:15:34 +0800
Message-Id: <20200908081538.1434936-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_041600_819814_1BF6E159 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Chao Leng <lengchao@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
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


V3:
	- add tagset quiesce interface
	- apply tagset quiesce interface for NVMe
	- pass blktests(block, nvme)

V2:
	- add .mq_quiesce_lock
	- add comment on patch 2 wrt. handling hctx_lock() failure
	- trivial patch style change



Ming Lei (3):
  blk-mq: serialize queue quiesce and unquiesce by mutex
  blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
  blk-mq: add tagset quiesce interface

Sagi Grimberg (1):
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-core.c         |   2 +
 block/blk-mq-sysfs.c     |   2 -
 block/blk-mq.c           | 177 +++++++++++++++++++++++++--------------
 block/blk-sysfs.c        |   6 +-
 drivers/nvme/host/core.c |  19 ++---
 include/linux/blk-mq.h   |  10 +--
 include/linux/blkdev.h   |   6 ++
 7 files changed, 140 insertions(+), 82 deletions(-)

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
