Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2681C6379F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 05:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iBtAheEM6wnZRltncAb4YD4CDLILeplXzPceme4va8E=; b=EmBRkaQILdm5FoPAYIDh2G5crD
	TGr5kGdrN3JweYljm0nOem/t0BspVp5x4g2km8LFI9W0d9uq9EGCc1lVV42TYQbeiLHcoJ9U+i4/9
	B1PDY4vhfR/MVz0draYjsu7i1yvlTbggjdmrPh+jFljIwTuriJW/MgTe+Xe8V1FJPsu4YKlqbY/wb
	fy7sHLYvvg+ZsNDvZRyJz8xe8KhjboWAHtrSn5kry4mIUw1JdCq3rMBZ90yYUaxpb39tDUU/pGqFy
	vgeto/kMb9YUUQIlF+0SXjbJ3JBeNeFVaVO6ScmwVVeArZaXrJLiTt7gm4cwBgzIJviZxV2XnqQ4k
	Le2XB3/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzCP-000BZ8-Ek; Thu, 09 Feb 2023 05:10:21 +0000
Received: from [2001:4bb8:182:9f5b:acdc:d3c1:a8cd:f858] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPzCM-000BYu-4R; Thu, 09 Feb 2023 05:10:18 +0000
Date: Thu, 9 Feb 2023 06:10:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.2
Message-ID: <Y+SAN97vxJtL/l4G@infradead.org>
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

The following changes since commit e02bbac74cdde25f71a80978f5daa1d8a0aa6fc3:

  Merge tag 'nvme-6.2-2023-02-02' of git://git.infradead.org/nvme into block-6.2 (2023-02-02 11:02:12 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-09

for you to fetch changes up to 70daa5c8f001e351af174c40ac21eb0a25600483:

  nvme-auth: mark nvme_auth_wq static (2023-02-08 07:28:16 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.2

 - fix a static checker warning for a variable introduces in the last
   pull request (Tom Rix)

----------------------------------------------------------------
Tom Rix (1):
      nvme-auth: mark nvme_auth_wq static

 drivers/nvme/host/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

