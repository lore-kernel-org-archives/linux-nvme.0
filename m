Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52E3EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kw/ZYjT4Lt79DlrXwSlXjlTb8p9RxjOuV//IiTZBw00=; b=ZaHISprqG+lIgfnH6mr5GAhww1
	AK+nCx40bYrjlYCPJho7roXOHbbT5844yS8iJ6coF+r4ErFFHp1aCUMlE1+vyWv/RzJnAlseNQ8rQ
	CwG39TK+dirY7FEZWe4Ji7nGnp2d6OpP8avD1P2sewgPx18/hiwmQDyBqEw7+o7d2iUlWVkv8XKni
	GMWGAWTX4kPDnWBdSsHU53C8/Zx6fk0wI4hiql0AtVJfyGEsfZBm95g+Oj0Yahg/Wgzplb749N+TQ
	BKFANsWRSXIYoPw8KqU+/vs9zyJE014Eq2kS35yzfgzG6wNWPgIkXLtyoSnIbsiAaaswlh0Kg4uuC
	Fb3LwVHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGK7O-00AhzS-2O;
	Mon, 03 Jul 2023 14:01:30 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGK7L-00Ahyb-36
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 14:01:29 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3140d798bb4so1170941f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 07:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688392885; x=1690984885;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw/ZYjT4Lt79DlrXwSlXjlTb8p9RxjOuV//IiTZBw00=;
        b=Lda+Jh+rApfNOJOCa6V9v5wBHx4wgwF5E0mlcpMkekDXdQ42Tk3e2s0L74L5gZR5nd
         jOI/B1Z9tKDNN8YtPcL4uzPdETcm9Oi5fY5LgkI4T9ruE5eJLGNUzAuZYOMa36PRcnwu
         oEPpciU7Gm7hYjoNLpQ8Mb8P1pX/HuqJQwXwJznWrc8XQwqc6iDrnoK2a+IG6L1i5dFp
         c1UIzHZSwVJcCGCikH/ljDF+IXaUbxoyzmZaJTS0tW/w6k3Y7SheGqZ6cIG5H5BFqUZp
         ry5mrNCKQFCsa9BMaWqEt3l7+CqGmHvjnxg8U4c2uWWsbCarm5haZHz2A1eGblPX5Mjv
         FFLQ==
X-Gm-Message-State: ABy/qLY7NNWcGNhqFvJWAoZgs96xCPX4r97YnfRmsiEB6ukaJ8wzxN+p
	Sl6gdhxgHkNqSrmNKQFM5BQ=
X-Google-Smtp-Source: APBJJlHh2SWxK7oXSwEwBZFEWy4sb+V1UKdMt8EibjmcvnW2h+PTXyycEFdv7tQzg+qyoLgyT7qqIg==
X-Received: by 2002:adf:fc4f:0:b0:314:f14:c24f with SMTP id e15-20020adffc4f000000b003140f14c24fmr8242224wrs.0.1688392884413;
        Mon, 03 Jul 2023 07:01:24 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c5-20020a5d4145000000b00314145e6d61sm11776621wrq.6.2023.07.03.07.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 07:01:23 -0700 (PDT)
Message-ID: <d8289263-2284-a229-75dd-cb1b771a00be@grimberg.me>
Date: Mon, 3 Jul 2023 17:01:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, David Howells <dhowells@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
 <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
 <b33737ab-d923-173c-efcc-9e5c920e6dbf@suse.de>
 <173e27fe-18bb-6194-2af3-1743bc0f8f61@grimberg.me>
 <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <656f77b1-caf6-ea3c-6d32-54637f70a629@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_070127_998223_E87BEE96 
X-CRM114-Status: GOOD (  19.11  )
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


>>>>> Hannes Reinecke <hare@suse.de> wrote:
>>>>>
>>>>>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>>>>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>>>>>> sock_sendmsg() as it's trying to access invalid pages :-(
>>>>>
>>>>> Can you be more specific about the crash?
>>>>
>>>> Hannes,
>>>>
>>>> See:
>>>> [PATCH net] nvme-tcp: Fix comma-related oops
>>>
>>> Ah, right. That solves _that_ issue.
>>>
>>> But now I'm deadlocking on the tls_rx_reader_lock() (patched as to 
>>> your suggestion). Investigating.
>>
>> Are you sure it is a deadlock? or maybe you returned EAGAIN and nvme-tcp
>> does not interpret this as a transient status and simply returns from
>> io_work?
>>
>>> But it brought up yet another can of worms: what _exactly_ is the 
>>> return value of ->read_sock()?
>>>
>>> There are currently two conflicting use-cases:
>>> -> Ignore the return value, and assume errors etc are signalled
>>>     via 'desc.error'.
>>>     net/strparser/strparser.c
>>>     drivers/infiniband/sw/siw
>>>     drivers/scsi/iscsi_tcp.c
>>> -> use the return value of ->read_sock(), ignoring 'desc.error':
>>>     drivers/nvme/host/tcp.c
>>>     net/ipv4/tcp.c
>>> So which one is it?
>>> Needless to say, implementations following the second style do not
>>> set 'desc.error', causing any errors there to be ignored for callers
>>> from the first style...
>>
>> I don't think ignoring the return value of read_sock makes sense because
>> it can fail outside of the recv_actor failures.
>>
> Oh, but it's not read_actor which is expected to set desc.error.
> Have a look at 'strp_read_sock()':
> 
>          /* sk should be locked here, so okay to do read_sock */
>          sock->ops->read_sock(strp->sk, &desc, strp_recv);
> 
>          desc.error = strp->cb.read_sock_done(strp, desc.error);
> 
> it's the ->read_sock() callback which is expected to set desc.error.

Then it is completely up to the consumer how it wants to interpret the
error.

>> But to be on the safe side, perhaps you can both return an error and set
>> desc.error?
>>
> But why? We can easily make ->read_sock() a void function, then it's 
> obvious that you can't check the return value.

but it returns the consumed byte count, where would this info go?

