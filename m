Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A5CC6FD1C
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4ZZe7fSAaR9q0nUqJ1oZn2r94eaUZb3Z4kG68yEvBmI=; b=gvf+nD04EopZrukiP8RymxBC85
	hUZi23g8Y4K8LEw5v01HxK0AjDtPw4rVaRCSKN2UXLj5aXNWuiMzwCR0tFCACsqPsEB0jOyr8LTWl
	N6bg7usnzzuyH1Qsn4Xj1hcT1ACXP1p3KGx7d7aKmwpT6cvNgph/6thCWI4coAzZME6DRM/OtNLps
	JXILPKtO3ZkPhSXjoCBeL+SZaHC/JwNSvyJHvue1ZvK9QfdKAylTZFd/yHdM1ZyRAjeYVrZt2YW7F
	8U6U97EdZRLDGC/pn8UJnqU6AFgUJCme8tZRn9dDZmju2JQdX2ltBjzRTV8kSFjLDUui0kdUXrnWd
	gno0ufjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKeN-0087Wu-2d;
	Sun, 26 Mar 2023 07:18:47 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgKeK-0087WK-3C
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 07:18:46 +0000
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-93075ee221bso20950066b.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Mar 2023 00:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679815123;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZZe7fSAaR9q0nUqJ1oZn2r94eaUZb3Z4kG68yEvBmI=;
        b=Vu/+0TDHh7MTZmudLmRH88k9L/9vE5bvKiIwYuKkYECxccAJnApLMyeoDoZhnmFwB2
         /4knatvmnysnn1BPbnardapq7DugZ00ozqMKo1QoFiEDDQZ0qSQbTOSD2rVW06Vy+7Tf
         UUboVV4jscExci7QduIko40yecof5Oikr86cL5WTFclL+9jrfw1np7O3yzN3HgNUl4+j
         h2gKdnHZTZ0GSVDugR3gimwelRCf8dCVH4Gpv9bfuC2BQSuOy87bBl8Xkdq+zajRcEhq
         uUmu0fb+syM5+xHG9XGNFsixbmMI6NP8yQoL+Ieu+BVQ/iHSIBNWGFC4r1CTG2B9a5rT
         bu3Q==
X-Gm-Message-State: AAQBX9fa4D/09NZ/1qsbGdqCC9ABTWxth6xj2DrGW+mFkbC7hP0pVykm
	yqQwojP1NHa7Kjs0Oxax09o=
X-Google-Smtp-Source: AKy350bR+ohbFsq/sfM+Z+tJyt0ap2UErIt8QPdnKBThSGP0cQFDP96z0MoPPvFnUjrbTkAJPvMbMg==
X-Received: by 2002:a05:6402:268e:b0:502:465:28d4 with SMTP id w14-20020a056402268e00b00502046528d4mr7299881edd.1.1679815122655;
        Sun, 26 Mar 2023 00:18:42 -0700 (PDT)
Received: from [10.100.102.33] (109-186-69-235.bb.netvision.net.il. [109.186.69.235])
        by smtp.gmail.com with ESMTPSA id f3-20020a50d543000000b00501d51c23fbsm8496046edj.6.2023.03.26.00.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 00:18:42 -0700 (PDT)
Message-ID: <c9b5bb2d-89d7-8805-6d60-2c53e13f5d58@grimberg.me>
Date: Sun, 26 Mar 2023 10:18:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Chuck Lever III <chuck.lever@oracle.com>
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <3ad50302-6b3c-6d6a-669e-0b11c2df6a6b@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_001845_029081_7C441F86 
X-CRM114-Status: GOOD (  27.83  )
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


