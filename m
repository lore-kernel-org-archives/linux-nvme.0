Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440D0C43381
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:56:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C48AC64E21
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 10:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48AC64E21
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3qrzd+X55e6UFTBhhJeHazKJNl/ViLzH6jq1hv8BpR8=; b=BPS7w9ggwd5aigWs8YwCAgY/uv
	DwnGr7CTW0OSWqGtVeIu3BpOWYcnsMh8d7jEnq/OAzXuo537NxEFM7aMB0ThpXpTOkgNzReUivAH2
	YubDyPvklJpLhoVhYnGK0lu7EiAKMRQ1Kes38byCitn4GyDryYsJZA7uj6HKKsrCEQr0cONH5kFDl
	SGgM2nZnAX2E/wVwPFic2xfgK/vhPEUtaY+dTn8YFQqSV9uSokNYyovo0hEjCrFf+XcVdK35xVXsF
	qaV5Qw0IpadOexdDXoSFYmRMrfteyUHaSEyejgmv/FT7DhA214WV12pAefB4D3xrcRiokUSdqvlMp
	Ga4NOncg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lFEJD-0005Ma-Ej; Thu, 25 Feb 2021 10:55:51 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lFEJ4-0005Ji-C9
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 10:55:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C9D55AC6E;
 Thu, 25 Feb 2021 10:55:40 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCHv3 0/6] Fixup return value for nvme_submit_sync_cmd()
Date: Thu, 25 Feb 2021 11:55:21 +0100
Message-Id: <20210225105527.75277-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210225_055542_993614_C8D9D835 
X-CRM114-Status: GOOD (  14.41  )
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
Cc: linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

here are some small patches for fixing up the return value of nvme_submit_sync_cmd().
As Keith correctly noted, nvme_submit_sync_cmd() should be returning
an error if the command could not be performed; however, currently
only pci does that.
So we need to fix up nvme_cancel_request() to return an -EINTR
on any pending sync commands during reset.
And modify nvme-fc to return the same nvme status after timing out
or cancelling requests.
Plus, finally, adding a new flag 'NVME_REQ_TIMEOUT' to indicate
that a command had been aborted due to a timeout, and translates that
back into -ETIMEDOUT as a return code for nvme_submit_sync_cmd().

As usual, comments and reviews are welcome.

Changes to v2:
- Include reviews from Sagi
- Simplify error logic from nvme_validate_ns()

Changes to v1:
- Include reviews from Daniel
- Include changes for nvme-fc to return the same status as the
  other transports

Hannes Reinecke (6):
  nvme: simplify error logic in nvme_validate_ns()
  nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
  nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
  nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been
    aborted
  nvme: return NVME_SC_ABORT_QUEUE for cancelled commands
  nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()

 drivers/nvme/host/core.c | 11 +++++++----
 drivers/nvme/host/fc.c   | 11 ++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
