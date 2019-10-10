Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0C6C10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:05:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D51021920
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sF/Js9sv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvIpyAEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D51021920
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=BdqMl0eiEMoeUP0YBIqSf0wJS/6VheRx109rh/GRNdY=; b=sF/Js9svi1Ru7F
	o2999DlsGUgYKHDa+bnoivWoxuFZmuVv5Mc8pvjMkD2VWy4YGczV15d+1g/DHCeGU8rtpZdHuvLgx
	ej8UyB2kWPVX5awTU9g7f3mIMuIJJZZVtotgkbyPO4SZxsk0bydLHd9Lm99BepxLtmbCFm+X6sSN7
	L8/la5maIeEiKnA1c+5Yj7hi2QPNv5m46orYU19v0hJuEvk41qr1BkB5W3NfGqKUEki3t08at+UQ3
	8RLYAwAfYhiAf5LUbxdp7Fyy03gD/knKy6iVz/GGO2h63D+nxSyAll99BTMCIS5jMnQLHO3HxHy9/
	jyN3vmff0/w33LsYF5NQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIawZ-0001xa-5i; Thu, 10 Oct 2019 16:05:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIawW-0001wQ-U3
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:05:34 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 32DB5214E0;
 Thu, 10 Oct 2019 16:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570723532;
 bh=jTdJv9O+IiF3uwM767Rq9mFMaeXhgW3vjnzeEw0+l50=;
 h=From:To:Cc:Subject:Date:From;
 b=CvIpyAEGlZkCJJSmBdERk8H9I3s0aO4+9dcFlXGiJ46rRBPMZprhZHpTyK283yWV8
 U12lnon1Tc00kx83KlDkPM0Hp4Yaad4cYBssBjywTODzhQ1MrVTH/Q2epjdPTS4/ar
 vt3hrsmigq0UWu5GqvuM3VhbBF/XsfAejJBTEirM=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv3 0/5] nvme: double reset prevention
Date: Fri, 11 Oct 2019 01:05:22 +0900
Message-Id: <20191010160527.22376-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_090532_987773_19A7AB03 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The main objective of this series is to prevent double resets. This sort
of thing is known to have happened if a timeout occurs at roughly the
same time as a user intiated reset, like through through PCIe's FLR.

The double reset could happen because the controller disabling had been
occuring outside of the RESETTING state when we can't schedule the
reset_work, which is to occur later. When another reset schedules in
between these events, the controller ends up in the wrong state.

The end result of this series is simply to block subsequent resets by
initializing the controller state to RESETTING without actually scheduling
the reset_work.

v2 -> v3:

  Added received reviews for patches that have not been significantly
  modified from the previous version.

  Changelog updates.

  Merged to most current linux mainline.

  Added code comments for the less obvious interactions.

  Collapsed the patch that introduced the new nvme_reset_continue()
  function with the "processing paused" patch that first uses it.

  Renamed nvme_reset_continue() to nvme_reset_schedule() and documented
  its usage in comments.

  Renamed nvme_state_transient() to nvme_state_terminal() and updated
  the logic accordingly.

Keith Busch (5):
  nvme-pci: Free tagset if no IO queues
  nvme: Remove ADMIN_ONLY state
  nvme: Restart request timers in resetting state
  nvme: Prevent resets during paused controller state
  nvme: Wait for reset state when required

 drivers/nvme/host/core.c    | 90 +++++++++++++++++++++++++++----------
 drivers/nvme/host/fabrics.h |  3 +-
 drivers/nvme/host/nvme.h    |  5 ++-
 drivers/nvme/host/pci.c     | 78 +++++++++++++++++++-------------
 drivers/nvme/host/rdma.c    |  8 ++++
 drivers/nvme/host/tcp.c     |  8 ++++
 6 files changed, 133 insertions(+), 59 deletions(-)

-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
