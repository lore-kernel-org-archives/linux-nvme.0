Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2598C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 21:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESan9JBmRokIZHcl3xO2oQu/yLuGmLntw5PPB729yuE=; b=FIJZB9uC/vNVA/UE9K8MDYwuhe
	kqnXBzkFD2yrOUUMIjcoc3n1mOsFKiQ7CFKrghtrZu1HMku6fQXA5wGWbOyBMKGdj7JLgtrPVA1n3
	mnTHcHROKh9/MEWY6/DJjDowP5gy9R7LlKb3+ZTDTHfLUtwH3UZX2LlvbOa1gQOcqLQf5B29UkVu3
	4qgKO4MWkRBLC3q19h3cD72DVIjRy4Syy78JBakxRhEY1cWG9w21P/oUR7lwwqL5l1sUQ521Hxa2d
	WW7uoAa/Wr/16U6y67cOt44KcXUaDm67KlCK7LJz7Bz/NMRo63U5hKY5o6QU6dL/ldCsHiaxSImvk
	t65j+GIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSvS-00AT31-LK; Fri, 15 Jul 2022 21:32:42 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSvP-00AT0S-Ut
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 21:32:41 +0000
Received: by mail-pj1-x102d.google.com with SMTP id fz10so6730187pjb.2
        for <linux-nvme@lists.infradead.org>; Fri, 15 Jul 2022 14:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ESan9JBmRokIZHcl3xO2oQu/yLuGmLntw5PPB729yuE=;
        b=noo704f8mSs/qVYaE8jN+WxPasbir+fSLLjfDYmjxXB3mRTjQciOhaNH0MLTATfQ3p
         tsz81HvqFoe1o/XZDn7JiMENk6vpsz9WSyGoBluR7G1G2j7rYvSjgnqxRDfKDcT9tNVv
         UR03bucAfDQQtEp963FnmZz0FVof5GdJsrSWo3NE8HLz7KkorM63SkEElyMYS3ogLeqh
         TCFJC7RwMAApK91x+Qai/1UjSh1RsT0SGTVnFABUf2TUrpDHyjvr8DuTZv7rNf7QFNuY
         jCCXRncwlWbm6KueNqteYwvzuV7WMcClXPA13fjv86zqKN2yzKTTbcJu7EJIOqP+EEJA
         tq+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ESan9JBmRokIZHcl3xO2oQu/yLuGmLntw5PPB729yuE=;
        b=Kn2DVIWU/AVmfERzUIyRn4x5Mtyi7GpLhRHqaBwHOAZfX+dl5iYreUvzVeL+MClKMu
         8tXX/Mtf0+c6PKBHDET9zsbBzswJ1M5TZp7j9g9KEOmenfdyf48YZ8C4rTm3DETAOkMd
         AEyhabmxy9M4OEJAnQsB9Mx2/M2ArKFCYKWTun1w0dgW92xT/rpV4W3DkLvVjtiGu2sr
         hSMqKvDcIkxZNzBh5jTfvEUZ+zD6hG4pEQc79Kne2URKO+LwAHkE0hgn3kXCW7JPnAGX
         voBgb2kakky0cwKCd9U1a5xsEK1lG8zq9nE2/7GARoIw4HrfgO+RxljnhJxMApfINerf
         IKFQ==
X-Gm-Message-State: AJIora8XTiAGsXkKYP6CeCDmki5UiFdG0yMAmYJe9aM4Dz70cOoIFMCf
	LC9gXSMIWuyYEQFCwzvYSfGkxA==
X-Google-Smtp-Source: AGRyM1uazsESb2FdRADBB9x052XegnOHXqVck2P43LgHiqV6DSc2FTXLWWFTWvKwKAugfS1uHWw9lA==
X-Received: by 2002:a17:90b:1a8c:b0:1ef:c1b2:b2cd with SMTP id ng12-20020a17090b1a8c00b001efc1b2b2cdmr18265028pjb.190.1657920756898;
        Fri, 15 Jul 2022 14:32:36 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bd3-20020a656e03000000b00419a6f3c8f5sm3577260pgb.19.2022.07.15.14.32.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 14:32:36 -0700 (PDT)
Message-ID: <da03fb01-83e6-974e-d273-ce86c770e5b2@kernel.dk>
Date: Fri, 15 Jul 2022 15:32:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks to for the new uring_cmd file
 op
Content-Language: en-US
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, joshi.k@samsung.com,
 linux-security-module@vger.kernel.org, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 a.manzanares@samsung.com, javier@javigon.com
References: <20220714000536.2250531-1-mcgrof@kernel.org>
 <CAHC9VhSjfrMtqy_6+=_=VaCsJKbKU1oj6TKghkue9LrLzO_++w@mail.gmail.com>
 <YtC8Hg1mjL+0mjfl@bombadil.infradead.org>
 <CAHC9VhQMABYKRqZmJQtXai0gtiueU42ENvSUH929=pF6tP9xOg@mail.gmail.com>
 <a91fdbe3-fe01-c534-29ee-f05056ffd74f@kernel.dk>
 <CAHC9VhRCW4PFwmwyAYxYmLUDuY-agHm1CejBZJUpHTVbZE8L1Q@mail.gmail.com>
 <711b10ab-4ac7-e82f-e125-658460acda89@kernel.dk>
 <1b220ed8-c010-15f2-3bc2-6ec4b2e7532f@schaufler-ca.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1b220ed8-c010-15f2-3bc2-6ec4b2e7532f@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_143240_024668_13751702 
X-CRM114-Status: GOOD (  17.56  )
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

On 7/15/22 3:16 PM, Casey Schaufler wrote:
> On 7/15/2022 1:00 PM, Jens Axboe wrote:
>> I agree that it should've been part of the initial series. As mentioned
>> above, I wasn't much apart of that earlier discussion in the series, and
>> hence missed that it was missing. And as also mentioned, LSM isn't much
>> on my radar as nobody I know uses it.
> 
> There are well over 6 Billion systems deployed in the wild that use LSM.
> Every Android device. Every Samsung TV, camera and watch. Chromebooks.
> Data centers. AWS. HPC. Statistically, a system that does not use LSM is
> extremely rare. The only systems that *don't* use LSM are the ones hand
> configured by Linux developers for their own use.

I'm not talking about systems that only I use, but I believe you that
it's in wide use. Didn't mean to imply that it isn't, just that since I
don't come across it in my work or the people/systems that I've worked
with, it hasn't been much on my radar and nobody has asked for it.

>>  This will cause oversights, even
>> if they are unfortunate. My point is just that no ill intent should be
>> assumed here.
> 
> I see no ill intent. And io_uring addresses an important issue.
> It just needs to work for the majority of Linux systems, not just
> the few that don't use LSM.

Agree, and hopefully we can make sure that it does, going forward as
well.

-- 
Jens Axboe


