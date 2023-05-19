Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC52C77B7D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 01:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NLPAOYG4bGqul1+Gne/Us6ESA5u0/gy5uqLx4/G2k3E=; b=3Au91YeCOG5k14PR5e6HC4q60I
	CKb1BB24+djpsQKoxZEgZyI1dHpdyZr+8cke8J7RN0FMeTR0qq/MXBvxS1EodkPgwo0W956bGyhmr
	F4HuR5aIoQ2D7sdEIvQttQ7/2pltmlt0+tgJ+61c7Jdpc5J5vrVFN6ohgfkaPwmuS+4E3984dzFO8
	jmIzcQqqu1MvRUE+VJ1qNsexBLE7Kkk3Bb+cttwovaltsKMKhWYjg49TTB/qj9MyHY8RrOMHU2o1h
	cpTErfrG+dFf+MRKQ4YP/KIs7WCS9tb8QWZwHQK5GihzF8n0qH72oiPwOVCoIVwrAe0qDMFHq2cTO
	FrzfGixA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpBy-00EikB-04;
	Fri, 19 May 2023 01:46:02 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpBu-00Eij2-37
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 01:46:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B98206117F;
	Fri, 19 May 2023 01:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C15C433EF;
	Fri, 19 May 2023 01:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684460755;
	bh=tnRSZTl/yrkbF79rZBYPvr06BV+ayl21I44AVvN/UXg=;
	h=Date:From:To:Cc:Subject:From;
	b=YIno5kqBvHH+fMwac+VoneCntDOBJWSKdZ9hVCmhs3ViiMtHde1g/i6WLoIy7FXLb
	 CUklFYUhDPqMKE2A6K3s5DrTo9SCdHCNz3E9g3jo21wx+f/Y3Dfa0fTySoseDDuIJu
	 cfr8B1s8F3JrjbRmbZuHdZCYYl4AJGcu6NISTWUyZXrtXgqZky9W5SS6yBVHZMwEef
	 +TXptbYJgcWeoF62uwgIckgJ/Dsp7GoEXbOpcmpGtfCdhAhfFuSusbyFbHG0+s4y0C
	 dkIofjK7eEScOQNtRhYoPkzvM5Z6AYI9Cs+fJGyQvoTUWqYOeQzcon5EBsO+P84ZCt
	 w4GYYqwniXy0g==
Date: Thu, 18 May 2023 19:45:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.4
Message-ID: <ZGbU0OOVRGRBeL+I@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_184559_068937_9FDF39D6 
X-CRM114-Status: GOOD (  10.44  )
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

The following changes since commit 7949aa46bb4b5c5e43ba3ba8298ffcb48bebf0ff:

  mailmap: add mailmap entries for Jens Axboe (2023-04-30 16:16:45 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.4-2023-05-18

for you to fetch changes up to 0649728123cf6a5518e154b4e1735fc85ea4f55c:

  nvme-pci: Add quirk for Teamgroup MP33 SSD (2023-05-18 17:53:55 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.4

 - More device quirks (Sagi, Hristo, Adrian, Daniel)
 - Controller delete race (Maurizo)
 - Multipath cleanup fix (Christoph)

----------------------------------------------------------------
Adrian Huang (1):
      nvme-pci: clamp max_hw_sectors based on DMA optimized limitation

Christoph Hellwig (1):
      nvme-multipath: don't call blk_mark_disk_dead in nvme_mpath_remove_disk

Daniel Smith (1):
      nvme-pci: Add quirk for Teamgroup MP33 SSD

Hristo Venev (1):
      nvme-pci: add quirk for missing secondary temperature thresholds

Maurizio Lombardi (1):
      nvme: do not let the user delete a ctrl before a complete initialization

Sagi Grimberg (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for HS-SSD-FUTURE 2048G

 drivers/nvme/host/core.c      | 6 +++++-
 drivers/nvme/host/hwmon.c     | 4 +++-
 drivers/nvme/host/multipath.c | 1 -
 drivers/nvme/host/nvme.h      | 5 +++++
 drivers/nvme/host/pci.c       | 8 +++++++-
 5 files changed, 20 insertions(+), 4 deletions(-)

