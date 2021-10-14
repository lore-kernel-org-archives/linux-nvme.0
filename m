Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0270C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:17:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A5760E96
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 08:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1A5760E96
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=23p+T0tGpMlNZUopKvREpNtpwsNoh2ybY4O0b8iKYvs=; b=oXrk1leQjjDexEua4HC9bZ/XDW
	OHxKV/XtlBOWnitzKWyILNfaPiv9R3G7YR5FLU/9e9eQpLPt8wbcEWi4QgqgEt6ku/MsNUHeBHU+q
	RPykNxiFucPFGfC6mUrsb/wFF7tO1Jlf7q5uP3PoR7p8/kqPO6vAsxi0vigJXmyzcCEfbIu2JiCaR
	R1g7V/CkHlANYXo5j9PBIaNmO+2GPWfaX087KsJo0B53pd/z8ZLJzTEbJZc2jEkICsGz9QUvxOtUJ
	qcG1Tf4oVMfdcsgiXW2TqqdZJR58eq5UT8dFT+lg5ln3cmAFJTbE8cAykMiuA+cfF058SIrt/nYN2
	+CisSjjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mavvj-0028zL-Cw; Thu, 14 Oct 2021 08:17:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mavvg-0028yD-M7
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 08:17:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634199451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=23p+T0tGpMlNZUopKvREpNtpwsNoh2ybY4O0b8iKYvs=;
 b=XPEPysko8QeroEHU6B5MBUkNPeagmkc5W0JuXYpA5WzHtxu+sgKZ7mpxD+4zv0R8XTnuIu
 bICaRV1pKf/THfInwD7qub/5Y7FaHAMNDZxC+Be9oGjtQ8s4mEB7Urtgacvq292QJJhdFB
 gUAOCUu2KofvWAr2IpT1MzwubyXo1SQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-rYZtqdW1NXCsXH_7RiWt7Q-1; Thu, 14 Oct 2021 04:17:26 -0400
X-MC-Unique: rYZtqdW1NXCsXH_7RiWt7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89B16801ADA;
 Thu, 14 Oct 2021 08:17:24 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 837125F4EA;
 Thu, 14 Oct 2021 08:17:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] blk-mq: support concurrent queue quiescing
Date: Thu, 14 Oct 2021 16:17:04 +0800
Message-Id: <20211014081710.1871747-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_011732_816598_663EEEBE 
X-CRM114-Status: GOOD (  12.73  )
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

V4:
	- one small patch style change as suggested by Christoph, only patch 6/6
	is touched

V3:
	- add patch 5/6 to clear NVME_CTRL_ADMIN_Q_STOPPED for nvme-loop
	  after reallocating admin queue
	- take Bart's suggestion to add warning in blk_mq_unquiesce_queue()
	& update commit log

V2:
	- replace mutex with atomic ops for supporting paring quiesce &
	  unquiesce


Ming Lei (6):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is
    reallocated
  blk-mq: support concurrent queue quiesce/unquiesce

 block/blk-mq.c             | 22 ++++++++++--
 drivers/nvme/host/core.c   | 70 ++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c     |  8 ++---
 drivers/nvme/host/nvme.h   |  4 +++
 drivers/nvme/host/pci.c    |  8 ++---
 drivers/nvme/host/rdma.c   | 14 ++++----
 drivers/nvme/host/tcp.c    | 16 ++++-----
 drivers/nvme/target/loop.c |  6 ++--
 include/linux/blkdev.h     |  2 ++
 9 files changed, 100 insertions(+), 50 deletions(-)

-- 
2.31.1


