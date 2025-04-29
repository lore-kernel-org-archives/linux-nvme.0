Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA7EC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 08:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Bu1BAeBtItlUtuVx8rQ1j5bqaofovsrsW/8C8wQklVk=; b=qV093YBmlIsmCpxogihoqsrFcf
	T0Re9uszYzy3tZ4iPzuFFbQ37XYpterw+4vUzAw8vLhuQJPFCA1IPryXnuR1bHnpTyCthOjP7p/9a
	hQkfbCZbs+XR0FfN2CG3XCQp6JKpRHYnCCKacyX5DHMZi4wDgCqgbDKQLJo62cin21mF1D3xHRaqr
	GkqUYBVxVQjKMuslkpbf7nPntdIUyWMM8Dg86RJGlQNHW0x6dTP+qyYJdX7+5mokpcz1VZo+HIbAQ
	lTXOEWIMLOSfBWGb2GkLBB94ly+BqUoMpIQM/GnnQ+tZKW4u1Pejd04y96stUH1I+wDlvSlvETq8D
	FP5eMsEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9gA3-00000008thd-3YK6;
	Tue, 29 Apr 2025 08:17:51 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9gA3-00000008thA-0ZUP
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 08:17:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D3CC261120;
	Tue, 29 Apr 2025 08:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED24EC4CEEA;
	Tue, 29 Apr 2025 08:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745914670;
	bh=Tbqe598cScBCydjp05DY7PLdFp8LqLyPlqyU2yA3REc=;
	h=From:To:Cc:Subject:Date:From;
	b=XvPNV4dHt4t+KHlfcxvVvnKx4gOJbzhVWEn1X7efdUO4mmtZxuPfIfD29VTP6gl4+
	 cAbNNK0nOnzBHqpw+ntGXszO8p3DoDASpa1v/8UiU6o1GIKkiqFyU15ArWN3QAlNRf
	 F22tjOppuc9vMf58wcy+pNFFpE/NJMkIiI4K2FtwDSEH+x1dTwyEW7mFj3nqZvhZ9Z
	 krDTl+8dbfPbOsFouNmuni7XajfxXE1p4SOXBZzoEDvPMIupYCPGMYp0FOU9ierYwI
	 U9pdx0abFGiWOwvEO5JDYZtiq6r2iKZKlrSXi1Wmq8gdrYIyLEnhtr9DNu7IomZ+Ah
	 Svo88nY0PjrDA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets
Date: Tue, 29 Apr 2025 10:17:37 +0200
Message-Id: <20250429081739.44820-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
weeks (monthsA, even ...). On larger setups (eg with 32 queues) the connection
never got established properly as I've been hitting keep-alive timeouts before
the last queue got connected.
Turns out that occasionally we simply do not send the keep-alive request; it's
been added to the request list but the io_work workqueue function is never
restarted as it bails out after nvme_tcp_try_recv() returns -EAGAIN.
During debugging I also found that we're quite lazy with the list
handling of requests, so I've added a patche to ensure that all list
elements are properly terminated.

As usual, comments and reviews are welcome.

Changes to v4:
- Drop check for 'queue->req' as noticed by Sagi

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

 drivers/nvme/host/tcp.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

-- 
2.35.3


