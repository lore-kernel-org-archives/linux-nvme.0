Return-Path: <SRS0=O3HW=ZN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53421C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26230206CC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2019 17:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iz1i10SM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lhwa3Jq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26230206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=imUy1LI4Kz8bHVNaMXBn6pe/LsyVlmUTlYMnroHToio=; b=Iz1i10SMLtFdiS
	RxjRkFHPe0zxZ+9f8yp5ArrFkG0hSvS3a+dqkic+CJJ+UVXUCNdqtvc4+q3Y9dkukiaa/p0AVOXXb
	6xFaab+1/LyfSzzxkA7nBROUR2nrex6SKHZwaiRtLIip28TyKPM+ANGCH/x15CFEPa9v2nd29uxCk
	Nvy/xIJrj+gsqL+JB5C7IyTVSCIA/nT6EygXRAakMNVPhc3mqTbOYNdTu7D0e2oW/m8YpoD80rzKa
	odkrnDvm2b8v32YhWv4HvSJNSNBbq8mRfdk0QuJ1LtfLtvGhY63WLJIWHDnIZaVStlMMSbgqbLIx1
	pkZ8Ctiwlhc1JUlCsfPQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iXqNl-000119-QQ; Thu, 21 Nov 2019 17:36:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iXqNi-00010g-8K
 for linux-nvme@lists.infradead.org; Thu, 21 Nov 2019 17:36:40 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2A6C82068D;
 Thu, 21 Nov 2019 17:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1574357797;
 bh=s+1u44AKeVLBrFvZ9m6Wa9o35kIRv4CqTrlx7iR7EQA=;
 h=Date:From:To:Cc:Subject:From;
 b=Lhwa3Jq3AQMua935uQLARqbxZma6v2BJRGXqakKwoLF5uMUkY+sx7PVjQio8kOMOk
 iF6wuY3J1ND8UydBPcMWUhY1G1EqDHHGabJTWW7vEew37il0XWyF3/x8epwtVoJ6FW
 0Q9SJ6M0/189MfoSekF23/gZW1pcO6fMODUrwjLg=
Date: Fri, 22 Nov 2019 02:36:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme-5.5, second pull
Message-ID: <20191121173635.GB19165@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_093638_317317_BB744330 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: chaitanya.kulkarni@wdc.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

We've accumulated a few new patches since our initial 5.5 pull request
ready for the next merge window:

 - The only new feature is the optional hwmon support for nvme (Guenter
   and Akinobu)

 - A universal work-around for controllers reading discard payloads
   beyond the range boundary (Eduard)

 - Chaitanya graciously agreed to share the target driver maintance

The following changes since commit 64fab7290dc3561729bbc1e35895a517eb2e549e:

  nvme: Fix parsing of ANA log page (2019-11-04 10:56:42 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.5

for you to fetch changes up to 6c6aa2f26c6813af38d88718881c0307bb9a54c0:

  nvme: hwmon: add quirk to avoid changing temperature threshold (2019-11-22 02:21:08 +0900)

----------------------------------------------------------------
Akinobu Mita (2):
      nvme: hwmon: provide temperature min and max values for each sensor
      nvme: hwmon: add quirk to avoid changing temperature threshold

Christoph Hellwig (1):
      nvmet: add another maintainer

Eduard Hasenleithner (1):
      nvme: Discard workaround for non-conformant devices

Guenter Roeck (1):
      nvme: Add hardware monitoring support

 MAINTAINERS                |   1 +
 drivers/nvme/host/Kconfig  |  10 ++
 drivers/nvme/host/Makefile |   1 +
 drivers/nvme/host/core.c   |  18 +++-
 drivers/nvme/host/hwmon.c  | 259 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |  13 +++
 drivers/nvme/host/pci.c    |   3 +-
 include/linux/nvme.h       |   6 ++
 8 files changed, 307 insertions(+), 4 deletions(-)
 create mode 100644 drivers/nvme/host/hwmon.c


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
