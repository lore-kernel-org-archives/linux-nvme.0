Return-Path: <SRS0=j6C5=H4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B010C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EAEF64EE1
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Feb 2021 08:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAEF64EE1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8EUcNhxsXpXf4I6VOm4qFfrxzDQGDu0xZ2V97ZeogEI=; b=iHwk7bqJWlKybJwo/ctqNW3Hv8
	3shcM/txps/Jlga9Xo/mdMltdVh8c5wdGDpzMU3g9wkpNqcnh2GOlxWKjm92LHVVoBNe/GfpahR1F
	BIG1ATTsZxpbYfssmuIb8ZI1vGMrwSEcvbTuEdXyN7ZrRYMfpSySMlIvvEUQ+eysHForH+VdG7d33
	Os+sqjRKTDc8l1PgaPyh9o9UrPqX9nmwys3tPPh21m6N2aD6WIazFu9Adc4vSoqPo5vsiEGTVrkEA
	NvMdF4Q3tn6NxwOOeKnR5uTEuPw+swcbjMeYs4CnqRqltrDQEUjG3nJNKqlujYbtr0FSp9V0ANdp2
	2SPP4pTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFXNb-0007Iz-1r; Fri, 26 Feb 2021 07:17:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFXNW-0007Ge-6x
 for linux-nvme@lists.infradead.org; Fri, 26 Feb 2021 07:17:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BB01BADDC;
 Fri, 26 Feb 2021 07:17:32 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCHv4 0/4] Fixup return value for nvme_submit_sync_cmd()
Date: Fri, 26 Feb 2021 08:17:24 +0100
Message-Id: <20210226071728.106923-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210226_021734_495796_57DD1EC6 
X-CRM114-Status: GOOD (  15.81  )
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

here are some small patches for fixing up the return value of
nvme_submit_sync_cmd().
As Keith correctly noted, nvme_submit_sync_cmd() should be returning
an error if the command could not be performed; however, currently
only pci does that.
So we need to fix up nvme_cancel_request() to return an -EINTR
on any pending sync commands during reset.
And modify nvme-fc to return the same nvme status after timing out
or cancelling requests.

As usual, comments and reviews are welcome.

Changes to v3:
- Dropped patch to change the status code for aborted commands
- Dropped patch to set -ETIMEDOUT on timed out commands
- Include reviews from Chao Leng

Changes to v2:
- Include reviews from Sagi
- Simplify error logic from nvme_validate_ns()

Changes to v1:
- Include reviews from Daniel
- Include changes for nvme-fc to return the same status as the
  other transports

Hannes Reinecke (4):
  nvme: simplify error logic in nvme_validate_ns()
  nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
  nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
  nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been
    aborted

 drivers/nvme/host/core.c | 9 +++++----
 drivers/nvme/host/fc.c   | 3 ++-
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
