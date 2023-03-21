Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395C8C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95Ntu88x8aEJJSN+D24us0gzQWFpYrU3q+q4Egatpmw=; b=ZN2yMYjfxhS70mNQy60tDY+hKM
	a5lqPm+v3G4EqMW24vHLLDgz2LhQgekHl6gBNICehSKEFKOJdyldocMl1TV7bDZ5LP6e067JAPX5c
	4ge0SnIibUUskI5n/aoY5Tj9bKPrYG9MvMh1FtVcHAKu0ic9oyvayUmeOdSABJCt9gQZ479luYaCC
	p2+P+Wf+/xQpxwtefBNk0/y8rwqk52uJk5NBFnOXq838IbGg8jPPRgiddLn5Rw36+9sYPnTHPvMAz
	Msj3Ul8g45U4+ghU8/DewCQMdsgJ0zp3/VP/aTnL6iIDBGko0nc38tqZ7NWYTAYZcfjZzSD9Wz1SK
	pdxTUKhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZtI-00C9Hs-1n;
	Tue, 21 Mar 2023 11:10:56 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZtG-00C9HD-0y
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 11:10:55 +0000
Received: by mail-ed1-f42.google.com with SMTP id cn12so12453636edb.4
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 04:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397052; x=1681989052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=95Ntu88x8aEJJSN+D24us0gzQWFpYrU3q+q4Egatpmw=;
        b=KR4avpGpZeK3p3+/H34fHW0bGFaZWq6nMbA0n/s5wwcAQgWrOxJvubxwWmKuEoqTfx
         WyzBOw9TrD7hdWrBVpDK3aRrttU/8YkH3eeVN2GZyB3pvQZl6AzXvNyo02zYD5nCj9zL
         DxH7jrat68aYPAJMIZO884WO7fR/7cwrwmBTS7DYfT8MrpSTuBKeKyKgRbNG61mmmf0e
         OlOoXI4R/Qqq3nAUrSye3jHzBcPhzpwkV0eDoas9o8He8Q/LsfMEnm8rnGsBwv5DIUwb
         4Tx+26Lxdy1DE/ksmIhErK3dgcABhRhiOFWZG4G9/elQ2yLwy+V0b8go2uFXB6g7WtOz
         AQ/g==
X-Gm-Message-State: AO0yUKVLsCbQ3/gbT/I2/gwgEE1hjAAZTqIZViRFHMOKxZNqvk8oPL+x
	V8pWFnTrylakhryojiTCb24nX4VEtSo=
X-Google-Smtp-Source: AK7set/2MSfYjbYe6ZOGd8799aVzsujsqnOEEj1XbWrlQp+xRpEFgRxEu8/qJaKBxFS8JgTV35NC1w==
X-Received: by 2002:a17:906:51d5:b0:929:b101:937d with SMTP id v21-20020a17090651d500b00929b101937dmr2056366ejk.1.1679397052511;
        Tue, 21 Mar 2023 04:10:52 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id ce20-20020a170906b25400b00929fc8d264dsm5706589ejb.17.2023.03.21.04.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 04:10:52 -0700 (PDT)
Message-ID: <b6b14ada-e004-8dec-5ed4-2c188ba7a9ad@grimberg.me>
Date: Tue, 21 Mar 2023 13:10:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
 "Belanger, Martin" <Martin.Belanger@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
 <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
 <20230321110645.ruxzlw5egzikagnw@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321110645.ruxzlw5egzikagnw@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_041054_356498_7B022037 
X-CRM114-Status: GOOD (  16.82  )
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


>>>> admin_tagset.nr_maps = 1 (only the default map, no read, no poll)
>>>
>>> Indeed, that would be to easy.
>>>
>>> I've just triggered a crash where we are passing in a non-null bio. Some
>>> more annotation. This time I am printing from blk_rq_is_poll() and
>>> we see that that is also the case where we have a valid bio but
>>> want to use the poll context:
>>
>> That is not a crash, but a WARN stack dump.
> 
> Not sure how you get to this conclusion.
> 
>> It is still unclear to me
>> how exactly you get to poll for a bio-less request.
> 
> I don't do anything special here. The only thing which is special is that I am
> testing against Linux soft target with Hannes TP8013 patches.
> 
>> See my other reply, While I removed the below warning, and allow
>> bio-less request polling, I was not able to observe any bio-less
>> requests actually being polled.
> 
> Unfortunatly, somehow all your inline patches receive my inbox whitespace
> damaged. Takes a few minutes to patch it manually. Anyway, with your patch
> the crash is gone.

Can you verify that you never see a bio-less requests is being polled?

