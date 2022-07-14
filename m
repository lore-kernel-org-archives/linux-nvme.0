Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD16C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KPYEGvVBco2zXJYpVqDArzlur3aCSYe/SQvT8HrLlRc=; b=0yQ8T7R+OpYV4xl2uIegCaY+Jh
	XxWaaOBN4j8OT1IoDS31R+NHUFtTgR78gUxqq1C98VnqgQIGZp6lbrPyadM3ZB3O+8z8xcqKPVpvk
	GhBtP6NrI+4gpp4fH15Ucpj7qFsFqW2UNQNw/ZBmOFyyCeo4mxgpPP5ZylXzEA2gJPw3Y0CkFSzw+
	vThapfaRqOQIu0tIrsFhAu7GT9oK6HdPglAO6OECiXa2zBAOOB/Y4xiKVzHnAuFMoXEshPNyhlhFo
	pqL7zoswjZWCo7XJvkB93Zx9aV5dnWVcP3HAj8qHjOR2s8N3vCnAjV01mK7E4rM5XFrN7A/SOkc9b
	vwa1tujg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByDj-00EM8L-2k; Thu, 14 Jul 2022 12:45:31 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oByA1-00EJaU-MJ
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 12:41:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 5F8431F926;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657802499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KPYEGvVBco2zXJYpVqDArzlur3aCSYe/SQvT8HrLlRc=;
	b=CznWC6XMda9f5SgEeKO5j6F6LvZMmorrAGlwwgoyQ1Mudo5HixMEW9lTL8XqM9odRq9MIr
	FpOxRDeqnVa/IdfxMaX68+xPUryhd8GktnqXaRwjPu3GlDQY0PV3e2uVouu3UK4Y8vbvMp
	boDCFnnYQ/obZzTOZ9xf4URVgndtIqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657802499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KPYEGvVBco2zXJYpVqDArzlur3aCSYe/SQvT8HrLlRc=;
	b=qSepvOVw13FjH6xmQ8cN+/DAGeHdcLob0LeggdjUijIrUB153L4O9UVINwFQ2zdU09VXti
	hBOwvS46KnnNN1Dw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 516EB2C141;
	Thu, 14 Jul 2022 12:41:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 43ADE51988D0; Thu, 14 Jul 2022 14:41:39 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] nvme: short-circuit connection retries
Date: Thu, 14 Jul 2022 14:41:31 +0200
Message-Id: <20220714124133.68598-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_054141_925888_F828B02A 
X-CRM114-Status: UNSURE (   8.11  )
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

Hannes Reinecke (2):
  nvme-tcp: short-circuit connect retries
  nvme-rdma: short-circuit connect retries

 drivers/nvme/host/rdma.c | 25 ++++++++++++++++++-------
 drivers/nvme/host/tcp.c  | 25 ++++++++++++++++++-------
 2 files changed, 36 insertions(+), 14 deletions(-)

-- 
2.29.2


