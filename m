Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0473CEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jun 2023 08:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iX4CLwxuTuO4frE1ZkNfG2gJ9+rD4aADOYrpxzsHz/k=; b=qJH+FdXSuUwByW7hGwUUl3cCSX
	tTOirNUoX683WMCxv7hWhtqugzC3Pppo8ubZsinigOgET0flMK84nKwQmAlgD6E07VONAYFPMDR/H
	6R3SbXPejudYsjT6wEX0G23Hj9e9/OoNhwzU2raH1GtY412rAFaUxa0PdABTz0DPYc6X53kdQ5Kas
	gXKu4zWP1NBdvgFNlif1TpCwlmkAhvPAZgVybTSC+2S5dP/Qghzxx7Fx0qxQTAXSFc5veiueNq0FE
	1ocHVadu5799J8zGvjRAC3nFf+pWCbr+KRJ0fd/XKUdnwfzmrEm24IHYmvs9XVIwAoyib9ZSwYU1Q
	BkjBWDRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBACk-007oq7-2s;
	Mon, 19 Jun 2023 08:25:42 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBACi-007oox-1i
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jun 2023 08:25:41 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f843f3f610so705119e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 19 Jun 2023 01:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687163138; x=1689755138;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iX4CLwxuTuO4frE1ZkNfG2gJ9+rD4aADOYrpxzsHz/k=;
        b=F+y2u/jU8QlYWTknWp1CI3lYLN6Bvn88NJ5XO3kXIytODzSPhoPBw+yvIKlyVP3Xss
         FZAD2ouaa5pLkYY+88+8eZpJpRSffC/Sje7TCLRo8dHqLoSOAGMUbYRGTPT4SM3xTEB2
         c4VlVZOz54RU1Xw4w0ggf6/oOSXGv6/hppOMgZhtt1jze5RpL9gj2uw16ySCIGpj9yE1
         t9aGGE6rCqlA/MKV0sVWBDc5KT1ckmWt2dARtnyruH1XsvrR7NFHSFcfcFOLEVQidBEP
         3g4k95Bg7MMkY7RJ+jJat0A3YHfmtIcDdI1H5OR25UkBe+CB9PSFHzvMR0sfJXeALHFK
         TFHQ==
X-Gm-Message-State: AC+VfDw93+qOVRU2ikP+5NoXkF2r3R+96JYwpJUlWcRTHKX9UbxUaWbw
	WCcMzoynEHyNIO8iIxrWq88=
X-Google-Smtp-Source: ACHHUZ44wI+K691se6TLRFSf74cGJkGpEfK4OPsyBLOS0ZdfsAOZc8G8mvYNQR0Th0SgRlbHmYSxDw==
X-Received: by 2002:a05:6512:25a:b0:4f7:6a87:f16f with SMTP id b26-20020a056512025a00b004f76a87f16fmr3558941lfo.4.1687163137715;
        Mon, 19 Jun 2023 01:25:37 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bcd0d000000b003f7ba52eeccsm9853963wmj.7.2023.06.19.01.25.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 01:25:37 -0700 (PDT)
Message-ID: <55e7058b-07d0-3619-3481-2d70e95875ea@grimberg.me>
Date: Mon, 19 Jun 2023 11:25:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 10/17] nvme: Use sendmsg(MSG_SPLICE_PAGES)
 rather then sendpage
Content-Language: en-US
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
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <755077.1687109321@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_012540_574783_C3E5FC7A 
X-CRM114-Status: GOOD (  15.28  )
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


>>      struct bio_vec bvec;
>>      struct msghdr msg = { .msg_flags = MSG_SPLICE_PAGES | ... };
>>
>>      ..
>>
>>      bvec_set_virt
>>      iov_iter_bvec
>>      sock_sendmsg
>>
>> is a frequent pattern. Does it make sense to define a wrapper? Same for bvec_set_page.
> 
> I dunno.  I'm trying to move towards aggregating multiple pages in a bvec
> before calling sendmsg if possible rather than doing it one page at a time,
> but it's easier and more obvious in some places than others.

That would be great to do, but nvme needs to calculate a data digest
and doing that in a separate scan of the payload is not very cache
friendly...

There is also the fact that the payload may be sent in portions 
asynchronously driven by how the controller wants to accept them,
so there is some complexity there.

But worth looking at for sure.

The patch looks good to me, taking it to run some tests
(from sendpage-3-frag branch in your kernel.org tree correct?)

For now, you can add:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

