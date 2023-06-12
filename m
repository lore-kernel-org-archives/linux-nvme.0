Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D30C7EE23
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/92dzSZdpe3rjJqa28mMOGjDcfEffajUMn5cgac754=; b=vjgOV9s+T+QlvNd1bUXo5c/hza
	bm5SJfSwpQi8c+e5goNYvhr9pKeconTjflPnU7XJOCigz51Jwc4wUMaF9CL/7F57CxxmanKEU1i89
	mPx2iTztsR9uEpJef9QP8dq+lhFHQbWFsQEWPCptUnAEJ680ibi5ms01P9JhNxBgfGq/NCBd/phPr
	q/mcCNYq/0Vkw1YqD7WuCeyBxZLRg2E3fFO18lDQq/Ix+igTjem9i3l96P0QiIhf6PuixWVsWG7hI
	LGS1pRUnTXvK9xotjmUZXjD/Sv3Who30Bhw+V1HCaiO7IrTQSr2quZgh9gfaXhxYCNDx6LmpLPFd+
	z8u2Y1CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bkz-002sym-2J;
	Mon, 12 Jun 2023 07:14:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8bkx-002sxG-2O
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 07:14:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7DD2046B
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686554064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/92dzSZdpe3rjJqa28mMOGjDcfEffajUMn5cgac754=;
	b=kBDNsz1dZVxA8xD4G2NGKqDjJH02mTcfLwAMhPj8nAgGk9+MomShhqtwnVglc1LF/QIrgg
	LZ5FgzlVlhqcjW2XW9CrQXzs+Z6btcsGaQi9NrfygCjqRl5/w7jldmcUeIqjYdGlW52B+l
	rLuyR+CIedJGmtWj0BNxJtzm0s3knBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686554064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G/92dzSZdpe3rjJqa28mMOGjDcfEffajUMn5cgac754=;
	b=fAe1ogkUjdKWFQIHpDbocIvcarxDo/ePxIcMDyAZoj2HCGrnVCDfruciJK09fYQo5nzn1N
	wR4Jy1vMd2GjP8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 382D71357F
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 07:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id gvoSDNDFhmRlXAAAMHmgww
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 07:14:24 +0000
Message-ID: <f6336590-e371-1c73-17eb-81b854806b32@suse.de>
Date: Mon, 12 Jun 2023 09:14:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] net/tls: handle MSG_EOR for tls_sw TX flow
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20230609125153.3919-1-hare@suse.de>
 <20230609125153.3919-2-hare@suse.de> <ZINVSBkUyBMW_ZeB@hog>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZINVSBkUyBMW_ZeB@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_001427_931258_D2C754E8 
X-CRM114-Status: GOOD (  23.05  )
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

On 6/9/23 18:37, Sabrina Dubroca wrote:
> Hi Hannes,
> 
> 2023-06-09, 14:51:50 +0200, Hannes Reinecke wrote:
>> tls_sw_sendmsg() / tls_do_sw_sendpage() already handles
>> MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails out on MSG_EOR.
>> But seeing that MSG_EOR is basically the opposite of
>> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
>> MSG_EOR by treating it as the negation of MSG_MORE.
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_sw.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 635b8bf6b937..be8e0459d403 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>   	int pending;
>>   
>>   	if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>> -			       MSG_CMSG_COMPAT))
>> +			       MSG_EOR | MSG_CMSG_COMPAT))
>>   		return -EOPNOTSUPP;
>>   
>> +	if (msg->msg_flags & MSG_EOR)
>> +		eor = true;
> 
> Is MSG_EOR supposed to be incompatible with MSG_MORE, or is it
> supposed to cancel it? (ie: MSG_MORE | MSG_EOR is invalid, or
> MSG_MORE | MSG_EOR behaves like MSG_EOR) The current code already
> behaves as if _EOR was passed as long as MSG_MORE isn't passed, so
> _EOR is only needed to cancel out _MORE (or in your case, because
> NVMe-over-TLS sets it).
> 
I guess the correct answer here is: Implementation defined.
Personally I would veer towards the first option (ie MSG_MORE is
incompatible with MSG_EOR), but then it depends on the implementation
to check for that. And most don't.

> If _EOR and _MORE (or MSG_SENDPAGE_NOTLAST below) are supposed to be
> incompatible, we should return an error when they're both set. If we
> accept both flags being set at the same time, I think we should
> document the expected behavior ("_EOR overrides _MORE/_NOTLAST") and
> add specific selftests to avoid regressions.
> 
Hmm. Yes, guess you are correct. I'll be adding a check to make
MSG_MORE incompatible with MSG_EOR.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


