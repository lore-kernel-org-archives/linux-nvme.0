Return-Path: <SRS0=D92Q=IR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48A6C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 07:16:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA4C164DFF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Mar 2021 07:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA4C164DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l5pReNN1qtyo+FI3Onwnp3wA9Pd6mQmMc/B1JhX3CVs=; b=F4yUF3/OVSmmmze7p3lYmUiwm8
	gl3iWk63uV2JVBTmTX/J4co74iun0Ezjt5B5lWThB1r5S1n4kHJwnRhgsr4AlGOjMS0NcA9C7Yet/
	W1C9/7nKnhB9sGHYwkyWo5kWcuzJY9fNW3O1gNPhAheihc9Rb0CnWwxdDpk+0nYGi4xTBFaWCLMXk
	Kx8/5MuGvpuoeEzlouaM1qr3g7KJMZPT5tVmqt4nrrtZbe3sQ8yeVpxuD1J1FoaCGmO/XODiJJuJy
	reZxoEZFfNneAyYIWwae62WxphKglH9sNrbB3ygnASFVMT+Mb097abXXq9T9K6XY0CfA1FxFUtqR9
	JmRe34kg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lN9N8-006mms-Mm; Fri, 19 Mar 2021 07:16:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lN9N3-006mmQ-PY
 for linux-nvme@desiato.infradead.org; Fri, 19 Mar 2021 07:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=M76xO1K/EQV5CCb+NqCLsqK0FN5oML1Ebg7OCq+pRBQ=; b=jxcC9LoF5K+EckjwTs6DaZdETQ
 y9XFjmtdVE2fcqDbe/TC2f4Q8OGLdYN9gdfG1t5ynE1u+UxmLnMXSEgMh6CftwuL6VuLB8MtJPV9x
 CV5IIBSvoVewMkk35HP7qjWcBh+DxEKZJfp2a5d00y0p0vbfBwR8qz7edSSou3mYxp9TTQvHCv7tO
 54Y7SRNkYWG5NRUc0jk8ZbUu0KiVzudYqAv4UONvtZJJQm4oP2Xgje7uVDtbJKGg2xRkmPeNdTTBV
 j4blFiTeRHXVVqiQtB2Wy5h4UpkLuxVE9VbpkObjoq+O5gBINlbVlp7yZH9ZKrfoOcBdBl9gkqCmm
 AXhyKdkg==;
Received: from 089144199244.atnat0008.highway.a1.net ([89.144.199.244]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lN9Mt-0045v0-Vh; Fri, 19 Mar 2021 07:16:26 +0000
Date: Fri, 19 Mar 2021 08:14:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YFRPRP/WLS/5FCSc@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-20210319

for you to fetch changes up to bac04454ef9fada009f0572576837548b190bf94:

  nvmet-tcp: fix kmap leak when data digest in use (2021-03-18 05:39:18 +0100)

----------------------------------------------------------------
nvme fixes for 5.12

 - fix tag allocation for keep alive
 - fix a unit mismatch for the Write Zeroes limits
 - various TCP transport fixes (Sagi Grimberg, Elad Grupi)
 - fix iosqes and iocqes validation for discovery controllers (Sagi Grimberg)

----------------------------------------------------------------
Christoph Hellwig (4):
      nvme-fabrics: only reserve a single tag
      nvme: merge nvme_keep_alive into nvme_keep_alive_work
      nvme: allocate the keep alive request using BLK_MQ_REQ_NOWAIT
      nvme: fix Write Zeroes limitations

Elad Grupi (1):
      nvmet-tcp: fix kmap leak when data digest in use

Sagi Grimberg (5):
      nvme-tcp: fix a NULL deref when receiving a 0-length r2t PDU
      nvme-tcp: fix misuse of __smp_processor_id with preemption enabled
      nvme-tcp: fix possible hang when failing to set io queues
      nvme-rdma: fix possible hang when failing to set io queues
      nvmet: don't check iosqes,iocqes for discovery controllers

 drivers/nvme/host/core.c    | 64 +++++++++++++++------------------------------
 drivers/nvme/host/fabrics.h |  7 +++++
 drivers/nvme/host/fc.c      |  4 +--
 drivers/nvme/host/rdma.c    | 11 +++++---
 drivers/nvme/host/tcp.c     | 20 ++++++++++----
 drivers/nvme/target/core.c  | 17 +++++++++---
 drivers/nvme/target/loop.c  |  4 +--
 drivers/nvme/target/tcp.c   |  2 +-
 8 files changed, 69 insertions(+), 60 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
