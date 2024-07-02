Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9161BC30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZoxqzOU8tcov7F8CnFkcCapO5eJRLQpquko7PyPYPK4=; b=s2k/XTT0jPlZ3Rhbkm8+codI1n
	/1jPBwnKPCh8LisHvWH5Py0bh55aoXpgHwlknnIGy+rG+31zLOcyQuCoNSjQOItx9phoiYoH0kMAj
	yIMTuyiIJD2imvR/E036iQh0gK0q48yyam2PZTxvDorr7IMxvvoxYVRLV+b9l0LKmmYbJz58MsnBr
	Bg5ZwGX8D5kX73xdVAR7JPLFACHJttu/ytxcLMvhXhzlh7ehJWRUuRrzPiZFF9pDppGH/XhbBKuzN
	+Xo0Sddh9qcpAtnLZuVb6qXspgjj1HQ58z568OuK6B8/xBOhghEPDaH9+voopmj3ILTAkdJWnoKBA
	i98WUUXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOflG-00000007GDB-3tQ1;
	Tue, 02 Jul 2024 15:49:42 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOflD-00000007GCe-1ER7
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 15:49:40 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-25cb022c0e6so571414fac.0
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jul 2024 08:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719935377; x=1720540177; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZoxqzOU8tcov7F8CnFkcCapO5eJRLQpquko7PyPYPK4=;
        b=ztnCmLAga9V0XnVYQuMGdFGnkj9y7L76EdPSCCyBZMbn8q12wxsKfgNfkLwUYzWI/y
         rxe6uQ7Nej6L8jENDhrYdWybp2yPc5tv7N30fJihHFJSjeRbtLqEUmxJZLcpppHShhXi
         LBLf2qyCJxGNiBYkdQmig0/ujK2TSK7cQfX8UHANTx3RMBtQr5KH6t6BBMU6EZEmln3o
         +JffWj1TyMDMD0A4MXUc+yZNa+LMYpcoCQtFo3Wge3XTqFcQoaFvA47ReY4T3IB9H5GU
         tWR8Ilda3kp4BR3pABm3Etc1oSXewjZVx1MicX4vphibgISBmLmMXmKx1/Y7Rpn7V07X
         Zyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719935377; x=1720540177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZoxqzOU8tcov7F8CnFkcCapO5eJRLQpquko7PyPYPK4=;
        b=ekKthK8jmLvjsLJn0SITknvLRezlYZ1zcyzdnc9mhF7sRpRxOPRE52u965bFXzhelz
         mYxcN9ceZvDWHv9/4cjJFZSSso5XXChrxbJGbRYqA7cW4XglzWM6PwcBE/ss+HVsnB8t
         xu2Dcrmz7qbw13CIdncN6HFQ8E7sWXzqEuvF1dcnez5ddR5b7n7yzBk1vDL9BiZX4RYT
         /u2RtYi8o6Av9lHWWAQRq3l9GZUoTTiJve40OpDJT01Iz3V7dJU4nbP5k7b/sX4n22IY
         zCErspVUWP6xLVuBZVlgDUKDJIfvv9R6Uk84x5JJ8SSl8+Ea/QcNMq9mGXzULnF6MC7N
         eACg==
X-Forwarded-Encrypted: i=1; AJvYcCXPN2ONPfoPM7dxs6Qqe/TPzY195BgcDdbXJqYIhXMEfP6mEA39/2LXd6IcLScbzUKpmZN53Qa8QoYCyiLB4HAPTY211nr0Ml4ho+HNPoI=
X-Gm-Message-State: AOJu0Yyk/XI7YnHobgqdjsdFm8O6/DYqvGzGahex/kx6vfz6N9hCqvQJ
	tsK/qpmwfFRclHXLSbC6u2cmBi9SwKn2Wy/HRjJZ7mATxCRFS8AD8a0VgrirenI=
X-Google-Smtp-Source: AGHT+IEJkaY7ch9hbn1flXDPUBuYtCUe1bs05Q3zPFa9pBtMZkHZRfXnL9cOZ5Is9aygUycMtaZhxQ==
X-Received: by 2002:a05:6870:8192:b0:24f:e599:9168 with SMTP id 586e51a60fabf-25db33732ffmr9129545fac.1.1719935377639;
        Tue, 02 Jul 2024 08:49:37 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25dee83c1aasm343629fac.0.2024.07.02.08.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 08:49:37 -0700 (PDT)
Message-ID: <d7a308f4-7b1f-4136-b655-c72474992151@kernel.dk>
Date: Tue, 2 Jul 2024 09:49:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme: enable FDP support
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 sagi@grimberg.me, linux-nvme@lists.infradead.org, bvanassche@acm.org,
 javier.gonz@samsung.com, gost.dev@samsung.com, Hui Qi
 <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com>
 <20240702102619.164170-1-joshi.k@samsung.com> <20240702113954.GA15325@lst.de>
 <ZoQZelWxFIiG5u4h@kbusch-mbp> <20240702153631.GA534@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240702153631.GA534@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_084939_367593_455003D3 
X-CRM114-Status: GOOD (  18.74  )
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

On 7/2/24 9:36 AM, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 09:15:06AM -0600, Keith Busch wrote:
>> My first concern for applying something like this is what kind of
>> maintenance burdens does this create, or any potential harm to users who
>> don't subscribe to the feature? Nothing here looks alarming to me, and
>> there is a clear demand to be able to access these features like this.
>> Maybe it works out for some workloads, maybe it doesn't, but I don't see
>> a need to block this at this point.
> 
> We're just abusing the interface, and giving how badly designed and
> intentionally Linux-hostile it was I see no point.
> 
> If Samsung and Meta care enough about good Linux I/O temperature hint
> support we'll get what we want in the technical working group, please
> help working on that!

I'm with Keith on this one - there's no real maintenance burden to bear
for this feature, it's pretty well contained. There's no point gate
keeping it based on changing the spec, as that will take a long time to
get done. And there's no reason to hold this back until this happens
based on mostly ideological reasons, when there are actual users that
could use it now. What do we have to lose?

-- 
Jens Axboe


