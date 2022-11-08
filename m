Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9127AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xCqWssH87NIP2qBXcjXCsEOkMsUPQvAGYtSRTrqH0xI=; b=wv9XQtHfpMtcyIHR5L1ZafrE3l
	0xwbaCV7sygdxyQScM6X35dT8jXCOmxDzrxOt8qHCUzNW9sRjsURXsrwKF0DBZ4DaqsRoEW1RXaXo
	zS5AAjW5iyN2X9uRiTTOkxPjDaThZdj+vX0dI5Fy870iQR/erpgESQQyXiGiNnVltFaUY8or6T+IZ
	mfFmef54JPC5wfBFrIWlVQV1u19OqkrUve6/7dJRv+ACP2bd9EusyFgkdMNfW7O8wEz0fUxKlOHwC
	5uNw0qhjBPpVm5m3HoopzJ/PCRe42KHY3wbXS2oUzp3F9W4CohGO+u+0dUmBUrj669fTRaVNa9VAO
	QCWDjl+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ8D-006BqY-00; Tue, 08 Nov 2022 15:03:17 +0000
Received: from [2001:4bb8:191:2450:b4e6:4796:2c38:d4bf] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osQ7s-006Bl9-69; Tue, 08 Nov 2022 15:02:56 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: RFC: nvme-pci: split the probe and reset handlers
Date: Tue,  8 Nov 2022 16:02:40 +0100
Message-Id: <20221108150252.2123727-1-hch@lst.de>
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

Diffstat:
 host/apple.c  |    2 
 host/core.c   |   39 ++++-
 host/fc.c     |    2 
 host/nvme.h   |    7 
 host/pci.c    |  415 +++++++++++++++++++++++++++-------------------------------
 host/rdma.c   |    2 
 host/tcp.c    |    2 
 target/loop.c |    2 
 8 files changed, 237 insertions(+), 234 deletions(-)

