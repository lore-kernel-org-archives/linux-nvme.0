Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11E8CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6r159uy7yNQzejbmMnwKk4lCOuJ8kWm+yfeGH7rMTcA=; b=hRqQwnBx8X8ej+IosUaBifs5Zk
	FIzMCsvvz1DCFW11WLPYsXyKRO1llISRwitELGFKx2e0FVrccrXfhtOJRyE+q4p7vm2evZJ2DHObC
	wKKAgbza8zsh0WYnZqNwFoWnLTyq9i4iZeZnGFgjEHSmfq1ZBIHoDTSZ5zayM6k5EYLnIs6L8Vh48
	HcHuz0iurqFjHND+rgZJoQEF6lmAhVNAEgJA9fw0+9tox/L5K39GFvn7JUv6zgf3u0pStgo2lt3rD
	8qcPaxPb4iZ1EgDfCsvcwfZnloXyv0z+MiOlOKM5+GV6U5T0IMtgadCCBb9gz5kd/h9dhROFTuMzo
	h05nMcFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDmr-00FhpI-08;
	Wed, 18 Oct 2023 21:09:05 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtDml-00FhoZ-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 21:09:03 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b390036045so1193151b3a.1
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 14:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697663336; x=1698268136; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6r159uy7yNQzejbmMnwKk4lCOuJ8kWm+yfeGH7rMTcA=;
        b=NMw8utcxJYUEzSV1WMiI8FVy3lxDacRQfEv+DG6JKz+4CO/R6b2yGHxU2gYCusN0BX
         FbqYKBIJkE/AtWIf70I774LqDyWIQnggPHqcY/Zd2/Nj3pLXNKjmV5U7vd1nEMES0ZLf
         /ivs1RE2OT9VplzomjNzHBS12tYer17E5/0xsCJKdVi7R+kRZS6ODfWyt9GuUvmPAunv
         90XlukgMKaPS6RaLlfnAqQeH1Qx4b8/qa4PCGP52HJH0vX8x6XuQ8LB1gthg7PjmDyV/
         Bj2BD2qoCQo4Nc9IZLD4NS8U/zUbkQCwtywGcvQJtn6DuigwAU8VSKnmQXQhISK0xi9c
         Y6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663336; x=1698268136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6r159uy7yNQzejbmMnwKk4lCOuJ8kWm+yfeGH7rMTcA=;
        b=qQWTpR9BGd+z71HFhEapkUPkggbcbeNb1nDN7ic2Hv9IzciWYrV7zCGLfB1qbHbT0y
         Sg6Q+hqiL68hkR9TFhHp/Jw/b8UjODgGOHPsOcVjH2c+gTncyE29u0iZ9F4Vnq+G4Blq
         e88IBlKExpCQStzvluD52Ky+Vu12CP32DFRjFa2pI66jry4Uknh1bv0LB5uW1brch0ou
         yLSrotXco9IackC5SsiWXXjAZACH92gaXsksFzHAYP9I2p8OSMAcbwU40DrbdX4ZJ/U7
         Cow/YdVc1Em/9b9kAuY0rKfTxp5x1aQH5nJe2u/wPkofsiXpKaI5MfkwcsM0b6iZXuek
         4omA==
X-Gm-Message-State: AOJu0Yw3hHLEcoLVky+V0Q/vDWmtfMnXLzWbxIPX9Q7AfbGn+AkLqeQm
	yQoGtFEmtPiKqleN6OXlnW8oKA==
X-Google-Smtp-Source: AGHT+IFYrvu/jgNVOcqWwIUFlTtWe3g77spAYxLyN5gfa/Rfqy2Vnz3g34ifO/NiS0loWhBoFobBNA==
X-Received: by 2002:a05:6a00:488b:b0:692:b3d4:e6c3 with SMTP id dk11-20020a056a00488b00b00692b3d4e6c3mr299650pfb.0.1697663336302;
        Wed, 18 Oct 2023 14:08:56 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x25-20020aa79ad9000000b0068fe9c7b199sm3781038pfp.105.2023.10.18.14.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 14:08:55 -0700 (PDT)
Message-ID: <8935bc2e-7d22-4762-b637-7fcf394598e6@kernel.dk>
Date: Wed, 18 Oct 2023 15:08:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Kanchan Joshi <joshiiitr@gmail.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, gost.dev@samsung.com
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com>
 <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
 <ZTAzaJ_4zrFF3Tag@kbusch-mbp>
 <CA+1E3rLF7ZRoo8hPPPLp19FvT7ae-3aDfBy_+hjgNGT9pRnk1Q@mail.gmail.com>
 <ZTBI6FRVCH4Czu13@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZTBI6FRVCH4Czu13@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_140900_071988_2F2F6E54 
X-CRM114-Status: GOOD (  14.02  )
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

On 10/18/23 3:06 PM, Keith Busch wrote:
> On Thu, Oct 19, 2023 at 01:29:46AM +0530, Kanchan Joshi wrote:
>> And if not this, what should be the solution to have non-root
>> passthrough?
> 
> I agree we need non-root passthrough.
> 
> Could we restore what we previously had, but fence it off with a module
> parameter to opt-in to allow it? Like setting a silicon chicken bit, and
> taint the kernel if that helps convey the responsibility taken with such
> a parameter?

Let's please not do a module parameter, those are just awful to deal
with. I'd much rather see a per-drive toggle for this, which whatever
list could then use. That'd allow you to open the device as root, toggle
the switch per-drive, and then drop caps if that is what your
application does.

I'm going to drop the 6.6 pending bits as, to me, it all seems really
half assed and rushed. Let's just do this right for 6.7, it'll need
backporting anyway.

-- 
Jens Axboe


