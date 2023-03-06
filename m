Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF914C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/4qBMkdtIMbsy7GP/ACSAxKzI0IdchAiAhS8YkWbsUY=; b=t9a2YOa3sIImZ5+6HOGUNiR2nS
	pX8rnnJiQQLapXmutVXAtmVvIkjxSZ2DDjYabWAsdU7HPYED5zYej8NyawIqGc69G/nVAsBe9r2Y9
	fnm0j2x6T3m+h5Jl757xWPgKz/0+mwdCYME1chiZWPTgOhVATuA3dwIzAjujHL/soM/RSrLOKLaI/
	LSkh3vkfmvxNjvd0RqLqW11woCADy+KQUI8BKET0O9Rgu7vzgDdvIhzpU+4NzqEzT3HNKlcjKVbRN
	fOzMsiT+T7z1EPuWgS3xSx+UYC9gFu4WqeExWrglUza0vJp/DEG4DB+7reFNK7B65fR0XTKqlNwU3
	VRJEjofQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DD-00C65F-Al; Mon, 06 Mar 2023 09:32:55 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7D7-00C628-UH
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B098E1FDDF;
	Mon,  6 Mar 2023 09:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4qBMkdtIMbsy7GP/ACSAxKzI0IdchAiAhS8YkWbsUY=;
	b=jTj7/ZkfIOSRgz5r28v6KRijEJY5Rqj4AFKTn3KXHQC/8D0ZYqrnD3TbXxlydkHBsbGaxa
	rJZe+AQx/l/PR6F/v5E1uN4mg1ac4eSkVHssJlvGtPxjnKQTL0/kpXPJCGll4Q+G03mm9x
	pby5+u0q4skOvct1UebvFY+HuQFZOjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=/4qBMkdtIMbsy7GP/ACSAxKzI0IdchAiAhS8YkWbsUY=;
	b=Uag/O58ydM+GlBjFx3G+d/eU+xyLjVxAHDHczJeh595Wv3dRKdUb3WTsqUkKciE0ngIcUQ
	9wtlty66z7EvxSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A281013513;
	Mon,  6 Mar 2023 09:32:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9yakJz6zBWRsYAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:46 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 0/6] Unifying fabrics drivers
Date: Mon,  6 Mar 2023 10:32:38 +0100
Message-Id: <20230306093244.20775-1-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013250_189953_F883BE8E 
X-CRM114-Status: UNSURE (   7.35  )
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

Second iteration of this idea. This time I moved all the state machien code to
ctrl. 

I've tested quickly tcp, rdma is only compile tested and coming up with good
names for function is difficult.

changes:
v2:
  - move the complete ctrl state machine to fabrics.c
v1:
  - https://lore.kernel.org/linux-nvme/20230301082737.10021-1-dwagner@suse.de/

Daniel Wagner (6):
  nvme-rdma: stream line queue functions arguments
  nvme-rdma: factor rdma specific queue init code out
  nvme-tcp: move error and connect work to nvme_ctrl
  nvme-rdma: use error and connect work from nvme_ctrl
  nvme-tcp: move nvme ctrl state machine code to fabrics.c
  nvme-rdma: use ctrl state machine from frabrics

 drivers/nvme/host/fabrics.c | 434 +++++++++++++++++++++++++++++
 drivers/nvme/host/fabrics.h |  21 ++
 drivers/nvme/host/nvme.h    |   6 +
 drivers/nvme/host/rdma.c    | 535 +++++++-----------------------------
 drivers/nvme/host/tcp.c     | 504 ++++-----------------------------
 5 files changed, 606 insertions(+), 894 deletions(-)

-- 
2.39.2


