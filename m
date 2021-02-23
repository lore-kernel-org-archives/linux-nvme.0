Return-Path: <SRS0=3q+x=HZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ABFC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F326A61481
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Feb 2021 11:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F326A61481
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UzrzwNtWtNuL4kqHwtwiKg7bohA+7LaaRW7z0scValo=; b=tILsu/H42zXi3g/+uUeMm+HmVK
	hDVo8/lwTCUnSvlpoHLV9G4C9FKTKyBCywaLbt6z7RA/mBKgQl3kr/xn8prYA6u7EORknO2S4UNM8
	F8/MnBHDie1aNnLPUJy7Oou5ZDvdVK5X+m5MQ9gF5VBU/swnEM+9x0cf8Hf4DboP3T9KFM4vBwyYG
	rYPghpbKqV6rdV6hZCat6U1g0tmJhVJn/c+QOdi1RNGhQOsB1Y/8RttDX2rpCSY0Bb762G3Od+wTD
	9GJu2NDbv5cUJR0wvFo6gDhIzp3uTswupZ6pCxEeFgtYgPhsh7SnJaCr3BydN7ff8wXr4bNwGhUNP
	aC9ENQEg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEWLn-0007Xf-Ch; Tue, 23 Feb 2021 11:59:35 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEWLj-0007Vs-Qf
 for linux-nvme@lists.infradead.org; Tue, 23 Feb 2021 11:59:32 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 64D33AE7A;
 Tue, 23 Feb 2021 11:59:29 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] nvme: fix regression with MD RAID
Date: Tue, 23 Feb 2021 12:59:20 +0100
Message-Id: <20210223115922.104369-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210223_065932_010491_CADC82B2 
X-CRM114-Status: GOOD (  13.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

ever since the implementation NVMe-oF does not work together with MD RAID.
MD RAID expects the device to return an I/O error on failure, and to remove
the block device if the underlying hardware is removed.
This is contrary to the implementation of NVMe-oF, which will keep on retrying
I/O while the controller is being reset, and will only remove the block device
once the last _user_ is gone.

These patches fixup this situation by adding a new sysfs attribute
'fail_if_no_path'. When this attribute is set we will return I/O errors
as soon as no paths are available anymore, and will remove the block device
once the last controller holding a path to the namespace is removed (ie after
all reconnect attempts for that controllers are exhausted).

This is a rework of the earlier path by Keith Busch ('nvme-mpath: delete disk
after last connection'). Kudos to him for suggesting this approach.

Hannes Reinecke (2):
  nvme: add 'fail_if_no_path' sysfs attribute
  nvme: delete disk when last path is gone

 drivers/nvme/host/core.c      |  6 +++++
 drivers/nvme/host/multipath.c | 46 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      | 19 +++++++++++++--
 3 files changed, 66 insertions(+), 5 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
