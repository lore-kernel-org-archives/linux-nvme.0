Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F1DC76196
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zfO+0Us7itGegIMbv5fe9MBJjiVDGQWc+5LuZ4+6uNE=; b=1uYkjdaY8xu4y1AOuy5ciLEAxl
	JckBc8Kni5x7wRJ4Suz/F8Bj81Ylq8Rh6uWdT6G2gQnqig5wKU62Jtj5ldZVlMs8TdBxaz5hvv/Zx
	glZb5Gg5NnThyU5iruvRL3x3nAGH0AuXlwTETtLr0welgoQZLR0NO6uiZ5keVELS3lJoZlRgBizHU
	jr1ppShb/m+8EzW7UHObHr8KZWn/J4FdvVnNtM5CPgWf/O86v6ytmSily1GhbkEVqxuwiqT1dcRHg
	q5jLl/qQLtRaT2FlqYHm2kSH1KPu7KGQfavV+jAXI7CQSkCXN1dV7q26aEpyvp12kugnrL17/d5FZ
	mR/WbP8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ph5VQ-00Dici-0w;
	Tue, 28 Mar 2023 09:20:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ph5VM-00Dib9-1U
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 09:20:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E22D219A6;
	Tue, 28 Mar 2023 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679995233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfO+0Us7itGegIMbv5fe9MBJjiVDGQWc+5LuZ4+6uNE=;
	b=BGzY9KzFWVuRdHt2ng1NgPW+XY7Vxv2W7dPcJaS6wSTnLUabJzKT/6wnIXd4TBqhKr0g0a
	K6qgADlO+QcW3m0uElsrnj8FldVB4Z6qefBvhKtrcDezK9j+xPJZBetv92syED7YDB4az3
	GtlAJ7lUlW1Kl4OcufPF8n0wh0qhKxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679995233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfO+0Us7itGegIMbv5fe9MBJjiVDGQWc+5LuZ4+6uNE=;
	b=FLPCvgJjOiCREut9NWntk3SYV61LntiWoU/AnEkpUPXdGvidufx/F8qwlBzaHVQfJNb/TT
	jmWiLPznLobfMsCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564BF1390B;
	Tue, 28 Mar 2023 09:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id nbe9FGGxImQARAAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 28 Mar 2023 09:20:33 +0000
Message-ID: <8fa65f04-7e82-77a6-00de-f51d20138ece@suse.de>
Date: Tue, 28 Mar 2023 11:20:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chuck Lever <cel@kernel.org>,
 "kernel-tls-handshake@lists.linux.dev" <kernel-tls-handshake@lists.linux.dev>
References: <20230321124325.77385-1-hare@suse.de>
 <20230321124325.77385-16-hare@suse.de>
 <6f69983c-17bd-dd72-b941-95f55db10180@grimberg.me>
 <b8a2e1d4-3571-447b-25c6-c6dd25fbad02@suse.de>
 <a1af3f6b-ec9e-4e91-ad70-57fcc9010a91@grimberg.me>
 <c426d104-b7f2-e736-c23a-b94fda54ed37@suse.de>
 <e0620d94-9729-014c-2cb8-8ff826ebbefa@grimberg.me>
 <e016af81-f77e-2eba-a805-838f62ba50f7@suse.de>
 <68AA3629-6B88-4098-AA03-BEDF614F8D0B@oracle.com>
 <ea181844-69f5-66eb-e64e-e9871916532b@grimberg.me>
 <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
 <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
 <7c3da604-251f-209e-db6d-d1bee5a838c5@suse.de>
 <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <8d0ddb2d-0b4e-e782-6507-a1d61b5d53f4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230328_022036_698707_00739FF2 
X-CRM114-Status: GOOD (  23.14  )
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

On 3/28/23 10:44, Sagi Grimberg wrote:
> 
>>>>
>>>> Nearly there.
>>>>
>>>> The actual patch would be:
>>>>
>>>> @@ -2031,10 +1988,16 @@ static void 
>>>> nvmet_tcp_listen_data_ready(struct sock *sk)
>>>>          trace_sk_data_ready(sk);
>>>>
>>>>          read_lock_bh(&sk->sk_callback_lock);
>>>> +       /* Ignore if the callback has been changed */
>>>> +       if (sk->sk_data_ready != nvmet_tcp_listen_data_ready)
>>>> +               goto out;
>>>>          port = sk->sk_user_data;
>>>>          if (!port)
>>>>                  goto out;
>>>>
>>>> +       if (port->data_ready)
>>>> +               port->data_ready(sk);
>>>> +
>>>>          if (sk->sk_state == TCP_LISTEN)
>>>>                  queue_work(nvmet_wq, &port->accept_work);
>>>>   out:
>>>>
>>>> As the callbacks will be changed once TLS is activated, and we 
>>>> really should not attempt to run if sk_data_ready() points to 
>>>> another function,
>>>> as then the sk_user_data pointer will most likely be changed, too,
>>>> causing all sorts of issues.
>>>
>>> Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
>>> called doesn't it by definition mean that sk->sk_data_ready ==
>>> nvmet_tcp_listen_data_ready ?
>>>
>>> Are you talking about a situation where between
>>> nvmet_tcp_listen_data_ready is starting and until the
>>> sk->sk_callback_lock the data_ready cb (and the user data
>>> pointer) is changed?
>>
>> No. Far simpler:
>> Starting kTLS will change the callbacks.
>> So sk->sk_data_ready will point to our callback before
>> the upcall, but to the kTLS version _after_ the upcall.
>> It typically doesn't matter, as we're setting it to
>> nvmet_tcp_data_ready() anyway.
> 
> For ktls won't we set it to nvmet_tcp_data_ready only when
> the handshake is done?
> 
Yes.

>> But there might be the odd case where the data_ready
>> callback is invoked after kTLS has been started but before
>> we're setting it to nvmet_tcp_data_ready().
> 
> What does nvmet_tcp_data_ready has to do with it?
> You are changing nvmet_tcp_listen_data_ready.
> 
This is not a 'race;
>> Then we cannot guarantee that sk_user_data really is set
>> to the 'queue' pointer, so we should skip the function.
> 
> nvme_tcp_listen_data_ready was invoked, then sk->sk_data_ready
> is nvme_tcp_listen_data_ready. Are you referring to the case
> where the callback has changed before the read lock ?
> 
No. The callback is changed when the userspace daemon starts ktls, as
that will set sk->sk_data_ready to tls_data_ready().

So before the userspace upcall we have the chain:

sk_data_ready -> nvmet_tcp_listen_data_ready()

and after a (successful) upcall we have the chain

sk_data_ready -> tls_data_ready
   -> nvmet_tcp_listen_data_ready()

once we set our callback we have

sk_data_ready -> nvmet_tcp_data_ready
   -> tls_data_ready
     -> nvmet_tcp_listen_data_ready

Calling into nvmet_tcp_listen_data_ready() is pointless here,
but we cannot remove the callback either. So we should to deactivate
it to avoid any side effects.

Cheers,

Hannes


