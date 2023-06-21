Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1811EB64D8
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Jun 2023 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZrSwU7sZ+tq2ti3olTSASQ+zEZysx384vzrRtwJJcs=; b=Ab7lcsdyqTOC0gG+1diuaakH+f
	zMPnEdqOxsnQ0vWKS/dWUFvvLP6r60MP9zWB9sDxOIjvFrOlbz04Su+5MXlG8Fe1OheIWpbtVShqH
	9iywHegdXKGA4P/HnpYTodJvT9TFpoKAar40mxqhSwLPnoDE4Jz4eDS6J+MWhXdMW9ta+NdIu5BHt
	94TwDHDUqSXplIwVDnaRLmBpOt6+F1+VMIYveaagRgbrc8pe49uzJwaNyqXYT1WNS8+YQiHPIdkQF
	VGaVYOcUhuu8Yk6Wo3vQF7xFvXwlO+S/UGdw/R7Ael2uWS4imUEMRQLhFg2O37lQheKXO0yyGmc44
	Wp1iSCLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtNX-00DinW-1S;
	Wed, 21 Jun 2023 08:39:51 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBtNU-00DilM-2U
	for linux-nvme@lists.infradead.org;
	Wed, 21 Jun 2023 08:39:50 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso13784345e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Jun 2023 01:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687336787; x=1689928787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZrSwU7sZ+tq2ti3olTSASQ+zEZysx384vzrRtwJJcs=;
        b=SAdkjltXXHpETFiQMA2+/yoFC3TWJXSezjutNRp7vWrGr9tvTId/a9UbXvC6SPQQeA
         GfGGdb3vak8qZ/k7y44FasSopT/disP/mOnYQFiUyUNcQ31CZL/iPsqjUvbIpsAx/ksA
         k2XG1MXNMwoXgpEFZ3panr5X7Crs6+ClJVI1ok1NEelh+WGarxrMhVCijwDR57awXxSq
         yJBJKWgvH223PA+1CbhXrhR9UW2IPeP2Y3OvBnKIhBN/5sOAmhWvgKQzxd+ELF0QjQuY
         0bFLuxFMzDZLNroIXF9PYVDLjelbgSPSQnDwNLZn1tfxK9JtbLvXq0sKUeL74tPB63Q9
         A3aA==
X-Gm-Message-State: AC+VfDzyhIUCzFBXDIQH4TIp974TmtBfNpqdn1250H3nYM9fwD3dVXo2
	f4AjyF9Tj9iHQ2zflWc61F0=
X-Google-Smtp-Source: ACHHUZ6qrwp92kCV1dS0R523NqQKTRce/Eo2cdDXsy6P5snKCi5r2n3MgMycr+M5VsIEzrtE0cyfzg==
X-Received: by 2002:a1c:ed05:0:b0:3f5:927:2b35 with SMTP id l5-20020a1ced05000000b003f509272b35mr12990022wmh.1.1687336786700;
        Wed, 21 Jun 2023 01:39:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c210c00b003f9b0830107sm8036286wml.41.2023.06.21.01.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:39:46 -0700 (PDT)
Message-ID: <35f5f82c-0a25-37aa-e017-99e6739fa307@grimberg.me>
Date: Wed, 21 Jun 2023 11:39:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] net/tls: implement ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 Boris Pismenny <boris.pismenny@gmail.com>
References: <20230620102856.56074-1-hare@suse.de>
 <20230620102856.56074-5-hare@suse.de>
 <5bbb6ce4-a251-a357-3efc-9e899e470b9c@grimberg.me>
 <20230620100843.19569d60@kernel.org>
 <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bae9a22a-246f-525e-d9a9-72a074d457c5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230621_013948_815534_6257B527 
X-CRM114-Status: GOOD (  22.70  )
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


>> On Tue, 20 Jun 2023 16:21:22 +0300 Sagi Grimberg wrote:
>>>> +    err = tls_rx_reader_lock(sk, ctx, true);
>>>> +    if (err < 0)
>>>> +        return err;
>>>
>>> Unlike recvmsg or splice_read, the caller of read_sock is assumed to
>>> have the socket locked, and tls_rx_reader_lock also calls lock_sock,
>>> how is this not a deadlock?
>>
>> Yeah :|
>>
>>> I'm not exactly clear why the lock is needed here or what is the subtle
>>> distinction between tls_rx_reader_lock and what lock_sock provides.
>>
>> It's a bit of a workaround for the consistency of the data stream.
>> There's bunch of state in the TLS ULP and waiting for mem or data
>> releases and re-takes the socket lock. So to stop the flow annoying
>> corner case races I slapped a lock around all of the reader.
>>
>> IMHO depending on the socket lock for anything non-trivial and outside
>> of the socket itself is a bad idea in general.
>>
>> The immediate need at the time was that if you did a read() and someone
>> else did a peek() at the same time from a stream of A B C D you may read
>> A D B C.
> 
> Leaving me ever so confused.
> 
> read_sock() is a generic interface; we cannot require a protocol 
> specific lock before calling it.
> 
> What to do now?
> Drop the tls_rx_read_lock from read_sock() again?

Probably just need to synchronize the readers by splitting that from
tls_rx_reader_lock:
--
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 53f944e6d8ef..53404c3fdcc6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1845,13 +1845,10 @@ tls_read_flush_backlog(struct sock *sk, struct 
tls_prot_info *prot,
         return sk_flush_backlog(sk);
  }

-static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
*ctx,
-                             bool nonblock)
+static int tls_rx_reader_acquire(struct sock *sk, struct 
tls_sw_context_rx *ctx,
+                            bool nonblock)
  {
         long timeo;
-       int err;
-
-       lock_sock(sk);

         timeo = sock_rcvtimeo(sk, nonblock);

@@ -1865,26 +1862,30 @@ static int tls_rx_reader_lock(struct sock *sk, 
struct tls_sw_context_rx *ctx,
                               !READ_ONCE(ctx->reader_present), &wait);
                 remove_wait_queue(&ctx->wq, &wait);

-               if (timeo <= 0) {
-                       err = -EAGAIN;
-                       goto err_unlock;
-               }
-               if (signal_pending(current)) {
-                       err = sock_intr_errno(timeo);
-                       goto err_unlock;
-               }
+               if (timeo <= 0)
+                       return -EAGAIN;
+               if (signal_pending(current))
+                       return sock_intr_errno(timeo);
         }

         WRITE_ONCE(ctx->reader_present, 1);

         return 0;
+}

-err_unlock:
-       release_sock(sk);
+static int tls_rx_reader_lock(struct sock *sk, struct tls_sw_context_rx 
*ctx,
+                             bool nonblock)
+{
+       int err;
+
+       lock_sock(sk);
+       err = tls_rx_reader_acquire(sk, ctx, nonblock);
+       if (err)
+               release_sock(sk);
         return err;
  }

-static void tls_rx_reader_unlock(struct sock *sk, struct 
tls_sw_context_rx *ctx)
+static void tls_rx_reader_release(struct sock *sk, struct 
tls_sw_context_rx *ctx)
  {
         if (unlikely(ctx->reader_contended)) {
                 if (wq_has_sleeper(&ctx->wq))
@@ -1896,6 +1897,11 @@ static void tls_rx_reader_unlock(struct sock *sk, 
struct tls_sw_context_rx *ctx)
         }

         WRITE_ONCE(ctx->reader_present, 0);
+}
+
+static void tls_rx_reader_unlock(struct sock *sk, struct 
tls_sw_context_rx *ctx)
+{
+       tls_rx_reader_release(sk, ctx);
         release_sock(sk);
  }
--

Then read_sock can just acquire/release.

