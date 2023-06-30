Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B87EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 18:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dRRn2roOPXnyISWHk0mrZ5eEGp3Vks8yYnvKdd5Dtc4=; b=JSKSP8sUvM92zsly+k+rO8G1nj
	SABfwrnm8gmGFvxBfOdFB+47sv2MIJ/UxmZ2Es7qUcqyG90Zpu/+8GANaLNWM7s0liVsuB7/B9Drh
	HFFzEERprFE4R/J8UK/7zQP4Tm+XOJzXBsyIDzYwqHtCHspwvgoUg1QUUuVFBQ0bZD9l5G1zK25lO
	m3ual2n+H19emogoakm+/iI/jpeIYk27CLLSCZDLLNNy+LE07riuW6Oc3BeQf4nEaYg+Xs/NcHmbU
	XxTdim3miuuwOIEs2vz97AsrVPr8ueIUgzc3qjfcboUHKCCSrAWQCjGab4YxFkFfN7RdU/xtpO1pN
	YPdqj5Rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIuC-004JRM-2H;
	Fri, 30 Jun 2023 18:31:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIuA-004JQq-0a
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 18:31:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 302C5616D7;
	Fri, 30 Jun 2023 18:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4C0C433C8;
	Fri, 30 Jun 2023 18:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688149896;
	bh=I4dxuCXpaoTh7tNOX2QIMFAuPKtmcJ66Opmg4bI0YZo=;
	h=Date:From:To:Cc:Subject:From;
	b=JswhxT+QCmPjURpoNrpzF3Ya7keWfJHYG5IdF3SIPwhgVbiTlWen4Pm+eEsGdO7ct
	 q3phYfSgL+QUmVWJ7+EP3fJiDz3nBx/pEkxvBZN5yF8CWi0tRZ16bacL4f6aJmCtB+
	 G11LNvkIyoxSyN+pcRA2QFU5fwDwyIWbwvu7zEVEl6WwZBTH+0V6gr5ZWuFPbNxJlN
	 ECpPTLjUxsNKG5SS2ixty9jDrIDDbLT8KALxTfBJ3aLnwUh4F+7X7C+mTnIZqm4yCp
	 sMGr84m++C+UPpt0HgIdi9M+i/RA8/AdabGyVlsyUkb2uy3Zx5tkl9tN0eN6YTyHR4
	 xiS1Zt1wB1u5w==
Date: Fri, 30 Jun 2023 12:31:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.5 (part 2)
Message-ID: <ZJ8fhWv2CuF+o//Z@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_113138_284793_1BE0311F 
X-CRM114-Status: UNSURE (   8.98  )
X-CRM114-Notice: Please train this message.
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

The following changes since commit 2293cae703cda162684ae966db6b1b4a11b5e88f:

  blk-mq: don't insert passthrough request into sw queue (2023-06-21 07:48:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.5-2023-06-30

for you to fetch changes up to 4e69d4dabd2379af57b0b8fb9b0d62c23f9cd3b8:

  nvme: disable controller on reset state failure (2023-06-30 10:48:20 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.5

 - Reduce spamming kernel logs on repeated controller updates (Breno)
 - Improved struct packing (Christophe JAILLET)
 - Misspelled command name in error logging (Damien)
 - Failover fix for temporary frozen queue (Sagi)
 - Reset error handling fixes (Keith)

----------------------------------------------------------------
Breno Leitao (1):
      nvme: Print capabilities changes just once

Christophe JAILLET (1):
      nvmet: Reorder fields in 'struct nvmet_ns'

Damien Le Moal (1):
      nvme: host: fix command name spelling

Keith Busch (3):
      nvme: ensure unquiesce on teardown
      nvme: sync timeout work on failed reset
      nvme: disable controller on reset state failure

Sagi Grimberg (1):
      nvme-mpath: fix I/O failure with EAGAIN when failing over I/O

 drivers/nvme/host/constants.c | 2 +-
 drivers/nvme/host/core.c      | 6 +++++-
 drivers/nvme/host/multipath.c | 8 ++++++++
 drivers/nvme/host/nvme.h      | 1 +
 drivers/nvme/host/pci.c       | 5 ++++-
 drivers/nvme/target/nvmet.h   | 2 +-
 6 files changed, 20 insertions(+), 4 deletions(-)

