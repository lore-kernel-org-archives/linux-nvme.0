Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E1C4363A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:45:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566482078D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 12:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RKkgU2uh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566482078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rSxXMdozb4Rt5xYYE/S2ki9hfo3q9ghRlrbhZCmza0k=; b=RKkgU2uhByY32p6yAvcLUFpBjG
	FEeuiPOStF02A6eSAIxC0eZ6S3j46KdwDA/sKdx9gkZlih1F+F+7N8toyGJUhDWsz1opB4NskvCIh
	jL4p4h18as3qjwVGl1AAogpHQMruPBHHe+fpXWmymWqq8aghyPQ+aYW6PgIOeLOmDvBa9iNICaQBk
	Q0e/456RjqcYxBS2iNRGc/1SrksWjpACV6UKuuiX/m8yWgBi8I50xR+2jClnI7jjvjEEBxYHMx3tZ
	cKXseVmAJexPSxwVNBwz51rdKzZU4o1a5yqKnuobxDRVrjR5NtgwxpkauGV7ttCv5YQU4rrDVczrM
	Nlu/eBfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPPrf-0003Z7-U4; Mon, 05 Oct 2020 12:45:15 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPPrZ-0003XN-69
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 12:45:11 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A7351B4D2;
 Mon,  5 Oct 2020 12:45:06 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [RFC PATCHv3 0/2] nvme: queue_if_no_path functionality
Date: Mon,  5 Oct 2020 14:44:58 +0200
Message-Id: <20201005124500.6015-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_084509_343238_DBD8446D 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this is a patchset based on Keiths original patch for restoring pre-fabrics
behaviour when the last path to a multipath device is removed.
Originally, the nvme device had been removed once the underlying hardware
had been removed. With the introduction of multipath support things changed;
it's now the 'CMIC' bit in the controller identification which controls the
behaviour. If it's set to non-zero, the device is retained even if the hardware
is removed. While this is okay for fabrics (as we can manually connect and
disconnect the devices), for nvme-pci this means that PCI hotplug ceases
to work as the device is never removed, and when reinserting the hardware
a new nvme device is created.
This patchset introduces a 'queue_if_no_path' flag to control the handling of
the last path; it's set for fabrics to retain the current functionality,
but unset for PCI to revert to the original, pre-fabrics behaviour.

Changes to v2:
- Merge two patches
- Fix to make it compile without CONFIG_NVME_MULTIPATH
- Move sysfs attributes to be compiled in only for CONFIG_NVME_MULTIPATH

Hannes Reinecke (1):
  nvme: add 'queue_if_no_path' semantics

Keith Busch (1):
  nvme-mpath: delete disk after last connection

 drivers/nvme/host/core.c      | 13 ++++++++++++-
 drivers/nvme/host/multipath.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  4 +++-
 3 files changed, 53 insertions(+), 3 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
