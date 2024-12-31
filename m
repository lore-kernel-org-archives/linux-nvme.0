Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E621BE77188
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Dec 2024 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HnLc1AGBvCq7BnMoAVRDRP57x+M/PY2hO+uqImQvyEA=; b=nZGNhcNmKCD93XhhVSbrd4pwdS
	JZ0qrbXq1q8PcChGbDTSqS8I4MqqPtv3lOuFIwC+TPpFApSnSHwyT7Akswnjr39Okq0e5shGu0v3I
	/nnh+Ciwm0/Ozdmj7AifkxpSHeGXAGeH9etrXxPv4rxNsarK8aaqWeK9i/JzrBEfB31d4MxI33xMh
	w2kozHFLPnpMq23YvLzKOnPxZtPZf9EaRt8hVlJwLY87jBkgZnJPmPOlbCmSo2mvgjRPdareTB0Fa
	dHylbqA2p08xoEi9a39tYN36ZNje6vhfPN9+UP7sYzwiN/kz5H1f/76+rTokhjsATAAMgGa322l96
	L5d7+ddA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tSgFB-00000007YPD-0X9s;
	Tue, 31 Dec 2024 17:41:25 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tSgF4-00000007YOq-2z4r
	for linux-nvme@lists.infradead.org;
	Tue, 31 Dec 2024 17:41:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1AACDA407F8;
	Tue, 31 Dec 2024 17:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8D0C4CED2;
	Tue, 31 Dec 2024 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735666876;
	bh=uDFXXr7r2N3cmE9Sl8gYO+USzh8RIlQ9JwYIB5B6U+g=;
	h=Date:From:To:Cc:Subject:From;
	b=ecUolk3YVb6OEBMXeoH55BV1qqpvTBAJTyLhjBqAU1VC4na7N8UebgAfaKivWW641
	 aRgbEeGbqt+fGCWRTpGeu56pleHxkzyISoq+gStcpbUx/GfyERX1dExqyc2/o+ypz7
	 4ZMP/6IiltJAg4lhaI6ZCmJZwxpI4raNLAhVN8rblTahW1rryOVLb8iaOEpKJMy77W
	 lv6VO9Z6/9Z/1UFjy0PT36wXPhMQMnCTyhVdGhcUr+is9uNfPFOqRPSBWmFbbvlAun
	 IsbRouBAn6+2HLBOtIumxlkxQf3jOyjuAvCBOYdaN3vBXfEzrB/tLxYpSQaCpG0FXy
	 fmPxKi4RrcEUw==
Date: Tue, 31 Dec 2024 10:41:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.13
Message-ID: <Z3QsuprGMAMhy1i2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241231_094118_815236_58CD59A4 
X-CRM114-Status: UNSURE (   6.11  )
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

The following changes since commit 790eb09e59709a1ffc1c64fe4aae2789120851b0:

  block: get wp_offset by bdev_offset_from_zone_start (2024-12-10 13:24:24 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.13-2024-12-31

for you to fetch changes up to 36e3b1f9abe359b2bc25e81bc47b64354e42c9b1:

  nvme-tcp: remove nvme_tcp_destroy_io_queues() (2024-12-27 13:33:48 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.13

 - Fix device specific quirk for PRP list alignment (Robert)
 - Fix target name overflow (Leo)
 - Fix target write granularity (Luis)
 - Fix target sleeping in atomic context (Nilay)
 - Remove unnecessary tcp queue teardown (Chunguang)

----------------------------------------------------------------
Chunguang.xu (1):
      nvme-tcp: remove nvme_tcp_destroy_io_queues()

Leo Stone (1):
      nvmet: Don't overflow subsysnqn

Luis Chamberlain (1):
      nvmet: propagate npwg topology

Nilay Shroff (1):
      nvmet-loop: avoid using mutex in IO hotpath

Robert Beckett (1):
      nvme-pci: 512 byte aligned dma pool segment quirk

 drivers/nvme/host/nvme.h          |   5 +++++
 drivers/nvme/host/pci.c           |   9 +++++++--
 drivers/nvme/host/tcp.c           |  18 +++++++-----------
 drivers/nvme/target/admin-cmd.c   |   9 +++++----
 drivers/nvme/target/configfs.c    |  23 +++++++++--------------
 drivers/nvme/target/core.c        | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
 drivers/nvme/target/io-cmd-bdev.c |   2 +-
 drivers/nvme/target/nvmet.h       |   7 +++++++
 drivers/nvme/target/pr.c          |   8 ++++----
 9 files changed, 108 insertions(+), 81 deletions(-)

