Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EE1C04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/ftuI4ma8v1eTl2J1KnUAyGnX9bQV+J0AX7kyfh0A3s=; b=Lu1+tH0Hu4JzTZuIJwALDKXtux
	vRkPHmDb1rItB7KfiTRw7623SC8OzuoYwEJTHRyhAgPM1mhWL7ssIqrmM+KAikIG0PSwc4mEAVABR
	25goD8IMDZILTRtZPuOb6P4O+GSBYEB04zld8SvkWmaU6uAIR5ssOoQQqfsZzMG1Q8BExYzV9YSQW
	I4ZXTmLtUGUigLQ5PGPicOL/xobY/IwHR3P6kX+qOWRs+qJT6hchOl6b0nUmPxkFo6GDARRQuioDY
	1gmxlvI1y8P5133KFTcjWWToXSOpDkBTIvAT/Y44w8Tbqn/v9HQA6Cn7FhyrUes1MXtTczdRNhx6Q
	dw0XWrHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6tl4-0000000GH8E-0T7j;
	Tue, 14 May 2024 15:08:02 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6tl1-0000000GH70-0GCT
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 15:08:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 97D95CE1259;
	Tue, 14 May 2024 15:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5A2C2BD10;
	Tue, 14 May 2024 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715699267;
	bh=pTvBvLC7sQekyOucLFmpXbzeayYfI0t8Kvu8k8/kMik=;
	h=Date:From:To:Cc:Subject:From;
	b=rsauEobguu+r7TQuml5fkLLGXJSgWV5sDpmvyE+mKlfFEYCGxX+Em2XIsd5TprCU0
	 unIXk0Db02JB+v4pGJhEWcioSyxlFgk7Mw4QAgM8wYFtlvQnJI+dmwrr5xFx9oBA+K
	 50jvKqFS2znsnqJtY2Nsa/2+FbkMPLmBYjYHmt2rM5UvLJHWO9nNgbaJN7CUG48ZtT
	 YopgCiwJJK0YwiaJJ+oLWlMSz7EUFHRf1DNg3zGGoZCI8RCBu98Qjrsbx+UPtcxKct
	 m1sbK0LZe9lMnR88winD9UzhrrLmsPes69Y2K59YaGSKBFUOPSDvZdMhh5Z1pnIN/+
	 0jouPlstHwkJA==
Date: Tue, 14 May 2024 09:07:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 6.10
Message-ID: <ZkN-QMZ9qE47zhFk@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_080759_307986_87CDA25D 
X-CRM114-Status: UNSURE (   6.91  )
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

The following changes since commit 6ad0d7e0f4b68f87a98ea2b239123b7d865df86b:

  sbitmap: use READ_ONCE to access map->word (2024-04-26 07:40:28 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.10-2024-05-14

for you to fetch changes up to 54a76c8732b265aa86030134d4af6a5a3c59fe52:

  nvme-rdma, nvme-tcp: include max reconnects for reconnect logging (2024-05-07 08:50:37 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.10

 - Fabrics connection retries (Daniel, Hannes)
 - Fabrics logging enhancements (Tokunori)
 - RDMA delete optimization (Sagi)

----------------------------------------------------------------
Daniel Wagner (1):
      nvme: do not retry authentication failures

Hannes Reinecke (4):
      nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
      nvmet: return DHCHAP status codes from nvmet_setup_auth()
      nvme: return kernel error codes for admin queue connect
      nvme-fabrics: short-circuit reconnect retries

Sagi Grimberg (1):
      nvmet-rdma: Avoid o(n^2) loop in delete_ctrl

Tokunori Ikegami (1):
      nvme-rdma, nvme-tcp: include max reconnects for reconnect logging

 drivers/nvme/host/auth.c               |  6 +++---
 drivers/nvme/host/core.c               |  6 +++---
 drivers/nvme/host/fabrics.c            | 51 ++++++++++++++++++++++++++++++++-------------------
 drivers/nvme/host/fabrics.h            |  2 +-
 drivers/nvme/host/fc.c                 |  4 +---
 drivers/nvme/host/nvme.h               |  2 +-
 drivers/nvme/host/rdma.c               | 23 ++++++++++++++---------
 drivers/nvme/host/tcp.c                | 30 ++++++++++++++++++------------
 drivers/nvme/target/auth.c             | 22 ++++++++++------------
 drivers/nvme/target/configfs.c         | 22 +++++++++++++++++-----
 drivers/nvme/target/fabrics-cmd-auth.c | 49 +++++++++++++++++++++++++------------------------
 drivers/nvme/target/fabrics-cmd.c      | 11 ++++++-----
 drivers/nvme/target/nvmet.h            |  8 ++++----
 drivers/nvme/target/rdma.c             | 16 ++++++----------
 14 files changed, 141 insertions(+), 111 deletions(-)

