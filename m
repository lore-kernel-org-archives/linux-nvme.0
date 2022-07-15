Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879DBC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 06:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zhg0yKwOzC0JI1wpJOfjN4KnE1XFzb0PWWmyxFVwflA=; b=bJv1GCmamW/bTovY6Yrv9fyJMU
	OC5NnQoMs5+Pp3pE/dknT6l9+rUMwUFmy8dbvgZ+YMW/LKVTsowTJ2D5B3rTh9+yFrkY+87yXd1c4
	pEpm1U/L5TMWmQ+x4ZqscJwkJtDz/0oOGIpkqBvZVFpgCSOLMmgjxacZX8TeXWmny7Ql7RwYRR6uj
	NarfW59brBBOat2XWxvXCs1Fw/DRN4uPFq5pxvQTIToECLLq3MrY2/FTiWemlXJETep39B6yUnroQ
	WdQi0qOhsjzHwat0DxepEwIdMNqK3lcuKJ1njytNqk4SyP1yjiG7AIdKqP8VS6XVFe2hCYpIDOmsN
	Xv0sO3PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEto-004dMx-3W; Fri, 15 Jul 2022 06:34:04 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCEtm-004dLN-4p
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 06:34:03 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6944F1F86C;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657866837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zhg0yKwOzC0JI1wpJOfjN4KnE1XFzb0PWWmyxFVwflA=;
	b=LKVSLRVkm3MxFZcNMDzW1PTKcex99u6HyuUTcUr//Eqbxz029kS8o0GzRH8l18eUECIVPq
	iqj0VDT0RLLRijcn6fsOstzFMDus4GWf4np1tlMAeq9yRaNNURaHF6HTSEtSGo+hLuo/aj
	HuLcsmYRMRfp3+vzkiQfJmve5sRo/9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657866837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zhg0yKwOzC0JI1wpJOfjN4KnE1XFzb0PWWmyxFVwflA=;
	b=28tNgU3D+Wdn9XOrSu4nFyXgjBuEn94InOt7JTFkQpDzXsxUTjNhZJp8ZMdg9gk6Q4lZCN
	3Gk8O9Ply+R9PUAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 6093D2C142;
	Fri, 15 Jul 2022 06:33:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4A27C51988ED; Fri, 15 Jul 2022 08:33:57 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/2] nvme: short-circuit connection retries
Date: Fri, 15 Jul 2022 08:33:54 +0200
Message-Id: <20220715063356.134124-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_233402_346622_D5CA99C3 
X-CRM114-Status: UNSURE (   8.79  )
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

here are two patches updating nvme-tcp and nvme-rdma transport
to modifications we've already have in nvme-fc with commit
f25f8ef70ce2 ("nvme-fc: short-circuit reconnect retries").
Gist is to short-circuit reconnection retries if we get a
status back with the DNR bit set, in which case we shouldn't
retry the connection attempt.

As usual, comments and reviews are welcome.

Changes to the original version:
- Rework with suggestions from Sagi

Hannes Reinecke (2):
  nvme-tcp: short-circuit connect retries
  nvme-rdma: short-circuit connect retries

 drivers/nvme/host/rdma.c | 20 +++++++++++++++++---
 drivers/nvme/host/tcp.c  | 21 ++++++++++++++++++---
 2 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.29.2


