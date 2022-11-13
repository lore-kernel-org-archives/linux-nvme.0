Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D080C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Usf+R6RVsaQ2qPXORkfHh47EniOLLHDMiICrDrEjhNs=; b=HPDI3xow8qP7P+jvt6kcBI/nzT
	jUCiXXW65u5sp7EEUrTwBHD5uRf18hDge5BxSyQwny6gq4iZ0EnLJteWow7XOc+hE1bjpFSm6kCqN
	l4Xe3dfCQo+qLPeq4Qed9Cpnnh/VtU5AO8Dvhfaw5i8chUNSLjRjVsRvZW67N0K1OY+vchrkXBsLj
	cfdaRNmiqUISXTQmL1PgT8MJNl48pBvBQvd6pKRQ3IpEIiCaJnc+bozf80qDDNWpatH1xSyDuLGTn
	HJMxV8K3CofZB4933pH3smo1bGswgjKLyHhaVgVFX57+xVMFVumC6uFFGtL49i6PFd+4PqLK+YczV
	Li0D6jKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaD-00CBnP-OI; Sun, 13 Nov 2022 16:11:45 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaB-00CBlz-JG; Sun, 13 Nov 2022 16:11:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: nvme-pci: split the probe and reset handlers v2
Date: Sun, 13 Nov 2022 17:11:25 +0100
Message-Id: <20221113161138.883195-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series split the nvme-pci probe handler to be separate from the reset
handler.  I've been wanting to do that for a while, but the bug report from
Gerd that was caused by confusing about the controller state in the reset
state required it to be expedited.

Changes since v1:
 - switch back from IS_ENABLED for the SED_OPAL code to prevent a warning
   when it is disabled.
 - rename nvme_pci_alloc_ctrl to nvme_pci_alloc_dev
 - allow initializating shadow doorbell buffers during reset
 - simplify HMB setup a bit
 - shutdown the controller on reset failure

Diffstat:
 host/apple.c  |    2 
 host/core.c   |   39 ++++-
 host/fc.c     |    2 
 host/nvme.h   |    7 
 host/pci.c    |  413 ++++++++++++++++++++++++++++------------------------------
 host/rdma.c   |    2 
 host/tcp.c    |    2 
 target/loop.c |    2 
 8 files changed, 240 insertions(+), 229 deletions(-)

