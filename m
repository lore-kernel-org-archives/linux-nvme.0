Return-Path: <SRS0=B5n5=C6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02796C4346E
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE7C2084C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2020 18:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EGTL5nIq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE7C2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EfcXAbpn2Ol6NA5JUb7xs3qxcKCeFxvD+XIAijNi2TM=; b=EGTL5nIqDWXLj8lWoGtPh6m9hi
	uPIkVkXB3KluGx6VgCmWGRDLZd4x8RepCXhlvBvFU96/1ljou+W2NtNF2ON4wKoQOovT/9S56qN6t
	K4O2BCd0kFzVFZ3zmpyFAhWue2fMHD3q86hCfy8536dLCDu+xV9ev5pXaLGyTFxfVWNTLQEIeG29b
	Sy4CyLAfz9Vhbl4qF/hOCyDRlqFN1YF1/MK/w/PAOsS4jLbI4YV0w1ilWA9g+wfZI8PwJGajxYCFZ
	ynlt0LjyC+hv21QDUyC3Zfb2SCB0CQmJO+BuYa+7rl6Eu/CdcJ6x5vAfOun9frLjVjXUmd2ngOpnP
	OCfaK8fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKQo8-0004Us-5S; Mon, 21 Sep 2020 18:45:00 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKQo5-0004Te-FP
 for linux-nvme@lists.infradead.org; Mon, 21 Sep 2020 18:44:58 +0000
IronPort-SDR: nrm1u62/Gg2aJ51q9e/LhBjDtAdSN4jq2pKJkjVID4xaliGvl6KIPjl9Zh1L5zSL6GfwF5qTQV
 ppamv6/Lx3UA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="224605175"
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="224605175"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2020 11:44:54 -0700
IronPort-SDR: SDkFz9FkJPmevQG049DhiaO77fNmC2qcPbzKKsZGWW1kWdEA3kZCKSXjcyrKL0iRZ01llk1UPL
 DvLRqB/tAf4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,287,1596524400"; d="scan'208";a="334663783"
Received: from unknown (HELO nodlab-S2600WFT.lm.intel.com) ([10.232.116.103])
 by fmsmga004.fm.intel.com with ESMTP; 21 Sep 2020 11:44:53 -0700
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: [PATCH 0/3] [backport] nvme: Consolidate chunk_sectors settings
Date: Mon, 21 Sep 2020 12:47:25 -0600
Message-Id: <20200921184728.11291-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200921_144457_789481_4A339451 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: kbusch@kernel.org, Revanth Rajashekar <revanth.rajashekar@intel.com>,
 damien.lemoal@wdc.com, backports@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Backport commit 38adf94e166e3cb4eb89683458ca578051e8218d and it's
dependencies to linux-stable 5.4.y.

Dependent commits:
314d48dd224897e35ddcaf5a1d7d133b5adddeb7
e08f2ae850929d40e66268ee47e443e7ea56eeb7

When running test cases to stress NVMe device, a race condition / deadlocks is
seen every couple of days or so where multiple threads are trying to acquire
ctrl->subsystem->lock or ctrl->scan_lock.

The test cases send a lot nvme-cli requests to do Sanitize, Format, FW Download,
FW Activate, Flush, Get Log, Identify, and reset requests to two controllers
that share a namespace. Some of those commands target a namespace, some target
a controller.  The commands are sent in random order and random mix to the two
controllers.

The test cases does not wait for nvme-cli requests to finish before sending more.
So for example, there could be multiple reset requests, multiple format requests,
outstanding at the same time as a sanitize, on both paths at the same time, etc.
Many of these test cases include combos that don't really make sense in the
context of NVMe, however it is used to create as much stress as possible.

This patchset fixes this issue.

Similar issue with a detailed call trace/log was discussed in the LKML
Link: https://lore.kernel.org/linux-nvme/04580CD6-7652-459D-ABDD-732947B4A6DF@javigon.com/

Revanth Rajashekar (3):
  nvme: Cleanup and rename nvme_block_nr()
  nvme: Introduce nvme_lba_to_sect()
  nvme: consolidate chunk_sectors settings

 drivers/nvme/host/core.c | 40 +++++++++++++++++++---------------------
 drivers/nvme/host/nvme.h | 16 +++++++++++++---
 2 files changed, 32 insertions(+), 24 deletions(-)

--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
