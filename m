Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283FBC432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D762760FDA
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 12:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D762760FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+RbvcK9IriSH5KQK8MCFgnSAE0sYlGJqQR6l6V+V6QI=; b=jimvhsElFPKaQo
	qhUf0sqTE2zIPNoLbd8+gYGiF7Y+y7IDjvA0fhz48ZxosTHAB4wFaaKo4Dl9rkbur9g2uRL2q+Cyb
	rA/kJTWpV++yzk65OaV38/Dxd67g1wN8X7kvSQtDShGWFHw9qPUhdQaFZjQsxD6gScmfkdFG2de5O
	Omrt/mtS3D4r0p4KCaURXKqg8MDE0JjX6WsmtP4pztwceqtO28vBVo6bzw4g9mhH2ffApPvNSW+/G
	3fqKAKTPP9S4DDuh+LxX1a9bwRJZt8z4QOMV8SFnexoPX/jvAzdPcRSEY3KI4+t1TxdtZJSItPjjw
	JisFGq5AN3xbAkBlqgZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJag1-00COK4-Ot; Fri, 27 Aug 2021 12:09:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJafv-00COHy-I7
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 12:09:39 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 7DE9720213;
 Fri, 27 Aug 2021 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630066173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Uw+43EQLf9Ctdpj+1V7kRh9jIblpsB5i2PLeneQ1WhE=;
 b=IV1w76b4Qhjn7IG0hxlysheG4JASW/nAsBWcAfXNwMUWV30C85kSkFzatZVu8iuG2Ydu6b
 Z97FUsBV3Ve2XK8V0z2h8pEi7RI8WtgIOH+RexICHMnsJZQqtj4ZzI8EEMIPcsrK3SXGJn
 nrgRgSfRA++Us/KiXTD4icITLMmj/TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630066173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Uw+43EQLf9Ctdpj+1V7kRh9jIblpsB5i2PLeneQ1WhE=;
 b=SJmKVy/s2f8BXYcHPqOUPWAdI5UW7SQp5n7byKi0ZbYGhhZlhHVvyd4AXupwhDpyQm0YeB
 bgo3eO5pRic0IRDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4AF3CA3BA4;
 Fri, 27 Aug 2021 12:09:32 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 74182518DB41; Fri, 27 Aug 2021 14:09:32 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] nvme: support unique discovery controller
Date: Fri, 27 Aug 2021 14:09:20 +0200
Message-Id: <20210827120926.104398-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210827_050935_872776_0962D6F5 
X-CRM114-Status: GOOD (  11.16  )
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

with TPAR8013 a discovery controller can support a unique subsystem
NQN. This patchset adds support unique discovery subsystem NQNs for
both target and host.
For host support a new connect option 'discovery' is added, as we
can't infer from the NQN whether it should be a discovery connection
or not.

As usual, comments and reviews are welcome.

Hannes Reinecke (6):
  nvmet: make discovery NQN configurable
  nvme: add CNTRLTYPE definitions for 'identify controller'
  nvmet: set 'CNTRLTYPE' in the identify controller data
  nvme: expose subsystem type in sysfs attribute 'subtype'
  nvme: Add connect option 'discovery'
  nvme: display correct subsystem NQN

 drivers/nvme/host/core.c          | 36 +++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c       |  6 ++++-
 drivers/nvme/host/fabrics.h       |  6 +++++
 drivers/nvme/host/fc.c            |  2 +-
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/rdma.c          |  2 +-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  3 ++-
 drivers/nvme/target/discovery.c   |  2 ++
 drivers/nvme/target/fabrics-cmd.c |  3 ++-
 include/linux/nvme.h              | 10 +++++++-
 13 files changed, 110 insertions(+), 8 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
