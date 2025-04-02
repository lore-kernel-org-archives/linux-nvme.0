Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5315C36017
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Apr 2025 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MGKX3GEVdoYlihhN8fkUncAEXXQ4gSrHv3lFuTLaLEg=; b=0xd3lTA6HCx0DiGxpqQcjMh1QB
	RNqtuNbm/Oi3qVd3hdfIjEI9P+ancqVuKYZvyShuMS3T0njKG1Folp4g8Z1C9UiP27qhR+ECoLjNb
	LyeqR5yJ8jTLYq0WgeqK5anWSLTrdRT0QnHJ4GPvNX+9gC7wL8igB3t6jqUqeC9Zknxp2pwchb432
	vO6372JAL3SmLAFnbnD0ciUpuUCK/cC1gxbn7WJZhEkigkTCIr5lDQyTA3ldRXCduu5ikvlT03ASI
	lFe1ywXc9i0Iit00Gk0F06FFwDnTdrVQpYUYoF9VxKl8Vm4DlkB35HK+uRjMA/VkdAvHdWuqS5mYi
	5gs29s4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02PU-00000006s3m-1xUN;
	Wed, 02 Apr 2025 18:01:56 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u02PR-00000006s3Q-25nu
	for linux-nvme@lists.infradead.org;
	Wed, 02 Apr 2025 18:01:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 26E3DA41703;
	Wed,  2 Apr 2025 17:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 497F2C4CEDD;
	Wed,  2 Apr 2025 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743616911;
	bh=UXlktAMWQSHlLtYPxsXnz5C8+z///cRUwrR2tbXU6Zw=;
	h=Date:From:To:Cc:Subject:From;
	b=plOirb+j2ZmcllqoSaZju8uiucH5tiGgZQ0JhDXiGUGxaxQURmLS8jY3lztqzG3as
	 x0hcd7G677ww69o7vMcVTvFdDInGOAiOvxEXCQJzEWqWgw+yjuDnXjEUP180Jj2Bym
	 z1xaBZe605/z1GyONyhEUidO/nUfcWgEz55wxSFnMlEz6zz1bcyRg43PRdYw+lXScL
	 EC6ap9j2Nb5TIjRbPKppW1vKYvF+Io8NKYhqs5qq29zPBw0rgnBXG651zamMJG/6rT
	 eXMqmufVDnv0z1UGs03POZwFTFOUUTOFmT0APSLClzntA3z9DPT5hju4fxnh3pvKkc
	 mOivGyFiwac/A==
Date: Wed, 2 Apr 2025 12:01:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.15
Message-ID: <Z-17jFW3e0ta22JW@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_110153_602398_B732D294 
X-CRM114-Status: UNSURE (   8.34  )
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

The following changes since commit e3e68311ead15d8be61e8e1a8d2f0d1773a7ba9c:

  block: remove unused nseg parameter (2025-04-01 07:21:35 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-02

for you to fetch changes up to 288ff0d10beb069355036355d5f7612579dc869c:

  nvme-pci: skip nvme_write_sq_db on empty rqlist (2025-04-01 09:01:06 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.15

 - PCI endpoint target cleanup (Damien)
 - Early import for uring_cmd fixed buffer (Caleb)
 - Multipath documentation and notification improvements (John)
 - Invalid pci sq doorbell write fix (Maurizio)

----------------------------------------------------------------
Caleb Sander Mateos (3):
      nvme/ioctl: don't warn on vectorized uring_cmd with fixed buffer
      nvme/ioctl: move blk_mq_free_request() out of nvme_map_user_request()
      nvme/ioctl: move fixed buffer lookup to nvme_uring_cmd_io()

Damien Le Moal (1):
      nvmet: pci-epf: Keep completion queues mapped

John Meneghini (2):
      nvme: update the multipath warning in nvme_init_ns_head
      nvme-multipath: change the NVME_MULTIPATH config option

Maurizio Lombardi (1):
      nvme-pci: skip nvme_write_sq_db on empty rqlist

 drivers/nvme/host/Kconfig     | 13 +++++++++----
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/ioctl.c     | 68 +++++++++++++++++++++++++++++++++++++-------------------------------
 drivers/nvme/host/pci.c       |  3 +++
 drivers/nvme/target/pci-epf.c | 63 +++++++++++++++++++++++++--------------------------------------
 5 files changed, 75 insertions(+), 74 deletions(-)

