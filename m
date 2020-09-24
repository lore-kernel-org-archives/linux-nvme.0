Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352AEC4363D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 13:47:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D39A206F7
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 13:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="h5+R1bqC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dUvetM9O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D39A206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fNVf8j7Vu/pR94L2rSqPegsFSUOBUBR8xB3zgnDELf4=; b=h5+R1bqCA9eMA9YSdQdPJTTi6C
	CuC6/o4qkxxtEcun/nP/hk/ZsaX7cwvf0v6o/dmUeF1KnOe62Hv1nNnANd7bzmgpWyCCPAAox2AEZ
	e21AN6ZpMlus3GrYpzkKyk+Miridxmt/rUbZ2s2PxuKSLzSHbl5Ld8KLeMoyVc1ZBpZBZUpdH8JZU
	KQ1tCE9CKgak3khijsG+ntUvKSN2i0/GNrOV1VUnAdDpsGzLRvkIY+Kb6ENnSxV6XjprDgVNc7zn4
	xe+zqap9OA49IIWVro2OA+XNWduiH/IKj4DFD4RgSX62OY99OewMxzYszWWnrgKwESnRh4NZWh53U
	xAvitwFg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLRaN-00080l-Ea; Thu, 24 Sep 2020 13:46:59 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLRaL-00080S-Rl
 for linux-nvme@merlin.infradead.org; Thu, 24 Sep 2020 13:46:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=QPRY1PBjjGfg4Jna7TYhCqqdJngF0dkb335+a5ET34E=; b=dUvetM9OE0gs43FYE0YiBXqPWP
 99ISp6Jj1qNb3w8YBhf9Uda0YsDf9pEQJHOAKJ3LsvZkEiJaQdmCh9UoCrmDrR5mKiC5HuHQZgFKW
 qBAgRXxZLPasTMyUr1w31jSFhzSdYA+ZuUBnjUslk6T7MMeIMAv80/SqKHVd+yD2tYsbHvnPwKYKF
 3UxLI6g1W0TeYB0OLv/xE5qaIVheV23olB3yOTJCLxLwJ5h+JZdWvNGjdtLzBxVkZmSK32Gq1z+MN
 9IbNoSx2v08UOKxUtzVU5c3hOEma8R8Rx/O7RSqBEQhJNX1S7BsMJViTOElktriij25/UKcojL8mP
 wyISLjRQ==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLRaJ-0003Da-U6; Thu, 24 Sep 2020 13:46:56 +0000
Date: Thu, 24 Sep 2020 15:46:54 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200924134654.GA873840@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 4a2dd2c798522859811dd520a059f982278be9d9:

  Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-24

for you to fetch changes up to 46d2613eae51d527ecaf0e8248a9bfcc0b92aa7e:

  nvme-core: don't use NVME_NSID_ALL for command effects and supported log (2020-09-23 20:01:47 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - fix error during controller probe that cause double free irqs
   (Keith Busch)
 - FC connection establishment fix (James Smart)
 - properly handle completions for invalid tags (Xianting Tian)
 - pass the correct nsid to the command effects and supported log
   (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: don't use NVME_NSID_ALL for command effects and supported log

James Smart (1):
      nvme-fc: fail new connections to a deleted host or remote port

Keith Busch (1):
      nvme: return errors for hwmon init

Xianting Tian (1):
      nvme-pci: fix NULL req in completion handler

 drivers/nvme/host/core.c  |  9 ++++++---
 drivers/nvme/host/fc.c    |  6 ++++--
 drivers/nvme/host/hwmon.c | 14 ++++++--------
 drivers/nvme/host/nvme.h  |  7 +++++--
 drivers/nvme/host/pci.c   | 14 +++++++-------
 5 files changed, 28 insertions(+), 22 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
