Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E1FC001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Oct 2023 14:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pq71ZFQSmqDBvaHKCanMYuz149NpjN7yRS2IvpkR2UA=; b=VbCpYWO+xuikMibV1wCjEKndLB
	ufgJ+HYD/i6e7sLsoRataw9GJdJi9tc6NZhymITOlGl3cApXwsQUIDvtQOv6iESQQuOMNAcHGoIB6
	m9zlfBFo+4DSc4k8CHjrlckbGw4+oQegVjJ3iYICbpdvaglouZ4bAgnpttJzViEk/YZrd0qXaMKR1
	4MZlsYjSVB4ppthls7uzmWzrZWkGMF+o9M6hTjcGMHF5a64DEXZ2hJmDCIxnqX++Q4GkqeRFNlTWn
	wB/qFVu/P5wlASrSc439IZ2JTQEDCzjdRWhtuBaqjGOO4LLYVwUOMCIlLUnxj+L4pz8+nNekAXwz3
	jr9Zp18A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTl-007Ubr-19;
	Mon, 23 Oct 2023 14:00:25 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1quvTf-007Ub1-1M
	for linux-nvme@lists.infradead.org;
	Mon, 23 Oct 2023 14:00:20 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 86B70240101
	for <linux-nvme@lists.infradead.org>; Mon, 23 Oct 2023 16:00:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1698069615; bh=iFQQRi702AynL/9DH88qNRr40fv94tsGYlUkbNd2M+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=XvmYhdNgbZZYfFbdCu0To32qGlkoy5oIVF9wbccHD3r+8r/lK9TDK9gJdjy4KVyde
	 GXkC2QPoOosyb4CMOKAPyqyNi7NekN9f09QRaFudBKWYFHXSBqx1X70KKiZwtZ2yOT
	 WM/PJy2uzGhYOuai4PuxZCew5C5/JfQ70vkVxfhyiZFpXnXdUwNai1qRjvH2DGcShE
	 fEbf98KcmtOnZKM0E7ZtnjWo5HLIO4GhvBCqtpEgOIRqffsl4lcQ8Qjoc9WpucP367
	 ANE6M+txzFfBdFEBPMTDcyRK9sJwji23Al0p93t2M537PF7/6i4SgvAGfSGGBqjCie
	 P6WRb0xKBTWpw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SDcJp23Dnz6tvl;
	Mon, 23 Oct 2023 16:00:10 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>
Subject: [PATCH v2 0/3] nvme-tcp: always set valid seq_num in dhchap reply
Date: Mon, 23 Oct 2023 14:00:00 +0000
Message-Id: <20231023140003.58019-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_070019_629476_46EA9DA6 
X-CRM114-Status: UNSURE (   8.13  )
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

The first patch is a small unrelated fix which makes it clear that the
response data section of the Success1 message is not optional.

The second patch removes use of the host sequence number (S2) as an
indicator of bi-directional authentication.

The third patch causes us to always set the host sequence number (S2)
to a non-zero value instead of the 0 value reserved for the secure
channel feature.

Mark O'Donovan (3):
  nvme-auth: auth success1 msg always includes resp
  nvme-auth: add flag for bi-directional auth
  nvme-auth: always set valid seq_num in dhchap reply

 drivers/nvme/host/auth.c | 13 ++++++-------
 include/linux/nvme.h     |  2 +-
 2 files changed, 7 insertions(+), 8 deletions(-)


base-commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1
-- 
2.39.2


