Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCBC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 13:06:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81AD610CC
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 13:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A81AD610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EgscirJH6Nx+kJdPjctUeiJAQYME4Qbw7QEV81O8Dww=; b=QZLWLizrLunyFjG6wQfg3hLh1i
	kqHgsvM0FymbNG2KzGmaNDKBD4vq+i6qUGDwTLCrv9NTPTXLAzSL73k15njhGzcskcxyCwPnO2U+u
	vMQRYiUPJZAstLlEZWcZ1eVkPgrTjQ4igb3artVNSZLBl2qtKCbixxvIJl298vcvSoKLTS6a7b/Gk
	TQl8tmBofp9jg2Gsi253SYybM7GQFifSjuuOjRrsxZQSUv4M/Fn2yb+tJVUP2RuOmm4zm6q8oAFIj
	/aLVFDEXJVVR42li4TPgJ3oeDABFaWdPJtt4NzIGMKmgyvxX9+tyRMrZsK8xQqqkv3pFBNVKHtdK0
	X5mWMT7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb0Qh-0039V7-SV; Thu, 14 Oct 2021 13:05:51 +0000
Received: from [2001:4bb8:199:73c5:b1be:a02d:b459:cc1a] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb0Qf-0039Ud-FH; Thu, 14 Oct 2021 13:05:49 +0000
Date: Thu, 14 Oct 2021 15:05:47 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YWgrK/7ttndn93Fx@infradead.org>
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

The following changes since commit 298ba0e3d4af539cc37f982d4c011a0f07fca48c:

  nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-14

for you to fetch changes up to be5eb933542629ad6a7d4c92097b1b472b1612d0:

  nvme: fix per-namespace chardev deletion (2021-10-14 08:07:47 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15:

 - fix the abort command id (Keith Busch)
 - nvme: fix per-namespace chardev deletion (Adam Manzanares)

----------------------------------------------------------------
Adam Manzanares (1):
      nvme: fix per-namespace chardev deletion

Keith Busch (1):
      nvme-pci: Fix abort command id

 drivers/nvme/host/core.c      | 21 ++++++++++++---------
 drivers/nvme/host/multipath.c |  2 --
 drivers/nvme/host/pci.c       |  2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

