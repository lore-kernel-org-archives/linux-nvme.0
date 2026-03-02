Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB9E9B354
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ITLQYA/HzG0UhdcNDBEdsI0BRF3I2G8Ft9JGx3o4SBg=; b=AyJeRK6Kjc8CDRpLWbgx8XDSXC
	Pi4cROeLUGzvPg9mTz3q77RL3V26MAILzB0n8UBWTqhUjF7B0tXlPDgnzlWioL94PQFKXWD3/m3gI
	uhTcN6f8WkhGS0WB3rNd5Tp1E6gR3eoi0uQ9KPa01RtR5Gg8pB7xAYaWHw5wQ1Vn8jePJZHBG6hci
	z2E+1NzLxgp+8cpVunRJ/o5iXukEU11feHjA2tagZPIPXeJL2VbowejDswajha9vh+jsDDwd1orSI
	vbaMgAd3NRQLqXFrd0i33dHPVshVnru7iWZpmddusoUxDQ6bEcyA3viUzfgnuPdBGmIrrwI8/moSt
	KiVehjuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx0C4-0000000CfGk-0bVr;
	Mon, 02 Mar 2026 10:08:04 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx0C1-0000000CfGL-3Qsb
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 10:08:03 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD6A75BD0E;
	Mon,  2 Mar 2026 10:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITLQYA/HzG0UhdcNDBEdsI0BRF3I2G8Ft9JGx3o4SBg=;
	b=T/vvG853YOJiuK5UzkB6ihZL64Wh8XTyykkQ85uoqegfES+BVSmxX/s7eFozmCSEXj3tzr
	lsVnnANNESREQU/mtw+cVOTGYu2Ngwt5AhFrpL8V44zgYsRWqkLCWz1k5AoNhvovzYwI36
	ReiubUFVHgC3ygBBJofTHr5jSW+UsZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITLQYA/HzG0UhdcNDBEdsI0BRF3I2G8Ft9JGx3o4SBg=;
	b=ZoXbPelbPI7mva+tb5Btq7jv8MTXhkjpA+LXUm4hfKhswUKfm+RPmhFs07Zn3UW+bRlLPf
	O8wAHEO+BjqJKBDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772446079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITLQYA/HzG0UhdcNDBEdsI0BRF3I2G8Ft9JGx3o4SBg=;
	b=s9tuw9iQaQzw/bP0+2Yb66Po3/NSQsNvqF2V+WxtxgczTwUDD/gCTW/pAief9YLPG26w/y
	pLon0v8SwIigCVYhxHF80nvmb7b4dJxF5o+YMy4gHF9SOVR1SFzn2jf7/cAlBkmQtOl1ji
	g5Dwf08Un9VHfUQplXnCf9EnxUQjxxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772446079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ITLQYA/HzG0UhdcNDBEdsI0BRF3I2G8Ft9JGx3o4SBg=;
	b=vCGiyjSfMRHol09o8AVqIRa1bkY4yMVIHUs+Y5ilVK5Mk2QC99hyob7TpSuU7zgAla5Qim
	4h1YRMVhOVoolmAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C208C3EA69;
	Mon,  2 Mar 2026 10:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dw+zLn9hpWmYHAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Mar 2026 10:07:59 +0000
Message-ID: <1417c781-cb2a-42c4-9fc5-9839f377772b@suse.de>
Date: Mon, 2 Mar 2026 11:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] nvme-auth: common: add HMAC helper functions
To: Eric Biggers <ebiggers@kernel.org>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ard Biesheuvel <ardb@kernel.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
References: <20260302075959.338638-1-ebiggers@kernel.org>
 <20260302075959.338638-8-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260302075959.338638-8-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
X-CRM114-CacheID: sfid-20260302_020802_022155_C7BD9AF6 
X-CRM114-Status: GOOD (  10.58  )
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
> Add some helper functions for computing HMAC-SHA256, HMAC-SHA384, or
> HMAC-SHA512 values using the crypto library instead of crypto_shash.
> These will enable some significant simplifications and performance
> improvements in nvme-auth.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>   drivers/nvme/common/Kconfig |  2 ++
>   drivers/nvme/common/auth.c  | 66 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvme-auth.h   | 14 ++++++++
>   3 files changed, 82 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

