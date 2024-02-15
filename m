Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D1C48BC4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UP92cpj3rA69SN/emsLwfCYbbcLuWqVNre86WhcWWYM=; b=MAitXgQYYYg+jJBjMzc+P4PtBG
	SXZYO6H3b25TqENHT6wGGKqCN3CfSXDT8mW3jtBXCa9u5xiT25KqMJT7nZsP5W1aic7rprDC5mHZ9
	iMtPbzYv3iIcQSzPtpPZvmSjO/UC5Q1p3oPESNepgR/Yj4k0bq40EjkYpKMnrKMvAdyRjWeA2wE99
	m/Wbc261epEL65EosDalkRZcPquOQjcKjtfqUVKH+1EqSc/IkV80ATkNOb9EZLWB9P4D9uefZm9ob
	gs9h/0dAtQ1XkmdeI1WTDjHRSd3Xq1b+NeWaIkw/srWyaHUoyLMjYHtG1+BwlRJxg4IQyr9XOVg2F
	aw/0f7IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeIb-0000000GtxI-27Hm;
	Thu, 15 Feb 2024 16:09:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeIY-0000000Gtvf-1CUF
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 16:09:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C789B60F1B;
	Thu, 15 Feb 2024 16:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1860EC433F1;
	Thu, 15 Feb 2024 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013357;
	bh=6oDBOIscsAAoix0SH5zJx23E8cxbKSOZEa0aiqVwQ4M=;
	h=Date:From:To:Cc:Subject:From;
	b=Mmf+210MPOpdMy9XuNpKyb+j+57MGEMFl2EBy4bpw4xeY/gZr+To7yTKc3JOuFena
	 CFvoI/6XF3vQUmr5yIcNp6Y0vIopfguT4jmvAv8Y9pPOGrpAv6J/1CDlDw3+vyocAC
	 W0MchvQV/Pj6YK7b2cdsHV0glUEN6VksfwF8Hx0vwOmtWe82+N3T3YZbeG8qYB2OKt
	 7q7xbo0pC2ec2kTgvmNI1sCUzXZ/4iezk77ykQkUNRfU99Bl8QtieRQ2C1B46dXuwT
	 QOdRq7sdIa1Ed7H4yN/fwpLvJFGksDyLc10HVnHYveHZF9bPJ/OYN77syRze6cn/GU
	 1C3QA1vNZRDWQ==
Date: Thu, 15 Feb 2024 09:09:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.8
Message-ID: <Zc43KhmATYI6tOyW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_080918_386372_16F68D32 
X-CRM114-Status: UNSURE (   7.74  )
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

The following changes since commit 5f63a493b99c848ad5200402bebe26211e00025a:

  Merge tag 'nvme-6.8-2023-02-08' of git://git.infradead.org/nvme into block-6.8 (2024-02-08 15:05:18 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme tags/nvme-6.8-2024-02-15

for you to fetch changes up to 8d30528a170905ede9ab6ab81f229e441808590b:

  nvmet: remove superfluous initialization (2024-02-13 15:42:44 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.8

 - Fabrics connection error handling (Chaitanya)
 - Use relaxed effects to reduce unnecessary queue freezes (Keith)

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme-fabrics: fix I/O connect error handling
      nvmet: remove superfluous initialization

Keith Busch (1):
      nvme: implement support for relaxed effects

 drivers/nvme/host/core.c          | 4 ++++
 drivers/nvme/host/fabrics.c       | 1 +
 drivers/nvme/target/fabrics-cmd.c | 4 ++--
 include/linux/nvme.h              | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

