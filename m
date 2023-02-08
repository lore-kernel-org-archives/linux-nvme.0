Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8539AC636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V3/w2XQBVqtYKeNnLGIYjCp6YEf+Q4EfoyyYphfnIek=; b=DK2U2AGIrHoBxE75La/wc5SrGj
	70HOoWnU3NNOca0viD417RdhKbaWKyX3z40glPvQ5R4aNvrRIIx5RnbxtoPcEFBlLH5VTX9NM2lLD
	jsQDtKr/OYTwy2PyS+HfI4lUo4LpxWoj5TiXg19JkMOP1vk7VGEJzBzHzUs0p82ssOWMh0wPFc8BV
	G5ETcnv3nmkexS8059arr/gPnmSsJBnw8HY7xwW80X7okXGYn/nmponucRicXbMoVm0uHoosG69yM
	oz3fpMJJGeJqvCMEwv1fxdQK1cfCwDb3jlb+bDzHY4S8O5ZRf/lo0AgeNNqVmB1O386iiyjak2S8q
	bOE37teg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCT-00G39E-9d; Wed, 08 Feb 2023 15:17:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCM-00G36Y-8M
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:17:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C7EAA1FED5;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675869444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V3/w2XQBVqtYKeNnLGIYjCp6YEf+Q4EfoyyYphfnIek=;
	b=rJapk83+nCuEjN2Nn5srgd0+r9Onp3NmcDvgBOHs/ud0TvWqWsh+AJSrTkcrMzyz14r2vB
	6w7TwbLt9wW8o0cGSsyblBv9APwG9Hu2TUZEfvZDFMOgMvsX5r/WEnIQOAA6ZAh/Aqv0g+
	NuaRjM3S+qZ+ABjv1pnIW3vLcM22CCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675869444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=V3/w2XQBVqtYKeNnLGIYjCp6YEf+Q4EfoyyYphfnIek=;
	b=vSmWk87YC8oFXSdgO81K5E2FtYCUiop0x+mpU8n9PhhpAm28ibEDxbMN93FNzAxNHMNLmU
	lZpBiqXYgVhwZlAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B26082C143;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9C66051BD097; Wed,  8 Feb 2023 16:17:24 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] nvme: rework __nvme_submit_sync_cmd()
Date: Wed,  8 Feb 2023 16:17:17 +0100
Message-Id: <20230208151720.109130-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_071726_493602_422EC3CC 
X-CRM114-Status: GOOD (  11.54  )
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

as Jens and hch complained about the argument list to __nvme_submit_sync_cmd()
getting too long, here's now a patchset to clean things up.
The first patch is to split off __nvme_alloc_rq() from __nvme_submit_sync_cmd(),
which serves to reduce the number of arguments; it's also a nice cleanup as this
function can be utilized to replace some open-coded versions.
The second patch is to introduce a 'retry' argument to __nvme_alloc_rq(), to
indicate whether retries for this command should be allowd.
And the third is another cleanup; the 'at_head' argument to __nvme_submit_sync_cmd()
really should be a boolean, as it can take only two values, and it's being
converted into a boolean within __nvme_submit_sync_cmd() anyway.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme: split __nvme_submit_sync_cmd()
  nvme: retry authentication commands if DNR status bit is not set
  nvme: make 'at_head' parameter for __nvme_submit_sync_cmd() boolean

 drivers/nvme/host/auth.c       | 11 +++++--
 drivers/nvme/host/core.c       | 60 ++++++++++++++++++++++------------
 drivers/nvme/host/fabrics.c    | 38 +++++++++++++++------
 drivers/nvme/host/nvme.h       |  8 ++---
 drivers/nvme/host/pci.c        |  8 ++---
 drivers/nvme/target/passthru.c |  3 +-
 6 files changed, 83 insertions(+), 45 deletions(-)

-- 
2.35.3


