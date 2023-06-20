Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FDEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X93F7b0wOWdtuJBRHnqORIf5mXHGdp4ICFY23Klr0r0=; b=yTCseGW88jUTfqCW/fCvkFoLN6
	RZA1kdHa266fDK4Ki4SShhsaR9vspZ2mEuhEpnJUlADAqpGde9uSmFnOmP1Rk1+031FEihTN4QPyU
	5/dzp+5ZxsTXBqvc9RC6PRgGzfLDe8p8xa3a2fm78CAS7eKmINAFcFPK2ibLvslfxAufRZmx9SGXU
	rxnTqmHeeN03SBEBvyBOcWdayb4otMXqA/TjirvUKXyPtOfRhA80CKcGWiySS5G8QCyqVt0LgHUH6
	49HN1ovhkhtdtOtl0n6lnTDQ1txnYPgshibGs74q9UiStCTvHPEXI+Z/GJ+otlNQwxqot3//HWjjr
	r5GJ0WcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBayM-00BK2X-2e;
	Tue, 20 Jun 2023 13:00:38 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBayK-00BK1R-35
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:00:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f9b38e4e29so4357075e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 06:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687266035; x=1689858035;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X93F7b0wOWdtuJBRHnqORIf5mXHGdp4ICFY23Klr0r0=;
        b=MGGf6e0MRdBumLSeb14oe9NVpzYeJyqYA8koFTdLWvP1IZI+FfVTaTPZB5X/BuROk2
         PVvsruLCK/6l7X6vcNVxoy19gkEzpexMCXcZdL8cRDr+ZpZwrZ95GLzABDcA8A4dW1dS
         UlZEPYQVVoccg+TFKK5JHW9ox8mK2ezTtDsCaIs/seqV7XTF2ZvRqF8ARkKdtso9wybf
         pLL0+o4xVmRkuP2Cf8eWEs1KNkTo0xjsHOO7KydIVbGZCsoqhlXr8Rn7GI0HYTPNQKf5
         aaNusXJnZA9CAhnTFSAkXtdL6ewB8XkaZHfbHtvCCx6DeWss37yuPJfHKnLNp8gbe1Ru
         71ww==
X-Gm-Message-State: AC+VfDzjZQQ6ZyPWMNgsfJe8gtKHKPT+2oPzCqyOPdU7KEkH06Pw/dve
	VYiFvAsbOE1S3HxfMGUVFsM=
X-Google-Smtp-Source: ACHHUZ4fMadoVOeylQzjAgw+8ckeVgibkoIHqT/D3sxLYyMEY5mGEhxW4ZiDHDRruH9UX+wLysw2Mg==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr13305521wmh.3.1687266034561;
        Tue, 20 Jun 2023 06:00:34 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z8-20020a05600c220800b003f9b12b1598sm5339723wml.22.2023.06.20.06.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:00:34 -0700 (PDT)
Message-ID: <028fd6f1-6fc2-6e8d-3de0-71c2b8f6b754@grimberg.me>
Date: Tue, 20 Jun 2023 16:00:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: David Howells <dhowells@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <648f353c55ce8_33cfbc29413@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-11-dhowells@redhat.com>
 <755077.1687109321@warthog.procyon.org.uk>
 <55e7058b-07d0-3619-3481-2d70e95875ea@grimberg.me>
In-Reply-To: <55e7058b-07d0-3619-3481-2d70e95875ea@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_060036_998065_09344814 
X-CRM114-Status: GOOD (  19.97  )
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


>>>      struct bio_vec bvec;
>>>      struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | ... };
>>>
>>>      ..
>>>
>>>      bvec_set_virt
>>>      iov_iter_bvec
>>>      sock_sendmsg
>>>
>>> is a frequent pattern. Does it make sense to define a wrapper? Same 
>>> for bvec_set_page.
>>
>> I dunno.  I'm trying to move towards aggregating multiple pages in a bvec
>> before calling sendmsg if possible rather than doing it one page at a 
>> time,
>> but it's easier and more obvious in some places than others.
> 
> That would be great to do, but nvme needs to calculate a data digest
> and doing that in a separate scan of the payload is not very cache
> friendly...
> 
> There is also the fact that the payload may be sent in portions 
> asynchronously driven by how the controller wants to accept them,
> so there is some complexity there.
> 
> But worth looking at for sure.
> 
> The patch looks good to me, taking it to run some tests
> (from sendpage-3-frag branch in your kernel.org tree correct?)
> 
> For now, you can add:
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Patches seem to hold up.
Tested-by: Sagi Grimberg <sagi@grimberg.me>

However if possible, can you please split nvme/host and nvme/target
changes? We try to separate host side and target side changes in the
same patch.

