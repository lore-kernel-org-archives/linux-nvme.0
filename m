Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B495C27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36798KKAtsQq5shjSYlwyjx48imMjsBb+8mxaI6X+8c=; b=EGd+dg8i/TLQTu1RSkQjKJHQZq
	ESx+jGOrlk+3i/Iq+qFJxI+nMqT88v/SrS5/Cgw5nkB2KGmlHh5PSLMnBq882OYNruhHSwEgObPaz
	5wE6XI6g6wYnnLqybNHpnEuEC9Ib3/NyX1dnwIXHHeN9QIvxprfIr8I7+MMDMgNIARHwvJXC1NI3P
	i9dcC03AEus+UvOwN7oRlWMSjYuqIL7wxZXY8wD+L2iFWD+GA+3aMc3XRp53tvi2JHOtWahgk/sra
	sQ1eQgLvDhX19SjQ+IfxXjCpwNa0utT5JkMIxlivCeUXDJDud6F7YAdIn52VQ/FVvDxZRPnSL8RWr
	VHua8KTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmh-0000000CNaz-2yML;
	Wed, 12 Jun 2024 11:04:55 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHLmd-0000000CNZC-1mHU
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 11:04:54 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 68627342AE;
	Wed, 12 Jun 2024 11:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36798KKAtsQq5shjSYlwyjx48imMjsBb+8mxaI6X+8c=;
	b=vqzcDz2Snwp8MIbLiKJ7PuQ/ZPVTDwLBgyJpUlvigeMbiqET2P3VGpFmrdYvUlCfDwsUb7
	pnG4+BRx89tWkXxofGgvGAeee+86zk1QPG6oJ/0blDWZGOyBytADIsPHRiWc4apDYpqVi7
	Pu7pPllhtJvLtWzXE+acJdcjaKdxNhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36798KKAtsQq5shjSYlwyjx48imMjsBb+8mxaI6X+8c=;
	b=aAvp3nJLAX4sithDTE7aTsav9c1B5lI59GB19pPMN/H1rO48nJrteFgd6mtVbxdFOaoSBB
	y0utpIp6Ob5oyyBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718190289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36798KKAtsQq5shjSYlwyjx48imMjsBb+8mxaI6X+8c=;
	b=vqzcDz2Snwp8MIbLiKJ7PuQ/ZPVTDwLBgyJpUlvigeMbiqET2P3VGpFmrdYvUlCfDwsUb7
	pnG4+BRx89tWkXxofGgvGAeee+86zk1QPG6oJ/0blDWZGOyBytADIsPHRiWc4apDYpqVi7
	Pu7pPllhtJvLtWzXE+acJdcjaKdxNhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718190289;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=36798KKAtsQq5shjSYlwyjx48imMjsBb+8mxaI6X+8c=;
	b=aAvp3nJLAX4sithDTE7aTsav9c1B5lI59GB19pPMN/H1rO48nJrteFgd6mtVbxdFOaoSBB
	y0utpIp6Ob5oyyBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F30F13AB0;
	Wed, 12 Jun 2024 11:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nyk7F9GAaWaaDQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 12 Jun 2024 11:04:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v2 2/3] nvme/030: only run against kernel soft target
Date: Wed, 12 Jun 2024 13:04:43 +0200
Message-ID: <20240612110444.4507-3-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612110444.4507-1-dwagner@suse.de>
References: <20240612110444.4507-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240612_040451_642555_806FA749 
X-CRM114-Status: GOOD (  13.34  )
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

This tests is exercising the target code and not so much the host side.
The problem with nvme/030 is that it depends on interface to interact
with the target which is not covered by the standard. Thus we can't
run it against a real target. Just skip it when we run against a
real target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/030 | 1 +
 tests/nvme/rc  | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tests/nvme/030 b/tests/nvme/030
index b1ed8bc20908..672487734332 100755
--- a/tests/nvme/030
+++ b/tests/nvme/030
@@ -13,6 +13,7 @@ requires() {
 	_nvme_requires
 	_have_loop
 	_require_nvme_trtype_is_fabrics
+	_require_kernel_target
 }
 
 set_conditions() {
diff --git a/tests/nvme/rc b/tests/nvme/rc
index aaa64453fe16..4a2d107bd532 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -219,6 +219,14 @@ _require_kernel_nvme_fabrics_feature() {
 	return 0
 }
 
+_require_kernel_target() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		SKIP_REASONS+=("Linux kernel soft target not available")
+		return 1;
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.45.2


