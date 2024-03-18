Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842B0C54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 11:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=; b=3COqgnbzuY5CX9GFS6kuyzUZ38
	WzPw0uZ6PDWKq0bhLKz1IK4UHFlAf8YSa2+lRWJbafvtkTVpdXDaOmR6Llv3CBSIR04QSweWeUM6R
	eQXYne8RsrgIzsfhtnfMR1j89ch73Gi0048MVBOvW5waWlMCHjah2Yhoz1BayeV9kCH0QCnWp6w2I
	L3C79biBMcqytnWaU6bxmQObI0q0JyPIuzazTY9B5ux1zmB1N9NnqwL7ptpzBcTYbBpoZ4MwVdAgN
	ESvJtxN7kqobx+jlhxLLKZ3QTkU0uwAibmUhmOPU4qbu+teCfBsFG50h9f++w6lsfN80ibzfihLOo
	l2HHXB2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmB4G-00000008L2z-2lly;
	Mon, 18 Mar 2024 11:22:12 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmB44-00000008L1G-1RHi
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 11:22:11 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F34055C45E;
	Mon, 18 Mar 2024 11:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710760918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=Olz9khKrXFnF9txCih6MQ95RWJzqLlYSK+ZcOI8SPlZBZLX5etRL4C39D70rV/kIOFnvcx
	/FBuqej3G1EMsxWdnHsQDpb7V46V9NmfOEwHxvT4XE1kJR1WDxaVe+mWApvOHAAp4QEbYe
	JECp8PI1dyEuf/BKrpdkYYvmklfaAss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710760918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=MN9oiW/+FDRFZACWRmG8yJ67lVFwqibh4jCa50abYV0OPESR0+gbmXLiKKu59Luwdbthph
	xWw8IXGEGgyp6iBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710760918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=Olz9khKrXFnF9txCih6MQ95RWJzqLlYSK+ZcOI8SPlZBZLX5etRL4C39D70rV/kIOFnvcx
	/FBuqej3G1EMsxWdnHsQDpb7V46V9NmfOEwHxvT4XE1kJR1WDxaVe+mWApvOHAAp4QEbYe
	JECp8PI1dyEuf/BKrpdkYYvmklfaAss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710760918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xyDiAoO1HQWO4tJreiq3N0r6YS1UZX2dwO6bh5L6qhY=;
	b=MN9oiW/+FDRFZACWRmG8yJ67lVFwqibh4jCa50abYV0OPESR0+gbmXLiKKu59Luwdbthph
	xWw8IXGEGgyp6iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A92061349D;
	Mon, 18 Mar 2024 11:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwTgJ9Uj+GWkdAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 11:21:57 +0000
Date: Mon, 18 Mar 2024 12:21:57 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC blktests v1 00/10] Add support to run against real target
Message-ID: <bve2fx5ywd2efqgakhgtzhyc6tbthfoiqjcsgurdoapv6qisgr@5r4bus3ipqnh>
References: <20240318093856.22307-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
X-Spamd-Result: default: False [5.92 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[0.999];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.97)[86.87%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_042200_568226_0C0B29B6 
X-CRM114-Status: UNSURE (   7.20  )
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

On Mon, Mar 18, 2024 at 10:38:45AM +0100, Daniel Wagner wrote:
> [1] https://lore.kernel.org/linux-nvme/23fhu43orn5yyi6jytsyez3f3d7liocp4cat5gfswtan33m3au@iyxhcwee6wvk/
> [2] https://github.com/hreinecke/nvmetcli/tree/rpc

The series is also available here:

https://github.com/igaw/blktests/commits/ext-hw/

which includes the mentioned Python script. As indicated it's just a WIP:

https://github.com/igaw/blktests/commit/ca1fe59b5ed67198228bcc017cfbbd25b797b868

