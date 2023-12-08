Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F86C4167B
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AimtgHiWxG4WvThVidivHgn3J+Odu4Y5GG7/q/YBLXg=; b=04IcCNQtF+KYoe7Jgi+EbHnijZ
	r6nhSoXNX4yqtHoeXnpPM8j9fa0UZC2d7XL+6VtSq9xs4vcRjpE6k+89t05spQ7d9/FBiyYTaqMMr
	4Z7mcaW3AVtu9lXbgcXvPRhF+7kYuXcXxMx2+3P3FTsuhGVApnx7Yx482O84u1IdtUSpgaDXxV/9y
	WJKavtMA2+RclJO73Phg3E+lHvedas05HcQuLo4HeR5/2RpAHnJHU4BQ1z8YOwKxUX7NplINRvn4Q
	OjQK98yQmqgznG6j2c3ANZWBpNpj+ctoxlMDaxqx4pD6ahMSBMDgj9B0ttQOj/nguI/9As2A4RUN2
	y+U6QGGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBcsW-00FuAq-2g;
	Fri, 08 Dec 2023 15:35:00 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBcsT-00Fu96-33
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 15:34:59 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5EC121F451;
	Fri,  8 Dec 2023 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702049695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AimtgHiWxG4WvThVidivHgn3J+Odu4Y5GG7/q/YBLXg=;
	b=Yj5xtYFQGsQVDOTFDv4AFWPGUjjWS0zBrAcZpX6szqM4htp3snUbD450jqsCvz5PrmNYHD
	UMdiYck9UNJx4GXomweOPTrJk1L3xPMuqyw+LJUiNyuET7Tx/NKQEiNaJPc9bTGAminJ1/
	r+aH5vQM/wFF7lbbtw0/e2F1lZnwYF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702049695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AimtgHiWxG4WvThVidivHgn3J+Odu4Y5GG7/q/YBLXg=;
	b=+vRLhhsIZNEzeDc9d9PARmc+OQIM4DJ/n5fvzdpHUnUkw80+EoQ6nmQQzadYBCaJbW7HQP
	METD99IeCa7dQEBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702049695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AimtgHiWxG4WvThVidivHgn3J+Odu4Y5GG7/q/YBLXg=;
	b=Yj5xtYFQGsQVDOTFDv4AFWPGUjjWS0zBrAcZpX6szqM4htp3snUbD450jqsCvz5PrmNYHD
	UMdiYck9UNJx4GXomweOPTrJk1L3xPMuqyw+LJUiNyuET7Tx/NKQEiNaJPc9bTGAminJ1/
	r+aH5vQM/wFF7lbbtw0/e2F1lZnwYF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702049695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AimtgHiWxG4WvThVidivHgn3J+Odu4Y5GG7/q/YBLXg=;
	b=+vRLhhsIZNEzeDc9d9PARmc+OQIM4DJ/n5fvzdpHUnUkw80+EoQ6nmQQzadYBCaJbW7HQP
	METD99IeCa7dQEBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 484F713A6B;
	Fri,  8 Dec 2023 15:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xyRgEJ83c2WzJQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 15:34:55 +0000
Date: Fri, 8 Dec 2023 16:34:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <ezyvgpuyky7nmahnmvsra2pm6vjhxyn7svvlwtp2kxdl67efpo@5vr7t3i5b5wd>
References: <20230908065717.92207-1-hare@suse.de>
 <70d9fb1e-07f8-d130-4308-f279c36ddc24@grimberg.me>
 <dd985619-7486-4ef7-9904-36e1d056767b@suse.de>
 <44f7eb6a-2dd5-b487-afeb-88b7e64d8a12@grimberg.me>
 <31a44658-4a3a-43db-a99c-451c655dfb4a@suse.de>
 <ef031aaa-e89f-4a66-b85b-28515db0800e@grimberg.me>
 <3095351b-f163-4b4c-8f37-145bab624a68@suse.de>
 <f5e70144-b6e3-4584-b2da-8ba3f783a4a8@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e70144-b6e3-4584-b2da-8ba3f783a4a8@grimberg.me>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.41 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.991];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.61)[81.92%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_073458_295345_2B7CF9DE 
X-CRM114-Status: GOOD (  12.13  )
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

On Mon, Dec 04, 2023 at 01:58:47PM +0200, Sagi Grimberg wrote:
 > Sadly, no. Everyone said "Yeah, good idea, but let's wait for the
> > others." I _dearly_ would love to have it as it will simplify the
> > logic in nvme-cli/libnvme drastically.
> > Shall I repost?
> 
> Yes, and I personally don't mind having it, so if no one voices
> any concern, I don't see why we should prevent it.

I'd like to get the sysfs link too, so no concerns from my side.

