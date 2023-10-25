Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10BDC0032E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 08:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w0xhN1d+4v14O84zFjPJAAkuoA6O2arWH3H0oMmvYcA=; b=g/MSLyBPmTpMgb6ymQNCV0zho8
	7Mt+yutj3tog1oHF3Xo9qACrZLwlZjQ8XPfykxndfHW4iqoj5J4pdqggOnp/h3E+UFJsVZ71gidci
	IyOBsJ6Km4XcaZNVZ45ICWP2KysP3YoMNOvuX8YTKuPfzeJAPWBundMhik1JFeurLxpX9hyHF3AtV
	G8WAEf4kvTQq5TM/59Dz7G4Fgg9Z/7gLzgUfAwI6zfSRSyGN/DjBGR9IS1D/SRlkx3KahGrZk9owY
	1+3wZZVhL5+3vcjmsl04xFmRCgJqe12dvmwrcta18ZY1KRyRtN+pExVhlTUz3d5W0xFkf6NSlCpgg
	dkMd+8MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0k-00BfnB-2B;
	Wed, 25 Oct 2023 08:13:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0i-00Bflk-0K
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 08:13:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0475A1FF31;
	Wed, 25 Oct 2023 08:13:00 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B82B12D31B;
	Wed, 25 Oct 2023 08:12:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D7AB651EC47C; Wed, 25 Oct 2023 10:12:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] [v3]: nvme: fixup module compilation
Date: Wed, 25 Oct 2023 10:12:51 +0200
Message-Id: <20231025081253.113738-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.47 / 50.00];
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
	 BAYES_HAM(-0.02)[53.05%]
X-Rspamd-Queue-Id: 0475A1FF31
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_011304_298330_F3F7AAAD 
X-CRM114-Status: UNSURE (   7.71  )
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
'proper' module by adding module_init()/module_exit() functions.

Arnd Bergmann (1):
  nvme: common: make keyring and auth separate modules
  nvme: keyring: fix conditional compilation

 drivers/nvme/Makefile         |  2 +-
 drivers/nvme/common/Kconfig   |  7 ++-----
 drivers/nvme/common/Makefile  |  7 ++++---
 drivers/nvme/common/keyring.c | 11 +++++++----
 drivers/nvme/host/Kconfig     |  2 --
 drivers/nvme/host/core.c      |  9 +--------
 drivers/nvme/target/Kconfig   |  2 --
 include/linux/nvme-keyring.h  | 10 +---------
 8 files changed, 16 insertions(+), 34 deletions(-)

-- 
2.35.3


