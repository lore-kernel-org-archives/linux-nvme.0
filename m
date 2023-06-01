Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15BE2C77B7E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jun 2023 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DKXLASX7Adve5R5oWaomuvlghI9dU93bUWGHOCtRkL8=; b=MUjj8GCRU0sabAhRvpVnOfwTHg
	XAtj++qVDamkntell1pdfTsq3lG9H4MfvO/KloEBBcsoJAMJxfI9K2//AKu4NhkZaHtuYj+gDxeMx
	VHjAkv7HUrjrJOUuTVS3LH5rZ77/YzCtR26pdxTNANwu5gp8Gu8f9mEnhHsHvsMQjJLFw1Q7X/adB
	VrcK6x06Gg6TwC6Pgfr1jivuAzlQ3n9xYYVWlWUTRgdt686Pf5kNErkSj1QVeWRnmBXARgZqWqD5X
	MUGFIlMOIUxr+CGLEzNhnlbmebS7xl32oZX6MdacHp+oyfssyxkG4i0j5m6HZ7jlslETKZy4h5UpG
	yx/UxziA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4kpj-0049ws-0N;
	Thu, 01 Jun 2023 16:07:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4kpf-0049vn-2r
	for linux-nvme@lists.infradead.org;
	Thu, 01 Jun 2023 16:07:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6902264726;
	Thu,  1 Jun 2023 16:07:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F9BC4339B;
	Thu,  1 Jun 2023 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685635642;
	bh=csrGq1MCdzeO4XqDnori/pzDTursbu7HdNsbYmg88js=;
	h=Date:From:To:Subject:From;
	b=k5NBAdhPeGyB13fYfa7Ay92iaIejy920V4sUDe5MKsvUo/T0RpA2pZxuOC5tavs9k
	 MBlkoLLwaso1gpsb8Tm4VG1Z2Sn2ktpCXBBGPuklqBcVgliznvvmCGkYZJSbaYHNPv
	 YF9cRNVXShwDw95Z9ZIin16OE2IUOlZG089O/maWSz/uGXtBEoouYRhIp7/n68kILO
	 JyN2EDoV4c+Mvb4yMikMYsHHRK6dqv4EVejOSEA1jj3WeGQ9In6FLQjDGWOvmy9rcx
	 +IvGaAbQhHwge0WpfIy44IGSXjtgAyXmrmjeRya0g/30+kk+cSanibpIJya1rpDGgC
	 V3fVvejMNCyow==
Date: Thu, 1 Jun 2023 10:07:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 6.4
Message-ID: <ZHjCOA0gUfIiYOLy@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_090723_981700_13FB67D1 
X-CRM114-Status: GOOD (  10.20  )
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

The following changes since commit a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a:

  NVMe: Add MAXIO 1602 to bogus nid list. (2023-05-26 08:21:50 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.4-2023-06-01

for you to fetch changes up to 856303797724d28f1d65b702f0eadcee1ea7abf5:

  nvme: fix the name of Zone Append for verbose logging (2023-05-31 09:21:26 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.4

 - Fixes for spurious Keep Alive timeouts (Uday)
 - Fix command type check for passthrough actions (Min)
 - Fix nvme command name for error logging (Christoph)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: fix the name of Zone Append for verbose logging

Uday Shankar (3):
      nvme: double KA polling frequency to avoid KATO with TBKAS on
      nvme: check IO start time when deciding to defer KA
      nvme: improve handling of long keep alives

min15.li (1):
      nvme: fix miss command type check

 drivers/nvme/host/constants.c  |  2 +-
 drivers/nvme/host/core.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/nvme/host/ioctl.c      |  2 +-
 drivers/nvme/host/nvme.h       |  3 ++-
 drivers/nvme/target/passthru.c |  2 +-
 5 files changed, 53 insertions(+), 8 deletions(-)

