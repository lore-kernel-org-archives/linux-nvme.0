Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C144FC4828D
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=; b=qjip2+1ec+3AUo76Td9qRwBE9/
	SQwh9EDuzIb5GMk8hVCDwp64tRJcm7rDRg9d/DXMJfIPMnYxnUzqMkuVidhiStTrFRfJomYVu3ohZ
	/L0NjxHLecgkDT2lQ51URRkMpwiTorg4Az+QT37EeDe5IqlXbmBxSO/7nLa9jn0fKA+Rshq7MkG0V
	mS8/WBa9BAj3UIWxiYJriKeLHSZ5cKOLuvIUDXglX++N5hhR/yA6qFRozoMmUognCvL1i8TugfL5C
	YXNghWRtpAgrNh73SNrmV9CDioZ7t5VpaDE1MxokDVTqrn+Rm36CkjslpK5R/+7466TymfsgNVSKz
	8VgczOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7PV-00000002dOH-1jO0;
	Wed, 31 Jan 2024 10:01:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6KQ-00000002FNg-1400
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:52:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=; b=OWF9QZNNqMzYfHtaKHMvszPwne
	GwS/kJmjlW/WuEwZVkzyVPbgcj+DHnSc9OgXSBIffBHH8UzofuvFfBfK8NpynWLF7i4hMb2L7LcPg
	qQt38TrTxOBJHwI2lbjaIXVdBvHtlIcBwkC03OkQjo17MXIZQmJ0ELF6Hsm0qFevWgNtRFN/ad0di
	+hWiFxpP852QcWBaVUf15tV+5dGqRQ/7bUepDy19NMlmxofmxyTqi0Q5ZCLHKkGBK94/gyfogIYDv
	G3dO6ZOT/9rBkzgF2SPtaKpLTe22XmJpHtdMUh0HP/eEUrZEv5vs5BqLPZxP6Z8uwtVVvLtmEpK06
	AYWBWm1Q==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jc-00000008r3L-2T0Z
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:52:01 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FC0522195;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=TU01xr0SmQvGHMHPEX7edpYR4lUK+Dhf/GB5BR+8Sj/8r9ozgHuNGNSN02+rRS1JfB9m37
	ljMpmWhhzAZuVAEV8g6YBo5U35NH2cgL+bjH86Gm27gPRR/cJMGcMCi9yjzdP9zoaw+WXd
	alKr5hWFUtpbNAYiAZluRonPM4Z/0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=wAD2FZou0247eB3mwCA5n9uPdQM8tsAEFX+OT11GoxaJtcPw2jgh+8Acys7vkidhNfsN+f
	ZpIbNTY2jRh6e3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=TU01xr0SmQvGHMHPEX7edpYR4lUK+Dhf/GB5BR+8Sj/8r9ozgHuNGNSN02+rRS1JfB9m37
	ljMpmWhhzAZuVAEV8g6YBo5U35NH2cgL+bjH86Gm27gPRR/cJMGcMCi9yjzdP9zoaw+WXd
	alKr5hWFUtpbNAYiAZluRonPM4Z/0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=wAD2FZou0247eB3mwCA5n9uPdQM8tsAEFX+OT11GoxaJtcPw2jgh+8Acys7vkidhNfsN+f
	ZpIbNTY2jRh6e3AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D14E132FA;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SJNZEQ4KumWVHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 08/12] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed, 31 Jan 2024 09:51:08 +0100
Message-ID: <20240131085112.21668-9-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TU01xr0S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wAD2FZou
X-Spamd-Result: default: False [-1.80 / 50.00];
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
	 BAYES_HAM(-2.99)[99.94%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5FC0522195
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085141_078055_6A95B482 
X-CRM114-Status: GOOD (  11.91  )
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

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 849d9b17c60a..fe3246024836 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1107,12 +1107,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1142,8 +1139,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
@@ -1180,7 +1175,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
-- 
2.43.0


