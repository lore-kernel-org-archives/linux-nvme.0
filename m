Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681FDC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 365292072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ILERRV3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365292072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9VWWbevDUrEEM2tFl+UtK5xc+3nftf7C4ADWgJrm+Dw=; b=ILERRV3tb5tp8EsiR9gkVLWCAb
	/+eMwc8n5ZtVg73P3YiFqbqBL7YHsobwvwoBQZmPhIwAfw9iiBmxFgxJzKv6edvRm3a6chYbr0Ajv
	8T0T/8gGY8NeBOUl/ic4wmLGLwvt7bp0wXMooLOt5vnoZbTS3CByp/4e6aPl0PgsW2G5KVQ2GYVsr
	b3M+QKKCz1eni5CsXgUcnPsimGUGpe3/12kuL380AqI068zN5TjXYzX89tQW981lGpZWazJe+9v2E
	RHfmnQyH3/iXXRdRHLFNJxELSFnxZEA3q99QR753dsPhVxfX3wluJbWZA4Jiu63FJNl8J5sD0Zqko
	G4Ttc7vw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzEh-0006M5-Ux; Wed, 24 Jun 2020 06:50:19 +0000
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzEZ-0006Ha-RC
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:50:13 +0000
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01355;
 MF=baolin.wang@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0U0Zd2IB_1592981406; 
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com
 fp:SMTPD_---0U0Zd2IB_1592981406) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Jun 2020 14:50:06 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH v2 0/2] Some improvements for NVMe
Date: Wed, 24 Jun 2020 14:49:56 +0800
Message-Id: <cover.1592980985.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
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
Cc: baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
 baolin.wang@linux.alibaba.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

The fisrt patch adds Arbitration Burst support, and another one is
a small improvement. Please help to review. Thanks.

Changes from v1:
 - Add new parameter to decide if use the controller's recommended
 arbitration burst.
 - Add arbitration burst mask in case overflow.
 - Do not export the nvme_set_arbitration_burst().
 - Add reviewed tag from Sagi.
 - Drop patch 2 in v1 patch set.

Baolin Wang (2):
  nvme: Add Arbitration Burst support
  nvme: Use USEC_PER_SEC instead of magic numbers

 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  1 +
 3 files changed, 32 insertions(+), 1 deletion(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
