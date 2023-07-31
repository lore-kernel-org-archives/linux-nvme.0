Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD58C001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQSYaglFHbCeXVvaupUEWLNsLwJkDurEJNTXFu1tGlY=; b=k5sshpwo8O3uvSbaP4obksQUhN
	qhCixQbV/kPNjC8Jhu8g8EY90avRGHbCH4/d3JpzVrwkIF1Po6FjwLII/pmLmXsxhkfTiSd7TZRs2
	EF60+br45OZms0gTm0BQHTXhGVONf8+e8ajzr0x8axGs3SqqmPh4x1LoDOHBQaZfvh+ZPei1ew9BN
	0Pw3z/nIHdJUffRg6SXR+rkPklJZbMgG/WUK6TMWpmrxcky2CvMiR+oHWWM04av5cQRqB9sLCGSL5
	AaOPmhsMRUWSzfiZfwM2fvGXieeb8Oybasu5ycGL5Gyf1sbO/9LSROUobCSehb1TatK1svoWpXOIN
	Fj55moVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVal-00GXxa-2K;
	Mon, 31 Jul 2023 16:17:55 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQVai-00GXwy-2h
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 16:17:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1CAC1F45F;
	Mon, 31 Jul 2023 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690820269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQSYaglFHbCeXVvaupUEWLNsLwJkDurEJNTXFu1tGlY=;
	b=fLgdlIxC9biD85dIjEfPZAcsw6bhww0K+D0GLja5FV5vwRrO372Ys/enTwdNE+VG4d5tM4
	qAiLb+3hiOKT9uJrfCokDKgAxLS51q9yi+1s3gsNIBnSMco/SrdHsgmfBzxNvDQsAslG9p
	RRC2Rt8T56dzv8fnV4R4dYYZ8vH8q+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690820269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pQSYaglFHbCeXVvaupUEWLNsLwJkDurEJNTXFu1tGlY=;
	b=3mIwl2OJUEZqJTS503a9Ppbzi82x36Qnihr3mTQ9GjrBOmu/0fcQCOkW7tiNuPvJ2nJPfG
	oauoFxRAM+SYVjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B80AC1322C;
	Mon, 31 Jul 2023 16:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ZbaCKq3ex2RdDwAAMHmgww
	(envelope-from <hare@suse.de>); Mon, 31 Jul 2023 16:17:49 +0000
Message-ID: <3b63d8d9-4246-3010-49e9-fbc433b1ce36@suse.de>
Date: Mon, 31 Jul 2023 18:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] nvme-auth: set explanation code for failure2 msgs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Mark O'Donovan <shiftee@posteo.net>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, axboe@kernel.dk, kbusch@kernel.org
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <20230727134748.4163796-2-shiftee@posteo.net> <20230731055806.GB30150@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230731055806.GB30150@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_091753_037293_D1A0905B 
X-CRM114-Status: GOOD (  12.06  )
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

On 7/31/23 07:58, Christoph Hellwig wrote:
> On Thu, Jul 27, 2023 at 01:47:48PM +0000, Mark O'Donovan wrote:
>> These error cases were not setting an auth-failure-reason-code-explanation.
>> This means an AUTH_Failure2 message will be sent with an explanation value
>> of 0 which is a reserved value.
> 
> I'll leave the final decision to Hannes, but shouldn't we find a common
> place, either behind a label or in the body of the function to set
> chap->status?  Having to add this in a lot of error labels doesn't feel
> very maintainable.
> 
Yeah; the whole AUTH_XXX errors are ever so cumbersome as we don't have 
a good way to passing them up the stack. Plus we can't transport errors
during connect, making it doubly pointless.
Maybe a printk() somewhere. I'll check.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


