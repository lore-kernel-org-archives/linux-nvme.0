Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FDDC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kviJokxr4QloTY2PjSmL1SOdZnGOhuURKjR3IayPBq8=; b=GQ+KRmYXZStaFRsXCu2RXYb0E3
	SaEMEKFFsECKnQy/TpUtO3DSe+SGLMO+PU3llxtrnnFZucGgdGlGh8/xUiSIj9K6FE59m6R2E4jXy
	zYhipGgjojm2y/r04qG3TKZlarBtn/WWdaZ9AsmHIaiwP4M1Yo82DRl6ES235mJITCQnvBrXMIEWG
	HhvGPNRlwrWOmFZSWWCTk9QqZ8FXAiUjF9G5HSHkairuVLDgB4n5YTv1C+8Em0zh5tZZNxkstUU+g
	HckXr1dwy2h1WolKZhGwKQML0fyAiTqniqDd2jKZ+GQUlJtCuLRG/Vxf7a80HG3R/mqJtZ3aYly3i
	wV75ahVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp843-00GEhh-Qc; Mon, 22 Nov 2021 12:04:51 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp7Yx-00G4Q9-NJ
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 11:32:45 +0000
Received: by mail-wm1-f54.google.com with SMTP id y196so14972375wmc.3
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 03:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kviJokxr4QloTY2PjSmL1SOdZnGOhuURKjR3IayPBq8=;
 b=jw1Blb6FkfezWtw9aqsZsy91ZX42eBL3k30sKu/71zmkX5/U9CiNVXxiOkpMWOrrsv
 jR6R2/NdgFhY3DhYuMcdQE334ICFNjUfiAzshmbKr+fQg6mIXd10S1UJYhA2Yb3RkyTv
 IIs/uftpvBPJxuNhjSWn1LLM6eh+YKWjo4ZFo1dDR53DApqsnWPcw0iSVD+8sgbUQ2kT
 XAdki58gLopf2OHmuR3Lj+M2j3OhHFpHUU1VSued6mr8N/7A952lc1UdHy6/tkaGrzpc
 8Mj5MP7wYOgpDyDPP7YzNgn+R7GWuQeZ/YCyy7q92HzAHPwwg2S5X1rOKjW0o4QoVEbs
 BMNQ==
X-Gm-Message-State: AOAM532Fhpx5ArfhBUsJii9Nh0pLHKxe+Fje/SeAauR4zVmiS5J/80a0
 C5ncySZI3CoGXDu4cyBUdcM=
X-Google-Smtp-Source: ABdhPJyncsgITIAMiA4Rj0pZKn1+M7Oz+23DbM17NtoFCyprdp21I1t47XLxFkLYgX+uz0LiDy5kfA==
X-Received: by 2002:a1c:9d48:: with SMTP id g69mr30286377wme.188.1637580761743; 
 Mon, 22 Nov 2021 03:32:41 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id a12sm8541498wrm.62.2021.11.22.03.32.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 03:32:41 -0800 (PST)
Subject: Re: [PATCHv6 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org
References: <20211122074727.25988-1-hare@suse.de>
 <14b025bc-746f-ea73-a325-7805c4b46c28@grimberg.me>
 <8e0909ad-f431-2600-7b68-d86d014fc9ec@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <8ba377cc-5c33-7cba-456e-bfc890f1ad88@grimberg.me>
Date: Mon, 22 Nov 2021 13:32:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <8e0909ad-f431-2600-7b68-d86d014fc9ec@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_033243_821303_8F4D414F 
X-CRM114-Status: GOOD (  20.32  )
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


>>> Hi all,
>>>
>>> recent updates to the NVMe spec have added definitions for in-band
>>> authentication, and seeing that it provides some real benefit
>>> especially for NVMe-TCP here's an attempt to implement it.
>>>
>>> Tricky bit here is that the specification orients itself on TLS 1.3,
>>> but supports only the FFDHE groups. Which of course the kernel doesn't
>>> support. I've been able to come up with a patch for this, but as this
>>> is my first attempt to fix anything in the crypto area I would invite
>>> people more familiar with these matters to have a look.
>>>
>>> Also note that this is just for in-band authentication. Secure
>>> concatenation (ie starting TLS with the negotiated parameters) is not
>>> implemented; one would need to update the kernel TLS implementation
>>> for this, which at this time is beyond scope.
>>>
>>> As usual, comments and reviews are welcome.
>>>
>>> Changes to v5:
>>> - Unify nvme_auth_generate_key()
>>> - Unify nvme_auth_extract_key()
>>
>> You mean nvme_auth_extract_secret() ?
>>
> Yes.
> 
>>> - Include reviews from Sagi
>>
>> What about the bug fix folded in?
> 
> Yeah, and that, to
> Forgot to mention it.

It is not the code that you shared in the other thread right?

> 
> Also note that I've already folded the nvme-cli patches into the git
> repository to ease testing; I gather that the interface won't change
> that much anymore, so I felt justified in doing so.

It's ok, we can still change if we want to.

