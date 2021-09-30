Return-Path: <SRS0=VDBV=OU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA60C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA88613A7
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Sep 2021 12:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7BA88613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cpM8ico+waoy6Ry808Lp/giSIfijXfa/VnCIXiVqstQ=; b=uguC+PEpBSUCLu
	qg5NDICQgLdkg6IkG+uxD8Q1a3qXNuOfBYSvYgNVNj7xBdVuB5pDN+VwKVQyFy4fXkbYoB+kcM6n9
	h/4mAykYAvS9YPT7ck2nxhv2xaHcUGdVG3KTIzu1TgUPckuq8i7wGraZlWUjZ0zZl8EeOuWNatS0P
	uGttBM5sHlXb+yjAjyZyDBuOoXDZzjHFtUESDIouTRjTfNkFbP7JJ7ZXteXCJWup6ggeWJ5gRwpWs
	oRJP73LnHVLCE6pJRTBf6WijSo8yHPRsJChbhDY/PrnNqfESCojiKtF22pn6QJaJO5Kp88TIEfba4
	/DseuKAoNpiCeC3CFV8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVvcE-00EJj2-NS; Thu, 30 Sep 2021 12:56:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVvcC-00EJh2-Cb
 for linux-nvme@lists.infradead.org; Thu, 30 Sep 2021 12:56:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633006603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RX9RlcTs+c2zIM/RTHHCkJJbaueEK8M/sumCaOzGWXE=;
 b=CNpQ6iXNlwgv3X1kjKClWZag7n6Jwfzpn5p5rPajR55LgRDApFNI0m5ici1zqjTCv02ZMA
 uto8sMnLTc8ojXJZz7JGRoYBiJ+s1QSrXlPJmhAw3L0Vpe/428IQajEsWJ2tD9n+MP+D6U
 HKi/r6kEjBT3yFNyiNbWVweD7muHThM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-iatLPiA2N1uVDvZ-eOW8Xg-1; Thu, 30 Sep 2021 08:56:41 -0400
X-MC-Unique: iatLPiA2N1uVDvZ-eOW8Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60EC38145E6;
 Thu, 30 Sep 2021 12:56:40 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCA625D9CA;
 Thu, 30 Sep 2021 12:56:26 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] blk-mq: support concurrent queue quiescing
Date: Thu, 30 Sep 2021 20:56:16 +0800
Message-Id: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210930_055644_530108_F4761EB4 
X-CRM114-Status: GOOD (  12.63  )
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

Fix the issue by supporting concurrent queue quiescing. But nvme has very
complicated uses on quiesce/unquiesce, which two may not be called in
pairing, so switch to this way in patch 1~4, and patch 5 provides
nested queue quiesce.

V2:
	- replace mutex with atomic ops for supporting paring quiesce &
	  unquiesce


Ming Lei (5):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  blk-mq: support concurrent queue quiesce/unquiesce

 block/blk-mq.c             | 20 +++++++++--
 drivers/nvme/host/core.c   | 70 ++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c     |  8 ++---
 drivers/nvme/host/nvme.h   |  4 +++
 drivers/nvme/host/pci.c    |  8 ++---
 drivers/nvme/host/rdma.c   | 14 ++++----
 drivers/nvme/host/tcp.c    | 16 ++++-----
 drivers/nvme/target/loop.c |  4 +--
 include/linux/blkdev.h     |  2 ++
 9 files changed, 96 insertions(+), 50 deletions(-)

-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
