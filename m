Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5116CC77B73
	for <linux-nvme@archiver.kernel.org>; Fri, 26 May 2023 15:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xC5rMRvTFRiY+MWaxFmueYKkh9smchlb4/UD7gMqkyw=; b=WfC/E7pSK1U99hFpZ6oxhJ6AYU
	Mb8qkheMmOZb1zQeGEH/Y6AOVR00e8DaWoCCJ4zhmDbeiPWEiqk39poTS4a4MmIGKYtYiq1gx2LIx
	f7AiKRv1CDyq3gzNGpFfl845WcP8ofi27+chLzerr4btKmncOJZhtp+v8gniFRkfwlD5gtPPEe3qd
	uVnRyOAgPySk+UL86yseBX+FvqGV82FLUn5lXSoyTVZ31L95PjixOhiZmgYTdjBGzTM3bCa2HCgrS
	n2jybSuW2XwfpJohgLVZxwDqxBiQoEbGGUOMnLLUkrW9SnQEnSBjQPMkZWp14ME84yUo1YMZhZIWp
	ektvwD7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Zcj-00311A-36;
	Fri, 26 May 2023 15:45:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Zch-0030zx-1a
	for linux-nvme@lists.infradead.org;
	Fri, 26 May 2023 15:45:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D4021650FF;
	Fri, 26 May 2023 15:44:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14020C4339B;
	Fri, 26 May 2023 15:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685115898;
	bh=BJUlFOaBpFQ83fnbsehUV7YSPVzTVEQgALdwU1h/72k=;
	h=Date:From:To:Subject:From;
	b=mLWlVPCmBxFL9O4X2b4BTZVPUfuurNE5o7Z2m27Vc114pRt2C7lQpV66+6BJwY6Q4
	 dDEpBLD379uHHvYzMmHzOX9f+LsreOta5jUjxdvCLsUAh16UH2kHvVQz/hNohmosbV
	 v0cNhjBCIdzxZv44U4pm3SZj4TJv5ZhqQGRoL3LasrIRLvWGnEHc1mr6VV935u/T1E
	 9mgRKwR35yzcdogQcO+NHiziEBFRtcIERwZ5pRSEfyTgC9Lm07WiDksMP/9dBAKIe+
	 8F4iAhQIkf62OI1PJcKpjtEY9s9Ivr0f65jEF0eZNLaCKJYqUGn70RdsgJ2ry9sPzN
	 zqpRQVNXCRb8A==
Date: Fri, 26 May 2023 09:44:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk, linux-nvme@lists.infradead.org
Subject: [GIT PULL resend] nvme fixes for 6.4
Message-ID: <ZHDT+I2z4at1OvRI@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_084459_561780_8B7DA047 
X-CRM114-Status: UNSURE (   8.64  )
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

The following changes since commit 3eb96946f0be6bf447cbdf219aba22bc42672f92:

  block: make bio_check_eod work for zero sized devices (2023-05-24 08:19:26 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.4-2023-05-26

for you to fetch changes up to a3a9d63dcd15535e7fdf4c7c1b32bfaed762973a:

  NVMe: Add MAXIO 1602 to bogus nid list. (2023-05-26 08:21:50 -0700)

----------------------------------------------------------------
nvme fixes for 6.4

One nvme quirk (Tatsuki)

----------------------------------------------------------------
Tatsuki Sugiura (1):
      NVMe: Add MAXIO 1602 to bogus nid list.

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

---

Resending because I used the wrong baseline for the previous pull
request. I won't reset the baseline for fixes for the remainder of the
release cycle.

