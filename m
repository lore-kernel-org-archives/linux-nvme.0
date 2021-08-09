Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C272DC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:42:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D1660527
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 06:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 64D1660527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hVSJ/Zdibnr+s1hp/eqYrA8A4llYyVT6gio5l3olg3c=; b=gRQFtt0nSJCFwq
	Y/uvgJpeojrauMYzp6DwkJOSIzMvf7MsuiDWH7rrwamUrmeA/V0gITnqtW8A6pZ2qlF2LJZtlCFic
	NpFnca72Zt6QFSidW9hNbeRLxv70JmHMlucBh31tPTI9/G/Nl5VpaNTaELQHSNVdxPmHcW1hAi5YT
	38jBrj/sVOUahTnRqermgaBvEjr9rLb1b+r7nTYHjVLL58wqx8vE5TAwNGViegwJrrplRv4GJ+JDK
	PXca6JquAYIhIHuoKbPjRU53mtSDXJf1fLAX6L+XMXYAIzcadqi3vsKYMWcKZlXhAOQDPggxd4wRh
	AN7RwnffOX87Q+nwJIgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCyzD-00HGg8-VU; Mon, 09 Aug 2021 06:42:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCyyr-00HGfy-CT
 for linux-nvme@bombadil.infradead.org; Mon, 09 Aug 2021 06:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=gu/wdO3pWcEV2DnoEvj5RVwNNwRwRD9cxQPKa/ARsu8=; b=mYVZtFcPQ4+E3YBX+sTHOUPIrO
 J2Bmm0o9TrUkEYjnnOoWqM+nxwMfA7G1aakmWt0bftItoCGMg7h/ssgKVMBDxZu/BaoylRTvgnMfR
 fhDTXTSYc2+kErta8SH6dFjBhtjzsz2cXsilz0MMeqHi3uGYO+oayBPgp5YykjqCIlc3zZByQpbvu
 VHTnwLHi1CnPz9ExfGgCWcpaHZFE7y4OUL2Jci7lYjTpjxrbObXMiJttFrqy0v0IyBeAxelCUxMir
 gQ4ZJE3NgEI13hQHqKPBSkPMooG9toraV08VDFjqLQXUTWMmjFfB3tsCA7oxWIDMHKaDieyXinM+4
 a4TE0ONQ==;
Received: from [2a02:1205:5023:1f80:c068:bd3d:78b3:7d37] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCyxZ-00AiWj-9Y; Mon, 09 Aug 2021 06:40:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Luis Chamberlain <mcgrof@kernel.org>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: remove GENHD_FL_UP
Date: Mon,  9 Aug 2021 08:40:20 +0200
Message-Id: <20210809064028.1198327-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Hi Jens,

this series first cleans up various drivers to not rely on the
internal GENHD_FL_UP to decided if they need to call del_gendisk
and then removes the flag entirely.

Diffstat:
 block/genhd.c                 |    6 -
 block/partitions/core.c       |    4 -
 drivers/block/sx8.c           |    2 
 drivers/md/bcache/super.c     |   26 ++++---
 drivers/md/md.h               |    4 -
 drivers/mmc/core/block.c      |  143 +++++++++++++++++-------------------------
 drivers/nvme/host/core.c      |   16 ++--
 drivers/nvme/host/multipath.c |    2 
 fs/block_dev.c                |    2 
 include/linux/genhd.h         |    9 +-
 10 files changed, 93 insertions(+), 121 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
