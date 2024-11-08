Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D87D5E147
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3GVJ9mzJVRi+M6MJgbHTSeE0aEQSyrJpioDqBuU31lQ=; b=3wGBZ+L+/0qTfGznInolqgLYBJ
	CX9Eskc8phVkohm9XRUktwjZCIizgy/kLsfSq0WsPn/3pb7Wzn2sSWGa+Xc4BlDW3bMmoBgNMYb4N
	5Q6ZfHg47mb7f88A8pUr78B9TP0JXOzjdKLr1R/z1fVjfc2lNqEoJSporgcYOlWfMBg9m+8z+n2BN
	8aC+d+wPjU+EpSisOuScvL91zh8Jl5UMUawYRGNEobUtFbfJ+aZ37cG/cYl3jY+VzS69TV1ojuTJA
	5E0aMeSTiyEUzVICGAsirMuZlOL6QRJns5xH5ys1LCMHYdXaYm32j58oG1qXLH7n083gLXcfH2gte
	u+gBEP+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9KoZ-00000009rga-39u5;
	Fri, 08 Nov 2024 08:57:59 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Ken-00000009pjG-05HB
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 08:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731055668; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3GVJ9mzJVRi+M6MJgbHTSeE0aEQSyrJpioDqBuU31lQ=;
	b=Xug6tF52XfrDmdAlB4yHt33nCVxZ7QoFMLXtnYIe4coeo8kxN7R/EFiJ4kSoXKsvoU7BwLqzfeHYQ+I7TEeUICVHx4T080yaclpnOFUcmBIE83RLZ7amdtVz54RTjZ3evw8DcCiRYeZ5ASniyliTfc/hRQ7NCMvvSjMLrVNEl6c=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIzTmC2_1731055661 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 Nov 2024 16:47:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 0/2] Introduce service-time multipath policy and document
Date: Fri,  8 Nov 2024 16:47:39 +0800
Message-ID: <20241108084741.40986-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_004755_477353_C2BDB709 
X-CRM114-Status: UNSURE (   8.58  )
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

Hi,
  This patchset introduce a new multipath policy, service-time, and also
add a new document to introduce nvme-multipath and all policies supported.

Changes from v1 to v2:
- Add more detail to message body.
- Add a document to introduce nvme-multipath and all policies supported.

Guixin Liu (2):
  nvme-multipath: introduce service-time iopolicy
  docs, nvme: add a nvme-multipath document

 Documentation/nvme/nvme-multipath.rst | 83 +++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c         | 53 ++++++++++++++++-
 drivers/nvme/host/nvme.h              |  3 +
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/nvme/nvme-multipath.rst

-- 
2.43.0


