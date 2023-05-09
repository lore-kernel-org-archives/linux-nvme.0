Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DEF1C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 14:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBtahf0eIQWar6Vw4AbIHIfX2Ek/QyfvSKTcx++cVDY=; b=NOC6dsBzNoFT2Olwsf8Zp7oGDh
	++4iCsjnzAVeQmsLuVxrTKAZXTW6hDCM5vJp6E5vhmVKmwTDuz+UdyP1SEzt0Botre/5VbCQL9bo2
	4onPE8lEf4kGV1UH88z/SPOalWA2IUudybqGFo7sFirgb+xIYaSGf1vFGuotwQI3qUXZEE8AwGKyl
	T7Oy7EPbnK1CSGrqj4AyAlUtO67np6nGaEy71sJuAFC5/HHho7BTFqMEqaxiJiH5/g5kf2XExJ6Ma
	/SDtWc3+0gizvgM+kKEw9wcqjd1eJPboLWo/rUajP8FuiVuHT9QPtiJzRbNlyN/siRkIQP/aWtXai
	IGHEexPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwOAr-003WFy-1E;
	Tue, 09 May 2023 14:18:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwOAp-003WEt-0D
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 14:18:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 779C71FE59;
	Tue,  9 May 2023 14:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683641914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBtahf0eIQWar6Vw4AbIHIfX2Ek/QyfvSKTcx++cVDY=;
	b=r0dkYHN0q9x3gd7MiWyHKCF0XMZd+BEIJXKSjrgNue1zm3dPK2Fs2NexvxUSo9TwCF5+8v
	jpyMowT/H+55HlVk3HGA5GibYKfGJ2Wtw0RPtOOs5ItQ/LgbAr4f88FUmrwYcuu6jbpuD3
	qEkGr7Z6MLWYHjiauglw5YavGB9bhWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683641914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YBtahf0eIQWar6Vw4AbIHIfX2Ek/QyfvSKTcx++cVDY=;
	b=0AaRBTNiNxSc9TfMCXRBgb+4LuXVD+/WvZOAkI6i/Snt2SX1aRNEFSzydDukfmYQPdyZxR
	ky8VbOFbRfXsJsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E7A6139B3;
	Tue,  9 May 2023 14:18:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 16uGHThWWmTfBQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 09 May 2023 14:18:32 +0000
Message-ID: <f3fe3fc4-b885-d981-9685-4b1a377db639@suse.de>
Date: Tue, 9 May 2023 16:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 07/17] net/tls: handle MSG_EOR for tls_sw TX flow
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-8-hare@suse.de>
 <fb934ee3-879f-f33f-efeb-945ccc9dc9a3@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <fb934ee3-879f-f33f-efeb-945ccc9dc9a3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_071839_243581_B890C24C 
X-CRM114-Status: GOOD (  22.44  )
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

On 5/9/23 11:19, Max Gurtovoy wrote:
> 
> 
> On 19/04/2023 9:57, Hannes Reinecke wrote:
>> tls_sw_sendmsg() / tls_do_sw_sendpage() already checks for an
>> 'end of record' by evaluating the 'MSG_MORE' / 'MSG_SENDPAGE_NOTLAST'
>> setting. So MSG_EOR can easily be handled by treating it
>> as the opposite of MSG_MORE / MSG_SENDPAGE_NOTLAST.
>>
> 
> This seems like a nice optimization but seems not mandatory for the 
> acceptance of TLS support in nvme/tcp.
> 
> I wonder if this can go to net/tls as a standalone patch ?
> 
Errm. Without this NVMe/TLS will not work as sendmsg/sendpage will
bail out.
So yes, surely it can be applied as a standalone patch, but that
only makes sense if it will be applied _before_ the rest of the
nvme/tls patches.

Not sure how best to coordinate this.

> 
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> ---
>>   net/tls/tls_sw.c | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
>> index 827292e29f99..9bee2dcd55bf 100644
>> --- a/net/tls/tls_sw.c
>> +++ b/net/tls/tls_sw.c
>> @@ -953,9 +953,12 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr 
>> *msg, size_t size)
>>       int pending;
>>       if (msg->msg_flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>> -                   MSG_CMSG_COMPAT))
>> +                   MSG_EOR | MSG_CMSG_COMPAT))
>>           return -EOPNOTSUPP;
>> +    if (msg->msg_flags & MSG_EOR)
>> +        eor = true;
>> +
>>       ret = mutex_lock_interruptible(&tls_ctx->tx_lock);
>>       if (ret)
>>           return ret;
>> @@ -1173,6 +1176,8 @@ static int tls_sw_do_sendpage(struct sock *sk, 
>> struct page *page,
>>       bool eor;
>>       eor = !(flags & MSG_SENDPAGE_NOTLAST);
>> +    if (flags & MSG_EOR)
>> +        eor = true;
>>       sk_clear_bit(SOCKWQ_ASYNC_NOSPACE, sk);
>>       /* Call the sk_stream functions to manage the sndbuf mem. */
>> @@ -1274,7 +1279,7 @@ static int tls_sw_do_sendpage(struct sock *sk, 
>> struct page *page,
>>   int tls_sw_sendpage_locked(struct sock *sk, struct page *page,
>>                  int offset, size_t size, int flags)
>>   {
>> -    if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>> +    if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
>>                 MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY |
>>                 MSG_NO_SHARED_FRAGS))
>>           return -EOPNOTSUPP;
>> @@ -1288,7 +1293,7 @@ int tls_sw_sendpage(struct sock *sk, struct page 
>> *page,
>>       struct tls_context *tls_ctx = tls_get_ctx(sk);
>>       int ret;
>> -    if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
>> +    if (flags & ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_EOR |
>>                 MSG_SENDPAGE_NOTLAST | MSG_SENDPAGE_NOPOLICY))
>>           return -EOPNOTSUPP;

-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


