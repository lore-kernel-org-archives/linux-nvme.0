Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B25C5478C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Feb 2024 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=; b=cyLNdPE72uGDu6GH1wFuo9hsBO
	BbjxcmsdZOZCQtbCeKcD629YBKrwYy9mhrjGu68Ow5J3aQLoqorV0NOWJaJFjqceS6KIvhJGrq/hU
	NhxaIWnSl3BiVlI4G+8kcWQjrFdF+OCqCViFfjxXUQ3iPO5VCw5Ip5s+WXeM8sHEMCkNQQ83ZhQTv
	0xHAxtPAdPi3ZU/YyDTlj+9SaF+zMEWlwyM37jwYBeQxp54WqXhOhrtn5+rHKLFvOn97UEnOPXlIa
	XmVDFUB9d0x4hhCp+VM6wepGV7w8yzQbAElaYG8dRbO8M4wnYGaZnpbQ6NLoU6WMIts1QGDJvUVfF
	q0D+vp+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdVxD-00000009eMp-2FEw;
	Fri, 23 Feb 2024 13:51:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdVwo-00000009eJa-09CH
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Feb 2024 13:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=; b=R6A1ocJTfWKIGsPn+inVlf8xZ6
	Z3oxrel0F4O2rl6u+xRCZ8rIZYM73Sg2S2XHaYfGiG78tFXyGuOKnHh0fHsx//Y1/U+Eucl6XvB8H
	YoaQ0UN070EmkYP/BLTDOx1piDptKYJVd+l0TdHR80A8jmtJC7NvzmvXsUaObaa9b6Wudf0C8cE5B
	N7Rp83BXzsHxFo64pI18hV8xr0cgyElTgw7koccR92TsZvuk75sSxP2JGezWvpAXS4jB4W/hSDjzt
	a34n9mzJMIzaeF+qLaxUsz5u8R+JjUJy1WmeP7b1R9nQky77vRHXj1gPMlRcKC/Aj1wKd79kLlckN
	0OoG+3GQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdVwl-00000007EF3-0Fe2
	for linux-nvme@lists.infradead.org;
	Fri, 23 Feb 2024 13:50:40 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58D0A21DE9;
	Fri, 23 Feb 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708696230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=;
	b=TAFF/Rz2YTGDyFdWSOYV2Do5vujYjv5nE52sC7xFwJWFlRFO9Mc0xL4NDX0Uxzol2OGVIv
	qGYwzUGso6L1ya7hGvC6e+GqI9c9kEMYL10r98i159OYb5FHSGrJVvbuOnfP7m/KjIqc2V
	4xSg8c1zX2UQ+Z7PH9MjvBRRQv//SzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708696230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=;
	b=Xia4kIW1TmfodB1MnpV5rEkypwHwo/KzIWhUeKCa+g/yPsicUrQPdPInxZKgcWB4qmWtXS
	KeDdla+gSQyNojCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708696230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=;
	b=TAFF/Rz2YTGDyFdWSOYV2Do5vujYjv5nE52sC7xFwJWFlRFO9Mc0xL4NDX0Uxzol2OGVIv
	qGYwzUGso6L1ya7hGvC6e+GqI9c9kEMYL10r98i159OYb5FHSGrJVvbuOnfP7m/KjIqc2V
	4xSg8c1zX2UQ+Z7PH9MjvBRRQv//SzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708696230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HTB+UK0y+JGJ8VYu1nx21E3QwhrIZQ3uOH9NP52HaAA=;
	b=Xia4kIW1TmfodB1MnpV5rEkypwHwo/KzIWhUeKCa+g/yPsicUrQPdPInxZKgcWB4qmWtXS
	KeDdla+gSQyNojCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4617113776;
	Fri, 23 Feb 2024 13:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id RRJeD6ai2GW9fAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 23 Feb 2024 13:50:30 +0000
Date: Fri, 23 Feb 2024 14:50:29 +0100
From: Daniel Wagner <dwagner@suse.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: authentication error are always non-retryable
Message-ID: <xsiv5zg7yey653srbcob47kvw6ywsmmxspdywjdzdputg6fyvu@btpnuwdywdi4>
References: <20240223105804.44473-1-hare@kernel.org>
 <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7mv5rb3wfpjlttvgycihgn7fxlngrewpdtuhucqhodde6y3m6@nk7hvf4rwzdj>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="TAFF/Rz2";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xia4kIW1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.49)[79.69%]
X-Rspamd-Queue-Id: 58D0A21DE9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_135039_146983_3D887D55 
X-CRM114-Status: GOOD (  10.55  )
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

On Fri, Feb 23, 2024 at 02:29:02PM +0100, Daniel Wagner wrote:
> On Fri, Feb 23, 2024 at 11:58:04AM +0100, hare@kernel.org wrote:
> > From: Hannes Reinecke <hare@suse.de>
> > 
> > Any authentication errors which are generated internally are always
> > non-retryable, so set the DNR bit to ensure they are not retried.
> 
> This still keeps nvme-fc in the retry loop. It fails with -126 which is
> -ENOKEY:
> 
> [ 2267.185691] nvme nvme0: qid 0: no key
> [ 2267.187596] nvme nvme0: qid 0: authentication setup failed
> [ 2267.188866] nvme nvme0: NVME-FC{0}: create_assoc failed, assoc_id 2a3022dff0fe0000 ret -126
> 

nvme_auth_negotiate() returns -ENOKEY. What's the idea to handle
negative return values? I though nvme_fc_reconnect_or_delete() should
stop the retry loop for for negative values too?

