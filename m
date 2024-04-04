Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D8CD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 16:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6kuZeGaCjOhYibQJThv8OY60Uh5rqwB2ZyIius41G98=; b=3r11/H1YrDqPeDCAgD2j2AY8AW
	5A2MgbFsmvQ+1QaHQJz+SaKpx5ChkZQ8EgjlvVPjP55tPywONZjw83MLVzOgGWJF4Uj0D1gNRXWf7
	TXZVQchCJf0k/pRTpyShL8SwLX7TRwjXwk8QfsBfgBAP/380caT3DJyu7rCmBOhpL4PKAnqivFWjq
	q5TIuQkCay6+LIiLQievEPYwk2609S4KKySbGCoidF9/vg1HEmOUesog8VUGtccPO3RAt1aKCNf/5
	6fPBEjp5aDRE0ZCxh6J1o5gEx9LWiLy/44b0nZ4Qd8Ck8COovAXVz+UrV6jq/J0yAytJ526en+tbc
	4jzOYn3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQQj-00000003ZW4-2Xba;
	Thu, 04 Apr 2024 16:59:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsQQh-00000003ZUF-0e7E
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 16:59:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2B31061719;
	Thu,  4 Apr 2024 16:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851BEC433C7;
	Thu,  4 Apr 2024 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712249949;
	bh=a6NEV1sfGz60E17awpk/JaAKazWyLCI2N7AvRsfS8A4=;
	h=Date:From:To:Cc:Subject:From;
	b=HzXTtILyrWMlsCVezQoQyalXfCDnMK7r95jN/4o1oImfj2CXg8WuG7rScdhN9hK64
	 R89hhfFzxcJ1hF92sbW/gJyPLD3DlRBkm825ClUZDPO2r5h+ejF21L0DNYjgMK0hz5
	 MmL1tivExAij5D41h17hnM9rLXBCbDM9T7sn0blF/fJnddF+bJ2IW/ZKpSW054U73W
	 IRQ0CrNy3WMyzFBJ3s40mxtLvP9hz+cpqUsz6G65g+Va3vQE3MTw7H5G3ZOou7q6/v
	 d3p/hWmotO6oRU/aO98z7BU/Iyo8EqfsFFCtM/FtHyYpxlDaIIuN9r6i71siUtAjh+
	 L9RnGTWRHagBg==
Date: Thu, 4 Apr 2024 10:59:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.9
Message-ID: <Zg7cW1X932Tz8iw2@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_095911_276738_3382B756 
X-CRM114-Status: UNSURE (   7.30  )
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

[resend for the mailing list]
The following changes since commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155:

  block: fix overflow in blk_ioctl_discard() (2024-04-02 07:43:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.9-2024-04-04

for you to fetch changes up to 205fb5fa6fde1b5b426015eb1ff69f2ff25ef5bb:

  nvme-fc: rename free_ctrl callback to match name pattern (2024-04-04 08:47:56 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.9

 - Atomic queue limits fixes (Christoph)
 - Fabrics fixes (Hannes, Daniel)

----------------------------------------------------------------
Christoph Hellwig (3):
      nvme-multipath: don't inherit LBA-related fields for the multipath node
      nvme: split nvme_update_zone_info
      nvme: don't create a multipath node for zero capacity devices

Daniel Wagner (2):
      nvmet-fc: move RCU read lock to nvmet_fc_assoc_exists
      nvme-fc: rename free_ctrl callback to match name pattern

Hannes Reinecke (1):
      nvmet: implement unique discovery NQN

 drivers/nvme/host/core.c       | 41 ++++++++++++++++++++++++++++--------
 drivers/nvme/host/fc.c         |  4 ++--
 drivers/nvme/host/nvme.h       | 12 +++++++++--
 drivers/nvme/host/zns.c        | 33 +++++++++++++++++------------
 drivers/nvme/target/configfs.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  7 +++++++
 drivers/nvme/target/fc.c       | 17 ++++++++-------
 7 files changed, 128 insertions(+), 33 deletions(-)
r

