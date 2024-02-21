Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939EBC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 13:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=; b=RRJKwGd2mmHKAB+dpoYBqTQvI/
	gXlR3U7LxJ8EPG/+ywCB4jxWwN7AEpy9ncmqPCph2qTWvpR6je1nPekL2HxMnwO16zID91BMDlNSb
	F2RzGFZYEyYuLUCfyZwiAwm6IRYPgQstv/Hsh4E5EFvpaO/Fcpt298MlMXt5UGo4YEZsecvpuUlvC
	XpgeOr9z/SPMq2JE4GHW3rg2cXbFVNUdoQ356m2+jB/WuS8Faf+8KOadflDTN4f+5VJlx74UG8hTg
	JlA0F7UIOwgBhIUZ2AACdJu6O0956jLTAJ2zCvl9wYY596eJNY4Al71bFg1sZ0XWwCGMupuanFWKp
	8XsY6PBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcmaI-000000011Oq-00A8;
	Wed, 21 Feb 2024 13:24:26 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcma7-000000011KP-2l6y
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 13:24:21 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAFE61FB61;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=w5Fx9Fz5qYRbrm7sF5DA/BeiBibRfI4JepUlrYc+xzdPzhB0BHL8mb3VWdQ0Ub/QwXu+IJ
	SPe2/wHblk44TlusZdYDevbcGJy+k4V1/UHQDV/Qn3qmzw/++5QoQNvN6w982l32N8FLaV
	hnhesFx7jmXt8uRXD/gd1v/zNiqzVoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521854;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=wikyw4A4sNr+V/eA2NM9fo0ArKcCRREKSH+JmyCDqUacibWJ0xpJ3LARycW60zFzmEGvl5
	Gd59FOqncoKYD8AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=Oldx6DBUt1bx2wzCuiBkGHXJ1WMBORMOA/Vq+yBMwicQthLQmi+ss4iqLb9oTfDqp9x9O6
	lcYjV2nTVeC8jE5OvB62o+8z+y7XVC0Tb45Kg3AicJzLt7eggfsgdxExs/zcWmkuJgpBe3
	Wf2lZHc/VvWr5OpWUF5r1O9UGxuuOcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zU7+H6imK6PdglzKKo++O8AYMoRco75nFqgEhuv3i/Y=;
	b=HNlrwYsn0sBlrkqQLpdXSPXPq9uk48zyG3xZJyPqMU7It49GBfZpo0TpBdG83X+s+XJddZ
	uYoTzx26bZxm41AA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A589113A42;
	Wed, 21 Feb 2024 13:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xjDoJn351WUXPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:13 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/5] nvme-fc: do not retry when auth fails or connection is refused
Date: Wed, 21 Feb 2024 14:24:01 +0100
Message-ID: <20240221132404.6311-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
References: <20240221132404.6311-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Oldx6DBU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HNlrwYsn
X-Spamd-Result: default: False [3.05 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.64)[92.74%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BAFE61FB61
X-Spamd-Bar: +++
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_052415_898061_26E1D119 
X-CRM114-Status: GOOD (  12.51  )
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

There is no point in retrying to connect if the authentication fails.

Connection refused is also issued from the authentication path, thus
also do not retry.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
2.43.1


