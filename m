Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180E8C624DB
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Sep 2026 22:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgqZxXmflp7+ufkovP28Gc9sksCc0hIZ5y20+xl/r48=; b=Ox1RaSSZqdcI6CVl8byxlMv9px
	YJti1O+15UTG5Byfg8LIKrZUrI3ljCeG2OeGLdQ4+QAcFDXVVTZ9rhkGEPtJHPFI2ozuy+exbL8Qk
	AsY3LARb8JIYEWfIQ7s6ffIobe/pW5GgMruHUslgTR/gmCbLd5UwPgAlF5IifTuKh/IWD0xxX/N8h
	2E7lma03UYwNWAFCDP0nDrcsy4QWWjaWNmcI0fiAndKTn1vH1aqky7Nb4jkIhTD3t66OcqnfUe44z
	F1R18lMwrceB2S0tkvHXJG1Hg4PA0RqL/Dqg/LON7MZz66tr12jNA9zoDdzULHp5UMfXdAWiI9i8K
	d391WE5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2ytA-00000004S8i-1H3a;
	Sat, 05 Sep 2026 22:29:32 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2yt6-00000004S8C-3zEm
	for linux-nvme@lists.infradead.org;
	Sat, 05 Sep 2026 22:29:30 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so4272195e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 05 Sep 2026 15:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788647366; x=1789252166;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgqZxXmflp7+ufkovP28Gc9sksCc0hIZ5y20+xl/r48=;
        b=eiBLCvafgr2tVldV+MMmHJz1oyjqLIBOSxmyIx+zQC4Z3/zM1+UXr5XDCcXQHGYxXV
         kd4k1L6VohvZm291wQZW+mQmlb//tG7/UFB6undsA0XHUQgHOsL5aH3URSj2obl5e0kU
         sRuOMO/no9lGgB+aEaPb7KRGJ+Z+9o4NC5NKirWHzvc7b3rVTjj9ufW7vocLEfNL/4s8
         AW/ZpTMvuX8tyT9/9EdAuvUgBSKqWcdlj1ukIYeWOXBB2N+xE1f1mAsZ13CofLOQK0Y8
         Uam/aoBTfoFiLB3hMgdJRrQpfreyE7yLlOIJgY6hgtwdFUCdqv8anuCmCVY13qwwCOQO
         uCVQ==
X-Forwarded-Encrypted: i=1; AKwUvByCEaFcOWeQ/j/xdAnaUmAvRY4oLcl52CDxt+n0ryJIO6Rd8TaAOaf6PzAlhL0UeQnKKTdKtihrBb4e@lists.infradead.org
X-Gm-Message-State: AFuF++lIa7lTbYyaC3my5QZJAAcB25O6ogdYSr515iqUvUkjU6gU8kTP
	BtMF5LBbthMaxszFbkHSZ0XAHc+LfFuihmpY6ew/1ywrh7goZq3RWmwQ
X-Gm-Gg: AYBFou3YBMo7oUYVOqtRFzzQ6K2QP03vM49u2CuxJOlvEFu8kXvDRQob5mP6X/34P/k
	YKkPQZjJ3vcZVMtGsM+odlDrxvVpnEsE2LLuFB+GSUX05Fr79kkntGp1UITuga6u3M2gHWK2EP2
	cQrucNx/4Bf9fh9E53teAe2W07TfPKhwBnMZrbS7UkEVqLaXIkuVognLJWZTMpVxUAlKxh9ug0F
	KAM9288iBEL27Ge33dpKC4ubmAt33tIfeGVc4gxz5TxgPeRXeK9ymgfMU8XqG7mLuNtB6AvVZKl
	qWBAXsGlCsMet13iT/mv09aVhKyKTHfeNr/MrL06SOPlNjXs6Pho0OQ3miQEOLFRNSEotnLLDnR
	mUCW+LEIb5Q0CueEDsx39EOfyp7/LWLj2LCXyvsNjwpAjeoI9nr3ghtgY+R3vpT8S/wNElZllDL
	L7GZHpJBcfVPwZW/bkhgJUFEG0ATdPtFkfSNMsB3TRSFZunc5Y6nU6LcVUK8JhhcDUr7BnKewmH
	+AjLLe+Mn6wTUgQQr3oBg==
X-Received: by 2002:a05:600c:190d:b0:49d:72d:9ba3 with SMTP id 5b1f17b1804b1-49d072d9bccmr43376595e9.14.1788647365653;
        Sat, 05 Sep 2026 15:29:25 -0700 (PDT)
Received: from [10.100.102.74] (89-138-77-243.bb.netvision.net.il. [89.138.77.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm260558705e9.15.2026.09.05.15.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 15:29:23 -0700 (PDT)
Message-ID: <7d73e7e1-bf22-49cc-a943-17b78b430651@grimberg.me>
Date: Sun, 6 Sep 2026 01:29:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 2/2] nvme-tcp: parallelize I/O queue allocation and
 startup
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>,
 Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, randyj@purestorage.com, adailey@purestorage.com
References: <20260824225648.316962-1-sgogte@purestorage.com>
 <20260824225648.316962-3-sgogte@purestorage.com>
 <c98fe50c-172a-4e53-a30c-5416c40cb23f@grimberg.me>
 <20260830222558.GB1842415-mkhalfella@purestorage.com>
 <4f2d2b60-56f9-4ae3-b38f-bba9754011df@grimberg.me>
 <20260830225939.GC1842415-mkhalfella@purestorage.com>
 <CAMof9cW8JFu3XG+BZc-ejG-fvsodQ9ygYbV_ttgvX=Kc_JjXJA@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAMof9cW8JFu3XG+BZc-ejG-fvsodQ9ygYbV_ttgvX=Kc_JjXJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260905_152929_000048_FF423088 
X-CRM114-Status: GOOD (  13.45  )
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



On 04/09/2026 19:04, Surabhi Gogte (she/her) wrote:
> On Sun, Aug 30, 2026 at 3:59 PM Mohamed Khalfella
> <mkhalfella@purestorage.com> wrote:
>> On Mon 2026-08-31 01:44:32 +0300, Sagi Grimberg wrote:
>>>
>>> On 31/08/2026 1:25, Mohamed Khalfella wrote:
>>>> On Mon 2026-08-31 01:00:52 +0300, Sagi Grimberg wrote:
>>>>> On 25/08/2026 1:56, Surabhi Gogte wrote:
>>>>>> - ret = sock_create_kern(current->nsproxy->net_ns,
>>>>>> + ret = sock_create_kern(&init_net,
>>>>> I don't think we can just change this...
>>>> Why we can not change it? Today the error recovery code running in
>>>> worker thread will be using init_net anyway, no?
>>> See commit: 1be52169c3488ef98582ed553ab35cefa3978817
>> Thanks for the pointer. I was not aware of that. What about error
>> recovery case? I _think_ it will be using init_net, no?
>>
>  From what I gathered, reconnect and error recovery run on kworkers,
> so those paths were already resolving to init_net even before this change.
> If we pin the caller's netns to the ctrl, we can keep netns consistent
> throughout,
> if that is desired.

We probably should.

