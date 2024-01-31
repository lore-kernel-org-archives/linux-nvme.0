Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8DCAC47258
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=; b=RxzCJC98QPDzmh1cZak+1yjB5K
	M8XbaMwU/lFD/+j/0seP57dl99uOOkCTiRwijHJlxdfZeNkeXJqAqwLAtvqtBJJJVNJ80Rh1Udayt
	/J3QDNswEPiAuQ7o7kBY/EZop7Fci882lGuTj4hrROm/rpkA25LH0Vaipiro1J41LR6EvhbS2sAPW
	mDg17s4cVN2vTXArVSJ2bEnFUfI7HPpZma6MRQxaFm0ujRqpoiv4Iqb/uiff5+G9z8ATGOm4Clu4+
	7xeuzvUqJwSyXUBdBW8Gdhg1BhsqGsGQtBmLlD+mfPokWeJ7f/ADgCrQh4k3houqxfcP+FKJUiRFm
	bt1lmK7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV8Lv-00000002wqY-3qLZ;
	Wed, 31 Jan 2024 11:01:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6K8-00000002FE5-0ptF
	for linux-nvme@bombadil.infradead.org;
	Wed, 31 Jan 2024 08:52:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=; b=gioC+XMFk0I0KbhBReo4s/CwQc
	L3HyxsgK2ibTbvbUeFnoX4tFQ7zf+BvPRUE4yOKmGQ7qWt8x54zG+iErqlr+ZprfvjUNDLgzv03Ig
	xHB6YeO5OP2Y/5wP59YLznDGI3HVWRV2IkOd6MgNOfHwZmMEPuoTc01MzsykCiI0b1P8Z366BtVEM
	3Wru198EnGm93bLj1ARfjoCZzlsK5iq1eAOCFT1fBlYbY3VcMiGTCZd8EAq4nPYM3c0lXTwnK+5ns
	vD7gODESNKf7TP1pKu9Z8w6cO+qxW0HKlvenPx5A9rsNQc46Kwx7GCCtzZSCQGkJM4Wg2fXOmd1hg
	WW0CcIbA==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV6Jc-00000008r39-0pVO
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 08:51:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39A651FD05;
	Wed, 31 Jan 2024 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=Q7l6jVU00tUnnQX0lIWFHaa2sGIkYUhgNYLgdDzeMhw1cFpwQz7x48UbC4mpV/qvyLLJdf
	Y6G+s+Umk6dxW8NSXUZN7Af4QRcSiN+Nnt7XOPtjIc4OXB0DJ+L+mJKz9vjyBacaUcM/ZD
	VN0eiqthmOGV14z9CfN7k6YGwELj9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=sk0oPjVEiZtgmRITqlDTWLlFJi8tw6Bw+QZ/uhlkWg1vZOEFUtTo0aYjOULqj4aeb2DWXO
	MWPv5ex21JoyPJBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=Q7l6jVU00tUnnQX0lIWFHaa2sGIkYUhgNYLgdDzeMhw1cFpwQz7x48UbC4mpV/qvyLLJdf
	Y6G+s+Umk6dxW8NSXUZN7Af4QRcSiN+Nnt7XOPtjIc4OXB0DJ+L+mJKz9vjyBacaUcM/ZD
	VN0eiqthmOGV14z9CfN7k6YGwELj9Hs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691083;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQUSWFdQCtv+1Rn2MqvdEYgTqrHLL1g6ezmsVfSoo8=;
	b=sk0oPjVEiZtgmRITqlDTWLlFJi8tw6Bw+QZ/uhlkWg1vZOEFUtTo0aYjOULqj4aeb2DWXO
	MWPv5ex21JoyPJBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 27FAE139F5;
	Wed, 31 Jan 2024 08:51:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nwxMCAsKumWDHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 03/12] nvmet-fc: release reference on target port
Date: Wed, 31 Jan 2024 09:51:03 +0100
Message-ID: <20240131085112.21668-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.88)[99.49%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_085129_526272_3AAD2CF5 
X-CRM114-Status: GOOD (  11.39  )
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

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 05e6a755b330..3d53d9dc1099 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -360,7 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -373,6 +373,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


