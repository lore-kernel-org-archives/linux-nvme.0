Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23CDC25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 10:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=luYAaC4Ad9rTiLXjx+ga8YrzC2X/wgzwmHzA+hkgu68=; b=AeyQlEwX0H6ED4rcx0VLqUo730
	trOBEGvA0N+xpSSGjKbPfqeusXgndyYS8+6rBpUt3LTP9KXDJ2OFlg4aJSXAznzuX/a6I+MioZ0cM
	N1RERPzadOY7IO3Pce6dhRwfyQETLqFErTG4kGTTGSIx1ay83RfAOGSYAcd73y167x0+F83Ud/ak4
	gsBJOm0EGEl3AEFnRYYl/aK8zKWzQKm5c07iqC0rI2Gm9xW2FAYNxtuUXRxlPeBh4b3CG8p0QXUrr
	+Cdmo3d1tw3OOofACvK0hMWvr0tDEJjUINhl/m/XkT0z1LKhkKwzFXQwJSFxQYGYiLDW0nmIYYi6M
	bqUkaMjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbYt-00C85W-0Y;
	Wed, 25 Oct 2023 10:56:31 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvbYq-00C83g-35
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 10:56:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2C25C21DA9;
	Wed, 25 Oct 2023 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698231378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luYAaC4Ad9rTiLXjx+ga8YrzC2X/wgzwmHzA+hkgu68=;
	b=Xjzg7RB+SX2KGGvgxAcattFJLLIljw8wm1yrbEcFKd1KyjC26eXN3LyoJDan5e9auhN5IA
	gZXCAL8K1D5//9fY0c+oTaKKDpXDOtx9/q6071DFSdVf8NUbeDBDiQnoVbCaHYv5WvOZie
	AaD1uc1UYRVIhRHJkx9L7D3Bvqzygrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698231378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=luYAaC4Ad9rTiLXjx+ga8YrzC2X/wgzwmHzA+hkgu68=;
	b=bEvvqyBjmBmMLUy50G+pv6d6puyiZPP4gKY8Ej4yqWRU62FXO03/Gw26gO+OeH7O/5uk6g
	f3CRixv2g/Oq/+BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2BF413524;
	Wed, 25 Oct 2023 10:56:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6FmENFH0OGVfSgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 25 Oct 2023 10:56:17 +0000
Message-ID: <6ce64595-9b99-4f8c-b713-f0a897a8670f@suse.de>
Date: Wed, 25 Oct 2023 12:56:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme-auth: add flag for bi-directional auth
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 axboe@kernel.dk, kbusch@kernel.org
References: <20231025105125.134443-1-shiftee@posteo.net>
 <20231025105125.134443-3-shiftee@posteo.net>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231025105125.134443-3-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-11.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.98%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_035629_170602_D5804791 
X-CRM114-Status: GOOD (  10.69  )
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

On 10/25/23 12:51, Mark O'Donovan wrote:
> Introduces an explicit variable for bi-directional auth.
> The currently used variable chap->s2 is incorrectly zeroed for
> uni-directional auth. That will be fixed in the next patch so this
> needs to change to avoid sending unexpected success2 messages
> 
> Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/auth.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes



