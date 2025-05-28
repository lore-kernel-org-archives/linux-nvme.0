Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3750C5B54E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 06:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VMGtyG6iPYr2vCbjgvTUz4NaCqqYU9UD2K4gzY80TJc=; b=qfk3GtotcORcUDh0+dRDetx0Kb
	Ht6G+YBPt/5NcXce+RxtyvoWV6DbShxmghIpmVQiV+2PwinQLCT+fuMeGeWdjykgNxzivPzWqX/wM
	qObtjK3kf23z/othAhUmzUo4uQB/nl1YWurMj3tzeHycJvWvaAYpcWtKIS+thwJiInqvB0pLgjylc
	mJioDuxBOI2RhIWB4Eltqi8HVr8hu5051eRJeBVPChJJQ4UL7tMAtzpQ4To32gyT7/Io53RMovZ1E
	OhmB9AHmxOvey1coqTlhvGTqkevYxOWIsob0oSy1B1TIErA3z3/G9Q6mbrpJGL5/otmA9KOmPVQzp
	GBg64Ahw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAg7-0000000CMAi-0nU1;
	Wed, 28 May 2025 06:54:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKAXu-0000000CKzv-11Mt
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 06:45:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 632984A08C;
	Wed, 28 May 2025 06:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C124DC4CEEF;
	Wed, 28 May 2025 06:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748414749;
	bh=N8RNNa4/UxtBRW3jdDswP9451h8qWWOuGc+RM3nP1Lc=;
	h=From:To:Cc:Subject:Date:From;
	b=AIrQla2LONlucnHhk/p/4EtKfpcZr1qFaJyZnsJQhc2Mdgvd8/Oi/tom3qNAd0S1f
	 x8eWvt5kxY58earQIGHb2vN4cb8qSslLaRdGGrA5rhHmDDYZzO23PaEkPPiXv1QPbz
	 r2ICzZcI3lRNtrch1zly+FZeJCvpW5KVVKorqqJFvKCRtOr1NWifx0Na0+vainj35G
	 uIbxZhs3XewWbvDRV90AqEM1K0d3iL05GtTrmrkofdIxXRAHpd/ustlCHrMR1OIwG4
	 qgloczZgccD6qrZe17CJhljOdEQr3MsJFzHr/k7RCMC3wKr2Dw/pIQB9nN3mRrbu5e
	 kd87Et9T+eTBA==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kamaljit Singh <kamaljit.singh1@wdc.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 0/3] nvme-tcp: fixup I/O stall on congested sockets
Date: Wed, 28 May 2025 08:45:32 +0200
Message-Id: <20250528064535.135653-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_234550_304085_A2BD838A 
X-CRM114-Status: GOOD (  14.81  )
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
days (weeks, even :-(). On larger setups (eg with 32 queues) the connection
never got established properly as I've been hitting keep-alive timeouts before
the last queue got connected.
Turns out that occasionally we simply do not send the keep-alive request; it's
been added to the request list but the io_work workqueue function is never
restarted as it bails out after nvme_tcp_try_recv() returns -EAGAIN.
During debugging I also found that we're quite lazy with the list
handling of requests, so I've added two preliminary patches to ensure
that all list elements are properly terminated.

As usual, comments and reviews are welcome.

Changes to v3:
- Drop merged patch to open-code nvme_tcp_queue_requests()
- Add patch to check for sk_stream_is_writeable()

Changes to v2:
- Removed AEN patches again

Changes to the original submission:
- Include reviews from Chris Leech
- Add patch to requeue namespace scan
- Add patch to re-read ANA log page

Hannes Reinecke (3):
  nvme-tcp: sanitize request list handling
  nvme-tcp: fix I/O stalls on congested sockets
  nvme-tcp: do not queue io_work on a full socket

 drivers/nvme/host/tcp.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

-- 
2.35.3


