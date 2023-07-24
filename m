Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B8EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 19:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p0OzWwaeRybKTUeC9/LT5DZEgHn/QS8XNnnJ3gXdz68=; b=mSagBdfdmOg5BOWFC1tACmPkIE
	nvotr8iRYDhxLvHLeXNzAQUsqPIOiW76dVDULUC0QhLzaqXkO3Y97XtqZe3IfbELaeVbjV9UQCOu1
	Suq8FvxwakVxGUqJ/JjI91ECJVVq3P9JobdRCjyDngXbgLBPY9Du4XEEVi8nNjp6aaSW9Lozv0a8g
	nskFaOtfCOPpOrYCPbYNEXUYpXIAOpXD5af9FNHJlX6iRiZvaqqtw3vHfpZOxWvcWz6Sz1XU2Uq+t
	ojAA0teqQYb3hJBwAd4E7q034u360s9QwGeaIFnVDYY9RcCS7Q+WIk3n5DOewj77hoB31z+5K11hy
	4Nc4qcGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1Yo-005KOC-1P;
	Mon, 24 Jul 2023 19:49:38 +0000
Received: from mail-ed1-f41.google.com ([209.85.208.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1Yl-005KNp-2o
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 19:49:37 +0000
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-521caf0d7a6so1475249a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 12:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690228174; x=1690832974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0OzWwaeRybKTUeC9/LT5DZEgHn/QS8XNnnJ3gXdz68=;
        b=Y/0SW3aqMm9gZjKJ+cxHe/OgLTCrvDWwcUE0sBZv1Mk0YCZTWC/uet3OUNvxL+joJj
         ju/5TQuCxRGpKZCjLlU6ezGiO3iwCf2H3iR1NmjEnsYP69AWtKlUy9J8b5bi+THLEC3p
         KMQ648G3wJwNlYIJO1ulA6EyRlLRpeTQFAgYGMknTnXpM/UasDe9erbpGExl8/Pkq+UH
         IOC4o8hBQZaYxbtOitTptc10tGrUZr7oIxRTAqjwx3PS28ip/zOeSYaqs8+VxPZBCND0
         ZD3mKnlSx4yVXbz9RI7Y+qWrxwUZImytQHe2sKuGiwkpMjlwtDSzPDN8duVtb3eePD+V
         hkCQ==
X-Gm-Message-State: ABy/qLbS6zsIwWMJQ0WjUIJZAvMR41nBVNJcdV49ETiyp153B/Tkrjx0
	PZ/Vy1bUYaTVIvRLW39KJg5oPxlPK9k=
X-Google-Smtp-Source: APBJJlEQcm2gqpfeRXTCatFDqZ0d1HO9FY0eDJ48KxQA5bJYGIKXKpnGP2/zLDCg+jUY0Jo2bCiUYA==
X-Received: by 2002:a05:6402:5214:b0:521:66b4:13d6 with SMTP id s20-20020a056402521400b0052166b413d6mr10442417edd.4.1690228173749;
        Mon, 24 Jul 2023 12:49:33 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id l1-20020a056402028100b0052229882fb0sm2631314edv.71.2023.07.24.12.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 12:49:33 -0700 (PDT)
Message-ID: <e23cbae3-2a31-070f-e03a-bb6b5ff1ad76@grimberg.me>
Date: Mon, 24 Jul 2023 22:49:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH libnvme] fabrics: don't pass sqflow_disable if the kernel
 does not support the option
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Caleb Sander <csander@purestorage.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20230724090611.705366-1-sagi@grimberg.me>
 <CADUfDZr9bNo17_NmWLCu_kVdURQn7XbbwtZoi2XzF8NTNyL_VA@mail.gmail.com>
 <a20ee796-3690-9d2b-2363-4caaefc3aca9@grimberg.me>
 <udo5xyydb5jb6isnpcbutuegifww2kuto44k3yu3eb6mnctwia@d7lmpffppurl>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <udo5xyydb5jb6isnpcbutuegifww2kuto44k3yu3eb6mnctwia@d7lmpffppurl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_124935_912677_97AA27D7 
X-CRM114-Status: GOOD (  29.79  )
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



On 7/24/23 19:18, Daniel Wagner wrote:
> On Mon, Jul 24, 2023 at 06:35:55PM +0300, Sagi Grimberg wrote:
>>> How do we know options is initialized here? It looks like that's done
>>> in __nvmf_supported_options(), called from nvmf_add_ctrl(), which is
>>> called a few lines later in this function.
> 
> I've paired __nvmf_supported_options() with build_options(). We can
> move the call to __nvmf_supported_options() further up if it helps.

We really should just have an interface to check specific options,
because that is what consumers care about, not the entire opts set.

Inside you can do the open/read/close once and cache it in memory
(although I think this is a really unneeded optimization).

> 
>> This is for connecting discovery log entries, so the kernel cap was
>> already read once for the discovery controller.
>>
>> Although granted, this can be udev driven on an existing discovery
>> controller. Probably need to do it regardless of adding a controller.
>>
>> I remember when adding the capability to check supported opts I added
>> an interface to do it per feature. Not sure why it was changed, it is
>> much more sane to just read it on demand given that there is just a
>> simple and short string copy in the kernel...
> 
> I was trying to avoid to do a open/read/parse/close cycle for each argument we
> are going append in the build_options() function.
> 
>> Ideally this would become:
>> 	if (e->treq & NVMF_TREQ_DISABLE_SQFLOW &&
>> 	    nvmf_check_cap("disable_sqflow"))
>> 		c->cfg.disable_sqflow = true;
>> 	else
>> 		c->cfg.disable_sqflow = false;
>>
>> Daniel? Any reason why we are caching these opts in an executable
>> with a short lifetime? And apparently we need to be very precise when
>> we rely on this cache to be stable.
> 
> Ah I see, in this case let's bring nvmf_check_cap() (although I couldn't find it
> anywhere... I can remember I saw those patches)

I also remember making disable_sqflow check instead of a retry, so maybe
it got left behind...

> 
>> If you prefer to cache it, at least do it in the start of every
>> fabrics callback so we don't need to understand when this cache
>> is valid...
> 
> I don't want to cache it, I just wanted to avoid the above mentioned
> open/read/parse/close cycle for each build options.

So do you want to add the interface? Or should I? (assuming you agree
on individual opt check) ?

