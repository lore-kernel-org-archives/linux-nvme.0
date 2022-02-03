Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D35C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 19:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GBFnOgde9oqUR1AZu6IyA7t4Yh0JHyulvtCcPkRH72M=; b=Uw2R0ba8QrPez2l81Rvw3IOr/9
	0LLyhQstN8K0jfc/fdaEaGbBhyNeD3wF11HPbWnUMV+UrzzHPpLzWnpEIW86uIENJB16fsXgTG0/U
	MfNNag0hSHUPgDpT35IGzhEyAFqvBW3XH/NapnVAt9v+hs9axoqCHAqvZKItOik6Fpwvppy0Rrc6T
	93OpM0DvYU0EEl9J3LTIqlKRgl4gaTORi7x5oDI9q6tntYDE/wPgoaiSZ+88aANpnM19DLE27BDvR
	jr8auySgpL3UmkyK3JPwgjF51eT2+k4s7Eqk7mrFfAXyk0cVDZAXG/G9qYt7QZqC/i/PrJsY5B+Zp
	PJ841kPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFhtV-002bIy-1Z; Thu, 03 Feb 2022 19:35:49 +0000
Received: from [2001:4bb8:199:3f6d:6013:69ea:945:9283] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFhtT-002bIV-Dq; Thu, 03 Feb 2022 19:35:47 +0000
Date: Thu, 3 Feb 2022 20:35:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YfwukSSzRWJE2Jy2@infradead.org>
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

The following changes since commit b879f915bc48a18d4f4462729192435bb0f17052:

  dm: properly fix redundant bio-based IO accounting (2022-01-28 12:28:15 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-03

for you to fetch changes up to 6a51abdeb259a56d95f13cc67e3a0838bcda0377:

  nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts() (2022-02-03 07:30:57 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - fix a use-after-free in rdm and tcp controller reset (Sagi Grimberg)
 - fix the state check in nvmf_ctlr_matches_baseopts (Uday Shankar)

----------------------------------------------------------------
Sagi Grimberg (3):
      nvme: fix a possible use-after-free in controller reset during load
      nvme-tcp: fix possible use-after-free in transport error_recovery work
      nvme-rdma: fix possible use-after-free in transport error_recovery work

Uday Shankar (1):
      nvme-fabrics: fix state check in nvmf_ctlr_matches_baseopts()

 drivers/nvme/host/core.c    | 9 ++++++++-
 drivers/nvme/host/fabrics.h | 1 +
 drivers/nvme/host/rdma.c    | 1 +
 drivers/nvme/host/tcp.c     | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

