Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3556C2BB1D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACC02073E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/4Ivoq5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KqcFJnKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACC02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ofU8ZHhcG6tE21XQZKGrlFiuXbxGrA2PIPPdTMo8zVw=; b=Y/4Ivoq5qyYgty
	/JBIuY7b3z9BT35lFwAsso7So8lpZqKzhMiiWnD11qj0Y9hvDR8JQYRM97YJ2QFNB0zI3nlY55Hwu
	XdRvREIglWG3ibhjW5xxa4mJNJVzZedh39wSQ2xf4PQjVTLxAZqx1n+vdGIjmEmYZ4ikeNCM2doaG
	GKUhqUSwzbnoEJJ1nv2LW8oQLDyoCBXu5c5cGmcVRpmklta2e+35LztapRqsxQ4vDGuweTqbpax1s
	J/4W01yocIZYetSeYr4Nf21VCuzFTsQSvjkpJGqmTCZEQUItAlxGoEmDY8nS8XLQEOPa7Po6E3P7i
	3ot8wNap3VWo4kCNmBFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCcuJ-0005Mh-Oy; Fri, 13 Mar 2020 05:30:51 +0000
Received: from smtp-fw-2101.amazon.com ([72.21.196.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCcuB-0005EC-HL
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 05:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1584077444; x=1615613444;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=REy7LBkdQ5MCy84KosSuZWNgbDSwbuHXvkOMZFApZ0g=;
 b=KqcFJnKYZSCh7pb699WB0+JSS2fnTn1NNz0CHYFZoWEiBlKK/8PtE0Dw
 K/rc1r8g0vENcFh+3TEQogPSJyTCrYrDFfRa2KAUUWPks2uBD6E2a1x7u
 iQAgBV4ofwjZOrBSHkKdl6EURidUAPHAkskv2E5AXqJ/ZH6bHLYFeW9lH Y=;
IronPort-SDR: BBxpNHEOWW1ENqqjyI1ueSy8wEtQCRVJhTMUDArhWjlmVcbDR3lUllZ4prigMjSQ6ncpcVpQDH
 I5KYk9VOYoPg==
X-IronPort-AV: E=Sophos;i="5.70,547,1574121600"; d="scan'208";a="21324131"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
 by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP;
 13 Mar 2020 05:30:20 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
 by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS
 id 8CE8CA2E2C; Fri, 13 Mar 2020 05:30:18 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 05:30:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 05:30:17 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Mar 2020 05:30:18 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 0/5] Add support for block disk resize notification
Date: Fri, 13 Mar 2020 05:30:04 +0000
Message-ID: <20200313053009.19866-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_223043_717910_8BE83532 
X-CRM114-Status: GOOD (  12.07  )
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
Cc: axboe@kernel.dk, Balbir
 Singh <sblbir@amazon.com>, hch@lst.de, Chaitanya.Kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Allow block/genhd to notify user space about disk size changes using a
new helper set_capacity_revalidate_and_notify(), which is a wrapper
on top of set_capacity(). set_capacity_revalidate_and_notify() will only notify
iff the current capacity or the target capacity is not zero and the
capacity really changes.

Background:

As a part of a patch to allow sending the RESIZE event on disk capacity
change, Christoph (hch@lst.de) requested that the patch be made generic
and the hacks for virtio block and xen block devices be removed and
merged via a generic helper.

This series consists of 5 changes. The first one adds the basic
support for changing the size and notifying. The follow up patches
are per block subsystem changes. Other block drivers can add their
changes as necessary on top of this series. Since not all devices
are resizable, the default was to add a new API and let users
slowly convert over as needed.

Testing:
1. I did some basic testing with an NVME device, by resizing it in
the backend and ensured that udevd received the event.


Changelog v3:
- Repost after rebasing
- Trim details of the subsystem/files in the subject
Changelog v2:
- Rename disk_set_capacity to set_capacity_revalidate_and_notify
- set_capacity_revalidate_and_notify can call revalidate disk
  if needed, a new bool parameter is passed (suggested by Bob Liu)

Balbir Singh (5):
  block/genhd: Notify udev about capacity change
  virtio_blk.c: Convert to use set_capacity_revalidate_and_notify
  xen-blkfront.c: Convert to use set_capacity_revalidate_and_notify
  nvme: Convert to use set_capacity_revalidate_and_notify
  scsi: Convert to use set_capacity_revalidate_and_notify

 block/genhd.c                | 24 ++++++++++++++++++++++++
 drivers/block/virtio_blk.c   |  5 +----
 drivers/block/xen-blkfront.c |  6 +-----
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/sd.c            |  3 ++-
 include/linux/genhd.h        |  2 ++
 6 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.16.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
