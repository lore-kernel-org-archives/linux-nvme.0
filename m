Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A847FC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PLAjOyCVDcX2GLrlUJT+B3gok+cwSdvPQqv9oJy56yY=; b=mRRqTfMgYVFqRgr/5tyL8iT5iF
	3YCm4Pj9emsqjvjG98GeyJ03RbRJqzljCSnAaUuit1XZGIU3j4HB77r+Vc/5jRT61QAepzpTz16qX
	VkuGHwpjGfxNXrIQfovQnPwwr5qzLxPvd1z0PDs3LWLMnNYbbvW8YSiD1/1OBrgxFpXqz4FnFuALQ
	CY2SP1PP3jzgLfY1x248W7p9+xAIzlCB+MpvvgH3yQwBKHjawWXCESBwZj6Eh+wkITjlEaDlxokh/
	HX+ZjU0vsT2YNKx5lQ1/hz0baarl2Oh8u7+beet/u5HUHO/3Wa9En1qdxQNn/wISb/ZTaoonhw1hw
	hGMvu+UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSMLI-006p4b-8M; Wed, 15 Feb 2023 18:17:20 +0000
Received: from [2001:4bb8:181:6771:d204:2f73:7b8d:611c] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSMLG-006p3W-FM; Wed, 15 Feb 2023 18:17:19 +0000
Date: Wed, 15 Feb 2023 19:17:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <Y+0hqoUKkv1fMMzk@infradead.org>
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

The following changes since commit 2f1e07dda1e1310873647abc40bbc49eaf3b10e3:

  block: ublk: check IO buffer based on flag need_get_data (2023-02-13 08:36:23 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-02-15

for you to fetch changes up to b6c0c237bea191fb99b6c2de093262402b0159a6:

  nvme-pci: remove iod use_sgls (2023-02-14 06:40:57 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - fix and cleanup freeing single sgl (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: fix freeing single sgl
      nvme-pci: remove iod use_sgls

 drivers/nvme/host/pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

