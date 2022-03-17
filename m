Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CBEC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Mar 2022 13:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Oh1QlLoF88vdjwE8guTQexAxfSLzIpTLA0dz2Ab3U+c=; b=aJKggkuhu8s9IaG2Eq2FkZriYx
	qY2L7G4WDxLtqPEZdT5Xety0GjvCvA9g7EUOSEMoxl9CToj2uPp44DLunC76TahedByq4f4YQWs3u
	oSb6sf/s5J22V9mRMhaOcioeD5hKKrgN5/v9frd/yHsO0DnxlHzsRwBj3ss75QqeRNJd8FjFvYYd2
	kSLANh9t6Sx5CMfRsl6los7tD/VFBxMoiLKpPdLczteT8CgbioVV7EiapArQ2ze8wABziYp4b3TKg
	G4AA4eNLe03isylMXdVt+g8DNnS8wQfVwRGlpprlk1vBb5jU4xbYfSQaa47Xx6ah4z4PJY7hPTYVc
	I5ArcRfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUq1s-00GDdk-O1; Thu, 17 Mar 2022 13:19:00 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUq1e-00GDZw-0G
 for linux-nvme@lists.infradead.org; Thu, 17 Mar 2022 13:18:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 06E4521112;
 Thu, 17 Mar 2022 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647523121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Oh1QlLoF88vdjwE8guTQexAxfSLzIpTLA0dz2Ab3U+c=;
 b=rrlM4/Xuqpko1+6b0WvaY0u6KfrNqiP+eLgisdII5n5lPywuY/cL8WoNJJUifREntNolxn
 0rCEI9qdSjhT5v4MHR0PUpkbwdY9too8y3ykCpW5SMotd1L+uaoXoxNO5RV4hiAJeidXTS
 aQfDilfV8/6MSNYKEtZh5vgfzKR95Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647523121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Oh1QlLoF88vdjwE8guTQexAxfSLzIpTLA0dz2Ab3U+c=;
 b=X0a3FcPvf/9CcxjmJl4Z7R+jAltzquyK2jOwZzesnk1yY3aYyAD39I2+B8zgWGi7DByuAr
 c/tTDdYymXwlBdAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A3016A3B8A;
 Thu, 17 Mar 2022 13:18:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8BCB9519375B; Thu, 17 Mar 2022 14:18:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] nvmet: unique discovery subsystem
Date: Thu, 17 Mar 2022 14:18:30 +0100
Message-Id: <20220317131833.37068-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220317_061846_209976_1EE6C39B 
X-CRM114-Status: UNSURE (   9.38  )
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

here's my next attempt to support unique discovery subsystems.
The main idea is to make the subsystem type configurable; if it's being
set to 'discovery' it'll replace the static discovery subsystem.
The admin then need to configure the subsystem as normal by linking
it into the ports where the discovery subsystem should be visible.
And the discovery log then includes all configured ports to all
configured subsystems on the port providing the discovery controller.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvmet: check for subsystem type in nvmet_find_get_subsys()
  nvmet: make the subsystem type configurable
  nvmet: include all configured ports in discovery log page for unique
    discover controller

 drivers/nvme/target/configfs.c  | 65 ++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 23 ++++++---
 drivers/nvme/target/discovery.c | 89 +++++++++++++++++++++++++--------
 drivers/nvme/target/nvmet.h     |  3 ++
 4 files changed, 154 insertions(+), 26 deletions(-)

-- 
2.29.2


