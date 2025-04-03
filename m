Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94653C3601B
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OOIflOoPaRKxGR7wjH3Jj3m9hLK7D4RWf2Lw/ywL09A=; b=MwtAqpnw054o7k5W+Q1rnpqArs
	a77V1tkW2WEUUpeJFM9u5iH33na/abEll91AwnxMfcidryicn1yCZXd8pnpy3UonpeiQKAo5q9LT2
	lpsKHi/dY56OocY6qJSrWMC4dvWqomVJSpXszAnosHyKHcgmuDn0wplhBU38HilMU/NVzNTa+sIhm
	gXxxQSgO4XM9bBg98/rnhOCOBZujmQ6vKapF0CDVAOrGhWdBdPW2L7dThn0rATOdP8fUV7/oZljGP
	vxjA8C9GxJSt9Ic5KQeJ/pW4S0ZoNGYcfpXLV3RLpT6ZsOApCfSSzQWD2hZ4+onxghjgrurj625T0
	lHYtGQsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Ea4-000000080ze-1Jwh;
	Thu, 03 Apr 2025 07:01:40 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EUF-00000007zbp-2KTT
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 06:55:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 085DEA464CD;
	Thu,  3 Apr 2025 06:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44079C4CEE3;
	Thu,  3 Apr 2025 06:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743663336;
	bh=zxmIoEWw4E+OaHD254rFV9aqDwZQFBLI3i4Ke1PZQe4=;
	h=From:To:Cc:Subject:Date:From;
	b=RrzuNxHsBG5n2VNSNAiDiSsMfgsLrYIFBSP4/x+g/A3Aw/ogbslIBnhe5Ihcze/YA
	 quNwa1JpcsDhwynd8ksKJtO+wwVzWeTIWRkEFMDVA3U5GlmA8HlseP3HPMiOa7qFzT
	 vALnEFCFCXlvLGOplIWQCOZqIMmvJUJ413X5EvowkIc1yPU6WJfSLj6P+WM2wBs7bD
	 EixXbyr/ZOXqT8z7WvZQQ+G0lJyuJ3J1axQDHE3ytMZ73BNYPzUL1UHFtobE0PnXrU
	 yGBWfzm9iv2yvdt9c9c5Kv4Ce6kztOZGKLjQcBjf5Vtm+9zjZLRjXdORr3MouDjHBO
	 x8CXzoCmDqw4Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 0/3] nvme-tcp: fixup I/O stall on congested sockets
Date: Thu,  3 Apr 2025 08:55:19 +0200
Message-Id: <20250403065522.90807-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250402_235539_667789_2CEE6D4A 
X-CRM114-Status: GOOD (  13.46  )
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

Changes to v2:
- Removed AEN patches again

Changes to the original submission:
- Include reviews from Chris Leech
- Add patch to requeue namespace scan
- Add patch to re-read ANA log page

Hannes Reinecke (3):
  nvme-tcp: open-code nvme_tcp_queue_request() for R2T
  nvme-tcp: sanitize request list handling
  nvme-tcp: fix I/O stalls on congested sockets

 drivers/nvme/host/tcp.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

-- 
2.35.3


