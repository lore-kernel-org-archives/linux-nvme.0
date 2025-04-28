Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC89C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x1W6WLRcK97WhMbDhO9ACRHiS6dzSTLg4MNt819lPeE=; b=OE4d2CNx5D8DDVVdt//aDEpkOS
	lCzP1CIKZX7gCfoC2p7lpN00bzuC7oRJj5WH0SPHW53DZF2pg6wU3ClLGogGjulSS5Op/jml2tTj2
	akkksDLDd3btriFQkuoowM5IA1/kAri9jMRHcUEggnfNAizjQEj8D7F7+fVp2o1wL1N/MyyVZHiR3
	AVAi6YCJh44p0AZykAeQWkrxpZ67xjZXimKQLbva4feJq2FIhKOjJzh4y54JfyeHvAFMbNeYcCmim
	b6fFhn6ov6KfhPq+EIOPdaitJg+6MQyipt+ebnLnkR81qDdJlIJu+iYCZVkbEwuJrMq+XVU0gpbpO
	WzUQsa8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKN-000000059K6-0DeY;
	Mon, 28 Apr 2025 06:50:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IKK-000000059J2-3csl
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:50:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AFF443630;
	Mon, 28 Apr 2025 06:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B092C4CEE4;
	Mon, 28 Apr 2025 06:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745823052;
	bh=uDIGW2a3Maw4KyeW13qKxW/s6iyonJQtxJLkWjnAew0=;
	h=From:To:Cc:Subject:Date:From;
	b=Xwt/5lSpemLFBFb5d4ljnlEJH1kzd+6hHxdr4H6lu6+ncHpktSfgxZYz42eaeIa58
	 aDdSSSe3jHgPuz/XHH6bBtXsIb3rol5tqsNxl5FVBbNDbc8lo4amr0Z3bUDvRmtnig
	 4fgFOXRGS+BI8mbmoki/5+5fgtzSji7ACsoEm5gDsO52R6jq9g0aa+7MKGWPGmoblP
	 30wYriyIry5sAqEUFNQNteF9ee+HXIx9zMYTfTeghlKdmCkgZ9xBcfBPEANtjIB4Xc
	 Noj1CFWvndJN3zrHxr8q2VQrdgsXEsqKNZCkKTR4BglAQ0HpSNktgJ4zCWF/sYwH8t
	 0JoJZOaYzsMhw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Kamaljit Singh <kamaljit.singh@wdc.com>,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 0/2] nvme-tcp: fixup I/O stall on congested sockets
Date: Mon, 28 Apr 2025 08:50:38 +0200
Message-Id: <20250428065040.32663-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_235052_925159_7B31087F 
X-CRM114-Status: GOOD (  13.28  )
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
weeks (months, even ...). On larger setups (eg with 32 queues) the connection
never got established properly as I've been hitting keep-alive timeouts before
the last queue got connected.
Turns out that occasionally we simply do not send the keep-alive request; it's
been added to the request list but the io_work workqueue function is never
restarted as it bails out after nvme_tcp_try_recv() returns -EAGAIN.
During debugging I also found that we're quite lazy with the list
handling of requests, so I've added a patche to ensure that all list
elements are properly terminated.

As usual, comments and reviews are welcome.

Changes to v3:
- Drop first patch as it already had been applied
- Include reviews from Sagi
- Check for sk_sock_is_writeable() to avoid requeing io_work when
  the socket is blocked

Changes to v2:
- Removed AEN patches again

Changes to the original submission:
- Include reviews from Chris Leech
- Add patch to requeue namespace scan
- Add patch to re-read ANA log page

Hannes Reinecke (2):
  nvme-tcp: sanitize request list handling
  nvme-tcp: fix I/O stalls on congested sockets

 drivers/nvme/host/tcp.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

-- 
2.35.3


