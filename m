Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4214DD767DD
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8xs3ilHWG9yiFJiyhcNiRK48KpDStdm8BsqxkAviVe0=; b=KaWGwzTHzrVdReYvkRqDfv0yLk
	obPVpUg5w99+3hs0MUo7xPr6IGway/xOf5ej0uo/bt5jZYLahPXX5bLoJ0t1RpYObxwIdm+08d78k
	kx2F6NYCRSGnlTW7bE3C4kvbFonkw7mPB+/txnbzrTNgJvBHKloNKjBMYnmOTWCvxLxTDnRU6GpQy
	vb7gAjm5OXFV6VrtywKh1Q8vVZEup1D+RlvCfPjVR8Dx1z7vFcHPqOPD6h8vt2GeAvuOBp3CCutRm
	erWOjgShU9bCKHTtZRE4cxP3d4QC7Asg0kftkGeHImLGrsXr9PuQ/iwRpYfJmQEh97dyTGVEFw0ZY
	+yrrAbPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6XAx-000000040hx-2UTd;
	Thu, 31 Oct 2024 15:33:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Wmf-00000003vX3-02H4
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 15:08:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 813E0A442C1;
	Thu, 31 Oct 2024 15:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F543C4CEEA;
	Thu, 31 Oct 2024 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730387303;
	bh=pyNx66wSN8YCuROiIsQObjWv08aiTRg/7zVaC70boYI=;
	h=Date:From:To:Cc:Subject:From;
	b=hNmNzTXQSEr0fTnhQVNnuyvAtVzq9dSrCuB6s4ouofofcAKxNKbjkB4ID0IKzbrzG
	 NLsFEZ8BHLNx7OsvPOIGck7lGKnGr4NbQe+KziJ0fAruEs2c2BZEm/6gNhMEgfWT5O
	 X2MO9jM4adU4yVHkT0OYWNzQkf65AVzCNAeI3irKCMPRFzT+i4Mz7nNuYpuZbXTbi5
	 Cz8Z4ZK8tan5I34xm3NPTCXNtZsFD25ZcN9PYjfz3/fnLj20nB1shnwXB9tdMYaUrU
	 Qfzf4bTiywZmwGoi8q/f+5GWZsiRyuFGPByN6UBN3ojm655YcLqtM6scM+VtpA1QcH
	 PJYTDFcSpssow==
Date: Thu, 31 Oct 2024 09:08:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.12
Message-ID: <ZyOdZWK7S1Q-VbcK@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_080825_130853_02F61D3B 
X-CRM114-Status: UNSURE (   6.15  )
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

The following changes since commit 49c234b50a437eb827832b61cd662e9aa382f31a:

  Merge tag 'md-6.12-20241018' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.12 (2024-10-18 10:58:24 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-10-31

for you to fetch changes up to 5eed4fb274cd6579f2fb4190b11c4c86c553cd06:

  nvme: re-fix error-handling for io_uring nvme-passthrough (2024-10-30 07:19:18 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.12

 - Spec compliant identification fix (Keith)
 - Module parameter to enable backward compatibility on unusual
   namespace formats (Keith)
 - Target double free fix when using keys (Vitaliy)
 - Passthrough command error handling fix (Keith)

----------------------------------------------------------------
Keith Busch (3):
      nvme: enhance cns version checking
      nvme: module parameter to disable pi with offsets
      nvme: re-fix error-handling for io_uring nvme-passthrough

Vitaliy Shevtsov (1):
      nvmet-auth: assign dh_key to NULL after kfree_sensitive

 drivers/nvme/host/core.c   | 56 ++++++++++++++++++++++++++++++++++++++++++--------------
 drivers/nvme/host/ioctl.c  |  7 +++++--
 drivers/nvme/target/auth.c |  1 +
 3 files changed, 48 insertions(+), 16 deletions(-)

