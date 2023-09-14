Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B54CEEAA72
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Sep 2023 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=16hpJAxL/awds0TH9qQb6JfaYaT9c5nt8qKw7+jlkfQ=; b=3MZXfuVrQio34vq+CT+g8yhZZy
	3A/FV+y/nxu7m3zHT0owZ5taJU1O/5VmHudxJLi1SrI5fdSD2bBxCHfdrsYfQbq+ksNSLTW0Qf7ln
	XibHalUMASPDcRG6y1GAyiwZETnaahk7X7nP/cGWZke6ZuXvNHVy/rAvZrvUUIim+53wpiQlunlAZ
	P/YnhRolBuBXnNyn5U9EO4OtsWwDN2tAujhX5rl4WTmx3dtSlKb3fMjZYiRzoyMaUku+salkuG+9Y
	6+Q9X3hGCaHWUMXbuUhaevawfXTsM4Xs3qzhT6AaaCV//E1esRdVuw3VpJ0QVfGlgjMXKTVsT7BGZ
	e7dj3qNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgsph-009DVS-24;
	Thu, 14 Sep 2023 20:21:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgspf-009DUa-2D
	for linux-nvme@lists.infradead.org;
	Thu, 14 Sep 2023 20:21:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 22A8361D57;
	Thu, 14 Sep 2023 20:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51051C433C7;
	Thu, 14 Sep 2023 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694722858;
	bh=GbQW9anmGSdKBGitnp5GOC+oo0oqUlv43RrzoTZDYuU=;
	h=Date:From:To:Cc:Subject:From;
	b=Pg1yPaccOAZCYKPnepstzlmpyILmuyVoYuLTOu8mmG3b/lLIB85l7s9+09eW2upkH
	 eDc+vaXjAuOuGcDhLbB0nmdghzBA/64s67kgVgw8o3F6u5+PcPfv1Wtv1dUjMvMXxy
	 +WTA9oe363bKKz7CKtOxgfiyT2J0QK/3p9O2fo7RgkvZT76fDDgjTANHuwHEYs5dU6
	 YBYaPC7A+Ir57zzRk4hT12Y3gUsvRIBHfWG8ZdGrnk+uAly2GGsybdTwIouNAI9nDH
	 04jyWFwx+OjpTS8z7LrifM6NNRfL+apAGK07i2a8pjPku6KzQ3MI/C6nZ9YX2Rd0po
	 zlyjS8HiXad6w==
Date: Thu, 14 Sep 2023 13:20:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 6.6
Message-ID: <ZQNrKAmt0kiR2Zjj@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_132059_767466_AD29EA12 
X-CRM114-Status: GOOD (  10.49  )
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

The following changes since commit 851e06297f20bbd85c93bbf09469f2150d1db218:

  ublk: zoned: support REQ_OP_ZONE_RESET_ALL (2023-08-20 20:24:34 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.6-2023-09-14

for you to fetch changes up to 6cc834ba62998c65c42d0c63499bdd35067151ec:

  nvme: avoid bogus CRTO values (2023-09-14 13:09:52 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.6

 - nvme-tcp iov len fix (Varun)
 - nvme-hwmon const qualifier for safety (Krzysztof)
 - nvme-fc null pointer checks (Nigel)
 - nvme-pci no numa node fix (Pratyush)
 - nvme timeout fix for non-compliant controllers (Keith)

----------------------------------------------------------------
Keith Busch (1):
      nvme: avoid bogus CRTO values

Krzysztof Kozlowski (1):
      nvme: host: hwmon: constify pointers to hwmon_channel_info

Nigel Kirkland (1):
      nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

 drivers/nvme/host/core.c  | 54 +++++++++++++++++++++++++++++++++++-------------------
 drivers/nvme/host/fc.c    |  2 +-
 drivers/nvme/host/hwmon.c |  2 +-
 drivers/nvme/host/pci.c   |  3 ---
 drivers/nvme/target/tcp.c |  2 +-
 5 files changed, 38 insertions(+), 25 deletions(-)

