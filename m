Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302F8C001DF
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=J7+18lmgaMC/YHR66nx0rAFp9jrPLiFlwCw157k1RJw=; b=gp+upa6yp08ZmxiWCXuy/AxUO5
	jQDMNZbMhz1sq+hxwkRRl+pr5iD+ZpPTLWtOvQdKCyDbdmz3vX3BV3Kzb5eyKTX8kK6INS+jAfZ98
	j/QymEmI4h0rISSLhRCN/UCcGgKQm1ROlICkFxMCGA+pedj9W27OB6KPb4weC17mFijlr9gZ1rAPF
	6QldiJZLbMVPBgdwyP2f4sAIO1lSOoRdtSTlQVfFVzgEpDwLI/JtQRniw2gsxm8Fbk+9vpC/11Sl2
	XuzzKeYH6RbDxX9aA35n7fmPXxYjM2OB6v9i/3AsLYTuIPOGbf8lCqPN8aIX/BKQAFxWuqfZ5ojtm
	VE5bNeNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU3-00AWbB-23;
	Wed, 26 Jul 2023 13:23:19 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU1-00AWZX-2V
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:23:19 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CDB111F86C;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690377794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J7+18lmgaMC/YHR66nx0rAFp9jrPLiFlwCw157k1RJw=;
	b=CESHv49oOIQ7v5yoeEKYgLleq8u+vyaqTnJmHHkPzovmtgiWUAaG7UbalYfDYTKol6hN1V
	XhKtB054eFL9miEE49kbjjqYrXA/HgW1ZDNFCiwGWhP/5waPeqfO2dl8rMrBeGXA4CHNV/
	Fv2tvYOi6luPzJlRc0MhdDwd7K2ekCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690377794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=J7+18lmgaMC/YHR66nx0rAFp9jrPLiFlwCw157k1RJw=;
	b=JgeKFu66AEuEGYi787MlVXmkC4Vdc1hr9rMA/7NEguW/yTTLBmQvJGbbmRnwt5+18Ldx6Z
	1cW8n+rcjHn0qHBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AD53A2C142;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9372551CA304; Wed, 26 Jul 2023 15:23:14 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ewan Milne <emilne@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH RFC 0/2] nvme-multipath: additional iopolicies
Date: Wed, 26 Jul 2023 15:23:03 +0200
Message-Id: <20230726132305.33739-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_062317_958271_D4DFFAFC 
X-CRM114-Status: UNSURE (   9.52  )
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

as Ewan raised the issue that we are suffering from a buffer-bloat
problem when using the round-robin I/O scheduler here are additiona
I/O schedulers to improve the situation.
The schedulers are untested, and are compile-tested only.
I just putting them out here as I had several requests for them;
I'm happily improving them upon feedback.

Hannes Reinecke (2):
  nvme-multipath: add additional iopolicies
  nvme-multipath: add 'latency' iopolicy

 drivers/nvme/host/core.c      |  1 +
 drivers/nvme/host/multipath.c | 69 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  8 ++++
 3 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.35.3


