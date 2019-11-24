Return-Path: <SRS0=zMYu=ZQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C61C432C3
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 16:39:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B7362075E
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Nov 2019 16:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AiTNz7u6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B7362075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/WiaLF8XQMmoZ4zlbSWGjO3zIlQ4KkMH4dICeuAu0rU=; b=AiT
	Nz7u6QETo+CwpoidG/KFu1YUzKN3ZIUFVYazHKrqJJw4CScLDWjoHUJiZqPUxF9EZsgDBx8LHqsLP
	BrEQZFCAuXWzm9sbGbekk4rBxJSMSomuK36t5VbOCXSy0Hepp3nLdPcAG2DSmqJ/cnK45qpWYeJko
	U6x4pL7QhRGB6/CGqDOkD/TsUJzecvNYgdQOZbcJ7yxWqbFUKnZpHjAAIcSTYquebrL42m4Kb9m0i
	TEeJUSXZRymETByjMBAKDNSJVE+bcOnsnkTNoIMeLysFRAinX54FEE/xVHIjmJp+083OGnYS0f1nv
	LkUmhMigha4z+6I2Z6dVWdpyh1vgLhw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iYuuf-0005qg-JF; Sun, 24 Nov 2019 16:39:05 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYuuc-0005pI-PD
 for linux-nvme@lists.infradead.org; Sun, 24 Nov 2019 16:39:04 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 israelr@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 24 Nov 2019 18:38:48 +0200
Received: from rsws50.mtr.labs.mlnx (rsws50.mtr.labs.mlnx [10.209.40.61])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xAOGcm6I029897;
 Sun, 24 Nov 2019 18:38:48 +0200
From: Israel Rukshin <israelr@mellanox.com>
To: Linux-nvme <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 James Smart <jsmart2021@gmail.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/3] nvme: Avoid preallocating big SGL for data
Date: Sun, 24 Nov 2019 18:38:29 +0200
Message-Id: <1574613512-5943-1-git-send-email-israelr@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191124_083903_222318_1C586C05 
X-CRM114-Status: UNSURE (   7.10  )
X-CRM114-Notice: Please train this message.
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
Cc: Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When nvme allocates a tagset it preallocates a big buffer for the IO SGL
based on SG_CHUNK_SIZE.

Modern DMA engines are often capable of dealing with very big segments so
the SG_CHUNK_SIZE is often too big. SG_CHUNK_SIZE results in a static 4KB
SGL allocation per command.

If a controller has lots of deep queues, preallocation for the sg list can
consume substantial amounts of memory. Switch to runtime allocation for SGL
for lists longer than 2 entries. This is the approach used by NVMe PCI so
it should be reasonable for NVMeOF as well. Runtime SGL allocation has
always been the case for the legacy I/O path so this is nothing new.

The preallocated small SGL depends on SG_CHAIN so if the ARCH doesn't
support SG_CHAIN, use only runtime allocation for the SGL.

Israel Rukshin (3):
  nvme-rdma: Avoid preallocating big SGL for data
  nvme-fc: Avoid preallocating big SGL for data
  nvmet-loop: Avoid preallocating big SGL for data

 drivers/nvme/host/fc.c     |  8 ++++----
 drivers/nvme/host/nvme.h   |  6 ++++++
 drivers/nvme/host/rdma.c   | 10 +++++-----
 drivers/nvme/target/loop.c |  8 ++++----
 4 files changed, 19 insertions(+), 13 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
