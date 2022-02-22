Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC8DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yDLlAFvK+T/73Yb8RG3JwCW99zMzcCE47Ha3YISA/WM=; b=M7zKXT7QDH5VOQAPjohKNZazY4
	Zh0i9XvFi6rK32BsJ9tFLcPwUtI2suaqPdTiG4e0H2XEtj+CR9llyiYcT8gV/6Mso5GTww5QXV4zF
	HXOMincVtUdiL7QP22TYnBeMnKbpgOBoEjvfAhgfxEkz9wW7C9lufD9v41kfFx4aSxESFm002x3Xm
	YFmePn2CxoDVZFmFTtZVYJ1PUxkGqdFgqJpZewfkdr1CXxRNafVfcuJO7jc9xX/DeGdB8a4PFQr9x
	cPphieu6GiZdbKEU0sKyT43jzv6PvBNo0Om6h3DVB70xWFqq9C3UXZkD4LfBYzXt8OmS8Azz9SBA2
	q6Mu6iTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMZ1F-00B0Qn-TV; Tue, 22 Feb 2022 17:32:09 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMYvb-00AyiG-P3
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 17:26:21 +0000
Received: by mail-pf1-x42d.google.com with SMTP id i6so12732699pfc.9
 for <linux-nvme@lists.infradead.org>; Tue, 22 Feb 2022 09:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=yDLlAFvK+T/73Yb8RG3JwCW99zMzcCE47Ha3YISA/WM=;
 b=sQzn11lhKdbc+BS2hXds+Hg7XcO5TKw7NEfuTf02Dm+mnB/MtaxmRAt0QilC+dboFi
 41/oi6nusHAwhKjrG+P3P42PKCarV8f4ENhro/+G7NvVdWP/ahHDBGxEFwYaKIEshYj9
 /f7zW0+F+3FAAQFbxtJxwvcuMzEQZfAMQfRWGpA6iwBMMz4/e6+2kboowIV1wEtMNVBM
 Esq9XfFIz8ZXwmA9nvPiVrNnzixs2+TKmakqyAyEshMUwPoXisqzH3il6oKmdNSYxrAS
 EGa3tBHWYPpzUeOlGihzKR8bJZVM/x/Y/Qt5/y+2LQ+8qrBsmmSP4Cnbem1iQvrkvb5e
 YhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yDLlAFvK+T/73Yb8RG3JwCW99zMzcCE47Ha3YISA/WM=;
 b=VH3nbBzDSv1XQ5LssudZxFsl+kiuxwXAm16T39i50K0EX5BklrhwZQqn5MLsDA06/E
 a/NtaSSMaPrwo30PHcm3CFAnz1GWmV7r/s9nx138PEtI8BDg1AwR40kD/kaT9XGr2mmB
 0zA/SxzYVk3G7Jt2v8087mnAX+GSsPLWnkS5L0k41LzOGjfyDZMlj/isBpq8uPIPEG/f
 UQPGsTuZFyb/k1gdG+n2RV2NnLh1dioGFh+Adm1J9foCBvGtHGjG4dRiA/OGBJw7m5dG
 ydLHR+iscdu3SVSwBLryJK6q0i2rv2MFKbUBKynncOgijsUVNZ5Il2WODgPYJNnEUoF4
 cANw==
X-Gm-Message-State: AOAM533oYW6BkI0hS47ehEXgau6Bs20iO5FFX0Mhw2TEr1mhH++WqWix
 Z/t0anTt8qzlM63zxSxAlhdSqQ==
X-Google-Smtp-Source: ABdhPJw/t5pc/d+LYCVOrTwPf7iKCyOLog7MvyjF1anbmzVS6DNLfKo/e6d6TxoLSSpgOgkLp9HjPQ==
X-Received: by 2002:a63:27c7:0:b0:343:984e:3428 with SMTP id
 n190-20020a6327c7000000b00343984e3428mr20790817pgn.528.1645550777909; 
 Tue, 22 Feb 2022 09:26:17 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id my18sm69139pjb.57.2022.02.22.09.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Feb 2022 09:26:17 -0800 (PST)
Message-ID: <e8c9e5e2-05d3-6051-92c6-b18f46d42494@kernel.dk>
Date: Tue, 22 Feb 2022 10:26:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YgTB0csAbKyI5WvN@infradead.org>
 <d165d411-4499-12aa-fb59-05ff1e2faaa2@kernel.dk>
 <YhUbhsy+C7Q16ihM@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YhUbhsy+C7Q16ihM@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_092619_874399_C024F342 
X-CRM114-Status: GOOD (  12.48  )
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

On 2/22/22 10:21 AM, Christoph Hellwig wrote:
> On Thu, Feb 10, 2022 at 06:57:10AM -0700, Jens Axboe wrote:
>> On 2/10/22 12:42 AM, Christoph Hellwig wrote:
>>> The following changes since commit b13e0c71856817fca67159b11abac350e41289f5:
>>>
>>>   block: bio-integrity: Advance seed correctly for larger interval sizes (2022-02-03 21:09:24 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-10
>>
>> Pulled, thanks.
> 
> Looks like it isn't in the block-5.17 branch any more.  Should I
> just resend it for this week?

Hmm?

https://git.kernel.dk/cgit/linux-block/commit/?h=block-5.17&id=93e2c52d71a6067d08ee927e2682e9781cb911ef

It also went upstream last week.


-- 
Jens Axboe


