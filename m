Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCDC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F2F64EC8
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 11:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F2F64EC8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ix1xPTnniZqWb7n6TJPiv1m4mfwvvfiVunU7+9LyqeU=; b=IbrXlcH8WUGIZADN2ol/n3y2i9
	obcNIaR5N9+CGq/857sb5HoXsyVoNzbhB6WUr5GETeQfFmuhMwhIZZdQ0pM3GOKKpfBwPd+4vgFkl
	B6xoaSKWvjZB0hE5BNUHF9rhh7E35rMEzdKkHXecVP4eH5nhBsXO4Q6DsnxwxksTTajy9Ddgjq/J/
	aiivQfulL59V3zak0GcyJsqbkR+Z4sOruJYX61Zt24aqi390Wxn+lbzFjU7QakDSf4Oa7KWgDWu8Y
	0WY78JeJNX4oSi4/HRf30V/Da8a0289dWKtrTcrRFaH51KMb84oNh3vsj/268Lud9AUnzh5uQ7pmw
	N13vfpSA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFESi-0007Lv-HK; Thu, 25 Feb 2021 11:05:40 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFESf-0007KW-IG
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 11:05:38 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 647BAADDC;
 Thu, 25 Feb 2021 11:05:36 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 0/2] nvme: fixup MD RAID usage
Date: Thu, 25 Feb 2021 12:05:32 +0100
Message-Id: <20210225110534.75710-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_060537_743459_24F64587 
X-CRM114-Status: GOOD (  16.14  )
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

While we already have a 'fast_io_fail_tmo' setting which would ensure
that I/O errors are returned after the timeout expired, this attribute
has to be set during the initial 'connect' call.
So the first patch adds a 'fasi_io_fail_tmo' controller sysfs
attribute which allows the admin to modify it during runtime.
To fixup the second issue a new attribute 'no_path_detach' is
implemented, which will cause the disk to be removed as once the
last controller holding a path to the namespace is removed (ie after
all reconnect attempts for that controllers are exhausted).

This is a rework of the earlier path by Keith Busch ('nvme-mpath: delete disk
after last connection'). Kudos to him for suggesting this approach.

Changes to v1:
- Integrated reviews from Sagi
- Use fast_io_fail_tmo instead of a new sysfs attribute
- Rename attribute to 'no_path_detach'

Hannes Reinecke (2):
  nvme: add 'fast_io_fail_tmo' controller sysfs attribute
  nvme: delete disk when last path is gone

 drivers/nvme/host/core.c      | 41 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 31 +++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      | 21 +++++++++++++++---
 3 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
