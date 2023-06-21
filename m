Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7049EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 09:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a6q/P+JsxZ1/FMyKnygNf11cV6ffBMw7VK5hG2JsrKs=; b=tmpGwsUoqtFejpZ2n+t/upOybm
	4AldwYsd716Dl+g7khZ7v8ygnMLGZB5pXAJEhRP1BHz0Ts2Ax5s+ilrJlJ2zO2HWmwVtkKI3bFJ2D
	Tu6ITumrggfH4VbxSEyypD4IZIfiuC1m+L9QecFWsJbCrPElvJyd5ZNdVQGzf2J50ajyloEYqF1fr
	KODgEg3rWiLrEYx1jZsMAza4z5i8VxZ2uoe7ks9X9CsKCgk0S1YyjK9ft4BLLdyJndACOjqw/Qgmj
	bUWs1sEy39ZMAl3xYHyyDBqCvEKRen9kV+e+wkG3Iy25bdlqvSHzE2SJlO4rh15kQjGF9m+TZEbZt
	UWV+qfXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtpK-00Dnpz-2O;
	Wed, 21 Jun 2023 09:08:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtpH-00Dnoc-0m
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 09:08:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79A5521A52;
	Wed, 21 Jun 2023 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687338509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6q/P+JsxZ1/FMyKnygNf11cV6ffBMw7VK5hG2JsrKs=;
	b=A14eNZReUlHloZXdum4ph+Y1XuAqkkZPEZ63idPxqEzc/bZ8qABRCtCiXm4WgMGyjsMUFm
	Gjx9RbkU3n9s/bbLZ756QBPGXa7mJSC3sX775GGqCzdv/d0TS0ehcFUHzegSPgfVzVMXH6
	ZzrjqNoe/8nQvHMhxEKCIiP7dmmVv5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687338509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6q/P+JsxZ1/FMyKnygNf11cV6ffBMw7VK5hG2JsrKs=;
	b=19tSquV/X8hIcTEau2JGn3lH2ms3XDjQ9M3InaHup6Z3IJeNHFCYv/71ab0iI9+Puj5B1U
	TKulYHO5x0bsvLCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56860134B1;
	Wed, 21 Jun 2023 09:08:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JNCYFA2+kmTpZgAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 21 Jun 2023 09:08:29 +0000
Message-ID: <f8d789df-8ca7-9f9a-457d-4c87e2ca6d0a@suse.de>
Date: Wed, 21 Jun 2023 11:08:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
 <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
 <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_020831_424671_A172EA83 
X-CRM114-Status: GOOD (  24.82  )
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

On 6/21/23 10:39, Sagi Grimberg wrote:
> 
>>> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>>>> +    err = tls_rx_reader_lock(sk, ctx, true);
>>>>> +    if (err < 0)
>>>>> +        return err;
>>>>
>>>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>>>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>>>> how is this not a deadlock?
>>>
>>> Yeah :|
>>>
>>>> I'm not exactly clear why the lock is needed here or what is the subtle
>>>> distinction between tls_rx_reader_lock and what lock_sock provides.
>>>
>>> It's a bit of a workaround for the consistency of the data stream.
>>> There's bunch of state in the TLS ULP and waiting for mem or data
>>> releases and re-takes the socket lock. So to stop the flow annoying
>>> corner case races I slapped a lock around all of the reader.
>>>
>>> IMHO depending on the socket lock for anything non-trivial and outside
>>> of the socket itself is a bad idea in general.
>>>
>>> The immediate need at the time was that if you did a read() and someone
>>> else did a peek() at the same time from a stream of A B C D you may read
>>> A D B C.
>>
>> Leaving me ever so confused.
>>
>> read_sock() is a generic interface; we cannot require a protocol 
>> specific lock before calling it.
>>
>> What to do now?
>> Drop the tls_rx_read_lock from read_sock() again?
> 
> Probably just need to synchronize the readers by splitting that from
> tls_rx_reader_lock:
> -- 
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 53f944e6d8ef..53404c3fdcc6 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1845,13 +1845,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
> tls_prot_info *prot,
>          return sk_flush_backlog(sk);
>   }
> 
> -static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
> *ctx,
> -                             bool nonblock)
> +static int tls_rx_reader_acquire(struct sock *sk, struct 
> tls_sw_context_rx *ctx,
> +                            bool nonblock)
>   {
>          long timeo;
> -       int err;
> -
> -       lock_sock(sk);
> 
>          timeo = sock_rcvtimeo(sk, nonblock);
> 
> @@ -1865,26 +1862,30 @@ static int tls_rx_reader_lock(struct sock *sk, 
> struct tls_sw_context_rx *ctx,
>                                !READ_ONCE(ctx->reader_present), &wait);
>                  remove_wait_queue(&ctx->wq, &wait);
> 
> -               if (timeo <= 0) {
> -                       err = -EAGAIN;
> -                       goto err_unlock;
> -               }
> -               if (signal_pending(current)) {
> -                       err = sock_intr_errno(timeo);
> -                       goto err_unlock;
> -               }
> +               if (timeo <= 0)
> +                       return -EAGAIN;
> +               if (signal_pending(current))
> +                       return sock_intr_errno(timeo);
>          }
> 
>          WRITE_ONCE(ctx->reader_present, 1);
> 
>          return 0;
> +}
> 
> -err_unlock:
> -       release_sock(sk);
> +static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
> *ctx,
> +                             bool nonblock)
> +{
> +       int err;
> +
> +       lock_sock(sk);
> +       err = tls_rx_reader_acquire(sk, ctx, nonblock);
> +       if (err)
> +               release_sock(sk);
>          return err;
>   }
> 
> -static void tls_rx_reader_unlock(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
> +static void tls_rx_reader_release(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
>   {
>          if (unlikely(ctx->reader_contended)) {
>                  if (wq_has_sleeper(&ctx->wq))
> @@ -1896,6 +1897,11 @@ static void tls_rx_reader_unlock(struct sock *sk, 
> struct tls_sw_context_rx *ctx)
>          }
> 
>          WRITE_ONCE(ctx->reader_present, 0);
> +}
> +
> +static void tls_rx_reader_unlock(struct sock *sk, struct 
> tls_sw_context_rx *ctx)
> +{
> +       tls_rx_reader_release(sk, ctx);
>          release_sock(sk);
>   }
> -- 
> 
> Then read_sock can just acquire/release.

Good suggestion.
Will be including it in the next round.

Cheers,

Hannes


