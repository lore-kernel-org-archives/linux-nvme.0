Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A57DC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s18Fllh+gB6Jtpr+Ov6lqWWsOKas/ShUMI9wmr9imiE=; b=ofowllnD+gvQUD2w1elKgbVaGW
	hEzSwey+sjGkr3H3OfjqPQsLEXiHmkOPN/oz5bl0whtrKZYE9pqotTjOsys+ai7e2w+MjnCQU3Trs
	quOZAsRlrsO3zPcao2xQPGvPRtp6uHuu4BM+sEDiQi2SKxErljXBXZoKYx+itmWPy5+rkQ0TpVab5
	Ocdaatg/CR94dXcXcrru+uo4eKjNlcyDdCEWv6CWKzR7s71Wsbf0fAcpySxWmuA/7UPlz4UTQr7PQ
	8XWMl3aNzM36B2/zCfvjq7QKSzasdcy3g7v72TEmELco3cOoVl9sltthTJU+xaK7dnyb5HM6PxDNa
	97F6QuXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCTA5-00AXft-93; Fri, 15 Jul 2022 21:47:49 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCTA2-00AXeU-8X
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 21:47:48 +0000
Received: by mail-pl1-x634.google.com with SMTP id z1so4245035plb.1
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=s18Fllh+gB6Jtpr+Ov6lqWWsOKas/ShUMI9wmr9imiE=;
        b=kt2ywWzJguHIlFYeD1kzJ1YCEy1ZlJBGDyPxy8TwI9f5RYY+BhK30WiL6U/IcMv2zQ
         /1vRBVzoebzeb1euKSejpD5lA7OPINT6SkZ2Bk8ciZhnQzQkw96ZDM9XScicROT4ALHl
         YV/fq7jBURIpwtr4P9Ev7wcru9f0wZ+hrkAuvwD4nQgVem2UlurEvEGoNQMRm2EY4ABq
         YOQCFtSUqto2q9t/tMKUFNi+QfEZxa9FqeY+k9n5FF6rAmWTBx5I2hJIlW71DOxjTBqy
         88Xp6iwg/4GC4q7qnuCiNO5NptgCkNF6CYXMNZ7hDUkQCYToVaNSXpilqPsZDa3T/pet
         J3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=s18Fllh+gB6Jtpr+Ov6lqWWsOKas/ShUMI9wmr9imiE=;
        b=o03GlSXFaZAUFAdDt3em4gCQqB3saLeFefeJxnGNIqwWE5lSGfpuKe69Zctg016/JF
         s695xMmoi33I3VpFjLYx11depDlwDW0AxVkYX1+yiN7E7nv7jWIsmwkPYYEE2oz/3nG1
         E+2Uq0zTAcrh4cXJQZDprtwP1kQbrkW5d6FcwZd+mfFBuZvg/abYD4bxqJFpuwuNTlo0
         SuQohuXrC25PRyuoqN8+3vxmxHHTJO4SARGlOyW4FbYulmz4zI71ckWonrFZNDouLfFP
         iBHendKiOl5/wrNSbEV3eA/hM5mFaCemAcftkcuER8ddKhEkO7Ue14M3bJYKccXZuV7v
         bNFg==
X-Gm-Message-State: AJIora+hmdKUo1I2Nn16uUi9X6dwx1OG3ss+1H+5Ch/a69VMZDxUCACA
	/uib174SaZyN71MQeZxoLyEfdQ==
X-Google-Smtp-Source: AGRyM1u7dqwQl7BVwsbXGj4ln4y2G4XR8MrNgmo1CpOIpFByG8MREhIt5lLf2iwdZKWL2dK/3ZdUGQ==
X-Received: by 2002:a17:903:2285:b0:16c:33dc:8754 with SMTP id b5-20020a170903228500b0016c33dc8754mr15832799plh.126.1657921664549;
        Fri, 15 Jul 2022 14:47:44 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t126-20020a628184000000b0050dc7628148sm4376258pfd.34.2022.07.15.14.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:47:43 -0700 (PDT)
Message-ID: <2c6541c2-d55b-4fbc-ec03-3b84722b7264@kernel.dk>
Date: Fri, 15 Jul 2022 15:47:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com,
 joshi.k@samsung.com, linux-security-module@vger.kernel.org,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, a.manzanares@samsung.com, javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
 <YtHeDa+rqXCFsd97@bombadil.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtHeDa+rqXCFsd97@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_144746_547735_C461A84B 
X-CRM114-Status: GOOD (  21.04  )
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

On 7/15/22 3:37 PM, Luis Chamberlain wrote:
> On Fri, Jul 15, 2022 at 02:00:36PM -0600, Jens Axboe wrote:
>> I did author the basic framework of it, but Kanchan took over driving it
>> to completion and was the one doing the posting of it at that point.
> 
> And credit where due, that was a significant undertaking, and great
> collaboration.

Definitely, the completion bit is usually the longest pole in the
endevaour.

>> It's not like I merge code I'm not aware of, we even discussed it at
>> LSFMM this year and nobody brought up the LSM oversight. Luis was there
>> too I believe.
> 
> I brought it up as a priority to Kanchan then. I cringed at not seeing it
> addressed, but as with a lot of development, some things get punted for
> 'eventually'. What I think we need is more awareness of the importance of
> addressing LSMs and making this a real top priority, not just, 'sure',
> or 'eventually'. Without that wide awareness even those aware of its
> importance cannot help make LSM considerations a tangible priority.

Not sure if this is a generic problem, or mostly on our side. uring_cmd
is a bit of an exception, since we don't really add a lot of non-syscall
accessible bits to begin with. But in general there's for sure more
action there than in other spots. I'm hopeful that this will be more on
top of our minds when the next time comes around.

For uring_cmd, extensions will most likely happen. At least I have some
in mind. We might want to make the control more finegrained at that
point, but let's deal with that when we get there.

> We can do this with ksummit, or whatever that's called these days,
> because just doing this at security conferences is just getting people
> preaching to the choir.

Don't think anyone disagrees that it needs to get done, and there's not
much process to hash out here other than one subsystem being aware of
another ones needs. Hence don't think the kernel summit or maintainers
summit is doing to be useful in that regard. Just my 2 cents.

-- 
Jens Axboe


