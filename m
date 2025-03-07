Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BE4C19F32
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Mar 2025 13:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ckLN0I6e7dpgm3B86gWJ2wPNj9kUx5W9KtcqScHumHo=; b=VUXNUm5TEQbkjWx2a5nKNdyCGf
	YWLH9QUSx4zvMeltVjk1c4H0CzVebNl+LqbzHHrDfB6gA2PVWpgjMxqcRGSA1Bd9srWkn/WGl7MGg
	9zIv0OVDAnQ0vKj3YyiUcItitIWPvdI5jdF6MQv0ffd6LyHm6vrJydDkLvwx+z6H4XO6Ov8g+Iakg
	YFGPgzJhDlrn5w6cV0e04eaaBB20BcU6tUWw5q2diwfcWw75cl6HEJstVaIVp1yVZ2oEPXFxNeLqT
	NcIjc0KOKAKJqm3tMICdatG9vi3ukbeDRWzeBV6wGO5iJGlKsZTr1gq8xEQ6d5bf+2U76pIe6WLDg
	YDbYIg8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXle-0000000EKcV-09Lw;
	Fri, 07 Mar 2025 13:29:34 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqXkK-0000000EKP0-12W9
	for linux-nvme@lists.infradead.org;
	Fri, 07 Mar 2025 13:28:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 45D83A457BC;
	Fri,  7 Mar 2025 13:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374CCC4CEE7;
	Fri,  7 Mar 2025 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354090;
	bh=X4lRxoGFuPj46+Od0sO1EInnrvURXtCavaSvAldZ5PI=;
	h=From:To:Cc:Subject:Date:From;
	b=jWRn5yKLTC0sKav1a17yEtva9VBi1eGA3TRClExeZiZwnlGL5J3mJAeegPL53g7gq
	 E/qR09lj+9USM5YoIuTUblrdd08oor2hvwGfEoaVxBq9h2FXYY9t9W+oMLutqN2JQH
	 WW/zMmrgvwha5j8eJqx8qHBjSwqttspXkfYSDYDtB0sHK8Dkw9Ud589f6R4MlvJCnm
	 5U/putWdT/jcBOFATCXkljMT0kOPZ5JbMQ1484ASlWoi5+2C8gRDbOvPbmEasETGZs
	 LsCh9run3DIRMyoLfsTR1JsP9sncuy8KvtCaBa+KFVcAfbrQm0ybJmjCxGNQERP/Ft
	 MFlnPcih6DFXQ==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 0/3] nvme-tcp: fixup I/O stall on congested sockets
Date: Fri,  7 Mar 2025 14:27:59 +0100
Message-Id: <20250307132802.111513-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_052812_379614_C1595CBA 
X-CRM114-Status: GOOD (  12.92  )
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

Hannes Reinecke (3):
  nvme-tcp: avoid inline sending when handling R2T PDUs
  nvme-tcp: sanitize request list handling
  nvme-tcp: fix I/O stalls on congested sockets

 drivers/nvme/host/tcp.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.35.3


