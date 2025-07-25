Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47571C87FCE
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Jul 2025 14:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hTdICirCVpjMlU/Re7SU/QR4vDS2cFYLSqelDyqCI3M=; b=osyvjy/98rzo6WKP2eOFlSVU6f
	VUzMBVmSLNiGkD54jC+sgmCh2HsQGp2t0vseeuEPVVmk+0whmZ9Mhe8vu0w5yGQtPjXuf1kqndUff
	QonQcCBg06S9ClV1FVJnqc2PQWSs7VNZdpfsemkcZsx71L+BAJB0YOSClcpOHz7/CbRMhTUVOEcsx
	EWLNaMCmDKAjTk3O/bZyalepk6zO4n4WMCs6hgfFT7BVgdwlnuu0lzDccRPoYM0L7dUooY1/gWycI
	kDvGIv5E/fyCvTHO3g0kmHEfOq3RuqbrD5PaLlb1yXXEecTXSD97CxG79YuzfHvjLRRnWX7SSCEnM
	5fjyAAyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufJYB-0000000A1Kk-1ZMG;
	Fri, 25 Jul 2025 14:37:31 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufJY5-0000000A1Ji-0wbp
	for linux-nvme@lists.infradead.org;
	Fri, 25 Jul 2025 14:37:26 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5447219E3
	for <linux-nvme@lists.infradead.org>; Fri, 25 Jul 2025 14:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753454242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hTdICirCVpjMlU/Re7SU/QR4vDS2cFYLSqelDyqCI3M=;
	b=xXNQXJz8OXipUDsPQdoB3Zf96/qbeIxMta6WvcndoXhwzfVkYMmR+XQomQDCo+z8JTSOwo
	o1gpnOu4TIgxCVC9Q8sgncz/cwILEE3AZgt1zvDyasrusbF6TGtKHPve+o1p9FBmw2+w/5
	ZiNBTM631cITgUOl8M1/aSTPd9R5El8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753454242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hTdICirCVpjMlU/Re7SU/QR4vDS2cFYLSqelDyqCI3M=;
	b=7JiRZPpxo13ZSQmjufkBDfM3j+J8SVJ05O9rhopgmnFnyWq+jIR6zNsyJuHS7QwEwYSLuh
	qWBatrJBul5pXkDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=khtQZTiE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Eg/MhcLp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753454241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hTdICirCVpjMlU/Re7SU/QR4vDS2cFYLSqelDyqCI3M=;
	b=khtQZTiEZohhUo/bHPxBHAZ87SwN6dSE/dk7lU27eTaMMkyiQeZ+Bhz4R+hnYRS4OtLJ9B
	PvfWJ+Z2TW9eCJLF9mttKs/jdBySJGjJAoRPuCZjOGZOtZY03066s2nG+fpRxI0oMKXU3S
	LV06BHmqsJybaFyF7jjO1hNfQy4NlZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753454241;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=hTdICirCVpjMlU/Re7SU/QR4vDS2cFYLSqelDyqCI3M=;
	b=Eg/MhcLpdmlZfxA9Zn4SuKANsjy+BfuvUNCEG4ExqEqHR11hd2CGCU5o+YPiP0pG6GFkTV
	tKEzWCZIDjFQFJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D434E134E8
	for <linux-nvme@lists.infradead.org>; Fri, 25 Jul 2025 14:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Cn02M6GWg2jmVAAAD6G6ig
	(envelope-from <dwagner@suse.de>)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Jul 2025 14:37:21 +0000
Date: Fri, 25 Jul 2025 16:37:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [ANNOUNCEMENT] nvme-cli v2.15 and libnvme v1.15 release
Message-ID: <63c55546-d408-42c2-ab40-79be51b9aadd@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: E5447219E3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.49 / 50.00];
	BAYES_HAM(-2.98)[99.91%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250725_073725_423031_ED7F0455 
X-CRM114-Status: UNSURE (   7.33  )
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

There are new releases available: nvme-cli v2.15 and libnvme v1.15

Nothing really stands out, so the usual fixes and adding some more of
the spec.

On the testing side, Dennis added some more tests, which increases our
coverage for the command API nicely. The coverage report says, that we
have roughly 96% of the ioctl.h header covered. This will help to catch
errors when we start to touch this file for the v2 API updates.

As usual thanks to everyone who contributed to this release.

