Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD1BC47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 11:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=; b=Eez59GGjHjrgsg7/eJItngYqqn
	uUPG+mKD6F19Q0R1PVN61y7tDo48wmua5qYdFZUjHjFwwodLDOqwwkpTB5VqLdP46PzJERTuyszZ+
	em+dVU/mmlXDrVSOBa+r8HU49q3q2qR90g/hfDQqqZHdoM46VBRXXRjJhQoCVky2ztRhdg8y9w7Pc
	bn8JMKea0DII8sVa0UCOQrlQ9d1ZIT2rAye6ZFFIMLp+NgGktSBgLXDNG4tQW/5QSLWg6jYbLYa0M
	pX030t+RDR6APmaFwksfC4rKcEQjRgi5f6aJjvVqxLLhr5qWmoTLzYr5IkCo1xqBWP+1Yu/UQiVYn
	coZGnhsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8M6-00000002wzs-2lEw;
	Wed, 31 Jan 2024 11:02:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6KH-00000002FJj-37gk
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:52:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=; b=pxTYyLtd7AoixSYcI5BGkY8Pmi
	arY3KJ7iMindvjESg3xlF547oGNIjVXa5riAwC5yDE+kLGZ5Mwq45a4w6c8ZpkcnBXjggtbS9PYzH
	KXpa4tlN9RnEl+0TPevt2Z3acK+1h4H93LhpMVoDHNdDZhtU6AgXHdY7SaOUHlyY+R3rwjsgoTMNA
	sRvMRwjgAmvMr7Fyf0qdMxU5jJgf4Nsug761Qkn7vZMglJzq24zm6O8k/AvVZAUt/9xQO5v/xGr7O
	cDN/IROQ4WAAUWG68E7DPOHFP0y6EaakLPegc4R0Jg1cNDyDQLYCBUr7ZiTK38TLqiCwtEVqEEhDz
	b+rezn5w==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jc-00000008r3E-0pdH
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:51:56 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCDEF1FD0F;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=NHAmMyQKQYT5OEqL3RyqLj9MXbs0/dkRxZoDlthMh8/xGDGyc9yfDV0tzBHi9KgnMTQa6B
	tPfgD9MwDYZpcBd/rRgbORw+F43y3Mcggx35L3nsXKya784ZwD0EbQUAh9nVetA0fUEjJs
	AWLeMWpcjK5qE06w4/GBKpTqPSD/v6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=W4sI37DXQkm2VXmUdRbQC7iwR0RR33/atncmXWJHuDPRfr3cXvl3LPYnR24YReoL3YFZs/
	RJ3o/cdl7UlTr6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=NHAmMyQKQYT5OEqL3RyqLj9MXbs0/dkRxZoDlthMh8/xGDGyc9yfDV0tzBHi9KgnMTQa6B
	tPfgD9MwDYZpcBd/rRgbORw+F43y3Mcggx35L3nsXKya784ZwD0EbQUAh9nVetA0fUEjJs
	AWLeMWpcjK5qE06w4/GBKpTqPSD/v6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=W4sI37DXQkm2VXmUdRbQC7iwR0RR33/atncmXWJHuDPRfr3cXvl3LPYnR24YReoL3YFZs/
	RJ3o/cdl7UlTr6Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD33132FA;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jQA7KA0KumWRHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 07/12] nvmet-fc: remove null hostport pointer check
Date: Wed, 31 Jan 2024 09:51:07 +0100
Message-ID: <20240131085112.21668-8-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.14 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.76)[98.96%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085139_492715_CFEA7208 
X-CRM114-Status: GOOD (  10.76  )
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

An association has always a valid hostport pointer. Remove useless
null pointer check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 205a12b1e841..849d9b17c60a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -488,8 +488,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	 * message is normal. Otherwise, send unless the hostport has
 	 * already been invalidated by the lldd.
 	 */
-	if (!tgtport->ops->ls_req || !assoc->hostport ||
-	    assoc->hostport->invalid)
+	if (!tgtport->ops->ls_req || assoc->hostport->invalid)
 		return;
 
 	lsop = kzalloc((sizeof(*lsop) +
@@ -1524,8 +1523,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
-		if (!assoc->hostport ||
-		    assoc->hostport->hosthandle != hosthandle)
+		if (assoc->hostport->hosthandle != hosthandle)
 			continue;
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-- 
2.43.0


