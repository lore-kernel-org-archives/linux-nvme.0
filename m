Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E8C48260
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=; b=1B+xI+uc+pMW4d8iFTquMSnQzL
	++VYe1OXsJbO5ta5WrZkX1+3M/8IZVm6pTOStDMNmapK8nOe96hHpCl9rhnjX8seWi5xfpRH8sfBs
	sabbIZ3s0ZAWhrGKvDOPs5luIY9mFedM3FSA/HwqhgKustYcC9nNdhl2xv63Wgb3KTRKo85kTWKhO
	y2I2141fuY/znygUXKrqDFC3rArGeKYVWT+FYGN1KbMKpYdmgLtPT3sahdnVRKOPKJG3I1P5vv+BA
	os+KIulQvFu8QdFUPBkgFepcL1FzDGOgVcQgV//4ctt9GhegCczIkVUfJ9YA77du3TbB4SSgIQM1i
	XFVYrw8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ratqv-00000001ZSB-2qts;
	Fri, 16 Feb 2024 08:45:49 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ratqq-00000001ZON-1Wd6
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 08:45:47 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABAB2220C9;
	Fri, 16 Feb 2024 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=oGmZ/pgLPXXIqg5PJg5IICrS7lcXzZPrhgF5ZZaDAzecPsx3bHJimDJRZgkz14T4Z+YjjO
	qefg6v+g+wi72ALfCB+zcdcmMWgO7hYw85jR5iE/8FSlL044yNAzLRoyK+SJnOFVmu6hXS
	TEO9P5XgQeR/9NAnSRYHfg7sDuT4jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=PlBPCkFLZgBA+CGTDdAI4ZNYR2Nb2hvshPJQpjW0R+WpsDX9WSBTKtpt+EhlSxjHrq8eIv
	NMjX1osvgsJT0SDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=oGmZ/pgLPXXIqg5PJg5IICrS7lcXzZPrhgF5ZZaDAzecPsx3bHJimDJRZgkz14T4Z+YjjO
	qefg6v+g+wi72ALfCB+zcdcmMWgO7hYw85jR5iE/8FSlL044yNAzLRoyK+SJnOFVmu6hXS
	TEO9P5XgQeR/9NAnSRYHfg7sDuT4jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=PlBPCkFLZgBA+CGTDdAI4ZNYR2Nb2hvshPJQpjW0R+WpsDX9WSBTKtpt+EhlSxjHrq8eIv
	NMjX1osvgsJT0SDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 999BB13343;
	Fri, 16 Feb 2024 08:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fGwHJLQgz2WccwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 3/6] nvme-fc: do not retry when auth fails or connection is refused
Date: Fri, 16 Feb 2024 09:45:23 +0100
Message-ID: <20240216084526.14133-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.45 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.45)[78.89%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_004544_600191_6493C88D 
X-CRM114-Status: GOOD (  11.57  )
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

The is no point in retrying to connect if the authentication fails.

Connection refused is also issued from the authentication path, thus
also do not retry.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a5b29e9ad342..b81046c9f171 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 			ctrl->cnum, status);
 		if (status > 0 && (status & NVME_SC_DNR))
 			recon = false;
+		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
+			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
-- 
2.43.0