>>>>>>>> The 'data_ready' call might happen at any time after the 
>>>>>>>> 'accept' call and us calling into userspace.
>>>>>>>> In particular we have this flow of control:
>>>>>>>>
>>>>>>>> 1. Kernel: accept()
>>>>>>>> 2. Kernel: handshake request
>>>>>>>> 3. Userspace: read data from socket
>>>>>>>> 4. Userspace: tls handshake
>>>>>>>> 5. Kernel: handshake complete
>>>>>>>>
>>>>>>>> If the 'data_ready' event occurs between 1. and 3. userspace 
>>>>>>>> wouldn't know that something has happened, and will be sitting 
>>>>>>>> there waiting for data which is already present.
>>>>>>>
>>>>>>> Umm, doesn't userspace read from the socket once we trigger the 
>>>>>>> upcall?
>>>>>>> it should. But I still don't understand what is the difference 
>>>>>>> between
>>>>>>> us waiking up userspace, from the default sock doing the same?
>>>>>>>
>>>>>> No, it doesn't (or, rather, can't).
>>>>>> After processing 'accept()' (from the kernel code) data might 
>>>>>> already be present (after all, why would we get an 'accept' call 
>>>>>> otherwise?).
>>>>>> But the daemon has not been started up (yet); that's only done in
>>>>>> step 3). But 'data_ready' has already been called, so by the time 
>>>>>> userland is able to do a 'read()' on the socket it won't be seeing 
>>>>>> anything.
>>>>> Not sure I understand. if data exists, userspace will read from the
>>>>> socket and get data, whenever that is. >
>>>> That's what I thought, too.
>>>> But then the userspace daemon just sat there doing nothing.
>>>
>>> I haven't been following this discussion in detail, but
>>> if the kernel disables the normal TCP data_ready callback,
>>> then user space won't get any data. That's why SunRPC's
>>> data_ready calls the previous sk_data_ready and then shunts
>>> its own data_ready callback during handshakes. Without that
>>> call to the old sk_data_ready, the user space endpoint won't
>>> see any received data.
>>
>> Yes that is understood. But the solution that Hannes proposed
>> was to introduce nvmet_tcp_tls_data_ready which is overriding
>> the default sock data_ready and does pretty much the same thing.
>>
>> The reason is that today nvmet_tcp_listen_data_ready schedules accept
>> and then pretty much immediately replaces the socket data_ready to
>> nvmet_tcp_data_ready.
>>
>> I think that a simpler solution was to make nvmet_tcp_listen_data_ready
>> call port->data_ready (default socket stored data_ready), schedule
>> the accept_work and only after the handshake bounce to userspace is
>> completed, override the socket callbacks.
>>
>> Something like:
>> -- 
>> static void nvmet_tcp_listen_data_ready(struct sock *sk)
>> {
>>          struct nvmet_tcp_port *port;
>>
>>          trace_sk_data_ready(sk);
>>
>>          read_lock_bh(&sk->sk_callback_lock);
>>          port = sk->sk_user_data;
>>          if (!port)
>>                  goto out;
>>
>>          port->data_ready(sk); // trigger socket old data_ready
>>
>>          if (sk->sk_state == TCP_LISTEN)
>>                  queue_work(nvmet_wq, &port->accept_work);
>> out:
>>          read_unlock_bh(&sk->sk_callback_lock);
>> }
>>
> 
> Nearly there.
> 
> The actual patch would be:
> 
> @@ -2031,10 +1988,16 @@ static void nvmet_tcp_listen_data_ready(struct 
> sock *sk)
>          trace_sk_data_ready(sk);
> 
>          read_lock_bh(&sk->sk_callback_lock);
> +       /* Ignore if the callback has been changed */
> +       if (sk->sk_data_ready != nvmet_tcp_listen_data_ready)
> +               goto out;
>          port = sk->sk_user_data;
>          if (!port)
>                  goto out;
> 
> +       if (port->data_ready)
> +               port->data_ready(sk);
> +
>          if (sk->sk_state == TCP_LISTEN)
>                  queue_work(nvmet_wq, &port->accept_work);
>   out:
> 
> As the callbacks will be changed once TLS is activated, and we really 
> should not attempt to run if sk_data_ready() points to another function,
> as then the sk_user_data pointer will most likely be changed, too,
> causing all sorts of issues.

Umm, something is unclear to me. if nvmet_tcp_listen_data_ready is
called doesn't it by definition mean that sk->sk_data_ready ==
nvmet_tcp_listen_data_ready ?

Are you talking about a situation where between
nvmet_tcp_listen_data_ready is starting and until the
sk->sk_callback_lock the data_ready cb (and the user data
pointer) is changed?

