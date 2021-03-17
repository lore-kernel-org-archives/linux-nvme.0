Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F0C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:50:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9057664E90
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 20:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9057664E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nZZmoNQkqxul3k6julKAjP3lfyw2l/WqyNT5C0/J/Wk=; b=MQ9c2zQgcBCFczLp3owXeL6+6l
	K4w4ODQEwV7DwfC7pQcgNYzMrbr4HRhxaZZ5odZkQL4yg0v1NY0X/WGPcUbJYrRW8pu8yoEpz258+
	1vcKj23zK86kmqRRxGB8pSBXsh7pD6gKmLp1yh1mn2M0cfq7y2cGK3qpf5reuOZ16uy4k9KMjH5Sc
	XYK7g1H0cmeJVsiudRK9LQ1lmwNMItb7FtmZ8MeipbAKuTL1QoZ0dli85IVDQNPa0DBxzeamaFhWE
	qlLYAXJcrBA6Cc3TT4EDxBVSSV5p8oV1s1baQV5F+KDk2795R6oBBXPukSsHuUQIgT8WwzJ3qLEdt
	Sa9DOBYQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMd6I-003smO-B4; Wed, 17 Mar 2021 20:49:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMcuh-003sFg-Pr
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 20:37:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB79464F30;
 Wed, 17 Mar 2021 20:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616013426;
 bh=qMg01JgFQNYZtJK3Iul98MAMjV7RIn4JaX2Hq+psLtY=;
 h=From:To:Cc:Subject:Date:From;
 b=T7J7n6S0R/s+yyCyvAf/w0sGocZ4FmflIvbWU17pxaAm05Y1EI2BRqV9gAs1OaJoR
 qhfEEdgP7c3j5jcZDJPWEUWVnGGjwEMarcpVvn/ooapoQDtA+wD2NXrW+kNtxg81js
 e7qsZcVw3AnhHE/0bqdOCDv3a869QPoHEssdDWXchf2AOy+/rBJhfKIQwFPbKL3UJ3
 LccyKH7qvL1auGgNBwmFgk3MYI9g9Ij1Rd4QOM2DZb+h2CbHCX5U0LDvdEVwg5gBJF
 3/UG6dnQkAu/t84JEic1SyjSBgZOYjCo6DByXSCd3UUW3ZVWMdzYru8kMjFzVSbrPa
 itrBgj+Sr1U4g==
From: Keith Busch <kbusch@kernel.org>
To: joshi.k@samsung.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] nvme driver pdu enhancements for passthrough
Date: Wed, 17 Mar 2021 13:37:01 -0700
Message-Id: <20210317203703.17391-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_203718_417154_B6C04740 
X-CRM114-Status: UNSURE (   6.27  )
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

v1->v2:

  Improved change logs, added reviews.

  Retain clearing SGL in passthrough commands (hch)

  Added a comment explaining why REQ_OP_DRV_IN/OUT is a no-op for
  nvme_setup_cmd()

Keith Busch (2):
  nvme-pci: allocate nvme_command within driver pdu
  nvme: use driver pdu command for passthrough

 drivers/nvme/host/core.c   | 23 ++++++++++-------------
 drivers/nvme/host/fc.c     |  5 ++---
 drivers/nvme/host/nvme.h   |  3 +--
 drivers/nvme/host/pci.c    | 12 +++++++-----
 drivers/nvme/host/rdma.c   |  5 +++--
 drivers/nvme/host/tcp.c    |  5 ++++-
 drivers/nvme/target/loop.c |  4 +++-
 7 files changed, 30 insertions(+), 27 deletions(-)

-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
