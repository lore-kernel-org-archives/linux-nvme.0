Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C228FCD1292
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=; b=Tvp8dCyB45dNeF7LIx6i8ouhEF
	+U3uRWSFODlsaP8JnTGCA6pdIPOpMRri+22yEHKzvpmTLCyrZCImDaxrClWBw+dfrSb5HmVA124me
	fXfXyR8FwHkIcvqLE3W+xr8+g1wxsU8Ckfowq57m/QLVJfmX4yM00RToUw5jdXSQhjn8B6tSdDaEn
	zGdAAIU2z8I5dkvSPyPfD0qHxrcsUnXQsaGKUKDlBLtTjHxST32ggU+aoVB1I5K4/6EHhhHqKGNjB
	FbPiDS04kPKw/S9sWWHv4X3UXhPvrAUtm9mIuYsLgTK+f1m/yNaDurJ2kVdUOKVpPJnolozJUtkXY
	uXrnnOog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHl-000000034lG-1aOV;
	Thu, 04 Apr 2024 14:41:49 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsOHe-000000034ih-21i5
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 14:41:46 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 784B15F806;
	Thu,  4 Apr 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=w67yvzg/Al/UeZ+5cLx0lHEij9NqcqbAZJVJpk9FEyNJX2o5wvQXjGzyZ2iiB3M3ZmvMfB
	YhG8ZdPSvqovq7nnnMfr9R4CfXvv1q5sEfj1Qj6LZ90ZY1WPh3SqyOwA3yO35hUiiM5BMR
	LXDcmShOB7qJ8FWdC/paGFdhTA1M0qI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=RNMzBZ72F6SkqmP7dEjSNzL0W2/G1/LvzkJ2VXFoo+qXepA6J/8jRKrZC1o8VKE4oiQHf7
	/jBL8CRg+r3FIPBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712241698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=vEOy8XuQKn4mMQ6MLsiOyElEX9NBfJz5PsQohHNLHgIEdCZuCzz55LcFzGMteP1Wq7pBG7
	TsQTOTNdaSXvprbcDsHErG8Rb5K2HGHCGe4PwNKsiCHPeJFhqzuPVQ/LtpWyHDeAR4j+sP
	y0GO/n0KFid9jy2xIMjKCu49655QIc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712241698;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZgEGK5+/nKmeqwHJu6h5IZvHCp+x7Kdn5a20nBLm2rQ=;
	b=vSijkvP5ap3vymxsQg0aH+sT+fj/RexiPB4AjIrXN2c4adR2kyPq3Vn2ENkuCClOz/dDhu
	GfHhdNJ/vjVRDdAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 66CFE13298;
	Thu,  4 Apr 2024 14:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XIamFyK8DmZxDQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 14:41:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/2] nvme-fc: rename free_ctrl callback to match name pattern
Date: Thu,  4 Apr 2024 16:41:31 +0200
Message-ID: <20240404144131.17988-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404144131.17988-1-dwagner@suse.de>
References: <20240404144131.17988-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.17 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.37)[76.88%];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_074142_705665_4F188E01 
X-CRM114-Status: GOOD (  13.40  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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
2.44.0


