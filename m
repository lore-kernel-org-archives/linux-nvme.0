Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E653AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
	Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHfS2esvBetFdz6Cim1QCsagcr9o0XmkA8r54rCLcL8=; b=sfbz+WEGYItpniwdMOco336BN8
	8hgYLMZKmNkiksWdWUe3Ohrd1FfZR/ZrW4DG/urRdeTr7EOHGrtcwKYW4H1f2k2FxNHLd788GjyAH
	1ieojpsJVOAf+WGsjCCtPkIW4W+9l9w8OjKnczwT3oyylyB4HpM1Bcooe17cgKAu/TskC4gye5YPR
	qveAoUuQm9UU5LmxgWskwcROL83QXd7iIFUMlHZRGpxHF0zlRVBqLvbjDyTZF/6HiYIkaNVHjcgg5
	hT+0T7FUhHNlgMGxXfZ7NJiGFyELxIFUhshdHo4wKNL2T0pEeyA6lmHGD2JV8I8mDAYCWOTay2F4L
	nUxsF6eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwLYF-006GvL-BC; Sun, 12 Dec 2021 09:53:51 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwLYD-006Gu5-Fz
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:53:50 +0000
Received: by mail-wr1-f46.google.com with SMTP id k9so4416345wrd.2
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:53:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HHfS2esvBetFdz6Cim1QCsagcr9o0XmkA8r54rCLcL8=;
 b=cWOXYv0VLKMgrM2aEl9BIrHP/HDhr8GdZaTfkfzMA+MVnvXZyByx7LPG10mNM8QQZv
 PAlmaVWTwShiNX0XGrBzjy6jpJFqkqMlQfzebMIwCivAU26s3XEFpYCAESFA8jLHrt1a
 TDxoSxJn6sXgsqObALjHahYXU4ODoSg7QbEb7vAnHXEP8O8F8kGmGJ4mnDVjN00HSNev
 ZKYRn490SnQ7xgyYk/SIOOzL9n0SkJULIx4BqcGTQHU7nb57qU+qjRxK9Pm0tVUJmSAq
 0muyRXUYV1RGXUiNdqRPPSTkibsc01TVvd9WcJ2TOkqWRRJ72Dds6RMHAcrWMWNlAHxw
 GX5w==
X-Gm-Message-State: AOAM533jurh1wa0UMoOyWgZaUWGWLrMFlcDcdH6xTiHkKZyjvm3c0klH
 6mac3sl4S8kNZhmqwKMxOd42qm2yL48=
X-Google-Smtp-Source: ABdhPJxJYQdJHdQW4CyPXHkK+cta3ksvM4kDTG4EkrsqNmpELpE92Hqfy9G2rx7p1ZALqfLGQZkg3g==
X-Received: by 2002:a05:6000:15cd:: with SMTP id
 y13mr7244209wry.581.1639302827858; 
 Sun, 12 Dec 2021 01:53:47 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id d1sm6894407wrz.92.2021.12.12.01.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:53:47 -0800 (PST)
Subject: Re: [PATCH 09/10] nvme/042: test bi-directional authentication
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
References: <20211123074940.113390-1-hare@suse.de>
 <20211123074940.113390-10-hare@suse.de>
 <ffe973a1-1856-e2e7-9695-cb2ce532de3b@grimberg.me>
 <ebae81ae-94d8-6044-1492-cc856a476290@suse.de>
 <17b0e7fa-317a-fbd5-6a04-2a76e3c7f88c@grimberg.me>
 <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aa4fe38e-a099-4de5-6993-e71c37040c09@grimberg.me>
Date: Sun, 12 Dec 2021 11:53:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <068a4335-74c8-e7e6-85e0-fed888f4e3fd@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_015349_562962_0B11F6F5 
X-CRM114-Status: GOOD (  11.00  )
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


>>>> This test case has a weird behavior. Why isn't _nvme_connect_subsys
>>>> failing?
>>>
>>> Oh, but it is.
>>> The line 'nvme controller found' is not part of the .out file, hence
>>> the test will fail.
>>>
>>> Call it an obscure feature of blktests :-)
>>>
>>> But yeah, I can make it more obvious that this is the failure case.
>>
>> Hannes, my question is why isn't nvme connect not failing (i.e.
>> returning a non-zero status code)?
>>
> I guess it does, but we're never actually checking the return value.
> Let me check.

I tested it manually, and the connect does not fail, but rather succeeds
and the controller is removed - which is strange.

