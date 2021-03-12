Return-Path: <SRS0=WLLZ=IK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2535FC433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 09:25:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDEA64EBB
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Mar 2021 09:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDEA64EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LU+qUv6bfr0Z5C1XCbcsRhKX8+3P5rVqFS2OdWwPs1Q=; b=O9nIdOC2Mu/09aL+EOUYOXTRA8
	ZNzsX35qxYU7P2KWhkQmfODZGCd14mYFldKKeE9DXQxL5OSG/OwI+CLVTx564QaUueS7vyOUwKq61
	SLPraaJVLkc6cOCM5TtgcUfBSZJqJGJgukAE4zM0WQaj+Uep71eXSOWvAYVeaE1sNzvJE3TL1+O/h
	75PPKzpLQIKjw57xMAqZXXOw8lYEOdSuvgtsrXYzHM95ZWQm1s5VnQZhjlNxkG8veIdvVjQ6uBro7
	psonDokk/3gxgXAsRB+emjgLDPmz+9VUeZeoZTmjB7ouHdQSL5W364X+WGf1rwznLytIv3JfmE7Ys
	93lRSo6A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKe2w-00B0Ty-Ht; Fri, 12 Mar 2021 09:25:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKe2s-00B0TN-TQ
 for linux-nvme@desiato.infradead.org; Fri, 12 Mar 2021 09:25:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Up3iCiQ9A+ATJo41hgx9LAy2pmrtqIhUr0S3rcYXTAY=; b=IeOyuN+sCO95oxiA/EYde8d7X2
 lnZeIhVFAnZFst3I7NExQm+y2FkOoN3f8AzwLJY844sZ1W6mT+D7FGEY9RRVzTorMAqwhfBGTHWVh
 ZwZBxyrTaWjHoMRp2bP817Kc/vAAf35EKl0gmTd3VgVRxIXoqh38u/rPNqbnspY5OAaRHRMfPFIgB
 7YGhxdOqMYdyazYFpHpbXF9n6ZTLfElM1ZDFipFqzv9i4XvZzdCqJXFRTwzuUC5FnxgBNihbzQ0g7
 fdZoiQh3TdY4jffXQk2Ldl4h90BrNVflVV2xjTDKdw+dErtJHDEiFZOgHMpGJyS8i7Qhk8mq70RBq
 Ok4IshrQ==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lKe2j-00A7MY-8f; Fri, 12 Mar 2021 09:25:17 +0000
Date: Fri, 12 Mar 2021 10:25:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for 5.12
Message-ID: <YEszeMEAQyfTPgHH@infradead.org>
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

The following changes since commit df66617bfe87487190a60783d26175b65d2502ce:

  block: rsxx: fix error return code of rsxx_pci_probe() (2021-03-10 08:25:37 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.12-2021-03-12

for you to fetch changes up to abbb5f5929ec6c52574c430c5475c158a65c2a8c:

  nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a (2021-03-11 11:48:54 +0100)

----------------------------------------------------------------
nvme fixes for 5.12:

 - one more quirk (Dmitry Monakhov)
 - fix max_zone_append_sectors initialization (Chaitanya Kulkarni)
 - nvme-fc reset/create race fix (James Smart)
 - fix status code on aborts/resets (Hannes Reinecke)
 - fix the CSS check for ZNS namespaces (Chaitanya Kulkarni)
 - fix a use after free in a debug printk in nvme-rdma (Lv Yunlong)

----------------------------------------------------------------
Chaitanya Kulkarni (2):
      nvme: set max_zone_append_sectors nvme_revalidate_zones
      nvme-core: check ctrl css before setting up zns

Dmitry Monakhov (1):
      nvme-pci: add the DISABLE_WRITE_ZEROES quirk for a Samsung PM1725a

Hannes Reinecke (4):
      nvme: simplify error logic in nvme_validate_ns()
      nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
      nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
      nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been aborted

James Smart (1):
      nvme-fc: fix racing controller reset and create association

Lv Yunlong (1):
      nvme-rdma: Fix a use after free in nvmet_rdma_write_data_done

 drivers/nvme/host/core.c   | 15 +++++++++++----
 drivers/nvme/host/fc.c     |  5 +++--
 drivers/nvme/host/pci.c    |  1 +
 drivers/nvme/host/zns.c    |  9 +++++++--
 drivers/nvme/target/rdma.c |  5 ++---
 5 files changed, 24 insertions(+), 11 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
