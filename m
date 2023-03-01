Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9BDC64ED6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Mar 2023 08:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IHfJEY/Gp0M78+ImLaQ4s8ejhgZNE5frmpAxWQp10rY=; b=Swr7mfhKUnMC2NRvcgwhjaTI1s
	sPp6qFaoDNIPumQIFX34yJ9rObH7nkds+1wtereB2b1nJLGLO/K5nPuCSb6f7coP347l8/0NUGIHA
	mD8ar9WMdNPnySSPWwoU1nbkum/x4zjwDqLADVD5OeOY9o5M3n2HcclzHcHFtgiWwnCl+/te0H/b6
	5XKU98NuiHG5L0W7Dtyj8Gv3dxrz/2ix8RUDVYk0BFxBqCWo2Yz/FWdaBGu4QQ+5bGAbMOh+cvzH2
	XrxT07y/QWplw4hHWHQfzBTG+2KZEBYJTdoLiFhIETgEMCJK1oJ5C64BOu3SRsQQyzsmATUC4RhAB
	7fip65sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHob-00FS1c-NG; Wed, 01 Mar 2023 08:27:57 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXHoT-00FRxq-NX
	for linux-nvme@lists.infradead.org; Wed, 01 Mar 2023 08:27:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 07EE01FE14;
	Wed,  1 Mar 2023 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677659264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHfJEY/Gp0M78+ImLaQ4s8ejhgZNE5frmpAxWQp10rY=;
	b=UvD9I8w5UNtm2bqCM0NRmqKI92l4AwUyRpaoFe0xwaUjkMTW8EpMwwlFr7YdUJy6L3lagJ
	X2TBXGWoUBXMpoHijFc4poiMON1gj30KTRo3BRn/QPBBkOlHjv6bGnBhAtoUTJlHvSmyRZ
	nh3IqqQy9Le+CZbDeOIpbw3bKUUQL3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677659264;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=IHfJEY/Gp0M78+ImLaQ4s8ejhgZNE5frmpAxWQp10rY=;
	b=yS3FumaSz3q0fN5dpGowzqETr/FKQ+V2sK7AvHe6IRqw22s5RXROsV3A2KnpTWZzj9Roim
	AwHoCaGLQPYpflAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EEEBA13A3E;
	Wed,  1 Mar 2023 08:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mDopOn8M/2PVZQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 01 Mar 2023 08:27:43 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 0/3] Unifying fabrics drivers
Date: Wed,  1 Mar 2023 09:27:34 +0100
Message-Id: <20230301082737.10021-1-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_002749_938632_A58E7AEC 
X-CRM114-Status: UNSURE (   9.00  )
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

The two fabrics rdma and tcp share a lot of common code. This here is my attempt
to consolidate the common code.

I've picked just one function (setup admin queue) for this RFC to get a feeling
and feedback if this is a valid approach or if people hate it. I've left out fc
for the time being because it differs too much two the other two drivers.

I've tested quickly tcp, rdma is only compile tested.

Daniel Wagner (3):
  nvme-rdma: stream line queue functions arguments
  nvme-rdma: factor rdma specific queue init code out
  nvme-fabrics: move configure admin queue code to fabrics.c

 drivers/nvme/host/fabrics.c |  52 ++++++++++++++
 drivers/nvme/host/fabrics.h |  12 ++++
 drivers/nvme/host/nvme.h    |   3 +
 drivers/nvme/host/rdma.c    | 132 +++++++++++++++++++-----------------
 drivers/nvme/host/tcp.c     |  94 ++++++++-----------------
 5 files changed, 165 insertions(+), 128 deletions(-)

-- 
2.39.2


