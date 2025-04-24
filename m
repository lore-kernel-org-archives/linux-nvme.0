Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88284C369D9
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:Date:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WVBr/Ghbog4PLk/aG+exb7ALAkQhCwEw3ntq1YdW8UY=; b=Q6ZnPBe2cTjacqF6iOlr/EhaSo
	niHaixux65q6+WA60pWlP/IeZ4ZZ0QvnxWggZGO0s2Q/dYg8eSUMg9PdNXr/M1nyEnVMaK/yyZdN/
	rZAVAoRhLWDNxZwiEz+yIkXEiY6fuPxGdrXOdqFB+i6fhvQoY3e+lodYZPWsMVtWMNoce8dOGCapE
	WDLwnn7G1srpCe2xOWvCNDbCSnS9VXKJRt7PpZGCKWCe0RWJhSzYvPz5XAulpHtKSIVFMXii//ZAS
	o4zPO7ccOH0ZhEl2GqFpFGmJ99sDy9gXp0ms/6w4UFrVIBSPowYhtOcCGylyTyc3kzWj6t0oKb8K7
	ZZD15MMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7z2z-0000000EZdu-095U;
	Thu, 24 Apr 2025 16:03:33 +0000
Received: from [2001:4bb8:2a7:ccbe:8b0f:ffa1:e482:eff5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ufp-0000000DqGL-19zn;
	Thu, 24 Apr 2025 11:23:21 +0000
From: hch@infradead.org
Date: Thu, 24 Apr 2025 13:23:16 +0200
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.15
Message-ID: <aAofJOcb2NzkXsP9@infradead.org>
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

The following changes since commit 81dd1feb19c7a812e51fa6e2f988f4def5e6ae39:

  Merge tag 'nvme-6.15-2025-04-17' of git://git.infradead.org/nvme into block-6.15 (2025-04-17 06:18:49 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-04-24

for you to fetch changes up to 3d7aa0c7b4e96cd460826d932e44710cdeb3378b:

  nvmet: fix out-of-bounds access in nvmet_enable_port (2025-04-22 09:50:28 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.15

 - fix an out-of-bounds access in nvmet_enable_port (Richard Weinberger)

----------------------------------------------------------------
Richard Weinberger (1):
      nvmet: fix out-of-bounds access in nvmet_enable_port

 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

