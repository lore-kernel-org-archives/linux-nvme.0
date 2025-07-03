Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33ABC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mrnEFAQtqxLZGcbjaYw141JliT60nsKNTrMACRJgZbA=; b=D1R3aTOHkHaf/wDD1An9p6ceS5
	1d+IC3INhFL5Lh1ItiYCap8PZcimI8sfcZv8UFVlHQC22ovI+soBRRB28S9euFXyQn6J6+nNNVSC1
	Sut9FszrxnBkKAJTA7pWmtTy2RHli4KUnbe2LzH/FmMXmXRjjVpZLVKCYVVY81G6NpvclTkd8+Opm
	/B3T/B8bmTOY0BcfTIko5NdRtErlm+yaWBjRCrA9zUEG3YnNKRCmDtygJvlugtFm94y5/GbuZajvn
	m93mZmXm2c9Ub5ih405GmlKCoWHxSwPz1+ObUC9x/h+NdG+C7BIP5qZquNwe6eCuDKC0LBjUPn8QY
	NlZG7wyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJW2-0000000BPhl-1N9K;
	Thu, 03 Jul 2025 12:58:14 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXITc-0000000BDvY-1OWm;
	Thu, 03 Jul 2025 11:51:40 +0000
Date: Thu, 3 Jul 2025 13:51:36 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.16
Message-ID: <aGZuyPbzY__Rb8Kz@infradead.org>
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

The following changes since commit c007062188d8e402c294117db53a24b2bed2b83f:

  block: fix false warning in bdev_count_inflight_rw() (2025-06-26 07:34:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-03

for you to fetch changes up to d6811074203b13f715ce2480ac64c5b1c773f2a5:

  nvme-multipath: fix suspicious RCU usage warning (2025-07-01 08:17:02 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.16

 - fix incorrect cdw15 value in passthru error logging (Alok Tiwari)
 - fix memory leak of bio integrity in nvmet (Dmitry Bogdanov)
 - refresh visible attrs after being checked (Eugen Hristev)
 - fix suspicious RCU usage warning in the multipath code (Geliang Tang)
 - correctly account for namespace head reference counter (Nilay Shroff)

----------------------------------------------------------------
Alok Tiwari (1):
      nvme: Fix incorrect cdw15 value in passthru error logging

Dmitry Bogdanov (1):
      nvmet: fix memory leak of bio integrity

Eugen Hristev (1):
      nvme-pci: refresh visible attrs after being checked

Geliang Tang (1):
      nvme-multipath: fix suspicious RCU usage warning

Nilay Shroff (1):
      nvme: correctly account for namespace head reference counter

 drivers/nvme/host/core.c      | 18 ++++++++++++++++--
 drivers/nvme/host/multipath.c |  8 ++++++--
 drivers/nvme/host/pci.c       |  6 ++++--
 drivers/nvme/target/nvmet.h   |  2 ++
 4 files changed, 28 insertions(+), 6 deletions(-)

