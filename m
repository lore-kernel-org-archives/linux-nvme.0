Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDF6C07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:45:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1608061009
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 12:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1608061009
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=fn/4kbjsrEqLR9Vz+TU9kHL+gQFwVRxfEA8KEr0E03k=; b=HDQieBP3e/+9K1
	54QW6n9OVxtg51y+vdBzFbcMIHQdJeX5kIFyA34c05bR5qsJrEa8vH7eyQ7A49BVnntGeKI3XnLmy
	DtPS7rgsQ9NnFbv+FeWLqHHc0f/7xeTxZZnhxflryhe3dY/gMszt1kvFsoVs+m6jdmP9LkgNG+CC9
	kqEsAdvwJG9R2Vz7o5yQVxOD1YKrJF/bHdZfOr00BAZxlUhbB0wz2Y1MbEFkaCRR/p6CykM8BYpBv
	3jbrYKFhdYyqpvp2+EEhhB8UEgO0FRwesZXaariVS7wd+zVS11NKm5hrwPl6B6GptpehrffQuAYmi
	QCe92wbT9zwYb2RZPq8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5p7k-00CohC-DD; Tue, 20 Jul 2021 12:45:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5p6Q-00CoHb-25
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 12:44:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD3BC202DB;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626785038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pyoIzDS0Og6G7hqh3R55JAHhxOyRBm5TYSAA13eeovs=;
 b=vPSfm7GnLAOMZk+HyFANz4xD5SmaHkpKb/seGitaJtIeWIpLRmvuSCUcZqqetMnMkzb/xo
 LsiL444a8UFKufBwa9umYg5I++SCdkG7Bjwu8hhkWMesxF/ZySVGqeHRL/g82R1z9DBkeI
 Q7HhJ+bxS7FRutyqk18hhQvBj5VAS50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626785038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pyoIzDS0Og6G7hqh3R55JAHhxOyRBm5TYSAA13eeovs=;
 b=8nm9X6PB4AmOW2AQglGomcL7X1yl+xfu19pn/N00x/YIFJAqY+amI986HFHH4gAcQfxt9w
 SEsW24UGDT4qRuCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 0E078A3BA8;
 Tue, 20 Jul 2021 12:43:58 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id EB0FD5171926; Tue, 20 Jul 2021 14:43:57 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 0/6] Handle update hardware queues and queue freeze more
 carefully
Date: Tue, 20 Jul 2021 14:43:47 +0200
Message-Id: <20210720124353.127959-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_054402_360838_C6A2D184 
X-CRM114-Status: GOOD (  14.87  )
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

I've replaced my 'nvme_start_freeze' patch with the two patches from
James and gave it another test run on top of Ming's 'v2 fix
blk_mq_alloc_request_hctx' series. All looks good.

Thanks,
Daniel


v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout
v3:
 - dropped 'nvme-fc: Freeze queues before destroying them'
 - added James' two patches


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

Daniel Wagner (3):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/rdma.c | 13 ++++++-------
 drivers/nvme/host/tcp.c  | 14 ++++++--------
 3 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
