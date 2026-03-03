Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF9EE67A8D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2026 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9T8MXFMMo+drkLYH41nsR9xI4Y/iHMMvMNMBGw/wteE=; b=0XSS0//No5L8WPiVcUIWvhd4+/
	r2w4MuYMfPJCx/f0Tch/hFB3vNVcrTCUUNrYIcJKk67GcV7/86B309qSyGeB1akW07B25xZa2kuiG
	YRnDi+j4fHqleAzwLH558f5I9u7hDQ5jBxJfVIanFeBim7pDew5Kjf85dntNf6v5xTsC5EH9/wbOX
	7SMbajVlru/F5EtzxxMx3QCEShj/2KAmbsNWzLX1zwQujTPLfnPLuFEZqfUBAIpS5DKFfiVjhFoCs
	h+BquHDysYn7aPJxNyMur2e4skjAl0nmimDQXVwiR6FeJS8TX6S//qkMzvdrFxoBqyxjHrEO8f7oH
	0wFYcXvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKPc-0000000EiBj-28zc;
	Tue, 03 Mar 2026 07:43:24 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxKPa-0000000EiAu-1UAy
	for linux-nvme@lists.infradead.org;
	Tue, 03 Mar 2026 07:43:23 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEA335BDE6;
	Tue,  3 Mar 2026 07:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T8MXFMMo+drkLYH41nsR9xI4Y/iHMMvMNMBGw/wteE=;
	b=alX4LfoOes/VER/b4OSSenlpZmRVqVJ+MmsrMNtD/e6iZgWAZ7bXtiijhCfoI4FwNbkUMQ
	iDe9qAQeO0kI1OOQQ0YABPuEjcu17Y6QfIm3oRlRES/bKH55Ifz/1Qa0q1uvnxI0csrzH1
	iMS9ps6HkYhKlJJow46NR9+v63iOBl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T8MXFMMo+drkLYH41nsR9xI4Y/iHMMvMNMBGw/wteE=;
	b=2/wt1waXJ/RdklQUZc0XB/c97LEWROWb38q3TYmr0sgHyN2pEiakOBuyahsjJjjZ3DKDqI
	crJWDF7mkdE+/MBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772523798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T8MXFMMo+drkLYH41nsR9xI4Y/iHMMvMNMBGw/wteE=;
	b=Zcogpfa9FAu2AH9INm5qLBUkAHT+s3UimaR6wNbBpOeUPiNQJp3Z5GhNrIKB/OhBoHUZ0Q
	jL5qyvgjEgNCzE94madUI+5W7EM/qwZRom+TgydiOOBeYbqWMO8WMbbKUSbK5Vc6I/CNrc
	gDt8rSNh+TWtGNPMXXq7j0FuQ/a9Mkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772523798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T8MXFMMo+drkLYH41nsR9xI4Y/iHMMvMNMBGw/wteE=;
	b=rNeH465uY+wydyWLXjRYKGODdXQ6Coh/4VbZ6BNLlCs+qJPzIPD9Ip9rAArCHlEn3ROdWN
	Fuqs8ouiPyVOZbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 852E93EA69;
	Tue,  3 Mar 2026 07:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 74u8HhaRpmmtWAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 03 Mar 2026 07:43:18 +0000
Message-ID: <cff9f152-6b1b-44a0-b390-99b5b3ee5ff8@suse.de>
Date: Tue, 3 Mar 2026 08:43:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] nvme-auth: target: remove obsolete
 crypto_has_shash() checks
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-17-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-17-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_234322_613786_B96C5FA6 
X-CRM114-Status: GOOD (  11.89  )
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

On 3/2/26 08:59, Eric Biggers wrote:
> Since nvme-auth is now doing its HMAC computations using the crypto
> library, it's guaranteed that all the algorithms actually work.
> Therefore, remove the crypto_has_shash() checks which are now obsolete.
> 
> However, the caller in nvmet_auth_negotiate() seems to have also been
> relying on crypto_has_shash(nvme_auth_hmac_name(host_hmac_id)) to
> validate the host_hmac_id.  Therefore, make it validate the ID more
> directly by checking whether nvme_auth_hmac_hash_len() returns 0 or not.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/target/auth.c             | 9 ---------
>   drivers/nvme/target/configfs.c         | 3 ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 4 +---
>   3 files changed, 1 insertion(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

