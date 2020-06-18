Return-Path: <SRS0=0To6=77=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B2C2C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2104D20890
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jun 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L1LcbG3q";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FpMHje6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2104D20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=jCraLh+1BVTFAe+rISQEDOjX6Rv/93dByUl2HTgUcWg=; b=L1LcbG3qOXIQls
	3ForKdF8E36+R/qRxbDPVrN0Tn8LNTdSt+O19L/Pc2oQHXL482hKDMYZCizn4f2VwGimEeeGI+fwn
	Xy/UXvMD+cklaBAR1KH8ECiCR0xSmSUHTYhopmK77YP/REhriXvTWgVjzzF+RUGg+XMCke8ZuLuL/
	gxnlyLNmRblvo1adxovCSAZ32FsV5jkayXiNV5/rL72NWlzoxv5jfiQFrG4y0WCx4FgacrPhfLctF
	uef57o75gU68kZbziplp6kuhToAmyOPyIaFkP5X0URWmq2NdVTs7ZS6cJQFfBkz8r5wszflTdcc7n
	VavfW8I65z1ijR3CUnOw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jm0kG-0001iP-7B; Thu, 18 Jun 2020 20:02:44 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jm0kD-0001i3-H8
 for linux-nvme@lists.infradead.org; Thu, 18 Jun 2020 20:02:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592510562; x=1624046562;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2kmMXn71z1aHaErHJz+a+5Rckm6j69eZzhgRB1l7j0Y=;
 b=FpMHje6H2zum13JcfAra3ISng4mKn/6PPicRsB9G62pnrokJ44rmX3Y4
 J5AZ0Fn9hnHoLYiGcKopWkqnK0xLJz7Rv9QfHZFzVDoBWbO3tveuMFXLL
 HQ5u2scMemM/oHgs/ZAZnxqIkhtFW9j56lP3s4d7+r2zHoflJ3baMjH/b
 Cea/bL+cr2Lr0DPo+18lHxdhNvuwZ5XpVanOnIz82lbrUg1TTQsfeX2Fm
 TIGLv0x05LvdsaNSHNl3tfm9nTJVRyCHF1x271qKyFvxU3WOq12F8fKmt
 ajMS/P+p+BUaGu3fdMnqC9zo0jTIMbIZnm8JIonhFOkCh8twTf5E6Z6/3 g==;
IronPort-SDR: +i4RErIgW617W2bUsNjwBu1yfT59h3TOmLX8y8eI5Lah7wy20J2GDwJW36Fjmzp8gEQuwyYX0j
 nYFmKbMohHVbb5I4YeejmTVUU+cowd/o+UMN4+TwnLXvAPLeOS4r9HxZIIm/3aEco45ToGM8DT
 SslffALK/erdpSUaBJtMBzEk7WSIUO9KbngrFTCFVDRJeX0BHsGZF4bVhgrT/jOxvYUVGrSMbw
 KPwwp/+zIg+4yLxI5lWT6dMgOWdvi60IqcPELRu7JtiC5PLtx/A4SeGg3L088d+MFu0/9dG+N+
 9y0=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; d="scan'208";a="144673241"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:02:42 +0800
IronPort-SDR: Tec42PQwtmZr3EEmKSE0dQVJMPOLk3LL1jERaYPz7jbQ8YSwoAeycF1erOQBcQrq5XvhRXghkM
 wMKicsTZ+/QecnGk0R1jruVVcm54HhKAs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 12:51:53 -0700
IronPort-SDR: lSS9MdC0lT01x7YZEJMxSdooO7aOZJmx5J4yxQcctGElNPf6cUg5eI6/ZpCBeeciO/sUzmfkZp
 yi8Dic1t1FAQ==
WDCIronportException: Internal
Received: from usa001298.ad.shared (HELO localhost.hgst.com) ([10.86.58.149])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 13:02:38 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 0/2] remove workarounds for gcc bug wrt unnamed fields in
 initializers
Date: Thu, 18 Jun 2020 22:02:32 +0200
Message-Id: <20200618200235.1104587-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200618_130241_574027_A923EF2A 
X-CRM114-Status: GOOD (  10.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Make the nvme code more uniform by initializing struct members at
declaration time. This change is done both in drivers/nvme/host/ and
drivers/nvme/target/.

This is how the design pattern was in nvme, before workarounds for a gcc
bug were introduced in commit e44ac588cd61 ("drivers/block/nvme-core.c:
fix build with gcc-4.4.4").

Since the minimum gcc version needed to build the kernel is now gcc 4.8.0,
which does not have this bug, revert to the previous design pattern,
which matches how the rest of the nvme code handles initialization
of struct members (excluding the cases where anonymous unions were
involved).

If, for some reason, we want to allow builds with gcc < 4.6.0
even though the minimum gcc version is now 4.8.0,
there is another less intrusive workaround where you add an extra pair of
curly braces, see e.g. commit 6cc65be4f6f2 ("locking/qspinlock: Fix build
for anonymous union in older GCC compilers").

Changes since v1:
-Fixed RDMA build error.

Niklas Cassel (2):
  nvme: remove workarounds for gcc bug wrt unnamed fields in
    initializers
  nvmet: remove workarounds for gcc bug wrt unnamed fields in
    initializers

 drivers/nvme/host/core.c     | 59 ++++++++++++++++++------------------
 drivers/nvme/host/lightnvm.c | 32 +++++++++----------
 drivers/nvme/host/rdma.c     | 28 ++++++++---------
 drivers/nvme/target/rdma.c   | 23 +++++++-------
 4 files changed, 71 insertions(+), 71 deletions(-)

-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
