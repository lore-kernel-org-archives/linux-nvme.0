Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B75EBC3ABCB
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2024 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=; b=1MtDWx7ABRPDHUrO2XYg0sIWsf
	DHA+QzrcFVboSmJE0RKkBJAUS1OUAY3XeNisMu/5Muk2SK8letbvjCijo98XpR/1qiL/ICwCl7+Vp
	OO4UEUW26zXn7avGhCpfCx73cpF0n13j6juouqEWWkqOhFsQGAuNtg7tawBh88wuDJZUtuzdpDEYn
	LOgENoc+CF9axs/ZRSuztTBKRaVjPjT0HitU0aGjyVw3PdD1b9wHQ9UsIs4cyYSTWP/igDzQs/zsn
	SbrS7IKiHmYIgF5IdFyWHzR6zdzV1Xl9kxtF8tQ8MH9MOABSm18xgMvFxe9ZZ1/UDBEN0gW6NAacd
	d360bpFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqIaM-00000004sEg-1B1i;
	Mon, 16 Sep 2024 20:44:38 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqIaD-00000004sBy-0kup
	for linux-nvme@lists.infradead.org;
	Mon, 16 Sep 2024 20:44:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECF9D21C4B;
	Mon, 16 Sep 2024 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=gd7eFRP4GtCb49kCy0vzhDXTmyE2zY8BOHejcxnJ4XrT3AEnTMjU0mFbrOSpmSEsPExZck
	wwrY8MMbsM3sEb8C1nZE1J2oDv/dZtK5BZ5H17GHLQj2R1z78siFziSR8TbvPmNMKcriub
	j0TV+7UFsAHDU2V0FOo1DBvp6N6PsJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=Kc79pJ0ZvUypSyJi/tU/v3I/idf4V3BMkcHtBnMjzE/b03b3WdF5xKNvwHgXcFvkvJd6Qs
	mXcd0XYvz6tDEhBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1726519464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=ONyxBSDCXP8qFh9Rx9BBeaE0T4YYXiVHuWtW+eCV0DYE8Z/kHSq9JXeJAzv88PVE2aYsbU
	8ReYEGSbt324nbeUU7N40KJF/QO+vhFxh8gUMY/6hDxmbfUoUR+hVsbbZ8CCNAQqkOIA4N
	fFpSfZxb43oqU6Gg7As/qRPl3gsst50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1726519464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYB1BzjBJYR3QZfgkjjXkNSuaJnu7Ab3AL2Hwq3V4cs=;
	b=MowPGmCpp9QLZNtpmYQBvQ1WeFmGy3WMQJ/dAZYaBAiSFynNa3yCsTxJUBI+Q1/xWR2P0l
	TG8QDZXyWz5//6Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9D03139CE;
	Mon, 16 Sep 2024 20:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XPqRLKiY6GYOIAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 16 Sep 2024 20:44:24 +0000
Message-ID: <721f6543-1bf7-4b6f-8656-b5d84248e56f@suse.de>
Date: Mon, 16 Sep 2024 22:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: assign dh_key to NULL after kfree_sensitive
To: Vitaliy Shevtsov <v.shevtsov@maxima.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240916174139.1182-1-v.shevtsov@maxima.ru>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240916174139.1182-1-v.shevtsov@maxima.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,maxima.ru:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240916_134429_397730_1B271124 
X-CRM114-Status: GOOD (  11.78  )
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

On 9/16/24 19:41, Vitaliy Shevtsov wrote:
> ctrl->dh_key might be used across multiple calls to nvmet_setup_dhgroup()
> for the same controller. So it's better to nullify it after release on
> error path in order to avoid double free later in nvmet_destroy_auth().
> 
> Found by Linux Verification Center (linuxtesting.org) with Svace.
> 
> Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
> ---
>   drivers/nvme/target/auth.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Now that is obviously correct.

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


