Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D6DC25B74
	for <linux-nvme@archiver.kernel.org>; Mon, 27 May 2024 05:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9uVWIm8cmChr25lUdgDPGz4q0C4E7/zMloh9qd69ev8=; b=wCbrZM3+8LkVNFFN4mZlz/vrIH
	fIJQLv4ImxlyJyXT7KWxtfr9T4FEnx2lpE6ho0765IChBKvNyK3zIDVAo26Oqw8K2XEfywffrbaM5
	0OioHsdhV2AD/NaKBXk4/lgXkHXEqJhxZZuAJajRN77gmQk9uFe/c7huq1yF8weCSWavbRB7PMbzg
	j0zSQaGBap/+tu7iXlViYT1X3x91gQn10qdRJJGlEt7gqlaNNdzfvkAuSMD49poH41QlU48WYtv0Q
	SOLgl2vW8nSztTsvwnIXr2mPxA45T8b8gS3El+uvyLHf9C1EQgtayPBBBkDq/phY3UgmcBRAFZXnF
	sz1IhpEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSiK-0000000Dob6-3yYy;
	Mon, 27 May 2024 05:16:04 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBSi8-0000000DoV1-2wKJ
	for linux-nvme@lists.infradead.org;
	Mon, 27 May 2024 05:16:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E55A621C4B;
	Mon, 27 May 2024 05:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uVWIm8cmChr25lUdgDPGz4q0C4E7/zMloh9qd69ev8=;
	b=hP2OscSY6Bj/qG7D+x1FKsCCK1dFs1aG0KIJG0cVeO03GypRMErXHfgivYh99/E04Q5+12
	nD2oAYI6rDwSyqtl5cprPV8hajVdOHy7MNCpzcNqTc4Nozmd9B4gd7fRo0mVWADpi7YTIC
	xbqKmvcxI7jrXz7CyCiQl9pHCszI5wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uVWIm8cmChr25lUdgDPGz4q0C4E7/zMloh9qd69ev8=;
	b=CzxmNGJJj02YsjOlcYMAo3e2LRde+rEYDq/aTkQrkiLRB41B8DOB7OsLVvLvVZ81ZXs+Ap
	MXxd5wetZ7ZN65Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716786945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uVWIm8cmChr25lUdgDPGz4q0C4E7/zMloh9qd69ev8=;
	b=tqWedguwFCi1WXb8E7uRlDj+fbgbufYpHJJo+CZ+K9R5PvumQ+peWYqIduX2HIB2E35nIT
	z/9pWW1mThOpmvXEIT1ZXAPgYHBhqqGU6HGa2GosEb1GfPMGi0Ayu+kJu/p4i/W7CCxVC1
	kIuLCK860OMoIX3Ak77WEOEeKfChLAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716786945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9uVWIm8cmChr25lUdgDPGz4q0C4E7/zMloh9qd69ev8=;
	b=muuvCfq/N16styL/vDKmiKcUlizNhrU6DLPiIhfgq0eqT0XAMLXwEyX+WgJhDArpEvzMeh
	sR3QIAzzf6/zmkDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D282613A6B;
	Mon, 27 May 2024 05:15:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zEjAMQEXVGbPYgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 27 May 2024 05:15:45 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 7/7] lpfc_nvmet: implement 'host_traddr'
Date: Mon, 27 May 2024 07:15:25 +0200
Message-ID: <20240527051525.762-8-dwagner@suse.de>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527051525.762-1-dwagner@suse.de>
References: <20240527051525.762-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240526_221552_916660_39C3546B 
X-CRM114-Status: GOOD (  11.12  )
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

From: Hannes Reinecke <hare@kernel.org>

Implement the 'host_traddr' callback to display the host transport
address for nvmet debugfs.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/lpfc/lpfc_nvmet.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 561ced5503c6..4dc044850fa3 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -1363,6 +1363,16 @@ lpfc_nvmet_ls_abort(struct nvmet_fc_target_port *targetport,
 		atomic_inc(&lpfc_nvmet->xmt_ls_abort);
 }
 
+static int
+lpfc_nvmet_host_traddr(void *hosthandle, u64 *wwnn, u64 *wwpn)
+{
+	struct lpfc_nodelist *ndlp = hosthandle;
+
+	*wwnn = wwn_to_u64(ndlp->nlp_nodename.u.wwn);
+	*wwpn = wwn_to_u64(ndlp->nlp_portname.u.wwn);
+	return 0;
+}
+
 static void
 lpfc_nvmet_host_release(void *hosthandle)
 {
@@ -1413,6 +1423,7 @@ static struct nvmet_fc_target_template lpfc_tgttemplate = {
 	.ls_req         = lpfc_nvmet_ls_req,
 	.ls_abort       = lpfc_nvmet_ls_abort,
 	.host_release   = lpfc_nvmet_host_release,
+	.host_traddr    = lpfc_nvmet_host_traddr,
 
 	.max_hw_queues  = 1,
 	.max_sgl_segments = LPFC_NVMET_DEFAULT_SEGS,
-- 
2.45.1


