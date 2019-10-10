Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37509C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D32F206B6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QN491P4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D32F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=sdAT0f6lSBWJpjqoaoP2F0FHPfbBGIT4/gT0+WNgNxI=; b=QN4
	91P4iCACOh+gIsWRKYllGBlN2VmnmmBih3rWmutUHiFp++FytkYZeacFYTQnM06SW2Qnw6XtMRFHS
	QAMssIqGXPtoxYvAmqhm4aeko5dvCKQ7gTplc5JdVgXb1lB5jMfiWEcLTfZ/iv9YIDV3voUSmNNG2
	1jMrcxmpH5bMIPcisWjMGm2O8GoXIRAdHC0j5kdcDWbXbHACiYl7wgeetHkuJB66F37GSqxTc5Ztx
	U6s8OXIH9uisfuBDOC5bBaaHFD3tyha27uL+8tgxIww9fmsayeINrHPAZ+JbCo0e/Vp/Rrtx5Nxvx
	0SzHHKREfwdiAiBwx+HEC2S+T8KWrMw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIYUb-00059s-1I; Thu, 10 Oct 2019 13:28:33 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIYUW-00057Z-TQ
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 13:28:30 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 10 Oct 2019 15:28:20 +0200
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9ADSKfH006526;
 Thu, 10 Oct 2019 16:28:20 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Subject: [PATCH 0/8] small NVMe cleanups/fixes
Date: Thu, 10 Oct 2019 16:28:12 +0300
Message-Id: <1570714100-15520-1-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_062829_346818_2F07C1A9 
X-CRM114-Status: UNSURE (   7.46  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com,
 james.smart@broadcom.com, shlomin@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Sagi/Christoph/Keith,
This series include few fast-path and code readability improvements from
IsraelR and also few memleak fixes and new status code introduction from
myself.

This series applies cleanly on top of nvme-5.4 branch, commit 3a8ecc935efab
("nvme: retain split access workaround for capability reads")

Israel Rukshin (4):
  nvme: Introduce nvme_is_aen_req function
  nvmet: Use bio_io_error instead of duplicating it
  nvmet: add unlikely check at nvmet_req_alloc_sgl
  nvmet-rdma: add unlikely check at nvmet_rdma_map_sgl_keyed

Max Gurtovoy (4):
  nvme: introduce "Command Aborted By host" status code
  nvme: move common call to nvme_cleanup_cmd to core layer
  nvmet-loop: fix possible leakage during error flow
  nvme-tcp: fix possible leakage during error flow

 drivers/nvme/host/core.c          |  6 +++++-
 drivers/nvme/host/fc.c            |  3 +--
 drivers/nvme/host/multipath.c     |  1 +
 drivers/nvme/host/nvme.h          |  5 +++++
 drivers/nvme/host/pci.c           |  4 +---
 drivers/nvme/host/rdma.c          | 16 +++++++---------
 drivers/nvme/host/tcp.c           |  5 +++--
 drivers/nvme/target/core.c        |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  8 +++-----
 drivers/nvme/target/loop.c        |  9 +++++----
 drivers/nvme/target/rdma.c        |  4 ++--
 include/linux/nvme.h              |  1 +
 12 files changed, 35 insertions(+), 29 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
