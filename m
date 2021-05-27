Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8C6C4707F
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:58:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C81610FC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 11:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C81610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Z3S512wegGsV8GUKwz4pvjPCodEWlbjCkb3R+ugx/1Y=; b=ku9RpumneGbA4o
	PEiZH1q0HOPNI74J33ISzRPzX7zeKlsvUkPlGGBJPdS/MbHJBxhSnJOZxqqonZ4YFqqH82XyB+alU
	su8WdWWYlXgYWhwXaMMcvMVCivIE5EW/Wu/sLBSERY8uwNI1mWIqR7lW5ujjNEqGV6C3vI9FlKhX3
	Co4STq2sE97ldOxPLDSVuNr9UEYLvPb/k1gLTdyY9DdS7n4iy5TwwQ/DGJ0UTydO4YKHZ9PZVdw6i
	4jPBKlNpUyltMg+vximf9EgrUKLGEUp4HS4Wyl9QpLdKP51JQdb3k05K6IvQ8q4dbUy8O5WIPGVaR
	NTXU0s0INKqyqS685x1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmEeg-005XPQ-DT; Thu, 27 May 2021 11:58:26 +0000
Received: from [2001:4bb8:190:7543:4a62:72ba:8559:b110] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmEed-005XMd-Sw; Thu, 27 May 2021 11:58:24 +0000
Date: Thu, 27 May 2021 13:58:21 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.13
Message-ID: <YK+JXQOdbaoUH4Zr@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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

The following changes since commit bc6a385132601c29a6da1dbf8148c0d3c9ad36dc:

  block: fix a race between del_gendisk and BLKRRPART (2021-05-20 07:59:35 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.13-2021-05-27

for you to fetch changes up to aaeadd7075dc9e184bc7876e9dd7b3bada771df2:

  nvmet: fix false keep-alive timeout when a controller is torn down (2021-05-26 16:18:22 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.13

 - fix a memory leak in nvme_cdev_add (Guoqing Jiang)
 - fix inline data size comparison in nvmet_tcp_queue_response (Hou Pu)
 - fix false keep-alive timeout when a controller is torn down
   (Sagi Grimberg)
 - fix a nvme-tcp Kconfig dependency (Sagi Grimberg)
 - short-circuit reconnect retries for FC (Hannes Reinecke)
 - decode host pathing error for connect (Hannes Reinecke)

----------------------------------------------------------------
Guoqing Jiang (1):
      nvme: fix potential memory leaks in nvme_cdev_add

Hannes Reinecke (2):
      nvme-fc: short-circuit reconnect retries
      nvme-fabrics: decode host pathing error for connect

Hou Pu (1):
      nvmet-tcp: fix inline data size comparison in nvmet_tcp_queue_response

Sagi Grimberg (2):
      nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
      nvmet: fix false keep-alive timeout when a controller is torn down

 drivers/nvme/host/Kconfig   |  3 ++-
 drivers/nvme/host/core.c    |  4 +++-
 drivers/nvme/host/fabrics.c |  5 +++++
 drivers/nvme/host/fc.c      | 25 +++++++++++++++++--------
 drivers/nvme/target/core.c  | 15 +++++++++++----
 drivers/nvme/target/nvmet.h |  2 +-
 drivers/nvme/target/tcp.c   |  2 +-
 7 files changed, 40 insertions(+), 16 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
