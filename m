Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3814EC47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:44:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA419610A8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA419610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MWZgD+7PvHD68jvvFN8fT9lVNd6Fr9LQx1yjxRexwPY=; b=V6XASJq94KGML6
	CDdpDh2RpjVXkIn4i8PwMoZZ+nVTgWRPIct3W51RPHn4hwudwF+Ln3IVy1ttGfLSxn34fTiUq+bEb
	NZwkqy4WkwdAL5BqX1FXyVQnB7lknLUwvd3BWOh+78fcRQyswnffidLVYSS3hzi5fR0ELL24Df1MN
	Y+blrsyJfs53R7YeNQaMbJM9YiifGu8FNYuVrOc8f4VicAL1h6+Ur1AlipiKOGCapYoVcHh8Tot2d
	hXlq6NFPv5uP3Z3C2hzlKCmoAKT6yLuu1rfaCMeAMi6RHk24R8ij+MgWeoCNr2vZbae5eftoi9wHy
	UNauWWrw6vOgMazHTzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llwe8-00Fq4j-S6; Wed, 26 May 2021 16:44:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llvNb-00FKSx-Re
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 15:23:33 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622042608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8hR1n8aL1c/k5shGJ+c9IQxkErXHtxmPTXlfWd2yhp8=;
 b=dEn+a4TGDZKeCH5TG0Ndr/k01xJlqMJtZ6mI3nhcsxdKEovdxzuaPeVTbAvQ3PuG1i1gTt
 Wf72hBQv3AUzEJseoJb7lwFibQzhP2J0lyoUVPLIl0oGDjXrgOzQMTiGiUe13xHKNxFMzP
 pzj/gjvNtxVJJLJf9T9nbZ1GW8anQcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622042608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8hR1n8aL1c/k5shGJ+c9IQxkErXHtxmPTXlfWd2yhp8=;
 b=O9tS11k60PjqAsgslrGzBPidwlmXFiPD1nJFcNMl44W7G9DRmJwWli1YY7Wq1jBLJPrJff
 13K2zkThUOB6YYAQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3192EB28B;
 Wed, 26 May 2021 15:23:28 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/4] nvme-loop: fixes for concurrent reset and delete
Date: Wed, 26 May 2021 17:23:14 +0200
Message-Id: <20210526152318.107202-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_082332_092984_A3FB0AF1 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
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

Hi all,

during concurrent reset and delete a crash might happen as we're not
resetting all fields in the loop driver upon reset.

As usual, comments and reviews are welcome.

Hannes Reinecke (4):
  nvme/loop: reset queue count to 1 in nvme_loop_destroy_io_queues()
  nvme/loop: clear NVME_LOOP_Q_LIVE when
    nvme_loop_configure_admin_queue() fails
  nvme/loop: check for NVME_LOOP_Q_LIVE in
    nvme_loop_destroy_admin_queue()
  nvme/loop: Do not warn for deleted controllers during reset

 drivers/nvme/target/loop.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
