Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC0FC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DB361993
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DB361993
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fFlJgi7/aQEP6llipSeB3TGVUAkxqWVuackKteEbEm0=; b=DGJyeu9nbpYxTn
	NwuZ408evcMJwG7ffMz0yt4jWcbWU0rZKEy3oO+Ue3MPn3OZl/zmpHjwASmnjpXVJ0mvqwxPqMzeB
	7pMOjt94EnKFD7mrrXRkFnh0SLlmCEx99QeV3H86Y6jZqjQH8WZFsNvgG5X6zH0feMIvAHMImorWP
	04Cs+q22IRPl2C/wC9I1LDPJ1lqc3MMMGPhovrJ586EqxhFMX94gMNBYPKFlc+SrGntgTAvqbrV3+
	E1utL5zJCZbXE4osDVsapqVC4yZC1RFSfYPo4rLKELTQ3zcvkkIrJhLfNuvJP60a+lhOxjbycG9qU
	SNUPzSc78lnHZKlRmCxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1QKf-00GQyd-7b; Thu, 08 Jul 2021 09:28:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1QKJ-00GQp4-Ik
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 09:28:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6EF6320198;
 Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+8D8Ux8ubyfH6HW48VcTiWCCSH0ipd0TmwlTxseTRGE=;
 b=HMJ6DMoT9fosQqtiCD9Y+Cvnie1kO4BWC61y0mIu5QPmqKN51RJp/7VX/ivbt5sLuZ9vh8
 nU71kWoie0AYcAz4ENi9PdAgrhmekIelz3UBDK4HVSOQVjeq4kgi40RAI3YfjmQ8gpen42
 OFsBq7WShfuUBO0wkQzB/GELfsbyFVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625736488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+8D8Ux8ubyfH6HW48VcTiWCCSH0ipd0TmwlTxseTRGE=;
 b=EDo6+Q9j7X5XUhjj1f2uD2fMiWpAUWQdnynm98ngyUT1uiLVWER5/7kjyt0bKxA09Z5GEH
 1p9oFfSYgaYN86DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 63B9AA3B84;
 Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 54140517114A; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 0/5] Handle update hardware queues and queue freeze more
 carefully
Date: Thu,  8 Jul 2021 11:27:50 +0200
Message-Id: <20210708092755.15660-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_022811_790297_9B3954C2 
X-CRM114-Status: GOOD (  14.44  )
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

Hi,

I've tested this on top of Ming's patches 'blk-mq: fix
blk_mq_alloc_request_hctx'[1] which fixes all problems (including the
hanger in nvme_wait_freeze()).

Thanks,
Danie

[1] https://lore.kernel.org/linux-nvme/20210629074951.1981284-1-ming.lei@redhat.com/

v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout


Initial cover letter:

this is a followup on the crash I reported in

  https://lore.kernel.org/linux-block/20210608183339.70609-1-dwagner@suse.de/

By moving the hardware check up the crash was gone. Unfortuntatly, I
don't understand why this fixes the crash. The per-cpu access is
crashing but I can't see why the blk_mq_update_nr_hw_queues() is
fixing this problem.

Even though I can't explain why it fixes it, I think it makes sense to
update the hardware queue mapping bevore we recreate the IO
queues. Thus I avoided in the commit message to say it fixes
something.

Also during testing I observed the we hang indivinetly in
blk_mq_freeze_queue_wait(). Again I can't explain why we get stuck
there but given a common pattern for the nvme_wait_freeze() is to use
it with a timeout I think the timeout should be used too :)

Anyway, someone with more undertanding of the stack can explain the
problems.


Daniel Wagner (4):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze
  nvme-fc: Freeze queues before destroying them

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

 drivers/nvme/host/fc.c   | 26 +++++++++++++++++---------
 drivers/nvme/host/rdma.c | 13 ++++++-------
 drivers/nvme/host/tcp.c  | 14 ++++++--------
 3 files changed, 29 insertions(+), 24 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
