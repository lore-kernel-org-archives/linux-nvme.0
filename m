Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C26C2C77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LT9lCuuHronvbfIBuaatosvKjMZfBPUi6UQ8BfHLcxk=; b=pSAlh6Az6tO7wGl0I18Op4PZio
	SjsVwH7m5S7uKUlrIWrCKy7+tM72rnO17jemQh0b1SacXCh67alXFC8S14vsnPQgkpCubo8Y1QYmH
	qe4tdOSz5zytECUHLBaj+Qu0KZjBYjcqKJ0/+cyv7rmttHghyMP9OQs79q5ZJ0ukoEDXdXxhxVRQg
	3y1lXjDcOu/rU9s6QkHLxK9iln4ucFp6uSXzDCs+KweRPiiaYPFVCPozWSTMGTmHI+nCRfE/v5ZpU
	HvTvRhcaCTG4KT91mvHPk8nKH2HFxJfYXe1it1aKeIl7scxSFwoTckMDvnJD1CRhz0TVzqDowtrrq
	UaxchYbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2IAc-0009cB-2o;
	Thu, 25 May 2023 21:06:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2IAa-0009bj-1f
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 21:06:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8377C64B0C;
	Thu, 25 May 2023 21:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B642FC433EF;
	Thu, 25 May 2023 21:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685048805;
	bh=cA1VbVuguAKfjoCFvQuj/EhFYXA6OOEZit0KHitCSLA=;
	h=Date:From:To:Cc:Subject:From;
	b=i0Dpp+OClxD+2vCU1GWdVkqdgkYqc+5ubASgmFKxTvtr+QsX3GIkCvv1WqlD3p09D
	 7Hw0RKFd+NzpvtSrYaLiMML2Sze8k9bdiuyTe+DMqJoGcsuOPgjW+voVM57KlffDrp
	 21ZU04K5FBh13uNXxTaK8bZv95e9aaRYVgVBaPKqeUP+9aeOlvLNAIqflME1EV7foc
	 SVgZP/XN3XCwmSqIjS/E+DZZAA4UwJgLiadJGGnCk9LAiFprxGWIYdqm9EMUlO52O5
	 IAxa7b+ejluuvoFkTUTThP2gd2TIXZ2Z+wdrp3PCznAnoVP3KBN3S/hbM8SHWyIb59
	 GLVNF2DLSHjBg==
Date: Thu, 25 May 2023 15:06:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 6.4
Message-ID: <ZG/N428NVdnvO8tt@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_140648_740865_528B1DC0 
X-CRM114-Status: UNSURE (   7.82  )
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

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.4-2023-05-25

for you to fetch changes up to dce8c22b9355d681c07be72c52c5dcc8d94a5d89:

  NVMe: Add MAXIO 1602 to bogus nid list. (2023-05-25 08:31:00 -0700)

----------------------------------------------------------------
One nvme quirk (Tatsuki)

----------------------------------------------------------------
Tatsuki Sugiura (1):
      NVMe: Add MAXIO 1602 to bogus nid list.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

