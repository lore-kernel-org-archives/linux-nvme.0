Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF3C3DA63
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jul 2024 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VoeGtHSXB64zwiuwvms6AcLkRLb38MEJZx4ZT1nmMD0=; b=hiOSnB0S6vOAgPkUhZacwruryC
	RNHHwJFz0soL6Fqo1ssdp7JYE1VM+ns/IIHsRZHtYPOouaGXRbG7fRX6va3coE1F8dNjriUyN2ohC
	ibZWI+2OtdIcqwngvK9d1cFIbQ979mIu+pgLZBr80cY6Q6937hFHZkOtBcGWdye/0dMNlqwjfqHJ7
	RyfMnpbeckSFR9H398jZ9Il/gncCHtKwH0T3JL6VY6vdSEL/1sGTcgB+e7zGsGBwkPkvScE4RwWWw
	DM04LIGFLsSbaNiIHwzhJ3SXIm1fj08JRz1t+49ImHJmgZznsjRRUQO2czYa8QpKUQ4CeYAZ+mSJg
	vSNNcLug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWJfx-0000000D9yY-3D2b;
	Tue, 23 Jul 2024 17:51:49 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWJfu-0000000D9y5-0nTS
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jul 2024 17:51:47 +0000
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc57d0f15aso861525ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 23 Jul 2024 10:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721757104; x=1722361904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VoeGtHSXB64zwiuwvms6AcLkRLb38MEJZx4ZT1nmMD0=;
        b=vB6PDHaXjz/Ke5EGVaLtaNVa4rQNyN3mnN98+mrDKLMuki9sP1+tOFEgv1ru3qI38B
         hElUtX7M4D8vQoNYNktHIab2pGkYSrSEa/44p5dO8qDm/1nYSxeOJBkQhOXD5nq5smcG
         wP0mE93q/vq9Rfhxqx8rFUncbwbFOIvIct63/rfKlg7+WvXIBneKCNkHxH0PQfv47MsN
         sOMXjaQMki0g173OrB6Zc57m1wlSLL9Nyz8I67yQHo0/IZNACzJeT+DQYMY9WiVA8fNi
         hIDX5r8xzR3p9oG6pIcuxprNoWQcW/EfDTzLzfVfFR1Y4Q9BHb9C6VHb9yzvt7HOUPxB
         ibYA==
X-Forwarded-Encrypted: i=1; AJvYcCUSD0c2ERKF8H4HUKQ7O8Q8RU2R9RSXBiLeAZuNAiCFqK8h53PQJNDKzK3+v+9u7iHxkMHcn/txl5foCgNC1uoryXmAmL+zSVet6u8S4Fk=
X-Gm-Message-State: AOJu0YxK8xqbLPZByRJKdK8jYLcR2A01XH3lj22hSXGTg/CqJgUk+ahs
	hauMo1M+WY2t8GUioNhOdlHoTTaW5vOEsAg5hKN/fdElo26rxC+g
X-Google-Smtp-Source: AGHT+IEWZwnlQ/uVz5RIULJVj6dMBCxAtD4yCOb6ArLoAjAlN3bT5GK7xeRd3S5Zevx1CkOR4GghGQ==
X-Received: by 2002:a17:902:e5d0:b0:1fc:5cc8:bb1b with SMTP id d9443c01a7336-1fd746009a8mr88898525ad.7.1721757102488;
        Tue, 23 Jul 2024 10:51:42 -0700 (PDT)
Received: from [192.168.68.149] ([70.90.172.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2947a1sm78061045ad.86.2024.07.23.10.51.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 10:51:41 -0700 (PDT)
Message-ID: <54cba15d-6598-47c4-9a62-81c4f463ef64@grimberg.me>
Date: Tue, 23 Jul 2024 10:51:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Jens Axboe <axboe@kernel.dk>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org,
 Ofir Gal <ofir.gal@volumez.com>
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
 <172174144805.171126.5886411285955173900.b4-ty@kernel.dk>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <172174144805.171126.5886411285955173900.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240723_105146_263308_81A662C3 
X-CRM114-Status: GOOD (  10.08  )
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



On 23/07/2024 16:30, Jens Axboe wrote:
> On Thu, 18 Jul 2024 11:45:11 +0300, Ofir Gal wrote:
>> skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
>> data transfer failure. This warning leads to hanging IO.
>>
>> nvme-tcp using sendpage_ok() to check the first page of an iterator in
>> order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
>> contiguous pages.
>>
>> [...]
> Applied, thanks!
>
> [1/3] net: introduce helper sendpages_ok()
>        commit: 80b272a6f50b2a76f7d2c71a5c097c56d103a9ed
> [2/3] nvme-tcp: use sendpages_ok() instead of sendpage_ok()
>        commit: 41669803e5001f674083c9c176a4749eb1abbe29
> [3/3] drbd: use sendpages_ok() instead of sendpage_ok()
>        commit: e601087934f178a9a9ae8f5a3938b4aa76379ea1
>
> Best regards,

Thanks Jens.

