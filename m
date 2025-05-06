Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEEEC3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 17:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OokJgCchqneXjWnsDj1Sjjodavmnvcl8YGWBPeqdGAU=; b=dLbVOtT/ekcmSAwn5ncrzptO5P
	0WB17fX5KUtGw8rOuUS4DZG+/8zAZl82JCCrr4VrY31EzgTsvya/e2BZ6dutMr8ZGevI+7aMRUCRP
	FUYu9PBgA0k6lo46aQet5pLsY5YNo2yFaxApr/jqTWhY4rD54ZrDPVKmjtAv+ThZ3W6YL7JH/A5DK
	K/+xSRUx1/03zzCygMeSRteNrNFcZlitSVrIHrTB+ag/mlsmF2MXCk5fwikbI18Gcivzj82lTMLhU
	c/dgCTjXxBTBgacOzw3AUMgTehS9mWpOGe/KwY724u9tvZVjJ/5RfEDqy0SLfeRU0CDRMvjVA1+Jx
	s6qkxNpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCM5W-0000000Cqhj-2f5O;
	Tue, 06 May 2025 17:28:14 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIRc-0000000C8zN-3d6g
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 13:34:50 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso3382255f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 06:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746538487; x=1747143287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OokJgCchqneXjWnsDj1Sjjodavmnvcl8YGWBPeqdGAU=;
        b=Ni4AorstK2TsudhA/DWbQXBqqog1JqC8C2w7jeNkp1loIH3VdBGsLQNnHhDEsjq93Z
         nhKFtSi/ftUctiEkO+9RcN7EPJtZTNRsvIlCj5CE9QfaQQu9E77GfZSSQVjOOF2+IqYG
         bPbqutdBA1Uh7IfNmoZPJcw6rzKU3Vs1FheLtdZT9Sk3WLjOwfElaPkkVieHXY5M1Rli
         s994aw7Y74IjN7Y+7qvmtzsY64o7R8OC5Cm1WHb0cx8IwTgvXiunxrZRUUxnPpn5w7Gt
         y8ZsZPNzXLo0Qb3leV55UJKvCvpoSy8zP5oslzEicefIRngkCbwatlvIkuaQa/2WTXkl
         gkvw==
X-Forwarded-Encrypted: i=1; AJvYcCV8DBGYgtjkAG8tcJr4fohi/yrverFTYCmpTTM/PWoT7iDOdbTylgaAxRcB3VrCm0lXIfhl6yfSk8AD@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5rMBuXPPni9NoV+IdQ7W8QEk4tqXVSs+KYe3iRgnOQu43Wu+J
	iIw5tf54vp7+kRPM0tXnoQb3dGd603BEsyyEelxxlsEBmNNwpUL5
X-Gm-Gg: ASbGncsKZp5OJtFLvMfNPQ/an4qZXXB6SATqKAy8fxHsek4dGjQkUoMBTonUHbpUzxw
	CFVaEO7KpWZmWWDFef3cqtYMDbTrlxEEZyNhyWnJp0O00DZpu7A9e4HpQKs8vhauEZQyjDvS8mT
	CgwzKqFOdcgn76VUeUum8lcGgXFradyBUD5ja5BDmx5qkS/ALwy8jktnG8l502eU2ocOZweJ6XM
	OnSxZ9xHY8zLfMPjxe/7xxb9WuBNWN9fdFWLZ4lrhdJB5/dqbg9yqbAJJ7JU58uGuX1i2/dC5Lr
	DKB5t5NnIUZAQSQ6tTHIbYZwZHd70dUdo0CdE5V/aUnS4vTqSLUhvNMLtwNltaiJf9triudKjFV
	Ff3gwKQ==
X-Google-Smtp-Source: AGHT+IEJ+6S2l4dL1RILDCg3dr6TjbuXO50PqYFF3qxvwSVe0eMOFGzjp+ywvS/51U169tlJf2lZOQ==
X-Received: by 2002:a05:6000:2484:b0:3a0:8282:88e3 with SMTP id ffacd0b85a97d-3a0ab5a8bc0mr3252698f8f.27.1746538486332;
        Tue, 06 May 2025 06:34:46 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae3cfbsm13502158f8f.40.2025.05.06.06.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:34:46 -0700 (PDT)
Message-ID: <4f1e9f1b-ace9-46d1-96bb-3a117d676c90@grimberg.me>
Date: Tue, 6 May 2025 16:34:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 00/20] nvme-tcp receive offloads
To: Keith Busch <kbusch@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Gustavo Padovan <gus@collabora.com>, Aurelien Aptel <aaptel@nvidia.com>,
 linux-nvme <linux-nvme@lists.infradead.org>, netdev
 <netdev@vger.kernel.org>, hch <hch@lst.de>, axboe <axboe@fb.com>,
 chaitanyak <chaitanyak@nvidia.com>, davem <davem@davemloft.net>,
 "aurelien.aptel" <aurelien.aptel@gmail.com>, smalin <smalin@nvidia.com>,
 malin1024 <malin1024@gmail.com>, ogerlitz <ogerlitz@nvidia.com>,
 yorayz <yorayz@nvidia.com>, borisp <borisp@nvidia.com>,
 galshalom <galshalom@nvidia.com>, mgurtovoy <mgurtovoy@nvidia.com>,
 tariqt <tariqt@nvidia.com>, edumazet <edumazet@google.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <19686c19e11.ba39875d3947402.7647787744422691035@collabora.com>
 <20250505134334.28389275@kernel.org>
 <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aBky09WRujm8KmEC@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_063448_906050_DCF6EC4F 
X-CRM114-Status: GOOD (  12.94  )
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



On 06/05/2025 0:51, Keith Busch wrote:
> On Mon, May 05, 2025 at 01:43:34PM -0700, Jakub Kicinski wrote:
>> Looks like the tests passed? But we'll drop this from our PW, again.
>> Christoph Hellwig was pushing back on the v27. We can't do anything
>> with these until NVMe people are all happy.
> FWIW, I believe Sagi is okay with this as he has reviewed or acked all
> the patches. I am also okay with this, though I'm more or less neutral
> on the whole since it's outside my scope, but the nvme parts look fine.
> The new additions are isolated to hardware that provides these offloads,
> so I'm not really concerned this is going to be a problem maintaining
> with the existing nvme-tcp driver. I trust in Sagi on this one.

Yes, as I commented before, I'm perfectly fine with adding this.

