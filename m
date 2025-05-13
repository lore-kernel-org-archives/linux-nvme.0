Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83054C3ABC9
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0VZ9bf8W+7fMryreltpRVDyqSYIv7m1lfLiTjKeooi0=; b=ErP3Kva2rJrXi5YkmQGvcEJIBS
	nKRoK/TPleBa/i/XKPEpFOiOblUBiyGkMq4eiDPESj2tmwtxcuvAnJVHjLW57FNJhnA3f25FNhCOa
	VzaiuU18fzAQS1Isdy9NOznmWyTZMZFU5lAWlV5kCc6wbvxkbxjgX0Whl8i19Dfsu9kHnPFjCu0uN
	HGVQYevKqbwZb/aK8kvXyKaMZ9yxshxc96T1N5BCpyz2iSDbahnZgwgQqHhEgy/bs99CdSZ56eAM6
	j3waw/zm5oh+kVeO6VLoDQurZOnBkGoq7K2mtkNcKpOzEAz0YFHaH3ZWBVFOMkgSWs4f1cGCllc6U
	dr0D5NoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjct-0000000BYxn-3EF9;
	Tue, 13 May 2025 07:00:31 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcq-0000000BYxM-2Foi;
	Tue, 13 May 2025 07:00:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: misc cleanups for nvme-pci
Date: Tue, 13 May 2025 09:00:16 +0200
Message-ID: <20250513070025.830930-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
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

this has misc cleanups for the nvme-pci I/O code.  Most of this was done
as part of the new DMA API work.  Which then clashed with the per-node
dmapools, so I'll try to get it out now instead of having to do another
rebase.  As part of that this also includes minor tidyups for the new code
from the per-node dmapools.

Diffstat:
 pci.c |  196 ++++++++++++++++++++++++++++++++----------------------------------
 1 file changed, 97 insertions(+), 99 deletions(-)

