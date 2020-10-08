Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52A8C4363C
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 15:01:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C0E20708
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 15:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z11aOP2c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mkJwfCE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C0E20708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+Hftr1SFNI6GeCH8ankkWu3WlrpZf+DaRSrpeP+RfLU=; b=z11aOP2cNsdroeKw1THw9CTYn0
	+lEFsf35sLf33mFsPRvhKWhiUspF6/mtPHVCDqfm8ENi/62g3ZWmy6sXAkRM9TzHJpF0OParppbLg
	3xOvdnhrR+N6gpAgjo1ApYWpfnYQJZTy8c9vAmC7qTjoEBWIANELG3kbHTuAaj8dzxGmHKviTWvNp
	L/vbkeirMvG8+cBmLBo9FpL5B886Tx1d4RGxxmwkTtbdvkkBsay9LnyS7CCGmNpo3+voBLI5LUGpi
	lc8HpgcToyPF7sNujS9SUNc6OvTHPFzkf62H2L8GBe8RPHRZkci3sM4fEekmDpXdAT8YoefIn/MPG
	MHGggvSQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQXQ8-0003TG-In; Thu, 08 Oct 2020 15:01:28 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQXQ7-0003T4-0g
 for linux-nvme@merlin.infradead.org; Thu, 08 Oct 2020 15:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=gCtmTvU+4iB0ZJq8Xk5I9RTnD1fzvpVWZs/DrC+eDx0=; b=mkJwfCE/zdBfQ5/PvlUgeWlPT5
 GeJCtAybmlKtJ7JrAZ+pIBoNvlPfR4irFWuiT5ov9lw5FQuxpF+LVTXLc9bVWaRRQtL15P/y0moyO
 9BWZ9pDerBeUjWij7KP7bWc4QnXOXtf5FimiDKyLpMVmtOXe2tdx06HOzQkr86MdelnWTnpgwxKpI
 5guZR1EXDREF7LmDtDd1J9aJnVMDo3eJ/GesM504HS9sQ+eP3bwzstw9wIuPNIi2CqoHP0ckKekV4
 +U4BHHmgedsHOlgMoq3maYxq65jYZLY43J263AMyUXZrmtzIhZlUNjpkzkIsNJ6AfHY3KxNqJTtoW
 KlK+MaaA==;
Received: from [2001:4bb8:184:92a2:cbfa:206d:64ea:205c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQXQ5-0006Wu-RA; Thu, 08 Oct 2020 15:01:26 +0000
Date: Thu, 8 Oct 2020 17:01:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme updates for 5.10
Message-ID: <20201008150125.GA1495381@infradead.org>
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

The following changes since commit 103fbf8e4020845e4fcf63819288cedb092a3c91:

  scsi: megaraid_sas: Added support for shared host tagset for cpuhotplug (2020-10-06 08:33:44 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.10-2020-10-08

for you to fetch changes up to c4485252cf36ae62c8bf12c4aede72345cad0d2b:

  nvme-core: remove extra condition for vwc (2020-10-07 07:56:20 +0200)

----------------------------------------------------------------
nvme update for 5.10:

 - fix a controller refcount leak on init failure (Chaitanya Kulkarni)
 - misc cleanups (Chaitanya Kulkarni)
 - major refactoring of the scanning code (me)

----------------------------------------------------------------
Chaitanya Kulkarni (3):
      nvme-loop: don't put ctrl on nvme_init_ctrl error
      nvme-core: remove extra variable
      nvme-core: remove extra condition for vwc

Christoph Hellwig (20):
      block: optimize blk_queue_zoned_model for !CONFIG_BLK_DEV_ZONED
      nvme: fix initialization of the zone bitmaps
      nvme: remove the disk argument to nvme_update_zone_info
      nvme: rename nvme_validate_ns to nvme_validate_or_alloc_ns
      nvme: rename _nvme_revalidate_disk
      nvme: rename __nvme_revalidate_disk
      nvme: lift the check for an unallocated namespace into nvme_identify_ns
      nvme: call nvme_identify_ns as the first thing in nvme_alloc_ns_block
      nvme: factor out a nvme_configure_metadata helper
      nvme: freeze the queue over ->lba_shift updates
      nvme: clean up the check for too large logic block sizes
      nvme: remove the 0 lba_shift check in nvme_update_ns_info
      nvme: set the queue limits in nvme_update_ns_info
      nvme: update the known admin effects
      nvme: remove nvme_update_formats
      nvme: revalidate zone bitmaps in nvme_update_ns_info
      nvme: query namespace identifiers before adding the namespace
      nvme: move nvme_validate_ns
      nvme: refactor nvme_validate_ns
      nvme: remove nvme_identify_ns_list

 drivers/nvme/host/core.c   | 455 ++++++++++++++++++++-------------------------
 drivers/nvme/host/nvme.h   |   9 +-
 drivers/nvme/host/zns.c    |  16 +-
 drivers/nvme/target/loop.c |   4 +-
 include/linux/blkdev.h     |   4 +-
 5 files changed, 220 insertions(+), 268 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
