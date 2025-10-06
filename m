Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C01CCA471
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=; b=Jt6xvhSNwyZ4qd0viVId6+e65J
	yenyCxvIUakoDlqFoj6Zkrx56TBTWidqPALZ2iRVg5Ls5jQFjQaLlVKqEM0ZEMUqUqk4mDMJAUDD5
	OBoy1CraXkMV7qvWhBb5iAQQWyYieJY+UeiBNkhERxDcloUiUQn7WEi/xnlPXXGHcBXldWs710r5i
	p+xHj6GKNV+CR9BRKT48T+TFK+k5ewiqmbejQV/E3eYcpBL+fEsB/s8cFMz5xH7Jd4KeDeJjZQbs6
	oSBMExlPVXWDdZF7O8Oxl4BfYV54RzR8Osozh8MUJ0CMGPU9BzE7wJ0eg185HDj7pr4s4z6EWbfvb
	mjp84k4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5kMZ-000000001CF-34Za;
	Mon, 06 Oct 2025 12:30:47 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5kMX-000000001Br-18N7
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 12:30:46 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BDC4D336CB;
	Mon,  6 Oct 2025 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=qYELF5GQ/fEzIt6b6U/00fnf8TZ4Am9FPXKWPtwfM2jNyOIHcAiJUmj6vTLEB1sTpsQBS5
	2RVl1SNqRt6kE+l0zwPAzWSBsbK6MVE69gUNxLrnsb80VLa6IUgECnqGq5mV5YFpQj2uiF
	k13SsPzszmzPE07BrK6HwwmEhEmdKz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753842;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=crxqOEWAKQga4pFbqrJrAPtOIrT9lTPYsnddKqsPCPaB2cX/gIIm/zikz36s6JNoBnXr9/
	XlagKGba+KJdj1BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=i9FFLlfw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KLmWKvyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759753840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=i9FFLlfwoi6YO3QSmRJX2BbkmHa/vi/HYrvDb8+80Z6+fo6dHWx6n4FU7Uhhreem7fvng/
	3XwvaEm1BuRvxMTLOfYUlf64xOjxyS2tRqcRPADMzDw76sKu3IO+R3BInbHhr1U1X9kbHV
	lAKIs/EYEmuOfnSzCIp1uhkBW6M9Jys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759753840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DH/E8tdqQkikeQeW9VrxwMtlsxz2Qi0OG9Sx1VZcu7Q=;
	b=KLmWKvyW/TQznlozFKG995pOwzVwtAuHepkeU1dXa1VBokbG36OsFgtyjvepq6mXh9Xf2x
	fI7q0uXX/AqgndBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A451213995;
	Mon,  6 Oct 2025 12:30:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uc4oJ3C242hwdwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 06 Oct 2025 12:30:40 +0000
Date: Mon, 6 Oct 2025 14:30:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktests failures with v6.17 kernel
Message-ID: <6f615e86-d160-41a2-a078-478406e4c749@flourine.local>
References: <3bbujxlhhzxufnihiyhssmknscdcqt7igyvzbhwf3sxdgbruma@kw5cf6u5npan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bbujxlhhzxufnihiyhssmknscdcqt7igyvzbhwf3sxdgbruma@kw5cf6u5npan>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: BDC4D336CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_053045_453710_1F40B51B 
X-CRM114-Status: UNSURE (   8.78  )
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

On Thu, Oct 02, 2025 at 10:35:48AM +0000, Shinichiro Kawasaki wrote:
> #2: nvme/041 (fc transport)
> 
>     The test case nvme/041 fails for fc transport. Refer to the report for the
>     v6.12 kernel [4].
> 
>     [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/

Thanks for reminding me. I'll have to update the nvme-fc-sync series
This should finally allow to pass all tests for the FC transport. 

[1] https://lore.kernel.org/linux-nvme/20250829-nvme-fc-sync-v3-0-d69c87e63aee@kernel.org/

