Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ABAD10399
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjDQUCDfSNZSw5E3w4ipNq9NMmIUXrgot6+TmCmz4hQ=; b=XF08AWzrs/nJ57e4ai0JsC0Mrg
	7c4OWdgxDhtj5lZTQJymcJKIwASs+/oNoQMjpCO1VR5ykZ0e68t8od8nrtv3Ok9LEB5LtIzc5/eWs
	zGk3MlU7GhGoC9ZGU44vB7L8QdLijkOrS4XcazG1IxPqnYg0X6B6egwqA7f7do2G2iBkn075WPPuh
	3nMv3SoFfzzonGGgyZvfIKmLY1yJiGiAsPPJf1TU4tAs5ACFrgSdaXrkaUHT5CjawTLSjHjYE5JUX
	v/a+VnUFwXHDCufUUgVNOaRUp8w1W7VM8cp5NAP+AHb9eRwDWezzvNK+Y7Yb/bcrGTB5lb2uQMt5F
	NocyIN7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4M5Y-00000004D65-13O2;
	Fri, 25 Oct 2024 15:18:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ljv-000000046vP-2F4j
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:56:43 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC0EF21DA2;
	Fri, 25 Oct 2024 14:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729868193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjDQUCDfSNZSw5E3w4ipNq9NMmIUXrgot6+TmCmz4hQ=;
	b=AUMbE+cZTZd/7SFaHXVJOkluodGZaNQJo/dmgIVizdzVeA/PghdngJpSweSWcffCgduopm
	DfxqVxFe6pMfAsaF/VxuQmA28nLezZaaAkreHWj+5AfoXySDoWS5hHt9LM0gnLIMFYRZz2
	ZY+9u2xYhBRIqXKmx9DI30pnySeBusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729868193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjDQUCDfSNZSw5E3w4ipNq9NMmIUXrgot6+TmCmz4hQ=;
	b=ZvzNDF0fUR1YRi9Jyk5gOmahqeSZUEiQAh8rQ8m6q3+eyJa3CvA9sQoBbrBjEnX4kpbJMd
	DIWU4+/kk0EOCxAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729868193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjDQUCDfSNZSw5E3w4ipNq9NMmIUXrgot6+TmCmz4hQ=;
	b=AUMbE+cZTZd/7SFaHXVJOkluodGZaNQJo/dmgIVizdzVeA/PghdngJpSweSWcffCgduopm
	DfxqVxFe6pMfAsaF/VxuQmA28nLezZaaAkreHWj+5AfoXySDoWS5hHt9LM0gnLIMFYRZz2
	ZY+9u2xYhBRIqXKmx9DI30pnySeBusA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729868193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjDQUCDfSNZSw5E3w4ipNq9NMmIUXrgot6+TmCmz4hQ=;
	b=ZvzNDF0fUR1YRi9Jyk5gOmahqeSZUEiQAh8rQ8m6q3+eyJa3CvA9sQoBbrBjEnX4kpbJMd
	DIWU4+/kk0EOCxAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B933C136F5;
	Fri, 25 Oct 2024 14:56:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ZPnKqGxG2fRZAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:56:33 +0000
Date: Fri, 25 Oct 2024 16:56:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 12/15] nvme: remove "local -n" from
 _get_nvmet_ports()
Message-ID: <7b1faf69-fb1a-42c2-8629-90d00de86b8e@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-13-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-13-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-2.99)[99.93%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_075635_757314_5EEAF8FB 
X-CRM114-Status: UNSURE (   9.46  )
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

On Thu, Oct 24, 2024 at 10:00:22AM GMT, Shin'ichiro Kawasaki wrote:
> The -n option of the bash local variable declaration means that the
> variable is used as nameref. However, this nameref feature was
> introduced to bash at its version 4.3. On the other hand, blktests
> requires bash version 4.2. To not rely on the bash version 4.3, replace
> the nameref feature with the "read -ra" command to parse arguments.

I'd rather update the min requirement here. bash 4.3 was released 10
years ago.

