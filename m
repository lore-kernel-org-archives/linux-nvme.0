Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48A7EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YmM64GS0eVRFRzBVo2cLRoD0D3roE9u3frKxGjRGZ94=; b=xW97QYOmP4BIt3TU2iQWCuobGv
	UbD62c26fTBnDpvoDX1utyS2cFo9T9qtv6IDdEAuoRVOhqExN8jVwwXKJ9Z2VAMiJFvt+KinGd9T9
	Hota8KJF3ijsqD+jFnJ+R176eFq/VcGZVCaMZM8xueYBMrPc6Ff8WZLYmLYnA6iAZ0G1sj031eoiI
	kuk06hUxgd3AVqyPQ7Ao/XsfToR026Joqw4HCwsa6MZJ+rev0hq+07qpNLs+TbgQ4fI3jEPvRAcIw
	YSlgvExCYPFJ9i1TT/bkTJDz4o/sDSjfRi18EfQOgnnYm5GdeF7BgS9Z6WJV5xwT94HUk+4aKzf4o
	cCnXDc8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtMw-002mj3-1K;
	Thu, 13 Jul 2023 10:16:18 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJtMt-002miM-2I
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 10:16:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A73302218C;
	Thu, 13 Jul 2023 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689243373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmM64GS0eVRFRzBVo2cLRoD0D3roE9u3frKxGjRGZ94=;
	b=Td6trXnBEjLTHMLiPrf/V0oUUcUvqP9UAknFkbcqXwErmSy5WErR9jx2nGr6SICY7hpj9D
	uV5aRCFjuRGcRIXiX1i7SLoLqe72p6gx5/xkyT7RKOpBXbxaXQs3bXy2W/YYDPskIhfCBl
	6+UKWZJAU/pgrNj9wmWuq9fcq/RpwDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689243373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YmM64GS0eVRFRzBVo2cLRoD0D3roE9u3frKxGjRGZ94=;
	b=2da8njKDXvd84BlsHu+M+hSHK5Aoz47NsTEMnNchue+eqhL8cmTdv/ZFQ9d2a9YzJjotkV
	dGvNiGQMtOwt4iCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98AE8133D6;
	Thu, 13 Jul 2023 10:16:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7yDgJO3Or2SkZQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 13 Jul 2023 10:16:13 +0000
Message-ID: <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
Date: Thu, 13 Jul 2023 12:16:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Jakub Kicinski <kuba@kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
 <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_031615_893023_AB3577B3 
X-CRM114-Status: GOOD (  17.74  )
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

On 7/13/23 12:11, Sagi Grimberg wrote:
> 
>>> skbs are unrelated to the TCP window. They relate to the socket send
>>> buffer. skbs left dangling would cause server side to run out of memory,
>>> not for the TCP window to close. The two are completely unrelated.
>>
>> Ouch.
>> Wasn't me, in the end:
>>
>> diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
>> index f37f4a0fcd3c..ca1e0e198ceb 100644
>> --- a/net/tls/tls_strp.c
>> +++ b/net/tls/tls_strp.c
>> @@ -369,7 +369,6 @@ static int tls_strp_copyin(read_descriptor_t 
>> *desc, struct sk_buff *in_skb,
>>
>>   static int tls_strp_read_copyin(struct tls_strparser *strp)
>>   {
>> -       struct socket *sock = strp->sk->sk_socket;
>>          read_descriptor_t desc;
>>
>>          desc.arg.data = strp;
>> @@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct 
>> tls_strparser *strp)
>>          desc.count = 1; /* give more than one skb per call */
>>
>>          /* sk should be locked here, so okay to do read_sock */
>> -       sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
>> +       tcp_read_sock(strp->sk, &desc, tls_strp_copyin);
>>
>>          return desc.error;
>>   }
>>
>> Otherwise we'd enter a recursion calling ->read_sock(), which will 
>> redirect to tls_sw_read_sock(), calling tls_strp_check_rcv(), calling 
>> ->read_sock() ...
> 
> Is this new? How did this pop up just now?
> 
It's not new; this has been in there since ages immemorial.
It just got uncovered as yours truly was brave enough to implement 
->read_sock() for TLS ...

>> It got covered up with the tls_rx_reader_lock() Jakub put in, so I 
>> really only noticed it when instrumenting that one.
> 
> So without it, you get two contexts reading from the socket?
> Not sure how this works, but obviously wrong...
> 
Oh, no. Without it you get a loop, eventually resulting in a stack overflow.

>> And my reading seems that the current in-kernel TLS implementation 
>> assumes TCP as the underlying transport anyway, so no harm done.
>> Jakub?
> 
> While it is correct that the assumption for tcp only, I think the
> right thing to do would be to store the original read_sock and call
> that...

Ah, sure. Or that.

Cheers,

Hannes


