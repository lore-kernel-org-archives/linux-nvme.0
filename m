Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B3BC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1362087D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jviut4Gs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DrT2hh1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1362087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H7968n2U+SzoGKzUVo10OL+KNuneyfoyhDzD6zbiCh8=; b=Jviut4GsvhnCoqp8HaA6VOVLjT
	qG80ypaXlKzqzBnsSYX3noykBCRVrNAR+jc2AkVU/4fB23MUp8HN/Krc9kt3Nj67oZBh5DHniA867
	bjLvKCrPP7RnLKELAWwbUPltZUuGNK52dA5aKAOXYRVVbuB0gDlOp6upJVMbrubt0GpozeXaNKoch
	cmHpUctXkoFR9UJTs4V7qAWJRcLEgLC2Wpp7qrtFue9LPbN0IShH/DQUQEm8pNwEUr2X95pooNPND
	zBvDcknJ+JXuvManu7MgZhajHJjEf0HTZZMI1Lp3O9PiM3M/H6eYvzxVh2O7NRPW19BWPp7a0tavJ
	bZQf6o4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQii-0006b8-OC; Fri, 16 Oct 2020 14:28:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQih-0006ad-1Z
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 14:28:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602858512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3TIf5iCrDa1crF7arOWYxShLok0bW/SJkG7vvFcFY0k=;
 b=DrT2hh1hzi49xlm/etkK7RSW2NuZlZ3psFcPgSUGu7kdr5DkJrL6LbUcMEOencXlZuMD0Z
 pZjrWpe65pgRW4KJv1C/suaHiS6HiLpONXgPK7w4P7rBeViznoxdnwj1gdEEb3lovYSBpX
 vTZ5/9TFY2jrinw0u07sBJM8qoDYI6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-GqhWd3abMpCw8nx2SKehaA-1; Fri, 16 Oct 2020 10:28:30 -0400
X-MC-Unique: GqhWd3abMpCw8nx2SKehaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C98E57083;
 Fri, 16 Oct 2020 14:28:28 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97C481974D;
 Fri, 16 Oct 2020 14:28:21 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/4] blk-mq/nvme-tcp: fix timed out related races 
Date: Fri, 16 Oct 2020 22:28:07 +0800
Message-Id: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_102835_146422_458C2120 
X-CRM114-Status: GOOD (  10.16  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

The 1st 2 patches fixes request completion related races.

The 2nd 3 patches fixes/improves nvme-tcp error recovery.

With the 4 patches, nvme/012 can pass on nvme-tcp in Zhang Yi's test
machine.


Ming Lei (4):
  blk-mq: check rq->state explicitly in
    blk_mq_tagset_count_completed_rqs
  blk-mq: think request as completed if it isn't IN_FLIGHT.
  nvme: tcp: fix race between timeout and normal completion
  nvme: tcp: complete non-IO requests atomically

 block/blk-flush.c       |  2 ++
 block/blk-mq-tag.c      |  2 +-
 drivers/nvme/host/tcp.c | 76 +++++++++++++++++++++++++++++------------
 include/linux/blk-mq.h  |  8 ++++-
 4 files changed, 65 insertions(+), 23 deletions(-)

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>


-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
