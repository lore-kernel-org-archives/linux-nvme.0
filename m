Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE4D65C5D
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 08:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pZAUTFIo0TrtJ+88VvBHkxSNC1hjBphWEAYPyuiqsXc=; b=zxwazcaXogLeL6FTNK0OL8XnRX
	grmMBiyGcBeAO0zsPphBGoZFob1lY1/uvoA6a2lIre/ck0pad+UbLBO3engH/WwMko5vAwqa+QSNa
	e+3uOla3nLln3gi0yeaUIJMQ/pn1pGTEzQUOLqATq268mA3bNEFEbcp/1pwnx/LzrYJ2nLq8AfhWM
	wOxHMCqz24lE8zqrnAHpXnl4kYHp/QoloXjMNK4ziyfYbcUKtSmDl0w0v4zqxB1ULvLCCN5zlqlwK
	a8VpLnO7f3xKi97+EohnF2S6gcMdjRm8xYyXOUAqc6Ph2jDHYfKfQcrd2WHYca+diDY3bXmrlLp9b
	Ahmd1BFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVYM-00000009Flp-1Idm;
	Thu, 14 Nov 2024 08:50:14 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBVYI-00000009FjR-0H9g
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 08:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1731574204; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pZAUTFIo0TrtJ+88VvBHkxSNC1hjBphWEAYPyuiqsXc=;
	b=wITcMkoK3sRWxSLAaQKAdVcrvdBSJk1pnkBjVTWuPvY8wOe6JoPKaePsUN0FHeQgpQV3l/4ablE1sPN0YANlZENcfK7xdt7Chq3doxfzn8l4kZUjCBPeHcxu4Fqel6zMahcHdNfPy0JW0aA3ad6U/6fh+xAhnjuqrBkbzP7jnkU=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJO8AGR_1731574197 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 14 Nov 2024 16:50:02 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND v3 0/2] Introduce service-time multipath policy and document
Date: Thu, 14 Nov 2024 16:49:55 +0800
Message-ID: <20241114084957.41787-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_005010_492909_B9CB4837 
X-CRM114-Status: UNSURE (   8.25  )
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

Changes from v2 to v3:
- Add more detail to message body(Christoph).
- Add a document to introduce nvme-multipath and all policies supported.

Changes from v1 to v2:
- Use atomic64_t to replace atomic_t (Keith).

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


