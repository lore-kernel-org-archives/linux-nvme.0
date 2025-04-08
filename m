Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4D6C36010
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 02:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Aq7V/gynHPRunG/aD9E6rdRfx0Clu5C3ezJpBcQAmk=; b=PqdcM09syPJmbB86MChkJy7hbL
	WQnihuMmo5pOB6QHYOhLx8Uv+70kXggPUtzAqwwW/MkbmhRI4dgAjhxdEyYZ8dyB55gpCvvmP2b/I
	h0SKNSCVawjiVwbX5/CtAn3FeB3i7nXzQJzljuUwmafbDew4V5VawC0TUgTVg5brqGosih9WOVP0P
	g9qBwJyQA3qxy0tCPXjL0vfQE6CN9I4jK3YWV3eXma1y0RRzSmM4YTw+wquHpEcHrJk45y2JVeiDC
	0WfUmDtiZXLmvzdweOErL/y6ESbBGjnzm5u1iL7QJV+ytlY6i0Tpdo29+HG3KxTPXUS3x6pNg23vY
	ydQkEL/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0f-00000002Xtu-3zT6;
	Tue, 08 Apr 2025 02:48:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1z0b-00000002Xtn-0g1a
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 02:48:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A201461141;
	Tue,  8 Apr 2025 02:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1531EC4CEDD;
	Tue,  8 Apr 2025 02:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744080495;
	bh=ecRqSQ5afQyg25WDtwQzFyJ739qpLdzlQbJKV/a7l/g=;
	h=From:To:Subject:Date:From;
	b=YVGSuDY/QJC2h+dTZf4TkAkIKufAw7KorXERAH9WETPrf5qJNKh6JbIFUvQi9rOAu
	 8KIAOZydHsIcOMLUGuAI5SGm2vwg2H606DucXFZA2bfa3oa0AaynwNFnoghegWAkRE
	 rBoHZgSAxEu4zTqunuBbwwV2whzHiKMdGg+RhN9d/SCeRiV/3I4rgrqLSYRQDzuyOj
	 tmul1U+ZKDsYOQojInj8+hKYU6W36iYeFkEEaLlF+R+ZstPdA8DG0NK3D0GKRKstBe
	 mkmGFU0UCX8JqPl92kOOX9Dgp5SUih2Dlo6tA/Yzbts+RW6Rz+On72tm3SpLQjv84b
	 0bdosxdFkk5iQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 0/3] NVMe PCI endpoint target fixes
Date: Tue,  8 Apr 2025 11:47:30 +0900
Message-ID: <20250408024733.690966-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Two bug fix patch and one cleanup patch in this series.

The first patch fixes an issue with completion queue entries
initialization in the case of failed commands.

The second patch fixes
the initialization of the CC register to ensure that we can always
detect that the host is attempting to enable the controller (with
CC.EN).

The last patch cleans up/simplifies the management of the PCI link
state.

Damien Le Moal (3):
  nvmet: pci-epf: Always fully initialize completion entries
  nvmet: pci-epf: Clear CC and CSTS when disabling the controller
  nvmet: pci-epf: Cleanup link state management

 drivers/nvme/target/pci-epf.c | 65 ++++++++++++++++++++++-------------
 1 file changed, 42 insertions(+), 23 deletions(-)

-- 
2.49.0


