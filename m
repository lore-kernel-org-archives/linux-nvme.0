Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12019C48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 21:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/j+URtYfhHZ0X45ez8cbh51PhIetR47+VGUclMHp2Sk=; b=ON6+/c8iXjwZLLpIFKwfMFQGdk
	1BLWkx6yX03kkuiqFbB2OYMDvcdoX8GD+eLLSdO6nZ5lkzs/F2INSND4OjqHz5VlvuCMSAreg6Wlr
	aMkmfB9E/UEu0P0kHe+TDajRw4heIQ2mWN88MB8L0Fzn/Rb7zb2xWA6CAKA+vgiRpTRCB/QXPdd4R
	xz+VFhCYm1SseOQQKoxRwJAs82ZHyAb5OsVK0+fRhJ3WquMP7J7D0N1Ypf8oE1oXoLJmxce2JbfEP
	cZEzfJTs6vdX6YhelH9PbTO+0D0vhca7sgn0nSV4lJwnj4vviwDVjN2JHmGv+1ShE5IVOWu/ga4Wz
	EA8Pwv2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYBuh-0000000Ez0P-2ZNm;
	Thu, 08 Feb 2024 21:26:31 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYBue-0000000Eyyn-3fH4
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 21:26:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 495C8CE1EBA;
	Thu,  8 Feb 2024 21:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E106C433F1;
	Thu,  8 Feb 2024 21:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707427586;
	bh=otnpp2EYixyE9BFyVzRzmKvpjVKIiHRymSg4LZGYlBk=;
	h=Date:From:To:Cc:Subject:From;
	b=ox58hXegDAoi51Od0ID6Tu37j991Ak+efbsNUpZmf7D39mnSVDGBAnvrfGhOHjlet
	 JQoWeBCbRxknbhIaloCNY4ttsrFL2uSnXoGYwBtWXgUu+0DnGU5HNEYaIrpfjLZcol
	 fIAetCeuFgIQxQRgz5TwhO38w3W3rnsbqDJvDer+WjAq032dXCjLruZgsuKCHOs9Fk
	 Xtco+7EsDva7pn6NnXSyHCqutHSw+giiEyVcGFjQ32uxyAdqc4rhfWghPwrFUXXTOI
	 /S3QjeFFu3gE5rD7gt225j97/M/IN6giVlHqMsJg3jxVFUJXs0ha17yUv0Qkfmn2RP
	 6R9U61Vm+Hwmw==
Date: Thu, 8 Feb 2024 13:26:24 -0800
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.8
Message-ID: <ZcVHAP3H2E-8BpUb@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_132629_114158_BF33AF86 
X-CRM114-Status: UNSURE (   6.79  )
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

The following changes since commit 373581643d3d6f34f16389b481b1462c8cbd37c7:

  Merge tag 'nvme-6.8-2024-02-01' of git://git.infradead.org/nvme into block-6.8 (2024-02-01 09:11:02 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme tags/nvme-6.8-2023-02-08

for you to fetch changes up to 4054705215ad7e6dd8e4e6ff27c39abd7667f700:

  nvme: use ns->head->pi_size instead of t10_pi_tuple structure size (2024-02-07 15:49:36 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.8

 - Update a potentially stale firmware attribute (Maurizio)
 - Fixes for the recent verbose error logging (Keith, Chaitanya)
 - Protection information payload size fix for passthrough (Francis)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: fix comment to reflect right functions

Francis Pravin (1):
      nvme: use ns->head->pi_size instead of t10_pi_tuple structure size

Keith Busch (1):
      nvme: move passthrough logging attribute to head

Maurizio Lombardi (1):
      nvme-host: fix the updating of the firmware version

 drivers/nvme/host/core.c  | 14 ++++++++------
 drivers/nvme/host/ioctl.c |  2 +-
 drivers/nvme/host/nvme.h  |  2 +-
 drivers/nvme/host/sysfs.c | 30 +++++++++++++++---------------
 4 files changed, 25 insertions(+), 23 deletions(-)

