Return-Path: <SRS0=2FDT=7Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B54C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 06:23:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E3DB2074B
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2020 06:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A0Zd1MIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3DB2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=LF/xDHwY8W1Xn4kp60U01gGo2Wwrh5E9zM7ZhEcteBg=; b=A0Zd1MILFjZxXR
	fi1YAmJzi4IpwgxgibGurXAJOnw3wwWtsugkydF9E6nYzvIp5OxTxaIL6UESE2WzOZSEcS0zQ4dRi
	04Dc3Or/UANZBbkkOz73dXF22uhF0d3BFxVJ55R3MSiIV31QN8eMeaIgCyceSmtGaR9BPXxjIV5e/
	JXaB+fxTeKfmygxAQj9KK34abl5hKrpKi0MVZU4sF6luXVFPCZS+kRMI9F1XPoK6a6Awg3RfDHZJR
	dPLCukAieedttvtgSyOkRnr4Uz2nA6i3WIb8cqgux7LQnWVTcAlCOL+hSQcD83ALM6adjAkA1cDAq
	Di8Qi1gvoVVNXyOzqd4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjGc9-0001Tx-9g; Thu, 11 Jun 2020 06:23:01 +0000
Received: from [2001:4bb8:18c:317f:efe9:d6fc:cdd9:b4ec] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjGc7-0001TF-Ei; Thu, 11 Jun 2020 06:22:59 +0000
Date: Thu, 11 Jun 2020 08:22:57 +0200
From: Christoph Hellwig <hch@infradead.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme fixes for 5.8
Message-ID: <20200611062257.GA11119@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit abfbb29297c27e3f101f348dc9e467b0fe70f919:

  Merge tag 'rproc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc (2020-06-08 13:01:08 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.8

for you to fetch changes up to 103ab3d94987ec18f222e78851807574fe59e6c2:

  nvmet: fail outstanding host posted AEN req (2020-06-11 08:15:15 +0200)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: fail outstanding host posted AEN req

Christoph Hellwig (1):
      nvme-pci: use simple suspend when a HMB is enabled

Daniel Wagner (1):
      nvme-fc: don't call nvme_cleanup_cmd() for AENs

Max Gurtovoy (1):
      nvmet-tcp: constify nvmet_tcp_ops

Niklas Cassel (1):
      nvme: do not call del_gendisk() on a disk that was never added

Rikard Falkeborn (1):
      nvme-tcp: constify nvme_tcp_mq_ops and nvme_tcp_admin_mq_ops

 drivers/nvme/host/core.c   |  4 +---
 drivers/nvme/host/fc.c     |  5 +++--
 drivers/nvme/host/pci.c    |  6 ++++++
 drivers/nvme/host/tcp.c    |  8 ++++----
 drivers/nvme/target/core.c | 27 ++++++++++++++++++++-------
 drivers/nvme/target/tcp.c  |  4 ++--
 6 files changed, 36 insertions(+), 18 deletions(-)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
