Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22183C3600B
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 15:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZoXDW46BGUvtMb/kT5sUSP+dYK+I9QfY+0i1Y8G9+sI=; b=1RMqTYostJFAxBv1eEBa9LBWkj
	hGAc7rRLlWnEHOVcyivo0uwqdy5c+MGtL/wcBV2YTHXyprv0YQyOrjERikcuf+TdpKLrw4ZYPVUgf
	G3nHZQxTzMzSnUhLqmqES/Bg/+UJ5TZpngpwIK5SURHo7F52Ew4dHPVEYTKxEdT8puSi+7QVrgbDR
	iWI2kPwg78iCwQIbLg4Xeia4C56KWzLpQfs/rqBlMICbakYF/aWfugP8fnYfc7upkASdR/M8EzCiX
	nEy+Fx5EJC0UkKMU+3lzr7bZE6qr3PGl42LlaSYOMkhKv8ANO83uhtawYoRB6xC38rYqDcy8jMm2c
	6dtMPYEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTn-0000000BPKT-1BDW;
	Thu, 27 Mar 2025 15:49:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txpTl-0000000BPJY-2LVJ
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 15:49:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5DD3144B2D;
	Thu, 27 Mar 2025 15:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DB4C4CEDD;
	Thu, 27 Mar 2025 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743090551;
	bh=eG9vlIJYZMt527FvwsxqhpdC9eiZwvQt0jseRZ0rLkU=;
	h=From:To:Cc:Subject:Date:From;
	b=uKV6eyNHHKnM1WYeeFEXlmo0eeQRv98aIVPKbE+j1Ujc2ubH6jgYiAKyihAW8lb91
	 vboq92qNUO+3rM4dRomRiYn0J96iRdKpBnqErI2/iJkxNOftELFWSA5Yt6GLAsQlVY
	 BwPBBT454DCCjXaU5W9K4FmIGt/wNsLmRRaCV8bKub4OQ8oZAD8su2Pnp0JDt+4JUb
	 m4S+oWQ22P0ekNf6MAlyzthU0NjmIzJgzUM675DN7otgmGN28l0pTlQjI2XDrrqo3j
	 FjhGBYHsqtT9Hr64PaVYxoA8blbawxKAZiE1bHTHXUO+9IKWO+/NW1dkhs+mHAGcI9
	 Z3Qef4GEzBkNg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv2 0/5] nvme-tcp: fixup I/O stall on congested sockets
Date: Thu, 27 Mar 2025 16:48:49 +0100
Message-Id: <20250327154854.85521-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_084913_614965_9C0A5835 
X-CRM114-Status: GOOD (  12.74  )
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

Hi all,

I have been chasing keep-alive timeouts with TLS enabled in the last few
days (weeks, even :-( ). On larger setups (eg with 32 queues) the connection
never got established properly as I've been hitting keep-alive timeouts before
the last queue got connected.
Turns out that occasionally we simply do not send the keep-alive request; it's
been added to the request list but the io_work workqueue function is never
restarted as it bails out after nvme_tcp_try_recv() returns -EAGAIN.
During debugging I also found that we're quite lazy with the list
handling of requests, so I've added two preliminary patches to ensure
that all list elements are properly terminated.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Include reviews from Chris Leech
- Add patch to requeue namespace scan
- Add patch to re-read ANA log page

Hannes Reinecke (5):
  nvme-tcp: open-code nvme_tcp_queue_request() for R2T
  nvme-tcp: sanitize request list handling
  nvme-tcp: fix I/O stalls on congested sockets
  nvme: requeue namespace scan on missed AENs
  nvme: re-read ANA log page after ns scan completes

 drivers/nvme/host/core.c |  7 +++++++
 drivers/nvme/host/tcp.c  | 32 ++++++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

-- 
2.35.3


