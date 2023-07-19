Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DB3EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jul 2023 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K3E8G3mJWR5fvLT8MJ/31Y2gpZtEutS4tFyS+IgWYzU=; b=AvhgNA8umtAZulpLYni7NoDuY3
	L9bNp7Q7IRIJJdQWqwiGSWBDzBQoYur25Gp7wGuqpHjBZLFaI6avODCyo8Xmx4ORDu34ttc6gpvzU
	LwvCAiEB3ubQsaCWh0Iju4F6reQa7uUtqm3U/BYwGXZvciO/mtWGDvYkmh4JMfxzOHJeD5V0SSIWB
	m5uh8vmPgiDdPWV74hdUvdVkVxRVGmBysDacGxQjbccUTTNO5vMd1H4tG5op1Z1Y3uzxfmry9WWBE
	q2jusyYcqVQBHiUTiYCgRL+m7ZXMxnmsHizyfBtpJEhtKQRuXTW+DDhiWr4J4fR/XsjzLtS2Dwzsm
	D17NHAGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qM1bB-0065Zs-0z;
	Wed, 19 Jul 2023 07:27:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qM1b8-0065Z3-2t
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jul 2023 07:27:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B636E1F8C3;
	Wed, 19 Jul 2023 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1689751663; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3E8G3mJWR5fvLT8MJ/31Y2gpZtEutS4tFyS+IgWYzU=;
	b=o0jJiD+2Q/NEHlxVLU/f5Q/eXkK2cd14wXy5PdM/2bzu2CeknnbEQ10vdmY/Wur6nN1dLp
	Ax4kKER3KHzQos9pUQeaFHQQUENObMxgnc8KQAATNm08DkSudiYyitrgjMXisdr08KepW5
	Z3ZPv6/Hz+nyCJihe2a6aMK7h6YFz24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1689751663;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3E8G3mJWR5fvLT8MJ/31Y2gpZtEutS4tFyS+IgWYzU=;
	b=2M5gCQnYNL/OUdp20HxB8CQiZz0Rp0gUaZoqNRZqgTuzNHibE4dyT/rZiLgnnlPhfoqZqF
	gfk2JAlJ2zz302BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 992F313460;
	Wed, 19 Jul 2023 07:27:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mfjgI2+Qt2RRXAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 19 Jul 2023 07:27:43 +0000
Message-ID: <8d866cf2-df52-5085-f0d4-864d15b8667d@suse.de>
Date: Wed, 19 Jul 2023 09:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: nvme-tls and TCP window full
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
References: <f10a9e4a-b545-429d-803e-c1d63a084afe@suse.de>
 <49422387-5ea3-af84-3f94-076c94748fff@grimberg.me>
 <ed5b22c6-d862-8706-fc2e-5306ed1eaad2@grimberg.me>
 <a50ee71b-8ee9-7636-917d-694eb2a482b4@suse.de>
 <6a9e0fbf-ca1a-aadd-e79a-c70ecd14bc28@grimberg.me>
 <1496b59a-10b1-bb49-2d04-5552e002c960@suse.de>
 <9da64307-c52d-bdf7-bb60-02ed00f44a61@grimberg.me>
 <a77cd4ee-fb4d-aa7e-f0b0-8795534f2acd@suse.de>
 <20230718115921.4de52fd6@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230718115921.4de52fd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230719_002747_075506_7C4844A7 
X-CRM114-Status: GOOD (  14.56  )
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

On 7/18/23 20:59, Jakub Kicinski wrote:
> On Thu, 13 Jul 2023 12:16:13 +0200 Hannes Reinecke wrote:
>>>> And my reading seems that the current in-kernel TLS implementation
>>>> assumes TCP as the underlying transport anyway, so no harm done.
>>>> Jakub?
>>>
>>> While it is correct that the assumption for tcp only, I think the
>>> right thing to do would be to store the original read_sock and call
>>> that...
>>
>> Ah, sure. Or that.
> 
> Yup, sorry for late reply, read_sock could also be replaced by BPF
> or some other thing, even if it's always TCP "at the bottom".

Hmm. So what do you suggest?
Remember, the current patch does this:

@@ -377,7 +376,7 @@ static int tls_strp_read_copyin(struct tls_strparser 
*strp)
         desc.count = 1; /* give more than one skb per call */

         /* sk should be locked here, so okay to do read_sock */
-       sock->ops->read_sock(strp->sk, &desc, tls_strp_copyin);
+       tcp_read_sock(strp->sk, &desc, tls_strp_copyin);

         return desc.error;
  }

precisely because ->read_sock() gets redirected when TLS engages.
And also remember TLS does _not_ use the normal redirection by 
intercepting the callbacks from 'struct sock', but rather replaces the 
->ops callback in struct socket.

So I'm slightly at a loss on how to implement a new callback without 
having to redo the entire TLS handover.
Hence I vastly prefer just the simple patch by using tcp_read_sock() 
directly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


