Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF694C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8UzlW103z/AG8Yxh6y5TrEV8zQwu8SBdufFx19Qs5Dw=; b=MfQ9gqML04HT9fx0LrFzciBKJF
	5yvEWx0F5wqta5I7HrPsgce2lt7w9nWs4hgRTW9yzsGO8ZS4rUxUR5Tdm+JEkR8HUE+3hiYCYLbwy
	hMhKesLpjqNCZQFluvs8YNR5XfMjzKAGKSQlQNGytm2NvuLFzKsWEiNwfdhATYUdMlO4v7cKS+BXL
	usdW7SpgJGPdycoRqjowQjjzBOyWwcGrzOepzjIqBup8p41Mw0xEagiOiuTnk/OCVDw0GfGDYF0SO
	Nck5vrtibGU2BJzpWYKgeANAcNKHxWQ2/9ieaU7kCfL8v7xokIBkT9d4+6Y+bOFR8hA2lpfyFFPgn
	pykEsAtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUr5R-00GQ48-Ik; Thu, 17 Mar 2022 14:26:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUr5O-00GQ2R-A0
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 14:26:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BCF861F442;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647527200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8UzlW103z/AG8Yxh6y5TrEV8zQwu8SBdufFx19Qs5Dw=;
 b=Xj4LX69CLyRz46D1Q3kraRF1huG5NvAZ4jHYgoaZ0n0WEB8bKn7BQ8r3TTKPAaqLafmlvk
 ZbOhYBhlXIQPihr1ofm174JV+N3jiEG49Qnd+PMo8kbAHO7D22/4yxmLqECTqa3ibJTRh1
 Hjr67GrbKUd+memzzuNhcZeW0kWsK2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647527200;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=8UzlW103z/AG8Yxh6y5TrEV8zQwu8SBdufFx19Qs5Dw=;
 b=hlYVKagJLdW/HfuPPbfd3DfjOSEG6Oh5JWEAlqQEg6QrTFztc5m728H8So2P0dL3i5tCSh
 JPULPzhHq7nuxWDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 6515EA3B89;
 Thu, 17 Mar 2022 14:26:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 52F9A5193764; Thu, 17 Mar 2022 15:26:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/3] nvmet: unique discovery subsystem
Date: Thu, 17 Mar 2022 15:26:31 +0100
Message-Id: <20220317142634.49324-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_072642_515744_204D1874 
X-CRM114-Status: GOOD (  10.36  )
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

here's my next attempt to support unique discovery subsystems.
The main idea is to make the subsystem type configurable; if it's being
set to 'discovery' it'll replace the static discovery subsystem.
The admin then need to configure the subsystem as normal by linking
it into the ports where the discovery subsystem should be visible.
And the discovery log then includes all configured ports to all
configured subsystems, as usual modified by whether the host may
access this subsystem or not.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Include all subsystems in the discovery log output

Hannes Reinecke (3):
  nvmet: check for subsystem type in nvmet_find_get_subsys()
  nvmet: make the subsystem type configurable
  nvmet: include all configured ports in discovery log page for unique
    discover controller

 drivers/nvme/target/configfs.c  | 65 ++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 23 ++++++---
 drivers/nvme/target/discovery.c | 83 +++++++++++++++++++++++++--------
 drivers/nvme/target/nvmet.h     |  3 ++
 4 files changed, 148 insertions(+), 26 deletions(-)

-- 
2.29.2


