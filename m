Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA2AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 08:06:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A1952071E
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 08:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1952071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2rREKSZwW39U/Tq/sTjr3pxpvZm0Olz8HetfVBe6ugw=; b=Fd8ThPgymmjsXq0LMVDT7whK4O
	cfl9AF3np23JXtzyjXhZdjPmh8iCrgdaV+MGMOm8iIKhW04VPFhX03Iw0WAO4EWRsbeFO/dbyB1SV
	GAvx/z1dT8P2SD1P/fVo5FpYXMM37Wx35c/vPxpG6JosYT4Uc//03265bQ23dR+GK6IKk0uxycMVE
	f1UF1H2pxUMgKarEJlfriF0qNTyiapuW2CO8wbDFZhX+WBHe0Ja2Atp2Au3HUJq2m1cdPQ/K6abXf
	mTC7w1gYQX9qUXbUC/u/hFWGzuBCD9WIUXK+vlllsqUXM2H95pIalwc8wFm/Cd5RZQBeZJFln9rqI
	jFDZSEQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4fqA-0002Fp-4U; Wed, 27 Jan 2021 08:06:14 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4fq4-0002Dt-UG
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 08:06:10 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 38378AD7F;
 Wed, 27 Jan 2021 08:06:07 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/2] Fixup return value for nvme_submit_sync_cmd()
Date: Wed, 27 Jan 2021 09:06:03 +0100
Message-Id: <20210127080605.146627-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_030609_155243_B38EB010 
X-CRM114-Status: GOOD (  15.39  )
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

Hi all,

here are two small patches for fixing up the return value of nvme_submit_sync_cmd().
As Keith correctly noted, nvme_submit_sync_cmd() should be returning
an error if the command could not be performed; however, currently
only pci does that.
So the first patch fixes up nvme_cancel_request() to return an -EINTR
on any pending sync commands during reset.
And the second patch adds a new flag 'NVME_REQ_TIMEOUT' to indicate
that a command had been aborted due to a timeout, and translates that
back into -ETIMEDOUT as a return code for nvme_submit_sync_cmd().

As usual, comments and reviews are welcome.

Hannes Reinecke (2):
  nvme: add NVME_REQ_CANCELLED flag in nvme_cancel_request()
  nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()

 drivers/nvme/host/core.c | 3 +++
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/rdma.c | 1 +
 drivers/nvme/host/tcp.c  | 1 +
 4 files changed, 6 insertions(+)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
