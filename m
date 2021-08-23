Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DDAC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 11:25:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C70613A6
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 11:25:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89C70613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0rnatp18lxeoHCsLdbF0A+hl9CvBEV1FEbeJg4RmHf0=; b=kYD9V8cFEjp1b4
	x2Iy1wI05vaK8mCA8cKjYc8w6KPhyBSYg94VtKOAp2/x7QEAOfH11+NGGdFm/sbKfsrDt8wp0BRG3
	z6paLlZle+Ud36Q4tx64ehLR8lUTarN7lZOe+LSIwZgdz8P9GvatzMQzCdXuO6baPAuZ6AgyTp2kC
	G3L/tcRLPVdEujBIBinbekbVGkkk/ZLe4//NzC4dANg8rimKd+0AMpG2dWkEJHi/kAUG+CSt6pFka
	RwaFhK0YE1qtxn/80K24Wi7+kuxVeA2Gn31sLz9O8cFkrF3q1APNKYWT/1WH+VEidt0eTNPSZMV+n
	Xt07Jv675DY1Ecm6Z/mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI84O-00GZAF-3Y; Mon, 23 Aug 2021 11:24:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI83Z-00GYod-6q
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 11:24:02 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id EE62D1FFAD;
 Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629717832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RA4HTkvFglG0/CjS1mPXjBNeKgRNmXs+Fgd4zJqlWOY=;
 b=tZsekKYxNsz1gmeaRFut4Yf7gU5dL2iwHK112uE7+EnjDDEgtbgq20z07l4Gdpwt7oOGxT
 GQzAuOpLlqsannzW3QEDzOL2fjWoGfpydugYU347DWAMxoJvEI4NEq9Avan2O+hkDgUYhM
 SgXnh1bK3Ng8xTiY0tJK6aS2pWX1Ywc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629717832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=RA4HTkvFglG0/CjS1mPXjBNeKgRNmXs+Fgd4zJqlWOY=;
 b=UQNBtlDCCBMGHvDx97dwJ/vtfdFiAVVkfqqEbcQ3G3G+Ienj2HTqOegYiBjYi/mpnxUvUL
 M6ZtkMsqrD0F+wBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2AF4FA3BB8;
 Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 18E83518D889; Mon, 23 Aug 2021 13:23:52 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 0/3] Handle update hardware queues and queue freeze more
 carefully
Date: Mon, 23 Aug 2021 13:23:48 +0200
Message-Id: <20210823112351.82899-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_042357_508025_6B21CF20 
X-CRM114-Status: UNSURE (   9.23  )
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

Hi,

After our last discussion in v5, the nvme_freeze_start() is gone
(James provided a new patch). I also updated the commit message of the
first patch which adds the imported bit why we need to update the
number queues first.

Anyway, I think we figured out the details in this path and I am quiet
confident that we nailed it now (yeah, famous last words).

Daniel

v1:
 - https://lore.kernel.org/linux-nvme/20210625101649.49296-1-dwagner@suse.de/
v2:
 - https://lore.kernel.org/linux-nvme/20210708092755.15660-1-dwagner@suse.de/
 - reviewed tags collected
 - added 'update hardware queues' for all transport
 - added fix for fc hanger in nvme_wait_freeze_timeout
v3:
 - https://lore.kernel.org/linux-nvme/20210720124353.127959-1-dwagner@suse.de/
 - dropped 'nvme-fc: Freeze queues before destroying them'
 - added James' two patches
v4:
 - https://lore.kernel.org/linux-nvme/20210802112658.75875-1-dwagner@suse.de/
 - added 'nvme-*: Unfreeze queues on reconnect'
 - added Hannes' reviewed tags
v5:
 - https://lore.kernel.org/linux-nvme/20210818120530.130501-1-dwagner@suse.de/
 - dropped non nvme-fc patches
 - updated 'nvme-fc: fix controller reset hang during traffic'
v6:
 - updated commit message 'nvme-fc: Update hardware queues before using them'
 - dropped 'nvme-fc: fix controller reset hang during traffic'
 - added 'nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues'

Daniel Wagner (1):
  nvme-fc: Update hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues

 drivers/nvme/host/fc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
