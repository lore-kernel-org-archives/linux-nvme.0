Return-Path: <SRS0=COHi=LT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BBCC2B9F4
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 10:44:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CB5D6128A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jun 2021 10:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB5D6128A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=th5iIYekMmKfH44Y3UUI08UPaAmL6RAC9x7Ygom73RE=; b=SaWC4u7lPCSpcz
	xA6ROigQTQlyr4rOPA+Lntlki1n9n7QUu9E06w3oVReRpXDlUlOk121e1EY4nrqPBE6SNICGtkBdp
	rMvxgSyO9VOtY6pMgDlwYzt58CtnSWiC0LRR70rblxz5nEgwrfcPod386OF0JCjWcnnalRZKi4OKh
	KR6+OyCmQX6lpjeNnB5J+MAXOJJpxDPw7b4NpgAcuYggcJ3rZ2s7SqQumIJUvlL/0Yp/jTmYIlh52
	nS8QpFiqx1N2PFt4BXWqtrkkNROJ6fCNRVIY7dUjAPqiq4hzgwCJmol/MD/fjV/6CWMjcb8ghw8lV
	mvHrTVcCDqBAXoAt3E6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwjJp-0015Fw-HC; Fri, 25 Jun 2021 10:44:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwitR-000tvO-SE
 for linux-nvme@lists.infradead.org; Fri, 25 Jun 2021 10:17:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6E8F51FE7B;
 Fri, 25 Jun 2021 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624616218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dfo/oMFhioRwNqYhFs8xw+OHX0Au8i83hWIWvQKrzA8=;
 b=Fp35AvFdFTLqdyWdfxu4IfEbP7+LYZ43dHp49PGhPfr8YvXoQPs6UbA0gmWpJNjjZuE7cn
 hopY7wse8Jy303pIKR7qPwDOiHS9bBKW+cuM9N2Ih4Pzxda8CujcqgOAz80sUDeTUPbjKm
 QhPPE/VAVWfTgOcPUk8776ZaTDJ5+3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624616218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Dfo/oMFhioRwNqYhFs8xw+OHX0Au8i83hWIWvQKrzA8=;
 b=NsZFF+P6sxEcIq5+9jClWXR6PH5Kve3okMiy1jZrXw/CRYuBvCP2hX9aDt1M5uoIUB9GG/
 PmAE2bWOII5FRMDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 94354A3BEE;
 Fri, 25 Jun 2021 10:16:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 81C5E51709BB; Fri, 25 Jun 2021 12:16:57 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/2] Handle update hardware queues and queue freeze more
 carefully
Date: Fri, 25 Jun 2021 12:16:47 +0200
Message-Id: <20210625101649.49296-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210625_031702_125356_9F3DC7CB 
X-CRM114-Status: GOOD (  12.59  )
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

Thanks,
Daniel


Daniel Wagner (2):
  nvme-fc: Update hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze

 drivers/nvme/host/fc.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
