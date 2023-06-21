Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B84AEB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 06:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZvXMWBa2bU8sXnxYwsv0mnYtatClMz2EqHHJ2F+ogw=; b=iqvtMlIHnD1AVDSqLuPxC4fuhH
	VxphGpQwhqBHlIkZlPcKbPHYVz3ovSogHg7RJ0kwW+uNrsJijJf3E7sZFnwz10XLftpiwyN+L7hUp
	SCNKaaQhA8EDz4PhrQjcaOE4achdYdIlEblWJVjkPdHzWjhrVkbviG0p0UJBRQwNYsOaOBUGcr55G
	sfaIKS9uJY3UZxBy+lKlKad6RLsMtrOV15sMdyAommkKiGU4IwsH0sAALWtZRaLCktCc/68iwvV8L
	/DQaNLt4EwsjeHC3ya5Po0Uem/lJPlayHHZh34zWvlJiMDBDOI5dhM2i2gN4IEal9uT4ybAI3gFYU
	66X3Jf/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBr2J-00DND1-0x;
	Wed, 21 Jun 2023 06:09:47 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBr2F-00DNBz-24
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 06:09:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37DFF218F3;
	Wed, 21 Jun 2023 06:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687327781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZvXMWBa2bU8sXnxYwsv0mnYtatClMz2EqHHJ2F+ogw=;
	b=dDieefXhTmoXlmJJw2VzHMyjHuts3AK69z6Oyn0pHFqWlgOAzKIP+hON+cxOAjo9rvjQxb
	0K/GvlNI4e3YuUI6RTrZLn5HJVkKDQCbQyt4+U/QkYwX+V5Z5swKOAHJjQFjZ/tRjpJmE8
	qwtw/kBAoGIgu9wI3ZPQ5+NSTUjBoSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687327781;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eZvXMWBa2bU8sXnxYwsv0mnYtatClMz2EqHHJ2F+ogw=;
	b=u2YY23+Y0HauK6Kq7q56Y+Hdy51TSCGapAKQr3p/rklMDNyzn1oBrK6acdgIecVbS9vsO5
	kiEaYoHcAjXVBYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07891134B1;
	Wed, 21 Jun 2023 06:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /dezACWUkmTnGAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 06:09:41 +0000
Message-ID: <f63ed759-7a56-bb8a-8712-55d2a0d33e80@suse.de>
Date: Wed, 21 Jun 2023 08:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] net/tls: handle MSG_EOR for tls_device TX flow
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-3-hare@suse.de> <ZJHd_2g-3-e8TNQU@hog>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <ZJHd_2g-3-e8TNQU@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_230943_823072_556464EF 
X-CRM114-Status: GOOD (  16.27  )
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

On 6/20/23 19:12, Sabrina Dubroca wrote:
> 2023-06-20, 12:28:54 +0200, Hannes Reinecke wrote:
>> tls_push_data() MSG_MORE / MSG_SENDPAGE_NOTLAST, but bails
>> out on MSG_EOR.
>> But seeing that MSG_EOR is basically the opposite of
>> MSG_MORE / MSG_SENDPAGE_NOTLAST this patch adds handling
>> MSG_EOR by treating it as the absence of MSG_MORE.
>> Consequently we should return an error when both are set.
>>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> ---
>>   net/tls/tls_device.c | 25 ++++++++++++++++++++-----
>>   1 file changed, 20 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
>> index b82770f68807..ebefd148ecf5 100644
>> --- a/net/tls/tls_device.c
>> +++ b/net/tls/tls_device.c
>> @@ -440,11 +440,6 @@ static int tls_push_data(struct sock *sk,
>>   	int copy, rc = 0;
>>   	long timeo;
>>   
>> -	if (flags &
>> -	    ~(MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL | MSG_SENDPAGE_NOTLAST |
>> -	      MSG_SPLICE_PAGES))
>> -		return -EOPNOTSUPP;
>> -
>>   	if (unlikely(sk->sk_err))
>>   		return -sk->sk_err;
>>   
>> @@ -536,6 +531,10 @@ static int tls_push_data(struct sock *sk,
>>   				more = true;
>>   				break;
>>   			}
>> +			if (flags & MSG_EOR) {
>> +				more = false;
>> +				break;
> 
> Why the break here? We don't want to close and push the record in that
> case? (the "if (done || ...)" block just below)
> 
Ah, yes, you are correct. Will be fixing it.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


