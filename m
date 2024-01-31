Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E19C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 10:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=; b=Lk8TxjphbTV5/ChO0kzPAICzwH
	QPaCttoK/07LfSvS6jdKNyat1P/MvD9fiWQHtvdfxWG+7uwJkaTZxXsWCnYl4CPndP7pWuJXbVDt9
	XEKKJgzrKm6CFFi6DJUSmFd0oxj1SnuOMzrSWADcPuMzoyuo6ejRaJ8+i/wbS1zm8X7lv5YXAq9tC
	Xib23UuTN6M+MJ9UWf2p3RzP90xw2jwWfWkbl/sMTJ3p/g7TVM6qTSqdXvki2ZkrwH6LDs860JtLd
	mJcxn1qJcI7IBtLHWFI8noXJtM345p2hS9fhvNCuvum54VhwNI2x9E8I3QuRb9CsLIUxJMUjFu15R
	jdjSF5uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV7PU-00000002dN3-0Y5U;
	Wed, 31 Jan 2024 10:01:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6KL-00000002FLg-3VJs
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:52:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=; b=C/kOYowTJcplMgn9aNizNH7GVV
	ukvQbPNWnTWik5aRsW4VfW4R/y4Ay2Yz7Udox9u8IdKMcFNv7SgFttQ7VCEOzyaF3sUTrO6u6IwWj
	5f545dFcQNaQ5uyWoowbLPfAidypM4Z+fFB17ashsjEK4XP4kct0hUAhYAtKCsnt/L68MR8/Vm88Q
	8CD/PO3ZYHfS0RiNLB68fxU1vYLB9bs/ocV2dsbPe9atso0dA1nDudmMduTdIabU5tV4OyoOcHvTR
	iIZSbf/XVoHDVwEcDciabF1niOxZTYIhSZe6ShMa0ik8nG2YxdW72PrdK8t92j+lfOCHsIZgqgj/T
	kuwZZuMg==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jd-00000008r3B-2j9i
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:51:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2034C1FD0E;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=R3sJXBOiHBdZXbXSqNVxZB+e5d2RasvE5TymeW1cne1QpwY8ZtD+8DtnBciUjjlYWairjf
	ionBbRwwlyemK8Ge/yjYgUz+JHFIHT3qWscgsk2rna5LEwf6g85qQi9zHwvwez6w3OJshc
	Aj9TgWsm1qxbVxf7pHcROpX3WJb7hx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=V+pZwvh39BnHJhGktSGfTLqpXdVzh3EJ73gPPUiHQqz8Wvzyki4iKdBNlPr3ma9xAVEKmU
	WUREzTA7HCp826Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=R3sJXBOiHBdZXbXSqNVxZB+e5d2RasvE5TymeW1cne1QpwY8ZtD+8DtnBciUjjlYWairjf
	ionBbRwwlyemK8Ge/yjYgUz+JHFIHT3qWscgsk2rna5LEwf6g85qQi9zHwvwez6w3OJshc
	Aj9TgWsm1qxbVxf7pHcROpX3WJb7hx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV2MGThNuULDTIR8ZdlJrRAXWk+1WOpSUxslfvlmMOI=;
	b=V+pZwvh39BnHJhGktSGfTLqpXdVzh3EJ73gPPUiHQqz8Wvzyki4iKdBNlPr3ma9xAVEKmU
	WUREzTA7HCp826Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E7EC132FA;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KFIYAg0KumWOHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 06/12] nvmet-fc: hold reference on hostport match
Date: Wed, 31 Jan 2024 09:51:06 +0100
Message-ID: <20240131085112.21668-7-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [2.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.63)[98.35%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085131_413444_739E23BD 
X-CRM114-Status: GOOD (  11.21  )
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

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b44b99525c44..205a12b1e841 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1068,8 +1068,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


