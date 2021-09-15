Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8663DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:51:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E81C61157
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E81C61157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5D9PDExCWO7C4C4ZzvnxsVuD+B+egeTP0R0MX5y+Zp0=; b=dmicKyMlNplq8K
	cH6ZQFnH7WcY9u86x/GowaCN4ebE8EjqQvA9+D9Uz8J8Non1FghJjEtye7D9UK6ZgP+jlcEIZtXtZ
	2ttunVlJJ5UtVhzUYeVqdV7tdyuluc51vti62Y7yHAzjOJR3GpxS6c4L5ls4mdE5TB/dpU16Vxoe+
	XQHG08IkH02c6DTjIFD0m7XYOfvJAQTeGIc8kh2wPe6Jv9FGVtV7evOeChgZMXZjDSBrXOixF0Kw0
	2otdPhUazWl+5PMcrHUo5ox9alj/gyB9Ir2/HHsJkjvjjoYwKUqP4YOLe8Lyh7JM+s7OnQfL8mwj5
	PDRN6lUyTwf7Cq+FThyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQVJK-009DvV-OY; Wed, 15 Sep 2021 13:50:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVJJ-009DvM-LY
 for linux-nvme@bombadil.infradead.org; Wed, 15 Sep 2021 13:50:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=R/oDDB1X8KW8mjUHzbdJN1KMLEZY1CFlvWgnnv8S4Uc=; b=eJFDDrmJbK90k6a0a75NFmWkuB
 nXjV3EjRTRIJIPCGDZsgHcbcsb+6CA1FC/YyZVXiKOW6MciuWRYZ51nVnQ0/GlEimrHIdyYVpy/ej
 dDVyJ07p/SG0a0A8prkXHLF7urXHOBQFs0sGlbnHpaL/t1PeDs085yaMqKswIwIo2Z08Cbo/Iw/bl
 aeY1TnwSljwMXNiRKlX2IlotiOvk3omIo9NUDGOwzSqZZyfNjZf0Pb809tgmQ5ezLcTiaZtN5fc07
 hSSvhioFPsypl6b0Zke1AgjM6bvUVOWj2YDUcKtySSh7435rEGWBSWtuTn/FQTCSA9IQuvldz6+0H
 5rkQNRXQ==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQVIS-00FinU-K2; Wed, 15 Sep 2021 13:50:12 +0000
Date: Wed, 15 Sep 2021 15:49:55 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.15
Message-ID: <YUH6AxwHYm+FN1Au@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
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

The following changes since commit 67f3b2f822b7e71cfc9b42dbd9f3144fa2933e0b:

  blk-mq: avoid to iterate over stale request (2021-09-12 19:32:43 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.15-2021-09-15

for you to fetch changes up to 70f437fb4395ad4d1d16fab9a1ad9fbc9fc0579b:

  nvme-tcp: fix io_work priority inversion (2021-09-14 10:32:05 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.15

 - fix ANA state updates when a namespace is not present (Anton Eidelman)
 - nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show
   (Dan Carpenter)
 - avoid race in shutdown namespace removal (Daniel Wagner)
 - fix io_work priority inversion in nvme-tcp (Keith Busch)
 - destroy cm id before destroy qp to avoid use after free (Ruozhu Li)

----------------------------------------------------------------
Anton Eidelman (1):
      nvme-multipath: fix ANA state updates when a namespace is not present

Dan Carpenter (1):
      nvmet: fix a width vs precision bug in nvmet_subsys_attr_serial_show()

Daniel Wagner (1):
      nvme: avoid race in shutdown namespace removal

Keith Busch (1):
      nvme-tcp: fix io_work priority inversion

Ruozhu Li (1):
      nvme-rdma: destroy cm id before destroy qp to avoid use after free

 drivers/nvme/host/core.c       | 15 +++++++--------
 drivers/nvme/host/multipath.c  |  7 +++++--
 drivers/nvme/host/rdma.c       | 16 +++-------------
 drivers/nvme/host/tcp.c        | 20 ++++++++++----------
 drivers/nvme/target/configfs.c |  2 +-
 5 files changed, 26 insertions(+), 34 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
