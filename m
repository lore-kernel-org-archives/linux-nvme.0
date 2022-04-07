Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FEAFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 10:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=StZ0EtQ64DzzyEsqco90Y1T/fh24IKeaGGOVrsw/VjM=; b=wTTSa8RLqEuQJilZySzKFys4B3
	s9MCT0xEfciMfxjq6upE7slU5ph7YV8uJ9nsUfXwN2pcj/jMJFLzsKy+G7/ZNqIzUY/m2ggZLAJRJ
	toRKAaw0Iw9w6pgVzfjM3mRqbr4fr+vK+MgRp/0a0EwW+w8SogeCssDTB7Xh2fhrrC2KGarJd3bGg
	IX0l4xe+iLgKkI5I/z0whAibkT3ueh5ZSgeNQfVlPX6EVs6TkMsfEiurrh54B51amVAE7oftDWsSk
	X0aYVXSJ1seKc4Putg+6cr81/1xB8/Yxy4OJjn57jIXy6ntfp4Cbo5X8k+kKZhy36fySuJOGPNfCO
	dPrA3oxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncPmo-00BOKl-95; Thu, 07 Apr 2022 10:54:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncPgT-00BLj0-MD
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 10:48:16 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 09B7D1F85A;
 Thu,  7 Apr 2022 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649328491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=StZ0EtQ64DzzyEsqco90Y1T/fh24IKeaGGOVrsw/VjM=;
 b=L6J2E2Ta11wtWyClUbKwgEilrFmiON76jnv+C+n1madTaJmV3yGNaJyWjLQSm6H3fZ9aZJ
 Q+8/+zfxPWf87LlYV/NEHMn/FvSDsev82z/zA5kcB08rc/OEWc73fLO5ClNO/gB4tBCS/F
 1/zFOKcaQC9pfnj3YfDph76WaFvp9SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649328491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=StZ0EtQ64DzzyEsqco90Y1T/fh24IKeaGGOVrsw/VjM=;
 b=lyqksYCyoMuJBw5oyHsYOkY+RB5rHURxMhLt5IM1SrLHl+kofTMPjpeBq2m6qekqcQCTRC
 n+GGrUV4a9VUqWCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id F1325A3B96;
 Thu,  7 Apr 2022 10:48:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id D99A75193BE3; Thu,  7 Apr 2022 12:48:10 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv4 0/3] nvmet: unique discovery subsystems
Date: Thu,  7 Apr 2022 12:48:05 +0200
Message-Id: <20220407104808.29007-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_034813_985972_1A30925F 
X-CRM114-Status: GOOD (  11.96  )
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

here's my next attempt to support unique discovery subsystems, again heavily
modified from the previous attempts.

As per suggestion from Christoph this patchset allows to have a per-port
discovery subsystem. For that a normal NVMe subsystem needs to be created
via configfs, the type needs to be changed to 'discovery', and then linked
into the port where this discovery subsystem should be visible.

Once that is done the discovery log page output will include all ports
into which the same discovery controller is linked.

If the discovery subsystem is unlinked the default behaviour is reinstated.

As usual, comments and reviews are welcome.

Changes to v3:
- Rework to use per-port discovery subsystems as suggested by hch

Changes to v2:
- Heavily rework after discussion on the mailing list

Changes to the original submission:
- Include all subsystems in the discovery log output

Hannes Reinecke (3):
  nvmet: make the subsystem type configurable
  nvmet: per-port discovery subsystem
  nvmet: include all configured ports in the discovery log page

 drivers/nvme/target/configfs.c  | 82 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  6 +--
 drivers/nvme/target/discovery.c | 82 ++++++++++++++++++++++++---------
 drivers/nvme/target/nvmet.h     |  1 +
 4 files changed, 145 insertions(+), 26 deletions(-)

-- 
2.29.2


