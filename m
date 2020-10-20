Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CC6C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926B320936
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZuGTSOwx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkLwBFxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926B320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QzRPXDzz3UAJHt+n35Go1O/50Mph5JSIQbQaTMBmxMk=; b=ZuGTSOwxKv/D2sDNYl7y0hW/Ea
	Dp9PdKpw5s3XUloVO9mJBPdm1ygn1nKou5thirzYKviG9rpRYZ1VObEN+ikju+DQzonkbg3lc1+8b
	OjNrQ/VfBLZp6fHNqE3lSAzPuwa6BewiC2ot2jMiNMx46K1Y43CDjnT67qzCRa5h80XIyI2HLbUHm
	Fsebinkw60Mh8SUwp74GgAbuj8u0NZgWuLj0qbnktrtoCFGBI+npx5Pa5A58t72OtZAXy5aSIdOul
	AZiV+GHgA3sqriVGXhP9B7+tlnT1JuJaqyoJFqORR21FXIHPaWHOw8a0NtHHYFQxPtCkHYCQbdv65
	tn+2Xe4Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUnOX-0002xU-0d; Tue, 20 Oct 2020 08:53:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUnOU-0002wP-Ch
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 08:53:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603184001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JtagE/ajhgoE7H7x1jlumd9vteeleoMmxBS5P2L1fQ4=;
 b=WkLwBFxEI2uyKR9hrQ9hcgvFYKwOKn7wAt9DjudzBlPeADj6QUM9+KQMA+0g1CLhXpR7aq
 xuXNMCRDll25xzA6TVd0gEp8zTJym6y8A4zrKica4XFPJJdTjQDc8FYWwb3UkijbJAdKF6
 VtGaaITfKtPaeS1aWroUnbt2HuXHDJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-NoLH95oiMdugDmvEo9pvgQ-1; Tue, 20 Oct 2020 04:53:17 -0400
X-MC-Unique: NoLH95oiMdugDmvEo9pvgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4FB887507B;
 Tue, 20 Oct 2020 08:53:15 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2AD1D10016DA;
 Tue, 20 Oct 2020 08:53:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2 0/4] blk-mq/nvme-tcp: fix timed out related races 
Date: Tue, 20 Oct 2020 16:52:57 +0800
Message-Id: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_045322_456926_E412ECE0 
X-CRM114-Status: GOOD (  10.63  )
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

V2:
	- re-order patch3 and patch4
	- fix comment
	- improve patch "nvme: tcp: fix race between timeout and normal completion"


Ming Lei (4):
  blk-mq: check rq->state explicitly in
    blk_mq_tagset_count_completed_rqs
  blk-mq: fix blk_mq_request_completed
  nvme: tcp: complete non-IO requests atomically
  nvme: tcp: fix race between timeout and normal completion

 block/blk-flush.c       |  2 +
 block/blk-mq-tag.c      |  2 +-
 drivers/nvme/host/tcp.c | 98 ++++++++++++++++++++++++++++++++---------
 include/linux/blk-mq.h  |  8 +++-
 4 files changed, 86 insertions(+), 24 deletions(-)

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
