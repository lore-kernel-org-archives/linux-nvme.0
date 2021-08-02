Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038CDC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:28:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D8460F36
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 11:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9D8460F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=OEUZyopzvCNtUMNL93nFW8i5S1TyKVecp+qmOUwzOxk=; b=jN/HBDp7zl+YTa
	jvl3FTN1QFmRtiIoL9Q1I3ifncrUhYDYSG4LJbzaQ2sa+l915a4ZNcDEnyaBFkUlGF4UnY3c1mExI
	KVwUsvg3x9rVCztH3jL5jrr+yDrAngdT+pTQNUNZ2hgIalag3/b2zVaSeaEqxuJNK2GUp5FjFv80c
	ziPlCmquDD1VR6uo2eGOywIETr961kR7WbdcdYZr3E9cOCVdanIUlj5ltmSLvf0EYwQ2p1zjAQoTv
	/P+PrBsR9wXzAdma2VlsdizE/5thyv0nDO8GBUZPCQOuu9dEaHB21uBuN1/KfjnHWh1GJNShMaFeu
	RifsWNMe1HgW5s2loSnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAW7T-00FwAb-Fv; Mon, 02 Aug 2021 11:28:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAW6B-00FvfG-72
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 11:27:15 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0736621ECB;
 Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eKM/s+8/w/7+zQFn5663T93zumbiLABfhNEM2wOaeG0=;
 b=XzOWKsgaJ2lAGAgZPfWWw6PrIqHStAsIlt5dOz/gyX48Ud+PhTh+16WxUPT2w/2dnNUIjN
 /JWqGJr7Ujtc379EP7nHBZx/RwxkLPBdfWhuf01L/YXPqztwGmP4tIudX3tGzQa6GS+Ak0
 NI6FeCXgeePzQmMN03qYNmag4GyhhUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627903628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=eKM/s+8/w/7+zQFn5663T93zumbiLABfhNEM2wOaeG0=;
 b=wKd/pThvOGkrIFZZEOZujMF8HYB8MWi0NRvm+C+JvVbBvWa/v4D2yZA//IJL0A/KyiOIj1
 pB8cJLRk0sl406AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id E04C3A3B85;
 Mon,  2 Aug 2021 11:27:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id D0C6F518C0A4; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH RESEND v4 0/8] Handle update hardware queues and queue freeze
 more carefully
Date: Mon,  2 Aug 2021 13:26:50 +0200
Message-Id: <20210802112658.75875-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_042711_454809_F52C7C1F 
X-CRM114-Status: GOOD (  12.25  )
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

[forgot to add the linux-nvme mailing list]

Hi,

This update version makes sure the unfreeze call is done when
recreating the queues. I was able to reproduce hanging I/Os when we go
into error recovery mode for FC and TCP [1]. Unfortunatly, I don't
have access to a RDMA setup to verify but as the code is identically
to the TCP, RDMA looks to like to suffer from the same problem.

Thanks,
Daniel

[1] https://lore.kernel.org/linux-nvme/20210730094907.5vg7qebggttibogz@beryllium.lan/
    https://lore.kernel.org/linux-nvme/20210730113415.wezsrvxv5cu4yz4x@beryllium.lan/


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
 - added 'nvme-*: Unfreeze queues on reconnect'
 - added Hannes' reviewed tags
 

Daniel Wagner (5):
  nvme-fc: Update hardware queues before using them
  nvme-rdma: Update number of hardware queues before using them
  nvme-fc: Wait with a timeout for queue to freeze
  nvme-tcp: Unfreeze queues on reconnect
  nvme-rdma: Unfreeze queues on reconnect

Hannes Reinecke (1):
  nvme-tcp: Update number of hardware queues before using them

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c   | 28 +++++++++++++++++++---------
 drivers/nvme/host/rdma.c | 15 ++++++++-------
 drivers/nvme/host/tcp.c  | 18 +++++++++---------
 3 files changed, 36 insertions(+), 25 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
