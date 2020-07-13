Return-Path: <SRS0=Gozd=AY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94E1C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772B72068F
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2020 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HzLUTZiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772B72068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=geVsvfvzFwzaM+G/ME7xoFfWHNFo3oeyOn9TOmMhuug=; b=HzLUTZiLW71JfBfDl6esjrNnvY
	FOHm/43FLoDQ5rFgfA+ReZQsOmyA1rE5QfatfIIcc+w/ZJXK+uYahe/TPFWSQNy4Qnk/874+z7Z1g
	L7bmtdGpOgj6FVMBP9lO0fBG8iUB1oQZucmh5vGTp7zW7TmPq7dYpehrTXaC7T6tqM5VN6nB6KeCi
	SpKZSg6j7pEBPyyX6xZ28kzunVGFFxjGdY1KZUPh7aTqjvJTgHyt9ZOmnOzJyCY5pmxkCtrejtd7q
	pBf2OCHWR6lv4x4GpTYMwn5CQxydpbYw+1K2uz+pDpMXFPoXdPnf+CN0UdLx+I0FqkNathx1rxu5Q
	YNXOnyHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1juuDX-0002BU-Tj; Mon, 13 Jul 2020 08:53:43 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1juuDT-0002AP-Nh
 for linux-nvme@lists.infradead.org; Mon, 13 Jul 2020 08:53:40 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com) with SMTP; 13 Jul 2020 11:53:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06D8rUVu026435;
 Mon, 13 Jul 2020 11:53:30 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: sagi@grimberg.me, hch@infradead.org, kbusch@kernel.org,
 yaminf@mellanox.com, linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] NVMe/RDMA CQ pool patches for 5.9
Date: Mon, 13 Jul 2020 11:53:28 +0300
Message-Id: <20200713085330.133842-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_045340_095293_26BFCD58 
X-CRM114-Status: UNSURE (   4.75  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com, jgg@mellanox.com,
 oren@mellanox.com, idanb@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This series include 2 patches from Yamin that were removed from the
merge window of 5.8 since it caused conflicts between RDMA and Block
trees. It uses a shared CQ API that was merged to RDMA core layer to
improve performance and reduce resource allocation.

Yamin Friedman (2):
  nvme-rdma: use new shared CQ mechanism
  nvmet-rdma: use new shared CQ mechanism

 drivers/nvme/host/rdma.c   | 77 ++++++++++++++++++++++++++++++----------------
 drivers/nvme/target/rdma.c | 14 ++++-----
 2 files changed, 58 insertions(+), 33 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
