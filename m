Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3085DC77B6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Apr 2023 05:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GjnYIyMBNHhHmz53AYPKDgCNgzIvG7TjdHr4iouOWIw=; b=knDSEoY2Xcn4cOoAm3hmcmy8nO
	/DRCecfppm91l0uKRczWbmQWDawF6NCZD2oO36iwHZAuvgPbTf4LcNviaHA6iEPTDIH2ZxK8LR0/+
	PM+0gEYgWnataH5qo5qTlxtDtBpQ8TnDfqQHEPHQM5n/Wx9dPTiEPqSB6LYQdmnDgImQg5X75J0hH
	Dfu+9v4aPiD6FC45uFXX2f1bpwLbexbwBBYI+Ef08J+PTWZ/P2K2Dd+YCSLL7hkfDb5a1KJxnle2G
	wUksFSwIn7HoerePOJ41REuirx8Iub4x5jLcng8ox9FiOPARu54+rfYOdRBsn0ZFIzEP1jDn4iI2y
	6fRvU5DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pnBnx-008LHZ-34;
	Fri, 14 Apr 2023 05:17:01 +0000
Received: from [2001:4bb8:192:2d6c:7f18:1319:183f:920d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pnBnv-008LGl-1u;
	Fri, 14 Apr 2023 05:17:00 +0000
Date: Fri, 14 Apr 2023 07:16:57 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: ith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <ZDjhyQfNnHzyvKAm@infradead.org>
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

The following changes since commit 3723091ea1884d599cc8b8bf719d6f42e8d4d8b1:

  block: don't set GD_NEED_PART_SCAN if scan partition failed (2023-04-06 20:41:53 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-6.3

for you to fetch changes up to 74391b3e69855e7dd65a9cef36baf5fc1345affd:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD (2023-04-14 07:13:48 +0200)

----------------------------------------------------------------
Duy Truong (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for T-FORCE Z330 SSD

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

