Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C68C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:33:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3E820731
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 10:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3E820731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MdlWftSDEhFJtXX65j46y2X8g308l31guGELBPe+pPk=; b=UPerugnvShHMp+PsmM+aAizFm3
	Bh04nC1UCuri593kux4Wr0lwcrVjTxEF5O2S1e17wxI8j5OHo+qewI0a5By2bz3aF4AZ9AEZbRU2c
	evVFLcbz/iO4SSUOu9fCV9D89o4c7IsKIIpmUcA82ZJsM4UJEbEf9onEo8bRRuiM36or7eBlcCGsZ
	g5eZFCtPY5cqrLctUIRMspXZDbuoP2DEIod295cX5Hq3wZtDdFwKmX7OIWbdBcerfPlvr2BVT5WiP
	FZBTnObMtWKlNZKPeo9djG+AsR0N9BOn9bsFLDLwJJMjpLdsUZnVqgW1vfP5DqZMW61d4rcJ8jLY9
	ZVqP/sCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4i8l-0000AW-W1; Wed, 27 Jan 2021 10:33:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4i8j-00008i-Db
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 10:33:34 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4D2A9AD26;
 Wed, 27 Jan 2021 10:33:32 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 0/5][RESEND] Fixup return value for nvme_submit_sync_cmd()
Date: Wed, 27 Jan 2021 11:33:21 +0100
Message-Id: <20210127103326.16191-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_053333_574892_5B056403 
X-CRM114-Status: GOOD (  16.10  )
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
Cc: Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

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

Changes to v1:
- Include reviews from Daniel
- Include changes for nvme-fc to return the same status as the
  other transports

Hannes Reinecke (5):
  nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
  nvme-fc: set NVME_REQ_CANCELLED in nvme_fc_terminate_exchange()
  nvme-fc: return NVME_SC_HOST_ABORTED_CMD when a command has been
    aborted
  nvme: return NVME_SC_ABORT_QUEUE for cancelled commands
  nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()

 drivers/nvme/host/core.c |  5 ++++-
 drivers/nvme/host/fc.c   | 11 ++++++++---
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 5 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
