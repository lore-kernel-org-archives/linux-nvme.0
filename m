Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10002C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D702E60EBC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D702E60EBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=hoW0gGGtGnap47wV6JnckC1RaYuTI3MWLsG6+M8VNyc=; b=A3f8O7jzl/IL0E
	ufWB+gmX4ppJ/xWytDZ8U1RH675O97uyrqDQmpE+tTT6WdaA9iq6gSyphxvl4zcpytdPXAC4gjGBt
	74uqnO1tW17cIic0oyPSdi3Xc3HOC2GCD6ueZd1yd4SFSmRTtj+rlymnJKC/OwMvxrHzVHJUb+kk1
	PFfP2K+QzZHbn8garQZPlTAolVuu2mGVaM/CMzFchC29bZOBttvAjJIhke7o3KgJHJKT8yVGcoNXq
	VZbl31eQcVuEuB8E7/JU+/xh0TkzRqPFyEWAuNnmcHMrKLXaauPyNvYCPOlfynh8iuw3wlhjl1kI2
	qtrMA1F3VfssCqcz3BGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKKC-005QZe-1V; Wed, 18 Aug 2021 12:05:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKK6-005QXu-Ff
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:05:38 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3038F20071;
 Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zgdwr7t3mBJoUNt/iXm4y9kn1wTY4VfgPeXgvi1oBxY=;
 b=pd5ZkACQrIFnWuJSHc5GfrA0E/dWMuYQ6Ipt7okzRC6iUtBuEjpR/it5KIBPO5AUu8Jj/x
 YntyA+fy6hfo5RVUfNgYQ0Lpl3p6YEheJs9/Nvgz2skMhyvwT2+DIe9FX/vH4vPwMw4OHQ
 BO18ARVDiwgNdQcHx1FymGKW+qBWj8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629288333;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zgdwr7t3mBJoUNt/iXm4y9kn1wTY4VfgPeXgvi1oBxY=;
 b=3DOVF2Iyxy/Pl2qrxbO4G2k9JcUBrZcMyKMq0BilNXKYWqFDRAoaKsw7oUaSxkHQNDuRKg
 UpGHdIyYgF978XAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 554A5A3B98;
 Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 763EE518CF79; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 0/3] Handle update hardware queues and queue freeze more
 carefully
Date: Wed, 18 Aug 2021 14:05:27 +0200
Message-Id: <20210818120530.130501-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_050534_742167_640E1CE5 
X-CRM114-Status: UNSURE (   8.41  )
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

I've dropped all non FC patches as they were bogus. I've retested this
version with all combinations and all looks good now. Also I gave
nvme-tcp a spin and again all is good.

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
 - dropped non nvme-fc patches
 - updated 'nvme-fc: fix controller reset hang during traffic'

Daniel Wagner (1):
  nvme-fc: Wait with a timeout for queue to freeze

James Smart (2):
  nvme-fc: avoid race between time out and tear down
  nvme-fc: fix controller reset hang during traffic

 drivers/nvme/host/fc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
