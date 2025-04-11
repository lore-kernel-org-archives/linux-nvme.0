Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59482C3601E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Apr 2025 01:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C/RvUAdpmc95KmO7EDBkulL8V7jVlvxsxRjwcxatn8E=; b=N0IHGJvNxTRF/1KIi4BnrgINCa
	SXvwub0kzosg1Ra+9vEThKWMt7I+4guz0u+f2o/CbwbQbkTy3+uSleycJIqiiBx9IcNLYt2h+BPqc
	dQARWfSKrsHA61DckWGMQt9Pm59oKligsMNmvOHVaussr3Z/fJqbBBiKnnr5de7tTwzGSgBSxo8ZM
	4oZ1fbMZ3nAw6vmToghjoZs/3zAMsQpqcWNWslR+QeM1H1HgesQR7ZKsduKuBEJrUKezW53CrdoDx
	Ion1g0oLfE44tkNAWov36QCaSGXPeU+P4Pj47Rmqfku8dBFQIQFT2uSN+FkLSpUJZeuVAGD3/6Eev
	kS9rmeYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Q0-0000000CGGp-3EU0;
	Fri, 11 Apr 2025 01:42:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u33Py-0000000CGFM-0xyS
	for linux-nvme@lists.infradead.org;
	Fri, 11 Apr 2025 01:42:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8071C5C51B6;
	Fri, 11 Apr 2025 01:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C55C4CEDD;
	Fri, 11 Apr 2025 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744335773;
	bh=68WVJVL+cs0AQEOnREXmSc7fuMwT/4eDlbIvWSLBBaU=;
	h=From:To:Subject:Date:From;
	b=ZaVliXf1HrEx58pSjulQUQl0lWDJzdTNFrOyGYiVaYOMJ36jAKjrF8BJPv9KqPgIF
	 BfW/TkjTvHigZMd7RrXnNmSMfIBR/WBwqz+NfmvOMACwe5Ysbf3jcIicCJpy5MF2+F
	 zFcvaIwBh4dPQstEX9LN6UxE48NEA7hLL7OfHAjVY/5o8pMMdZ1z2hsm17yINw1YJ5
	 D4vhioixYlg31Yc0fhaSqc37Hdr5+hqFIsNx4ib0RKYr2WEFlekaV3VQzzO9uYt8bN
	 jRiSy9Sca7GYM4Q/30Sj2pYSeEAiWBRVLh3UBg57S+5Blwl3BoA3IhuJS2XM0YxuiV
	 LjWAUQWHwEWOg==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/3] NVMe PCI endpoint target fixes
Date: Fri, 11 Apr 2025 10:42:08 +0900
Message-ID: <20250411014211.1070887-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_184254_322468_E0B28783 
X-CRM114-Status: GOOD (  10.25  )
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

Two bug fix patch and one cleanup patch in this series.

The first patch fixes an issue with completion queue entries
initialization in the case of failed commands.

The second patch fixes
the initialization of the CC register to ensure that we can always
detect that the host is attempting to enable the controller (with
CC.EN).

The last patch cleans up/simplifies the management of the PCI link
state.

Changes from v1:
 - Patch 1: Add comments explaining iwhy the cqe needs to be initialized
   and also add setting the cqe sq_head field.
 - Fixed typos in patch 2 commit message
 - Added review tags to patch 3

Damien Le Moal (3):
  nvmet: pci-epf: Always fully initialize completion entries
  nvmet: pci-epf: Clear CC and CSTS when disabling the controller
  nvmet: pci-epf: Cleanup link state management

 drivers/nvme/target/pci-epf.c | 88 +++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 30 deletions(-)

-- 
2.49.0


