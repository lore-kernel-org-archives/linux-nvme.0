Return-Path: <SRS0=K1w7=4J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AFCC35656
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376BD24653
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Feb 2020 14:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FddTTICF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hr6iEq3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 376BD24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gpNzYbOzsjRQSKbuCzIslwTO4lDH+kpNSbanFp8RgtA=; b=FddTTICFFbzPvV
	QJEUZi0VP+C2ZKgPEUqt/s0MUpgjsWqCj7CmOj2vwaLks3Sl8L131Gwmvr51Q9UD0mxQ5hFH7sjH7
	16Bqlp4LrTH0bbuUMsCYaelMPOCRgXOCPEQBYfoKmyBmNBPy3Vn9V3OMgHbSzaGzuVSAQxiOTVaCY
	PnN5KvaIgV0pDdbUf/din6jVOJC7Cm4oxVMI9Eu4bq1ohNUkDxXXRECmpzGIN4WGInnE/biGSlW0S
	ShjZnkzZ77IEbzDzP3Sx9JsMqABvLrukd7ozZdjbelcHmIIYDZQpDrKcg3KJzAeIkn70FdDOGWnIh
	YlEffI+GK75o5fkUZktA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j59jd-0006Lj-4I; Fri, 21 Feb 2020 14:56:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j59jb-0006L7-1B
 for linux-nvme@lists.infradead.org; Fri, 21 Feb 2020 14:56:56 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 24A5E24650;
 Fri, 21 Feb 2020 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582297014;
 bh=E9TXriVL/Zsow1hjYWkUmT331BY712ftRGblihaaBu0=;
 h=Date:From:To:Cc:Subject:From;
 b=Hr6iEq3ilWjuGf9o4DY3LDkgpbHIfd7c/JZOgrGs4oTYEb7Kfr0qU9KeC8i9FYL/8
 nT4CqBa/3Qr38kcWT+REFDTZGWMzHkz0s8Mf87U19WurY0SK1uDNQYu9ALvJqluar9
 zcHYvGxCpO000Qw8vxDGzRYbRWuKgY3Zu97kuJAE=
Date: Fri, 21 Feb 2020 23:56:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Subject: [GIT PULL] nvme fixes for 5.6
Message-ID: <20200221145652.GB15144@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200221_065655_099596_B50D5C71 
X-CRM114-Status: GOOD (  10.80  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit f25372ffc3f6c2684b57fb718219137e6ee2b64c:

  nvme: fix the parameter order for nvme_get_log in nvme_get_fw_slot_info (2020-02-14 10:12:04 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.6-rc3

for you to fetch changes up to 3b7830904e17202524bad1974505a9bfc718d31f:

  nvme-multipath: Fix memory leak with ana_log_buf (2020-02-21 23:52:25 +0900)

----------------------------------------------------------------
Andy Shevchenko (1):
      nvme-pci: Use single IRQ vector for old Apple models

Keith Busch (1):
      nvme: Fix uninitialized-variable warning

Logan Gunthorpe (1):
      nvme-multipath: Fix memory leak with ana_log_buf

Shyjumon N (1):
      nvme/pci: Add sleep quirk for Samsung and Toshiba drives

 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  1 +
 drivers/nvme/host/pci.c       | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
