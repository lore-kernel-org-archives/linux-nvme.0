Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19374C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5B6o3SqHy457KHdlRJXgJOZMyj57yqsxZre3J7driDE=; b=dyRwC2YAMoumV5k4v9KFYYK3lb
	KFbsWQG4KNNIyl5+utr6Eht+sSQFJR/kdmBA7H9eXOq423pfZNbcBDhcUW8cqAM+mUtqovzNtRrMM
	PZqCUVCcGi46X8TGURjLp6vEG1uF0Pt2wW3GH07tgzcsWio3WqPO6jRL3zyKH7aUx1fK4HlOhBnfi
	oXLFdo19L3YnII1jRBzjXcuC2Dphgh0Sn13uESkx2KLZemvSSc9byfQRWk7PCMiL3a1feojku6fq6
	NX6hQ9q9czZc4wVssH5rZvUq9npIMiGmLiE9731wHB4Eq3Vy9qRmhTs9qDXBVMhRbGZwH7BXmoVT5
	ORojA9gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv5Q-000000076u6-0eix;
	Wed, 05 Jun 2024 18:10:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEv5N-000000076tQ-1RZv
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 18:10:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 412706199F;
	Wed,  5 Jun 2024 18:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908D4C2BD11;
	Wed,  5 Jun 2024 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717611007;
	bh=NC0HbXLFMcdESYCLWn4GeHCbeySYAbMnB+vyqbnOi8I=;
	h=Date:From:To:Cc:Subject:From;
	b=B7ixP07lr1Va1UnBjBXMd7gVlBUBdN8/9Eo6ii4UPJgyjQvwkoP484A7G3mG1RZD/
	 B3VNil7tonl0kB3/rXTirS5BVBTntvPUb33TftfIdpJfuq+dSf17zm4wWQatHg15DC
	 PEEX+JTwGed45hZmi6BA+2SLWShvDYf6DmbtwVsBaMfFVQjZL93zp+07TiHfyhzYIF
	 znZD6hY8hjlmRR8eKf5q7ZK48xSg40WTLTALmNcqEDKSiTpbG34rmMqmVUn+yaJWjx
	 FBbPzm8/lDazpLqvDCHXJfWyNikWbx+mlBM4eoUQKwczqUwEqVT+gTFXd4TGPwJ9LM
	 yvwSm/cEK+fhQ==
Date: Wed, 5 Jun 2024 12:10:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.10
Message-ID: <ZmCp_ZJF9ExtjwUP@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_111009_662076_3BD7678F 
X-CRM114-Status: UNSURE (   7.06  )
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

The following changes since commit 29459c3eaa5c6261fbe0dea7bdeb9b48d35d862a:

  block: Fix zone write plugging handling of devices with a runt zone (2024-05-30 15:03:52 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.10-2024-06-05

for you to fetch changes up to b1a1fdd7096dd2d67911b07f8118ff113d815db4:

  nvme: fix nvme_pr_* status code parsing (2024-05-31 13:50:59 -0700)

----------------------------------------------------------------
nvme fixes Linux 6.10

 - Use reserved tags for special fabrics operations (Chunguang)
 - Persistent Reservation status masking fix (Weiwen)

----------------------------------------------------------------
Chunguang Xu (1):
      nvme-fabrics: use reserved tag for reg read/write command

Weiwen Hu (1):
      nvme: fix nvme_pr_* status code parsing

 drivers/nvme/host/fabrics.c | 6 +++---
 drivers/nvme/host/pr.c      | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)


