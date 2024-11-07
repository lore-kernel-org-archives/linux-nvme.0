Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B3D5D687
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 20:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y3LYm6rMOsQviI2aSevA67GEvsy7Nt88E0WJ8E+gTi4=; b=JCcZxU9ckRo7uf5FvD2sik7Uhh
	QQE5nh+lnB+5VPjRn9xOLQP9YuQUhbPjxXT29WtpWYgoIpt/fijywEPY6iAzVzO3Z/dwg+lrASePc
	L2ztwRRHEMV48SrptnWXm813zkS+Xr/6PJiLSp9ZV+9NJ4J7u9eQpTRZvMM79lCAAL01pYJyNmzXh
	6PtGEZ3zDkZU9N1zwjTahNqySC/NR2mIa49yhDgL3s8rNr9x3lk9byVQUlfu+iKduobaZG0LFMr87
	wRJLFIwoDLcMkIG3vaNWCCXtkypZ3U+6JNyC9Yo00d0Y6GPVN2Qsntbh2eDE4dlY5wdit27jbK49x
	SAKxFdDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t98jy-00000008CRl-3Kal;
	Thu, 07 Nov 2024 20:04:26 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98db-00000008BGl-2sUW
	for linux-nvme@bombadil.infradead.org;
	Thu, 07 Nov 2024 19:57:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=y3LYm6rMOsQviI2aSevA67GEvsy7Nt88E0WJ8E+gTi4=; b=CwyO8HwvOUlCf7hbAOJcyS3TYV
	MxaQKgn+aKpdxNTAaiyO7N/RefAtUeAWKt2XvlOSiLmVQe7IGJNeWvt+m0uU88pdLRwJxDaAlzJko
	SRHa5NeThRTjGbd2jFOw4/hWsVXzA/6y4b02GVtzWbn0pYzoS+RpK1wksv9t7kjsNeO3n6VuUT6Sb
	nyts5XKH/wfEt7AEfWMKeQPHKaOLD5xaZY4IDEdrDouqiHSHUeVTm0fhl/R4YDjy9uwpMFcM8c7a7
	gUgLcH1rZ+6m+yl8JVLLCPSJbmpvyqxtDX1ubzHavGSlpV8U+w/U18C0+flet0kmdYb/pgcQSQ10T
	BaUUXZeg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t98dY-0000000CCHA-0QI2
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 19:57:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 163D45C0438;
	Thu,  7 Nov 2024 19:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2462CC4CECC;
	Thu,  7 Nov 2024 19:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731009463;
	bh=piDEoprL5yWLYI6KJ7irzQsFSP2mDoPEJUwt6zr5kKk=;
	h=Date:From:To:Cc:Subject:From;
	b=GPEW0xGg5n2TC5W3BgIzaMzp0waYmgbcoASOKDLuuZjU6fYtEs10eynbEK0oHFcLo
	 7PApnoV5f7biwV0kGjOgCvg4hCWtrrTmx8QJmr8l1bFiYkHExdiz9ix4/9kEbXslOL
	 6sE/DW30ikMQQxehEucdo6eJCKO5uAV7RdRrNICesRIALRWUx4fkJ4GF8eiWjqFV1a
	 g+i2WOlpwdrBvs1/bFJkAGC5eEqF9fGvWqglKWyfCbLBJXU3+m93PFZwgwtPzv6Z42
	 7ic39aaRQnVKDfe6KzSw5TzO+EeaG9g8RQFxFzZNKb3jQ1Tu9yRT0BfHkQdIjBuvrr
	 IkHwvYIZOqPdg==
Date: Thu, 7 Nov 2024 12:57:41 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: nvme fix for Linux 6.12
Message-ID: <Zy0btdXvfd8LA7Rz@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_195748_480114_55966F34 
X-CRM114-Status: UNSURE (   5.36  )
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

The following changes since commit d0c6cc6c6a6164a853e86206309b5a5bc5e3e72b:

  Merge tag 'nvme-6.12-2024-10-31' of git://git.infradead.org/nvme into block-6.12 (2024-10-31 09:10:07 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-11-07

for you to fetch changes up to 6d1c69945ce63a9fba22a4abf646cf960d878782:

  nvme/host: Fix RCU list traversal to use SRCU primitive (2024-11-04 13:25:41 -0800)

----------------------------------------------------------------
nvme fix for Linux 6.13

 - Use correct list traversal for srcu lists (Breno)

----------------------------------------------------------------
Breno Leitao (1):
      nvme/host: Fix RCU list traversal to use SRCU primitive

 drivers/nvme/host/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

