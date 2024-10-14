Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB58CFC501
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Oct 2024 07:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rj916A9VBInZQGD+K92CdYK78ZmjccoxTWDhMq8dyk=; b=vrBNb48cbV3y94aQ+3NlLmMpkK
	zimDBjwCZaaFyi4sxe7YJaldSCYOC2KjgG7J7Jd3RzUMJ3rKgny2MveK8FomWU/u36D70VHgnaS2f
	HEo/13E2/vcFE0iFTvsu6PTMVS62mKIbWgh/GTjw0NoAhZn41f839JXNbM35uM2CCxJzrTC9v5caS
	4jFs6NL0XvYr9tYHi5YtZGT/9ts+54IdjDspwO6Cnn0qCjBFaNWcO/uAzno4Oi2xI9JZQm3ebNMau
	TXWK6vv9LXGJmlpyoYlmMhiqRPs9bQvk2w2D+Hh2PmNRFTFX0fnAiH/1MePvcQOJOHLsC8/XXWmka
	rbralzqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FQd-000000042Yk-0DDK;
	Mon, 14 Oct 2024 07:23:43 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0FQU-000000042UO-0jwV
	for linux-nvme@lists.infradead.org;
	Mon, 14 Oct 2024 07:23:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12BC321D54;
	Mon, 14 Oct 2024 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rj916A9VBInZQGD+K92CdYK78ZmjccoxTWDhMq8dyk=;
	b=vPp+iC49RGWCtRAKUW2HjBzCEbL/+JHUFtMslZFpIaek27sjgGjCQTNBuKHb246xXDyi1a
	PkZmTL2BfqIucR34iVMil0QIZRJ1kVSRpJkk9c1pA3jG1lXYaoBfqS9tGQxxYzEceLabiw
	6GIiqBoJj/fqpGZQ5VwCdKxKd1O3VlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rj916A9VBInZQGD+K92CdYK78ZmjccoxTWDhMq8dyk=;
	b=6XgPKUKuM5FfRSQaWChEVp33BTm0jqpkyooqwLe+khe/hZaInU5iSEXYKHMBzQstiRyZNt
	/RM073pJwc38szAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vPp+iC49;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6XgPKUKu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728890612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rj916A9VBInZQGD+K92CdYK78ZmjccoxTWDhMq8dyk=;
	b=vPp+iC49RGWCtRAKUW2HjBzCEbL/+JHUFtMslZFpIaek27sjgGjCQTNBuKHb246xXDyi1a
	PkZmTL2BfqIucR34iVMil0QIZRJ1kVSRpJkk9c1pA3jG1lXYaoBfqS9tGQxxYzEceLabiw
	6GIiqBoJj/fqpGZQ5VwCdKxKd1O3VlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728890612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1rj916A9VBInZQGD+K92CdYK78ZmjccoxTWDhMq8dyk=;
	b=6XgPKUKuM5FfRSQaWChEVp33BTm0jqpkyooqwLe+khe/hZaInU5iSEXYKHMBzQstiRyZNt
	/RM073pJwc38szAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECF1213A51;
	Mon, 14 Oct 2024 07:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TXt3N/PGDGd/XAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 14 Oct 2024 07:23:31 +0000
Date: Mon, 14 Oct 2024 09:23:31 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v3 2/2] nvme: test the nvme reservation feature
Message-ID: <4f6fac7b-2ef7-4255-94d1-9387f4110765@flourine.local>
References: <20241012111157.44368-1-kanie@linux.alibaba.com>
 <20241012111157.44368-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241012111157.44368-3-kanie@linux.alibaba.com>
X-Rspamd-Queue-Id: 12BC321D54
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_002334_440187_20E7D205 
X-CRM114-Status: GOOD (  11.19  )
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

On Sat, Oct 12, 2024 at 07:11:57PM GMT, Guixin Liu wrote:
> +requires() {
> +	_nvme_requires
> +}

It's probably a good idea to test if the reservation feature is
available, otherwise this test just fails on older kernels.

> +Running nvme/054
> +Register
> +
> +NVME Reservation status:
> +
> +gen       : 0
> +rtype     : 0
> +regctl    : 0
> +ptpls     : 0
> +
> +NVME Reservation  success

I think this is a bit fragile, because the output of the nvme command
might be extended or reformatted (obviously not on purpose but happens).
I'd recommend to explicitly check for the expected values in the test.

