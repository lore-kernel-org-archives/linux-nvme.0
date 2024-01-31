Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD26C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=; b=GOnEXe5bPT0MTuSUNOyueHHX0D
	0p5mafUwi6DSaqjAAPfWh9VRKlJajwXhYaAIPgu+JzQ5L4rXMzltL7HVAOuKi0u27ev17U0F3wZdd
	fUAwV6KQ6shvRWbL0XvoQlSRcPfj7wcZnDoM/dDGiDWgBA1G6Ezs2S4Vd5RTva1L3D2NzpEz6cQqu
	/B1qzftaz/NFEdBsM+6NZjaasjKn3M4SrA4z0w+0xaoNuwc6VHIOZxUOX/hbJ+Uq8t6BqAVfb5u39
	z/c0yDBN03SVpMh+1dSxBpnVXjiSfbzWmo4hZV+DEdztY7YN1a8vPD3HEBfxoEujgNciAAlOy2vB/
	gcVcYQ6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8Lq-00000002wmX-2u4B;
	Wed, 31 Jan 2024 11:01:54 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jv-00000002FA4-2A79
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=; b=BZRoXCNiJ0Cub8QvD3yypZtmt1
	iB5j37g69ee0FsL4WXorYwHoV4V1Wvw0aDbKiApX6B3E2QYRyhk1qWh5ktYRtFZMCCpPpkCfAPi8c
	2SQ7WttvtaB5nFsrMSEHcHQYolVl9+mGcucwXh2t3hocy1Ggswl6IIj9EulPg1wz6C29fuJxBsQ/z
	YBRgWqRrPcLveUpAH+EKEDq7BJtEbjpdi7Qb7SurTY6hYphI1/yprRq4OqIMWfRwnd1qJt/4Z4vi4
	WHXlbHnQHJJn1c0BgvPPXlMkhMa+Y29S6gx2ZrqbuQG/3pE1omP0JOM3+Wv+V4l3e+C8c3qY4FlbR
	2oEqJEjQ==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jf-00000008r3t-0wh4
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:51:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03F221FD0A;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=qBJYU/tI6j44El8T38dpMPmQFBHQ7EV+uE73VMBvrYlvgInoeeMOhk/IPLrLu8AqVA6a4n
	gb1e50BqDnsl5RSbhSOGukyuA4Fl1eW5Rhp4yxiO1DUJLmwKLKvlKzKxU/rEDiAjPq2GsW
	s78FDYPTS8e+pHQuOTiAEfqfJVt6/+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=uI5ABNFFvxjGkzFXZmBy6BLnb78DDdvMbwLRHoomuwcUdrhh++C8RkPRJj7TDKbtbkacjW
	MldXcc7gZBA39IAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=qBJYU/tI6j44El8T38dpMPmQFBHQ7EV+uE73VMBvrYlvgInoeeMOhk/IPLrLu8AqVA6a4n
	gb1e50BqDnsl5RSbhSOGukyuA4Fl1eW5Rhp4yxiO1DUJLmwKLKvlKzKxU/rEDiAjPq2GsW
	s78FDYPTS8e+pHQuOTiAEfqfJVt6/+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwD69Rb4Ovy/rg6BuDZUolwj46uS8Nqdj2ffUDESYmI=;
	b=uI5ABNFFvxjGkzFXZmBy6BLnb78DDdvMbwLRHoomuwcUdrhh++C8RkPRJj7TDKbtbkacjW
	MldXcc7gZBA39IAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E54E5132FA;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9PmSNg4KumWYHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 09/12] nvmet-fc: abort command when there is no binding
Date: Wed, 31 Jan 2024 09:51:09 +0100
Message-ID: <20240131085112.21668-10-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="qBJYU/tI";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=uI5ABNFF
X-Spamd-Result: default: False [-1.52 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.71)[98.74%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 03F221FD0A
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085132_792664_7F8C51F3 
X-CRM114-Status: GOOD (  12.89  )
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

When the target port has not active port binding, there is no point in
trying to process the command as it has to fail anyway. Instead adding
checks to all commands abort the command early.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index fe3246024836..c80b8a066fd1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1099,6 +1099,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	int idx;
 	bool needrandom = true;
 
+	if (!tgtport->pe)
+		return NULL;
+
 	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
 	if (!assoc)
 		return NULL;
@@ -2514,8 +2517,9 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->req.cmd = &fod->cmdiubuf.sqe;
 	fod->req.cqe = &fod->rspiubuf.cqe;
-	if (tgtport->pe)
-		fod->req.port = tgtport->pe->port;
+	if (!tgtport->pe)
+		goto transport_error;
+	fod->req.port = tgtport->pe->port;
 
 	/* clear any response payload */
 	memset(&fod->rspiubuf, 0, sizeof(fod->rspiubuf));
-- 
2.43.0


