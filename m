Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18762606A32C
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M0g5YR8H;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pyqoohjc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BOAYAjE4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZPWv75aj;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tvPePDnC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=; b=M0g5YR8HFjwpC0
	Mrqua/nwkH2Q9jkV1ZJdLDU2NDyJLF6lt+Nlv05aIUWPyA68vYbCm6/WVVDido4El0G5lix8qb69R
	u3myYN1smXtcYKhzTxVQCY7bsSx66TGc8KFi4er2PReqlWmWXPgQRDyYOO4T5UedMbblhks+WXwX4
	0bcf1KzUjGdJAUERf7sSAL+ILsULwxE3+WGFTi7wV8jy9yPaXXuRpnWTJgxfVNAz9TRoiiduJ5QDw
	fE9FX6PZneYb5aybXNGwXTlnQLPq5PD2Yqgq7ubHJgKDqfr/GG7Ig0Pj1mY5Kwpn6hkdgg7quyKI7
	ouKDpKmQjbdOmxDIVauw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6g-000000062Ha-3B94;
	Wed, 04 Nov 2026 16:45:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOe6e-000000062Fu-44Rg
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 16:45:02 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EBB361F45B;
	Wed,  4 Nov 2026 16:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810699; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=pyqoohjccBtq9YUbBbSDn11zd/veNKvy2lkl1cGJD2XUZ1yvafbRNDkuBuK5XJjxE32oID
	OsvlorWeML3s8dTUGgDpy0QgK4cQVcczu3chxUwqoAi/hK7sHOVcK5zIxSRp/nMcujHCMN
	QIeJg0r/0jz4scMl3wecXzmeUighYDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810699;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=BOAYAjE4UmRo8sQAAMM++hArJfiPDqCfH+rIInQjrPO7uX6/0erPg5wnDdQ5hnGJxI82EQ
	1DV+qi2CJ9CLQgAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793810697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=ZPWv75ajykyMIvPDAjValtCErogwitu8mFeRdCg346Y+5KbeOIMAwE6NR4+9teLXR5UJts
	935ktXejRaOiYcCvsODgLTOey5hNcPaI3qo7CRlOSk4SFRtpPRagh+wN+uWPh2F5nzjG9U
	ptsQBpz6Nl3Xe7lbXox+993QIrJcXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793810697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yDDuJEEniFFNN320ZoGrolyDRJHNQrk9l92mg/vdmiw=;
	b=tvPePDnCflZQdXNLHJWS3V267A+ZVTnfsvZsLs7IBgmyH8zwqlr9NRyeVdTD9RDTX6bwzV
	nrnlbo1bfcX4JVCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B25134F0;
	Wed,  4 Nov 2026 16:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bwDxIwlh62pGfQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 16:44:57 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 17:44:40 +0100
Subject: [PATCH blktests 01/10] common/nvme: pass --ctrlkey to the target
 control script
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-target-control-v1-1-b31b40537bb4@suse.de>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,running-tests.md:url]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_084501_281202_A23C20C2 
X-CRM114-Status: GOOD (  10.63  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

_nvmet_target_setup and _nvmet_target_add_ports pass the controller key
to the NVME_TARGET_CONTROL script as --ctrkey. running-tests.md and
contrib/nvme_target_control.py name the option --ctrlkey. The script
rejects --ctrkey, so the setup fails for the tests with a controller
key, nvme/044 and nvme/045.

Pass --ctrlkey.

Fixes: 5b6d89ced118 ("nvme/rc: introduce remote target support")
Fixes: db623ee8039f ("nvme: Add _nvmet_target_add_ports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/nvme | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/nvme b/common/nvme
index ad3d140a8811..a8c7634ec2b8 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1611,7 +1611,7 @@ _nvmet_target_setup() {
 			ARGS+=(--hostkey "${hostkey}")
 		fi
 		if [[ -n "${ctrlkey}" ]]; then
-			ARGS+=(--ctrkey "${ctrlkey}")
+			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
 		"${nvme_target_control}" setup \
@@ -1708,7 +1708,7 @@ _nvmet_target_add_ports() {
 			ARGS+=(--hostkey "${hostkey}")
 		fi
 		if [[ -n "${ctrlkey}" ]]; then
-			ARGS+=(--ctrkey "${ctrlkey}")
+			ARGS+=(--ctrlkey "${ctrlkey}")
 		fi
 
 		"${nvme_target_control}" add-ports \

-- 
2.56.0


