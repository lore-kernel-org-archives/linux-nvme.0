Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4472C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UMSsWMmFDwVW5JTk/1hvpeOn9qpfY+djpGLHNROyqk0=; b=mYcebDmzMHA3OFXkTtt7lM3ygF
	rhAHj/G2iA48qdA8ZvNxoC+YZawW1Hc+ibbMS8i1T8E0HAxVKV0fCCD4NfUp5yF9Jl0ZkekK4WXFe
	BTMbktpTLptqqMCepr5HT9sLYSBpBq+hfp4xLOkKgE24hWVUu5s93qXO+FA3tTVLc5bpzLwLs/jM6
	TSdCzNDEZ4ZXqPtTv/YVKSvbmNOm3Vbwr95nHmwvy3s4iJX+ihbuaUYbPOPXuc24LcOZutrZC5Rtb
	QRid+yA/sLIngg0KJ3W623+jfMobeW+BMU7oseiQEuB9jyDCzkT/PBuR789KYBr5VIaW9jIF3Zjah
	b+qGGj+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8YT-008giU-Kb; Wed, 02 Nov 2022 07:52:57 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq8Y5-008gVP-SV
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 07:52:36 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 97E1F33968;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667375547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UMSsWMmFDwVW5JTk/1hvpeOn9qpfY+djpGLHNROyqk0=;
	b=nn7ZRR4FM02UKNUi6gJDsyscycoELdykEvbphqdfsvlQX1xo14NlkDJLLe1OnLFVb99E6y
	265XRVqsgvC9lmXazHXwwZNWG7o+54YwOXc0tUaBrv5DihYwFuOVbXzNt3ak75Msfs5cfU
	k58BkTZbjU6kkFD/IU6wl/guMINWKY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667375547;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UMSsWMmFDwVW5JTk/1hvpeOn9qpfY+djpGLHNROyqk0=;
	b=9zva/FUQHfuXiwFcSKZkWYh97jrMfOpYbSLjr/Fl4aApxDDOQ0K7pQrNzgKhUHfyQWLmrp
	JW8gWZHoVdMTbXCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8D72A2C141;
	Wed,  2 Nov 2022 07:52:27 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 8123F51AD6C1; Wed,  2 Nov 2022 08:52:27 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/6] nvme-auth: use xarray and minor fixes
Date: Wed,  2 Nov 2022 08:52:18 +0100
Message-Id: <20221102075224.70869-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_005234_118073_B8E16F83 
X-CRM114-Status: GOOD (  11.28  )
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

this patchset moves the dhchap context allocation to an xarray to avoid
locking issues uncovered by blktests. But during review of the original patch
several issues were pointed out (like allocating the transaction buffer
even if the transaction is finished), and I've found several other issues, too.
So I've decided to wrap them all up in a patchset.

So as usual, comments and reviews are welcome.

Hannes Reinecke (6):
  nvme-auth: allocate authentication buffer only during transaction
  nvme-auth: do not queue authentication if the queue is not live
  nvme-auth: use xarray instead of linked list
  nvme-auth: return real error instead of NVME_SC_AUTH_REQUIRED
  nvme-auth: set DNR bit on non-retryable errors
  nvme-auth: use a define for chap buffer size

 drivers/nvme/host/auth.c    | 199 +++++++++++++++++++-----------------
 drivers/nvme/host/fabrics.c |   2 -
 drivers/nvme/host/nvme.h    |   2 +-
 3 files changed, 107 insertions(+), 96 deletions(-)

-- 
2.35.3


