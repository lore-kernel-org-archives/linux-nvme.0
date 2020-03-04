Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C5BC3F2CE
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1999C24671
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="T5Roni8Y";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATBMi0K7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1999C24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PQ/1eid3lJRitMykHXDoREvc9VDhaROB+sfQLECUvwA=; b=T5Roni8YeGrdgg
	Iije2A6YUFZdic+aw6RD7zfzAjD8MyzYZKcDEIi1n8SEFZRnPii/ADixxS8zotIFbyEGGtvYHa99+
	9F/+bAvuoR6fANPSN4Odrym1MgrTtKoLXAW2S6U8i5GDMDvwpy8Ss6Za6scfatlZ17/45I4liLSzI
	iUbVfQwBpguGF/CNG4gf0En/qpopkrUCQptGqsmoD8n7TBPTMP4YcOTDBMFF+I5pm5FWlawxE9bb/
	HgdWvr0McntpygVeOGsp0ymQvHatl0d+AhDMVqgU68HQ1We3enXb5CM0FFlcrNvP+kP6tlOG37Htj
	NsdhLUAwwjPebCvE9qVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9YVt-0000Gk-8T; Wed, 04 Mar 2020 18:12:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9YVq-0000FT-AC
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 18:12:55 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 21A4224654;
 Wed,  4 Mar 2020 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583345573;
 bh=Bgqs+82oPE8ezmdX4VqeQXoNWy9YRmBwYbb1BsB8Bd0=;
 h=From:To:Cc:Subject:Date:From;
 b=ATBMi0K7wlEyGmseOxMLAYo3LmdOJlHH9V/kLRp1RP34Qrr8Ae6TB2IO/tqqIE2lW
 Lmh4ArFzoqO1iMacTgS6GkyFHnh9agp7Zy/BvvFQIzyAmn2HiZKqI1M4sPZpjtK7Gy
 MbH1wlYnqLmb8/5CXSdzfA1/zn71QmpvwyQQtBr0=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCHv2 0/3] nvme-pci: process cq improvements
Date: Wed,  4 Mar 2020 10:12:43 -0800
Message-Id: <20200304181246.481835-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_101254_374361_FDCAB5BC 
X-CRM114-Status: UNSURE (   5.98  )
X-CRM114-Notice: Please train this message.
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
Cc: Keith Busch <kbusch@kernel.org>, bijan.mottahedeh@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Chances since v1:

  Rebased to linux 5.6-rc4

  Didn't alter the post/pre increment for 'found' completions

  Don't use the return value from nvme_poll_irqdisable()

  Newly addeded last patch removes nvme_poll_irqdisable() handling for
  polled queues

Keith Busch (3):
  nvme-pci: Remove tag from process cq
  nvme-pci: Remove two-pass completions
  nvme-pci: Simplify nvme_poll_irqdisable

 drivers/nvme/host/pci.c | 83 ++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 56 deletions(-)

-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
