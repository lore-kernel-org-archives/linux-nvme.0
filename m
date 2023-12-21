Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C97AC35274
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=679LOrMhdHoIYsSq0DIOlVgyhoaHWmHADxxbISqB38s=; b=Jsdtztlpas7W0B1ReV1XzKvTxi
	3u5fQPI45Yy2SfyzNTRjTNNHjoKhI0kEloA7CfyOT4CYHwP/Ey4jkrGHzBtE3gaxJVLWsh50pyLeX
	rWXNVKiyoJkrs08B8b+oPv7XPRNpxX8qxvuBWgxFS+Nairnn03qZdg7SJ/lCRLGDakx4+c9uQq/5w
	NLJwojTsK6Q4bBo+8CwycIZm/jmCy/ZpbkxcdnpiOdTRiEMokM74/nNB6qgn5KGJHW5b+sDL/hHNw
	Rm7052SFbEhakCxy/tSCw7uH+1SRkDpfp35/v1PB0S0E+/mFiP4kTQ2rJ6jPUnHlD6wizYff0wH87
	9B+tyLgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQdG-004ARx-1t;
	Thu, 21 Dec 2023 21:31:06 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGQdD-004AQy-1E
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 21:31:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48EC3CE20F6;
	Thu, 21 Dec 2023 21:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C82C433C8;
	Thu, 21 Dec 2023 21:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703194259;
	bh=AGzaN5Gd905O0DDoCcPpDd7gcrF/G3nTykEjSnG5dQI=;
	h=Date:From:To:Cc:Subject:From;
	b=V+vc7jUeaSiQ+SqQHLM8WgLW6NiW/Uqiv0Xtgb3p1uT6VhIxVXjkWkwKNi2RXy9SD
	 m8LaqAlY8RrEV0cp8HvLBUN3MTkJxah9QNJ05WKa1A6iLwCpmh/iK4ERYWuAA0hv+i
	 NrQJD7rxNiJorEFQfM6WW04oiXHTS5JbeYE9IK3ttffSfk6maDwcnlOWvuQgoiZq+7
	 V+LBsfrp/zUE0eaeLgIsBeaey9K9DR4Fd6aH1a63Wn1XGH146OKVGIyxJK1nCOnhJE
	 gV1wDqMr9A4yK7BdPiA85aZ+x70yqfL2IKK/8zoBtF7tNND0KQJZBIgzaFm2iMOZFk
	 zp2bIDuIbomVg==
Date: Thu, 21 Dec 2023 14:30:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.7
Message-ID: <ZYSukaa3fDv7p96Z@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_133103_657318_BC1A9570 
X-CRM114-Status: UNSURE (   6.18  )
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

This pull request is expected to be our last for Linux 6.7.

The following changes since commit c6d3ab9e76dc01011392cf8309f7e684b94ec464:

  Merge tag 'md-fixes-20231207-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-07 12:15:18 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-12-21

for you to fetch changes up to f6fe0b2d35457c10ec37acc209d19726bdc16dbd:

  nvme-pci: fix sleeping function called from interrupt context (2023-12-19 12:41:05 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.7

 - Revert a commit with improper sleep context (Keith)
 - Fix async event handling sleep context (Maurizio)

----------------------------------------------------------------
Keith Busch (1):
      Revert "nvme-fc: fix race between error recovery and creating association"

Maurizio Lombardi (1):
      nvme-pci: fix sleeping function called from interrupt context

 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/fc.c   | 21 +++++----------------
 2 files changed, 7 insertions(+), 17 deletions(-)


