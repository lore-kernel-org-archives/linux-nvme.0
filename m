Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F529C25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ab3vHA0Y5z6MlXp50K3+NEPb/ITU2nFiIYKsWuBvPYs=; b=a0AwGUfLpHKE7NWBKnhF4/yxoe
	aCIepckmV/jEKMzXJhcIxdFMklXaaSm5skLHOMsofyWfeiSaqTQUAC3OioaWN7s+b7cs0BF/sQzWI
	1Pei9hKLtn4mUOB+G8lH0/6ZquoBD3X2Efo6E78kHwWF6h4xu+Z7IR1ShEGX6iSfyrb2UD9k8hCbL
	Azy+jEggcmBceRL7Qf3fqmG7VFcmCCBP4ZcNgGKCIFyziq36tMwWY47sw7pxfdfImDu/6mxTQcgHi
	DJM2X84fBX5Z342t3eOx32RXNpoTRa/2TJrtrKzuV7aQuUFIjkTq83d9SOWRFxVsz0+Qb5A5DKCmw
	ceJg6SoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw06B-00EWKL-2g;
	Thu, 26 Oct 2023 13:08:31 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw067-00EWIj-00
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:08:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 974C021B49;
	Thu, 26 Oct 2023 13:08:21 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 7E27B2D5BB;
	Thu, 26 Oct 2023 13:08:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D584151EC53A; Thu, 26 Oct 2023 15:08:19 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] [v4] nvme: fixup module compilation
Date: Thu, 26 Oct 2023 15:08:02 +0200
Message-Id: <20231026130804.142586-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.45 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-0.04)[58.06%]
X-Rspamd-Queue-Id: 974C021B49
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_060827_211148_A0C677FF 
X-CRM114-Status: UNSURE (   8.58  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

Arnd noticed that the module selection between keyring and
host/target code fails under certain combinations.
This patchset addresses this by making 'keyring' into a
'proper' module by adding module_init()/module_exit() functions
and ensure that the module will always be compiled in when
one of the dependent modules are selected.

Arnd Bergmann (1):
  nvme: common: make keyring and auth separate modules

Hannes Reinecke (1):
  nvme: keyring: fix conditional compilation

 drivers/nvme/Makefile         |  2 +-
 drivers/nvme/common/Kconfig   |  5 +----
 drivers/nvme/common/Makefile  |  7 ++++---
 drivers/nvme/common/keyring.c | 11 +++++++----
 drivers/nvme/host/Kconfig     |  4 +---
 drivers/nvme/host/core.c      |  9 +--------
 drivers/nvme/target/Kconfig   |  4 +---
 include/linux/nvme-keyring.h  |  8 --------
 8 files changed, 16 insertions(+), 34 deletions(-)

-- 
2.35.3


