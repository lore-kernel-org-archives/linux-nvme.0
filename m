Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A43EC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yKnSRy8wd5gsjdzuG1C+XyZoTt2zZ8i35dFzW2QjgdA=; b=oj67tadCDOV51kFz0LCE15B63D
	368XcA7CXhcvYMD5/zRJGZxoIAXMxpqu5Z9MxNcEAbds5odPvEIbb162NZ7p9jB8aUJBFPzVp+gzW
	+7PA5wkPA+FKtkAL583wdYKO/UCVYuQWoMPjfuQd0Y2tQqUPM4MJ0Mc3+h5rzK3S8zIYqvDfFf4pH
	/7fdNyxLpyYl3pd1wPmQ8TQ09YxUFGcSBV52/wDdbrX5PqeB2qcf2jbU5SvI4QbMJKRdPp6MvxR3X
	1Gui1fmZ+5bsxdE1mLi+2YBLS7I4gqIMfc+KsTeu5RwwwFdbIK5janIxZ0U5IWxXMWM030qPB9CqU
	XdZFTpjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcty-007vxP-4r; Fri, 10 Jun 2022 11:34:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctV-007vio-Cr
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id D308C22080;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKnSRy8wd5gsjdzuG1C+XyZoTt2zZ8i35dFzW2QjgdA=;
	b=PuylpbvLJhh/5IuU7QnbJ/Z4C7Ex06LSjujZTEaMAabeKkN3V37aJ4JXQHjKi4VLGwCDjU
	X9fr4f0sNFEkNlhpKVL9MT0h3Pmza7Nv0ECmjFnWuPycYxeV73IrfsI5m4xjgNk0VbS0/i
	T5mK6do5TjYNDVMdUld+nWdTC4YAfFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKnSRy8wd5gsjdzuG1C+XyZoTt2zZ8i35dFzW2QjgdA=;
	b=QyBDcZxL7kFj6V/uxhAh+LXy83jhmIHc1lnwurPfwnDf8py474fsEVhDauWrn2+KNzPaRN
	85HnUIso/Zy68fCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A0DED2C143;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 921765194A3A; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 02/10] nvme/rc: clear allowed_hosts subdirectory
Date: Fri, 10 Jun 2022 13:33:16 +0200
Message-Id: <20220610113324.10294-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043337_634948_9048A0D4 
X-CRM114-Status: UNSURE (   8.41  )
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

When removing a subsystem we need to clear out the allowed_hosts
subdirectory, otherwise removal will fail.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ad4324f..454609a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -264,6 +264,7 @@ _remove_nvmet_subsystem() {
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
 	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	rm "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
 
-- 
2.26.2


