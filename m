Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5BAD767E3
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+UwZJM+PF1dFhVxt4T2P/IDwmPNoczxONAJngjChUpQ=; b=blXv4d1dOk5Y4iVD/ODlosViOo
	SdRcEOi+LIL2YrLpQ5K3HNueKP4LXpTL9WHJx49Gv+4QmU+AihThvOjpn73C8OvAE4vtrOEgXfTVR
	JXbZ6Xz3pX918FafIAaNziuYW1WOGsIeawOoP0s2BKzq1YS6yzbTsG2icm/zd0WsKRbWdn4+Ku5YW
	Q+FFjwOxnqytmt5qgzqvHDbKzygopvAA1PehgzZyMXZK1H4wOhpMSfm1+7h59tMzhIECD6lSUocvY
	CQMp/gPXofrGOT/P5JaPogklODldqSnp5rt2J4Olm2V54Fb7GE59E0FsHyJ1i5DOws/jL7F1UG+S+
	HBBnUaKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6YDR-00000004DMM-31WC;
	Thu, 31 Oct 2024 16:40:09 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Y3t-00000004BqH-2f1b
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 16:30:20 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3E8F21D0D;
	Thu, 31 Oct 2024 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730392215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+UwZJM+PF1dFhVxt4T2P/IDwmPNoczxONAJngjChUpQ=;
	b=fZf+fijs6EzzVCwW5LoQsCvMo4CJxRsM0AYhq4On0k5mGzMma5R5etlnASfC2kJG6xp3Ai
	DdRh9ajfCACumViMSgR0Se3IYS2eXwoqe8ZjA9VsywrHl7miv5zOywPG0X+h1c9zvIlCvT
	/CfAy7qnXjPfio5Q81I0bePn7l55opA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730392215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+UwZJM+PF1dFhVxt4T2P/IDwmPNoczxONAJngjChUpQ=;
	b=8TF/hKu4R4mWojacN/BVONT807ULm8AMMj5GTf66BhADmUhrb5S8SDzgC2YmUsclQdt4Uz
	I3qQREkQBa2GitAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fZf+fijs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8TF/hKu4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730392215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+UwZJM+PF1dFhVxt4T2P/IDwmPNoczxONAJngjChUpQ=;
	b=fZf+fijs6EzzVCwW5LoQsCvMo4CJxRsM0AYhq4On0k5mGzMma5R5etlnASfC2kJG6xp3Ai
	DdRh9ajfCACumViMSgR0Se3IYS2eXwoqe8ZjA9VsywrHl7miv5zOywPG0X+h1c9zvIlCvT
	/CfAy7qnXjPfio5Q81I0bePn7l55opA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730392215;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=+UwZJM+PF1dFhVxt4T2P/IDwmPNoczxONAJngjChUpQ=;
	b=8TF/hKu4R4mWojacN/BVONT807ULm8AMMj5GTf66BhADmUhrb5S8SDzgC2YmUsclQdt4Uz
	I3qQREkQBa2GitAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B81B13A53;
	Thu, 31 Oct 2024 16:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G5uQI5ewI2cDNgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 31 Oct 2024 16:30:15 +0000
Date: Thu, 31 Oct 2024 17:30:14 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: [ANNOUNCE] nvme-cli v2.11 and libnvme v1.11 release
Message-ID: <8693d754-5335-4afc-a91f-28e4cd5e947f@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: B3E8F21D0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,flourine.local:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_093017_847183_648C089F 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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

New release for nvme-cli and libnvme available.

Dennis Maisenbacher spend a lot (and I mean a lot) of time getting a CI
setup running for nvme-cli. The new nightly build jobs run the in Python
written tests living in tests directory. These tests were dormant for a
while because these tests really interact with hardware and blindly
write on the disc. You don't want to run these on your desktop, do you?

Anyway these new nightly CI runs update the kernel to the latest Linus'
upstream master branch and then run following tests:

        nvme_attach_detach_ns_test
        nvme_compare_test
        nvme_copy_test
        nvme_create_max_ns_test
        nvme_ctrl_reset_test
        nvme_dsm_test
        nvme_error_log_test
        nvme_flush_test
        nvme_format_test
        nvme_fw_log_test
        nvme_get_features_test
        nvme_get_lba_status_test
        nvme_id_ctrl_test
        nvme_id_ns_test
        nvme_lba_status_log_test
        nvme_read_write_test
        nvme_smart_log_test
        nvme_verify_test
        nvme_writeuncor_test
        nvme_writezeros_test

There are the usual small updates left and right. Nothing really
outstanding, so just an maintenance update.

Thanks everyone who contributed to this release!

Cheers,
Daniel

