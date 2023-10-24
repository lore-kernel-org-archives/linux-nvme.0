Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683F6C25B47
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 06:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O4hB87RGPurmzvZ1uahWKrz40WlaKalaUeVSJnJg9FQ=; b=zGTsWwESCIAEbatiwwATlF6C1u
	hd9WxBJgZnAO7RZV9isqfuBmPOShtBRl1Yze6YFqpDqbXaSjFza7abQJZGU/jdaNBtk49BUQHku/L
	sLCEBKMjDb8U0eMYT4PQdbumIkgBn8HfQUGYfLLrhI4n6vBWzW6VSCw4/qqctYcW+5Ff9Cn9AYnb8
	RWadUz7iVKtbNM5SlfdRl6Clc2ZZRQ1wz5Da5qjtntsucVl5JKERELksd+CnGhvUZZK5bzgIui087
	yG4RpLbe93qz+TGcc8nhJi4LCqDmbtjVwzIX5E50KlwN1k0LFl9sVaxBe7GelRCQWrgcnXFtW3IFT
	7ERhQyAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfk-008x78-1E;
	Tue, 24 Oct 2023 06:13:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvAfg-008x4b-2G
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 06:13:46 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id DFDD51FE5E;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 12CA52D105;
	Tue, 24 Oct 2023 06:13:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3ACD251EC3D5; Tue, 24 Oct 2023 08:13:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] nvme: start keep-alive after admin queue setup
Date: Tue, 24 Oct 2023 08:13:34 +0200
Message-Id: <20231024061337.35621-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
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
	 BAYES_HAM(-0.00)[43.29%]
X-Rspamd-Queue-Id: DFDD51FE5E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231023_231344_885151_8316BD38 
X-CRM114-Status: UNSURE (   8.69  )
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

Setting up I/O queues might take quite some time on larger and/or
busy setups, so KATO might expire on the admin queue before all
I/O queues can be setup.
This patchset fixes this issue by moving the call to start keep-alive
into the ->init_ctrl_finish() callback, and move the call to stop
keep-alives into nvme_cancel_admin_tagset().

As usual, comments and reviews are welcome.

Changes to the original version:
- Reworked to use nvme_cancel_admin_tagset()

Hannes Reinecke (3):
  nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()
  nvme-loop: always quiesce and cancel commands before destroying admin
    q
  nvme: start keep-alive after admin queue setup

 drivers/nvme/host/core.c   | 6 +++---
 drivers/nvme/host/fc.c     | 6 ++++++
 drivers/nvme/host/tcp.c    | 6 +-----
 drivers/nvme/target/loop.c | 4 ++++
 4 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.35.3


