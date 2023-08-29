Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 797DFC83F14
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 09:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=krh7iP1jPEzQU6m6g0mCEDbOBodfhbSV73GkQQ6/CMY=; b=M6PCbRE+nWKJkVT2R2R9+fXN4O
	mwZgTryHAYj6vxmlG5ej+ZVWXC5JP9/2H1UQFGrpLhBK7nIN2Wf8Iy3PPimgxoFzbvKscAuhHLTs2
	aLheSahEJ5jcCes087Qx+r+1H4Iv20PAm66jR9L8Lm3Jw7vjj1ah+H2bnPceouqUHE66/zQZEPtyQ
	d+ob0cbIfbHOH9oQwIMR64rcEXNfhRSgqx7HfQq+Kw4Fvcqstfknb/BqnyGz8P/+3xmgxDJnOA5M4
	i5g2k2AH86MsKTKugKgxuJJOX/Yy+liUKUJzBG1lsugKjoh7c0TMVQwf92ALc5wFhLXKO5oSEmr6r
	3873FalQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunG-00B68y-0B;
	Tue, 29 Aug 2023 09:13:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunA-00B65r-1K
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 09:13:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 541FB1F37E;
	Tue, 29 Aug 2023 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693300419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krh7iP1jPEzQU6m6g0mCEDbOBodfhbSV73GkQQ6/CMY=;
	b=dXxBXujXWYB1Crh1oTOGFUjipIikfjsET1Pp/2UzKq5TBNHWmbRWk8Viilk7qUq1Mb6MPB
	CuroTNdOicTPmhU2sOQSQvUh3jfY/8W0yRuqPVSEWFt2qtC+OmCtYoWldoDlDbksLmRiii
	OIrnroiYY2tuxt45FVk/MoQ7yGWDDRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693300419;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=krh7iP1jPEzQU6m6g0mCEDbOBodfhbSV73GkQQ6/CMY=;
	b=ohmpBxJDuiyFQ085R95QPlyPr+W8z6+kb1xPaKpxbvI6eAe2611T38bjxChoxILx/ldPtd
	6xd0HlAVosyz6sCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D7B13301;
	Tue, 29 Aug 2023 09:13:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3rfmEMO27WSyUwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:39 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1 2/4] nvmet-trace: null terminate device name string correctly
Date: Tue, 29 Aug 2023 11:13:47 +0200
Message-ID: <20230829091350.16156-3-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091350.16156-1-dwagner@suse.de>
References: <20230829091350.16156-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_021344_595349_C5588267 
X-CRM114-Status: GOOD (  11.55  )
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 6997bd7e45cf..9ba466b49613 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -55,8 +55,8 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strncpy(name, req->ns->device_path,
-		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path)));
+	strscpy(name, req->ns->device_path,
+		min_t(size_t, DISK_NAME_LEN, strlen(req->ns->device_path) + 1));
 }
 #endif
 
-- 
2.41.0


