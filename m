Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE49C48BF8
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=; b=ICneMOtNfsincIqJixrWb/Vw5U
	Bz1kYmTcle4cTXzW3WE8IQvYQrGOAWkmA8a6ZmGG6FptZhlgG5Z2bNCWd+i7p4XhYVZwGOSwfSje9
	v9ISadaf0cabTdPsxneic0dXg4MLHnhXlmhU3JMOTNWSS7IV7H1l4W/ijuOlSMjfVbjaLsDSVgTxa
	66FAvcUe2c7L3vvKkAwwQWAxy2vH6nMKCSr9vQiir/G3mstJNVPbYbkUr258PoBXAqwRVCrmjbCsO
	BToMKN2jNrHnDvWEFOBOXen1P1SfABNcpibMoaZcNiGdYPhtb/L2mtzArWNgXuKctrXDnBPE3o7j6
	fO39/NJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3Ut-0000000AaZX-1SHF;
	Mon, 19 Feb 2024 13:15:51 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3Ug-0000000AaQF-1Jer
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 13:15:48 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4F6821DFE;
	Mon, 19 Feb 2024 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=kzt+TfDd+mTxaKPIR4JctUKJ1SM0uYHfXf+NS0zGCSq3lNHzZjsgR45NTXK5cNCszeCrx+
	guaHX13M+cEQ5PVjhTOAZWqkp/0+yJC4KSb4PYhKsv8v1n+A46khadcGV79dTQFyaE0UND
	S8IDavU/CyYBZCdYLxG16JKiYSVkwks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=INNiLbdHKwwai1Gct2MY4SrphrL9jLL4RMpMXfcFGKpIbXqxHs13qsdZevL/Bg+s/lgoRN
	6cFxBIP4Xy7OCFCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708348534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=kUWL2YXTD0jMuBNMposXQcCjyF27PjwK3GUpnhi1vqgZMd3wqpUFsm5BKhwDwdT+2ooeN3
	29hCLbg/sR0Xkqtx/ft1+xTHbbkBC5S/4ynMX31zRhAnMWZykutBiHiqXKuclcJlLIxoxZ
	5ubKLc2DQ1kk5WFHH0N2IcN8ArukD2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708348534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PXfoi+WQ6MgXGzIpaS791WKCBDb96vUjuq/mUEJiuJE=;
	b=v3b1YmU9Shky4lBX1wnH+Dlo5oLpt5pRtZ8QAvlu3tMDES/Dq4czEOe9lGMrnIyja93Nj5
	u8c/dS9DdlM7wwDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C0E86139C6;
	Mon, 19 Feb 2024 13:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6kerLXZU02X7AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 19 Feb 2024 13:15:34 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v1 2/6] nvme-fc: rename free_ctrl callback to match name pattern
Date: Mon, 19 Feb 2024 14:15:27 +0100
Message-ID: <20240219131531.15134-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240219131531.15134-1-dwagner@suse.de>
References: <20240219131531.15134-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.53 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.17)[70.04%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_051538_536793_FB519D02 
X-CRM114-Status: GOOD (  13.14  )
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

Rename nvme_fc_nvme_ctrl_freed to nvme_fc_free_ctrl to match the name
pattern for the callback.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 68a5d971657b..a5b29e9ad342 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2428,7 +2428,7 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
  * controller. Called after last nvme_put_ctrl() call
  */
 static void
-nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
+nvme_fc_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
@@ -3384,7 +3384,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
+	.free_ctrl		= nvme_fc_free_ctrl,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
-- 
2.43.1


