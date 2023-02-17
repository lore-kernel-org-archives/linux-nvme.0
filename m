Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D5CC636D4
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 13:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dh2mOVLVNuPHRCozUiQ72xMyWhCXI8s2QDhvo1SiyDM=; b=fyg69RVu9pH7tkdYoTqvd2bpj1
	KXonmstjZJ3D1vnQH0C4Aye5cb7+1DEEHuxRZSvrmMWHhBH2WB/Hq4DQ+8t58o6rlLaX4AA/UnXgw
	ADpU6DK4+bdnH8jY2e5yL5bf3At+ozEwY39/uJEpgvaPj9UAJhmTHM/+6G2ZT0Y92dNv0rawmbiXB
	5OrNh7m0n1xqUNWWJXR/Z41RxSzaTTTbAjqy8Pvamj5MtrrMI7fMmeHindIGq1D7z6rf1DKM9skio
	5HMv9B2177WmQYNn+9oqhTV/c7brRxkKkt5vT5J7rShtmdrhWpnZw4v8G6oV7Gsp6x6eavzVxDXE9
	zePLKIpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0k0-00EHG7-60; Fri, 17 Feb 2023 13:25:32 +0000
Received: from [2001:4bb8:181:6771:d986:bedf:4fff:d74c] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pT0jy-00EHF9-EJ; Fri, 17 Feb 2023 13:25:30 +0000
Date: Fri, 17 Feb 2023 14:25:27 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.2
Message-ID: <Y++ARzuse5GE4UCL@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 9a28b92cc21e8445c25b18e46f41634539938a91:

  Merge tag 'nvme-6.2-2023-02-15' of git://git.infradead.org/nvme into block-6.2 (2023-02-15 13:47:27 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2022-02-17

for you to fetch changes up to e917a849c3fc317c4a5f82bb18726000173d39e6:

  nvme-pci: refresh visible attrs for cmb attributes (2023-02-17 08:31:05 +0100)

----------------------------------------------------------------
nvme fix for Linux 6.2

 - fix visibility of the CMB sysfs attributes (Keith Busch)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: refresh visible attrs for cmb attributes

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

