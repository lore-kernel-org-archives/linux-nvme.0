Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA49C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Dec 2022 11:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jx1HDh1RNqSDUpvSBpzaYqTfIGMieKJ7FGhX/FB9Rjs=; b=eFgn1vWp9duEaLWYMMA/RjSip+
	KUxUgCxtz1BerJzJUZU75nGpoRF/VLT/YXFMF/b5S8CF7PeL6iEmkGxcnTL2tCP05HkE9ILiRVsti
	xi25OMOh5Ly6RX/YuNDiTJ9dF+GHtpetEZveBmjWXPX0hoD0matlwLOCzyiUHVsRIfNn536LMvpbx
	RdW7BGeZ9s0Aif/sMFmOd0cM8PlbD4mRfncmOD9FXupJMQ/+uSC9GXp4Fxah/fSGPITgY6Xs2QvOU
	7/ZNYuL6asIrl/ZKwpAKUHdkA0AWSQsigrw9ZDW8pw6FziOivPthFAALgFuI/f6lMKfwb5Rp73eeq
	o/kFoYpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9Owx-00AMkt-My; Sun, 25 Dec 2022 11:13:51 +0000
Received: from [88.128.92.76] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9OJ3-00A2XX-OE; Sun, 25 Dec 2022 10:32:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@fb.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hugh Dickins <hughd@google.com>,
	linux-nvme@lists.infradead.org
Subject: fix nvme sqsize on off regression
Date: Sun, 25 Dec 2022 11:32:30 +0100
Message-Id: <20221225103234.226794-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
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

Hi all,

this series fixes up the sqsize regression that Hugh reported.  The first
two patches are the real fixes, and it might make sense if Linus just
picks them directly before -rc1.  The other two just clean things up a
bit to avoid pitfalls like this in the future.

Diffstat:
 apple.c   |    3 +--
 core.c    |   21 ++++++++++++++++++---
 fabrics.c |    2 +-
 fc.c      |   12 ++++++------
 pci.c     |   27 ++++++++++++---------------
 rdma.c    |   23 +++++++++++------------
 tcp.c     |   12 ++++++------
 7 files changed, 55 insertions(+), 45 deletions(-)

