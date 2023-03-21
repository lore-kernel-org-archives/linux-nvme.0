Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E39C6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8E23RFEECA3mIcBRVUK7JDK1NXaQ5061nvfHmW6h3x0=; b=hVkBJK8GBgQzu/KPW/d4BvsDha
	Oz5pH/qD/ZzKl7Xy6+CseHPGeHxPW4uJY5j8+9aJeilOIzkRloAdMNNp/HFNqCvEeDGzl5PlFaxMk
	dagfFD7rhwE4RnsTPaBFU74cWX8RDPxVdoXiYOOpeSFxl0Ugwi5JHfWwGEXXlFhv1WyMPjH9ccsSR
	f8yrXMWAx7AfLI0bRSGtKXTQUFbNfwlhQ4ml0NWdhtuVAPpeUR8spvWlS6nKKcOJA+NjOyJgACYOH
	IUeWwKgj85qACPolhFsCM3qJCAD4nyut8ZHlRosf+Gbb5E2QN7PE0rQnfUtlvu7f+tquHh1BrNDcO
	87LETWFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peZcV-00C6xE-1z;
	Tue, 21 Mar 2023 10:53:35 +0000
Received: from mail-ed1-f48.google.com ([209.85.208.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peZcT-00C6wT-0e
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 10:53:34 +0000
Received: by mail-ed1-f48.google.com with SMTP id i5so10999364eda.0
        for <linux-nvme@lists.infradead.org>; Tue, 21 Mar 2023 03:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679396011;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8E23RFEECA3mIcBRVUK7JDK1NXaQ5061nvfHmW6h3x0=;
        b=QtXOmG0Xww80wns7dWbinAPmDRq5d54jO+FPwXRUsrRbM5vx4sZrqnK6e+lvNiLZGM
         lqTlfKIjLtX8c3Q+KYynY5F1wqyee2blaXwswkVNJZQSMMkr8rxcjIWm1HcVHah+uoAM
         SbHv+zSnRKOHsDnSh9hphb5APeUH29+NrRMkZYmkGD9pGQ5IFQ1E4HPfJMg+ae+191zF
         qqqCy9TlUzBAH4n8OmYY3PllgU/YIMdXUbbQtbaBPYMkzDDH510x55rEweX2ogrZjGfp
         vEpyBj8I5xBp3V1l5iPq6BhMf2VLETMKmo0xphG5OT+RrsJ5ucuY1MU189tL5JZK2zlH
         2aeA==
X-Gm-Message-State: AO0yUKX3EwLLo1LCdg1Z0GGw0w5p+UvfHw9el8aqpkLeNS5gHq8YyfYM
	NFjx6CxtUASsxanYZPMXd6Q=
X-Google-Smtp-Source: AK7set+oixMeEwENR0kKjgFvu9GVfgcnNce1HRnbEJ0S/RORaCxu4J3BWayseQJf4x0Vtn+q7bhjYQ==
X-Received: by 2002:a05:6402:27c7:b0:4af:81f1:5b02 with SMTP id c7-20020a05640227c700b004af81f15b02mr3309411ede.2.1679396010928;
        Tue, 21 Mar 2023 03:53:30 -0700 (PDT)
Received: from [10.100.102.14] (85.65.253.165.dynamic.barak-online.net. [85.65.253.165])
        by smtp.gmail.com with ESMTPSA id a18-20020a50c312000000b004c06f786602sm6077948edb.85.2023.03.21.03.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 03:53:30 -0700 (PDT)
Message-ID: <f2653732-5566-ba2c-1dc5-412b20879ef8@grimberg.me>
Date: Tue, 21 Mar 2023 12:53:29 +0200
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
References: <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <20230321104009.nltadi6zs6iz66h4@carbon>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230321104009.nltadi6zs6iz66h4@carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_035333_236489_3CB2992A 
X-CRM114-Status: GOOD (  12.78  )
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


>> admin_tagset.nr_maps = 1 (only the default map, no read, no poll)
> 
> Indeed, that would be to easy.
> 
> I've just triggered a crash where we are passing in a non-null bio. Some
> more annotation. This time I am printing from blk_rq_is_poll() and
> we see that that is also the case where we have a valid bio but
> want to use the poll context:

That is not a crash, but a WARN stack dump. It is still unclear to me
how exactly you get to poll for a bio-less request.

See my other reply, While I removed the below warning, and allow
bio-less request polling, I was not able to observe any bio-less
requests actually being polled.

