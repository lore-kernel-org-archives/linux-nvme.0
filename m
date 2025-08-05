Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC314C87FD1
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Aug 2025 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCCSZms0Za+ctcad/8OEFjdHGC9r5a+9fhCilRpn7GM=; b=XDazOzAYRBew8ouCQipWcVWCCK
	tXD/PLTUNARhvjK5cwN3OAUEG2xolO1UEUYjpRtphsmJfYkXJ2wcHFuwwmo+XOsAQMdUq59hKBUgw
	aW0iWskA2cxJaZznPDKJiUkbWR2d+H2oG70rPfkdC3bMTm3iBleSIJ9kSs7/80cvR6T3Yc2DLDeGJ
	MWcsfokIV6QmLHOu88cQQef+RLlYd9q+IsoTfr8wko9kFkI1UAcb1UM6uJrN+GkBbJ5zuRlOO60kP
	nOkV6Oph87wEjGCHtyIqO248cu14jBJohEeL00EEZznCabn7R4KF7Vv7UkWpjqIhzlpucW3Y9rj+l
	v/9Ff4Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujC6X-0000000C1Q4-48Rk;
	Tue, 05 Aug 2025 07:29:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujC51-0000000C1Jt-18fg
	for linux-nvme@lists.infradead.org;
	Tue, 05 Aug 2025 07:27:28 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 47D40218A2;
	Tue,  5 Aug 2025 07:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754378845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCCSZms0Za+ctcad/8OEFjdHGC9r5a+9fhCilRpn7GM=;
	b=SKnUoHYVIrj1eHyPj/GMByDSbvmCf34UoJuz/cqgK+zt7e4HI30IP3yE0A9WO7AuoIWygx
	+Hxuk/A5VPuTSEZo2UMOUDfGoPlEGPMeeugjk1xtOquBWbuWl8X+5EZzqWIEG092RO2O2z
	i5KCtfNzmhrAHWedFyoG9cb5DXcLmag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754378845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCCSZms0Za+ctcad/8OEFjdHGC9r5a+9fhCilRpn7GM=;
	b=HQGMbt+apASXjj1ziwbJjeqWVhPNs4qQz3ca4lzO0Ejw2x7lEwg2HJgdK3u20AAsscldAw
	Byq/FPOp9Sl1bKBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SKnUoHYV;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HQGMbt+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754378845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCCSZms0Za+ctcad/8OEFjdHGC9r5a+9fhCilRpn7GM=;
	b=SKnUoHYVIrj1eHyPj/GMByDSbvmCf34UoJuz/cqgK+zt7e4HI30IP3yE0A9WO7AuoIWygx
	+Hxuk/A5VPuTSEZo2UMOUDfGoPlEGPMeeugjk1xtOquBWbuWl8X+5EZzqWIEG092RO2O2z
	i5KCtfNzmhrAHWedFyoG9cb5DXcLmag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754378845;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pCCSZms0Za+ctcad/8OEFjdHGC9r5a+9fhCilRpn7GM=;
	b=HQGMbt+apASXjj1ziwbJjeqWVhPNs4qQz3ca4lzO0Ejw2x7lEwg2HJgdK3u20AAsscldAw
	Byq/FPOp9Sl1bKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 352DC13A55;
	Tue,  5 Aug 2025 07:27:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AwG2DF2ykWiZIwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 05 Aug 2025 07:27:25 +0000
Date: Tue, 5 Aug 2025 09:27:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, msmurthy@imap.linux.ibm.com, 
	gjoyce@ibm.com, tbzatek@redhat.com
Subject: Re: [PATCH] nvme-list: fix verbose JSON output for 'nvme list'
 command
Message-ID: <37b53f3c-8654-4a14-8c54-9179e7bf5a5f@flourine.local>
References: <20250721102946.1003295-1-nilay@linux.ibm.com>
 <175336669186.426033.4256373145639280312.b4-ty@kernel.org>
 <cc396386-3924-4198-bc05-e1a3137d59b7@flourine.local>
 <9d5dfce1-4a6c-4b3a-af46-3c3d9ad67e2e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d5dfce1-4a6c-4b3a-af46-3c3d9ad67e2e@linux.ibm.com>
X-Rspamd-Queue-Id: 47D40218A2
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.48 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_002727_486700_9DC21D31 
X-CRM114-Status: GOOD (  11.07  )
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

On Tue, Aug 05, 2025 at 10:00:53AM +0530, Nilay Shroff wrote:
> > https://github.com/linux-nvme/nvme-cli/issues/2886
> 
> Okay so does it make sense to retain the old output with the
> default --output-format-version=1? But then if the user selects
> --output-format-version=2 then we'd switch to the new output 
> format?

Yes, the default output for nvme-cli v2 should be
--output-format-version=1. As suggested by Tomáš we can set default
format version to 2, for the next major nvme-cli release.

Thanks,
Daniel

