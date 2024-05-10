Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE6C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xwGiyZ3oLz19bx2Ii+3KteAMtJjo/84Z2FjTil7DziE=; b=SNwV6lVFXy93eD9rBjPplDnJIG
	Ocys3cElxvFC9g0W5GH+cJYZ4NVUkLSD/J92sjk37aVMRkE4opY64BkmFWmK/wPzMppkf1o4WtxZy
	HjTHakqQLSZ4WyyZlte0LPiMfKWRwtVCtfSFckmbg4vrLyOGv9h5YZZBjK++LaZrZNXOfp2eCzFX8
	plr9uRPoon+G6K7QUYJOniKb6sR+wlROgZCbwlv2CCoW1qZLxoTmK1qXa63zjV9uo42A1aAAbPXPt
	BAlEaYO8PDgEIbzyCYdLuCsa+MObPDdvZ7Swf/QajefTORlXvvz5Z6zn7q1mfTvKHgJeLI2BtHDMQ
	demijeJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVW-00000004ryt-1lsu;
	Fri, 10 May 2024 10:29:42 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVP-00000004rtw-2Mot
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 10:29:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EAE8ACE1CB6;
	Fri, 10 May 2024 10:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB50C32781;
	Fri, 10 May 2024 10:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336971;
	bh=8lGQFIvKfDwehzESNqCctgvMERNI8590PmNeL44Ggw4=;
	h=From:To:Cc:Subject:Date:From;
	b=dsuabjDdR6iK8RvinEKBVFeGJ+bTIjD1UL3hRWTpI7EWgK4+2WRwQtkUBWzY4ixjO
	 7LWaYM3uKO0ek2gM1Vex/RTSpihMEc1yl67IF4Yb7ni7sDkJ8jQd3iOkArwZExIlod
	 cf26rjbkQm5Ov+p3tP5lZiOG89pT5LFNvFrrdguCDfw4So9ThhFAfmqOwmNuzwPXSF
	 bu5LudWZU7XJLJJTelchtuPfDFvdjnb027rQWukoLOFe33JXG7NhVjh+aFk48zS1Co
	 J9PPfm3DPDNFaKu1xT8ruZvTql2cy9KcM4eLSzg41v+FvY5QE/VVj0g3goVNU/2dwr
	 P03LRrecbSiEg==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/5] enable bs > ps for block devices
Date: Fri, 10 May 2024 12:29:01 +0200
Message-Id: <20240510102906.51844-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_032935_846081_9AF36A45 
X-CRM114-Status: UNSURE (   9.34  )
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

From: Hannes Reinecke <hare@kernel.org>

Hi all,

based on the patch series from Pankaj '[PATCH v5 00/11] enable bs > ps in XFS'
it's now quite simple to enable support for block devices with block sizes
larger than page size even without having to disable CONFIG_BUFFER_HEAD.
The patchset really is just two rather trivial patches to fs/mpage,
and two patches to remove hardcoded restrictions on the block size.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  fs/mpage: use blocks_per_folio instead of blocks_per_page
  fs/mpage: avoid negative shift for large blocksize
  block/bdev: lift restrictions on supported blocksize
  block/bdev: enable large folio support for large logical block sizes

Pankaj Raghav (1):
  nvme: enable logical block size > PAGE_SIZE

 block/bdev.c             | 10 ++++++---
 drivers/nvme/host/core.c |  7 +++----
 fs/mpage.c               | 44 ++++++++++++++++++++--------------------
 3 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.35.3


