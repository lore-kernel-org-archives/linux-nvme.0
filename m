Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA05C83F18
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 09:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=; b=eR2y/1I7SJdOKIDm700M6Nq4u0
	WrRCg7c9tm8GF1XA3TqmmVjKDxCJuFXORUkm7/20b2b0eupOZ4B6Ci2Jd63SDvUQPzXzrAkDjQ9xf
	xOO6YVx+i9VkvHz3zDEKpmiN6RXLGA/fGW9qhhMax2gDD/akKPAG3B1jvCm3MZ7wEc94nJ5VnVsXb
	43/qAtn54rSYO/eFDMu4gIWq33ObkE8L+/KN7AagniFCd2VexDsboegGaEUI4/L2OM3MaRlrOEou6
	voUa3rs/uGcon31W3roI1MTZ/s27/bUP91ycBp8dn3GLCIElo1xoNxSgy39C8TRS6ZmXeLBc24yKa
	cWhG4IHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunH-00B69p-1J;
	Tue, 29 Aug 2023 09:13:51 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaunB-00B65s-0m
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 09:13:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 93E6B21869;
	Tue, 29 Aug 2023 09:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693300420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
	b=jqB6/4DD7H3h9Qv0f5H3Amcc7qkkeg0pN/kQ1MA7nKvvxByqMV0cLWoUrlmkVSdi75ajWw
	6+DcvYqhXeG1vdz6Tp6I7eSBkCHQFAwGqfmmJ+yXo5FDmFgXSWciZD5Ke9d5Vl3qU7B7CJ
	Xc+4QY+uAm002euoxnqYy4MaNT8c/5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693300420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB9aR/U6RXS2ICVTlyDomYJuoXmtN3u/uV5XxMcbYuo=;
	b=gDO+TahvCneMmJqnz5bI64wB9N8vCLVS6ZJBqCCqOivnUJNoxhjZXOaxHWiR78fIVCEJJq
	rLaYC8qBh/KS5WDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8736013301;
	Tue, 29 Aug 2023 09:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IdP+IMS27WS2UwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 29 Aug 2023 09:13:40 +0000
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
Subject: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Date: Tue, 29 Aug 2023 11:13:49 +0200
Message-ID: <20230829091350.16156-5-dwagner@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829091350.16156-1-dwagner@suse.de>
References: <20230829091350.16156-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_021345_422781_5930DF5E 
X-CRM114-Status: GOOD (  11.86  )
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

The port entry binding might not be existing and thus the req->port
pointer is not valid.

Reproducer: nvme/005 with active system nvmf-autoconnect systemd service.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/discovery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..fc113057cb95 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -191,6 +191,15 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		goto out;
 	}
 
+
+	/* No port assigned, portentrybinding is missing */
+	if (!req->port) {
+		req->error_loc =
+			offsetof(struct nvme_get_log_page_command, lpo);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
 	/*
 	 * Make sure we're passing at least a buffer of response header size.
 	 * If host provided data len is less than the header size, only the
-- 
2.41.0


