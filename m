Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D3AFC3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 07:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eKXJR8k+3Car53CGn3lLqr06m/48/cMMlI5ylJMduok=; b=epdqyOK0QE+Q7K/N6xwtXaLMM+
	CpDbPOJuPsvlF+IoeEeQqscWR5zY5OciQ3BXHaz4s8aeFAeyzkfWZV/ZkrMu3FbhsA3BBlQ2OlFpJ
	SHudJOCdPr6+90A9em4S+GRmXAhiTBOq4s9dqaPUCZfusFG/t0+7CpPxrzVYCnMXKPLfnWwm1Sfh8
	GbzmCMVkypMwxvI6RdN5CZawRwoQmBgI2YKyvG4ubdqC9foVP72ys7lWY3yLacIPktGTbXtKaEHrg
	BhL3GD55MKW2gCI2qZ7WAW/GQGIBeLvrsq/uWQQot0PIGxda8AniXLtB47RHHLLcNiqHVCYM0yoTU
	3vN5vGQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHH7W-0000000BoXU-0IIL;
	Tue, 20 May 2025 07:10:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHH7O-0000000BoWr-1Vw5
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 07:10:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E39222A43;
	Tue, 20 May 2025 07:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747725028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXJR8k+3Car53CGn3lLqr06m/48/cMMlI5ylJMduok=;
	b=An2GG0GFz6r1RzlXtPENZFORWPRjy2DDTXrwrFFxvAlROnL5MzKE4cB7dfcy32U6mSuD57
	q+/z0iZTdIseiElRc8ThOR7F0INpT2licQWtZArNVHgo+O/Qq9vjc8+cKOfNMmJPzmY510
	s2y5Daj30Bg6/Yp6MX3bpJBTS/WM85A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747725028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXJR8k+3Car53CGn3lLqr06m/48/cMMlI5ylJMduok=;
	b=lb1ERZSNjdBOPCgqsDQKtZvFkfHOl/hceKXg/9byiLJjefE2YdYUEDrVFeVO9HtOHYPnjz
	4cILaatzFRgOgfAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=An2GG0GF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lb1ERZSN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747725028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXJR8k+3Car53CGn3lLqr06m/48/cMMlI5ylJMduok=;
	b=An2GG0GFz6r1RzlXtPENZFORWPRjy2DDTXrwrFFxvAlROnL5MzKE4cB7dfcy32U6mSuD57
	q+/z0iZTdIseiElRc8ThOR7F0INpT2licQWtZArNVHgo+O/Qq9vjc8+cKOfNMmJPzmY510
	s2y5Daj30Bg6/Yp6MX3bpJBTS/WM85A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747725028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eKXJR8k+3Car53CGn3lLqr06m/48/cMMlI5ylJMduok=;
	b=lb1ERZSNjdBOPCgqsDQKtZvFkfHOl/hceKXg/9byiLJjefE2YdYUEDrVFeVO9HtOHYPnjz
	4cILaatzFRgOgfAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8713C13A3E;
	Tue, 20 May 2025 07:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RkA9IOQqLGijNAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 20 May 2025 07:10:28 +0000
Date: Tue, 20 May 2025 09:10:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 0/2] nvme: check that nvme-cli supports json
 output format
Message-ID: <f492f067-de58-44d5-9cec-92d38bdca078@flourine.local>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.25 / 50.00];
	BAYES_HAM(-2.74)[98.85%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9E39222A43
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_001030_547260_6745A3EF 
X-CRM114-Status: UNSURE (   6.61  )
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

Looks good to me.

For both patches:

Reviewed-by: Daniel Wagner <dwagner@suse.de>

