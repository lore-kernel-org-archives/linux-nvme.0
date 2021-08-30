Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA26C4320A
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:26:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E906F600D0
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 21:26:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E906F600D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=34jTx6ycV+ogn5YroGXac4d62EYklp0hoDW3tTOI+hQ=; b=DzrxuC/dvn2t5x
	QyRHwZ0Aa9Uf6ss759CCw5RRKNHc18zlZqm+Md6IMBqWxAGwRQ5dvUvJlGPhiEZaQwSSFmQT7aUs6
	gr2S0RT3hNOklUHtAY2Gq2NipGw30W+84/zNj3IfY1R3rXNwf+3Q8rUB5uWz2aK0ese7R57NLbdf4
	y/Jss2epN0LRUjMa16oZACkxRSjGw0QW3A+nWzWYgmasCxbOBRUscs8IV8ExJZEZfkDgb9LEiz9dS
	R1pLLPEVxCD2OIbspN9NY6BZeHtR/zHxr3Z5AbW7TAVBad2+d6g9PhZbsMw6lvyLpmd9VBmX1GIbn
	q0WAj0k49clcJbVbZTtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKonI-000cwt-Hk; Mon, 30 Aug 2021 21:26:16 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mKomk-000ci4-DU; Mon, 30 Aug 2021 21:25:42 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mmc@vger.kernel.org, dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 0/8] block: first batch of add_disk() error handling
 conversions
Date: Mon, 30 Aug 2021 14:25:30 -0700
Message-Id: <20210830212538.148729-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Jens,

I think this first set is ready, but pending review of just two patches:

  * mmc/core/block
  * dm

All other patches have a respective Reviewed-by tag. The above two
patches were integrated back into the series once I understood
Christoph's concerns, and adjusted the patch as such.

This goes rebased onto your for-next as of today. If anyone wants to
explore the pending full set this is up on my linux-next branch
20210830-for-axboe-add-disk-error-handling-next [0].

[0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210830-for-axboe-add-disk-error-handling-next

Luis Chamberlain (8):
  scsi/sd: add error handling support for add_disk()
  scsi/sr: add error handling support for add_disk()
  nvme: add error handling support for add_disk()
  mmc/core/block: add error handling support for add_disk()
  md: add error handling support for add_disk()
  dm: add add_disk() error handling
  loop: add error handling support for add_disk()
  nbd: add error handling support for add_disk()

 drivers/block/loop.c     | 9 ++++++++-
 drivers/block/nbd.c      | 6 +++++-
 drivers/md/dm.c          | 4 +++-
 drivers/md/md.c          | 7 ++++++-
 drivers/mmc/core/block.c | 7 ++++++-
 drivers/nvme/host/core.c | 9 ++++++++-
 drivers/scsi/sd.c        | 6 +++++-
 drivers/scsi/sr.c        | 5 ++++-
 8 files changed, 45 insertions(+), 8 deletions(-)

-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
