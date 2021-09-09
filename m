Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C978CC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:55:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B39160FC0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 08:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B39160FC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n7UCY/cHd8O7AebPsFhFFm3LfWj8UBNUfQjaJnk9N3Q=; b=BQmlr9arTIdbE++txZDqm3uLUJ
	ilvGe/snA0F3ANzR6uUGCgzWqlMjIlMMMejJiTAI0myhESruT24pakU7pbyrZo16di4QLxRCGpP8I
	sEOZkeAaQxOREJFN0BlxsvnnJLTqJbaYXj4qjrrM5nYC0GMD1+2BBaXyDZ9Oq0+eGMgzyl05oJToh
	cjhdyCTB+XQ3OJ4dws0kdYMeKn3K8EwPB9UL6zUqE52Ok7byZiyF0NaCrJGKule1kzbR7EfjjCXs6
	V9UbMRk/Kz964cs9RWovCPIcKDXx1j+uZcTa4PG+0tb3jPnk+ppTQyd1PjOaS6pJfYYLkwbiXRqed
	Zr1dVkWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOFqG-008emT-2V; Thu, 09 Sep 2021 08:55:32 +0000
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOFpM-008eLo-31
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 08:54:37 +0000
Received: by mail-ej1-f44.google.com with SMTP id x11so2158773ejv.0
 for <linux-nvme@lists.infradead.org>; Thu, 09 Sep 2021 01:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5dci7kCOWKoZHzTsFO20dBKayTJLyuoCfp6RctfUQdQ=;
 b=mm0U3bQdxt5UmJ9zNPcVSaWZVp/IKRYjDgAQQy9oSRhx2Fy3mX7TbJvT7TsPtf68Pe
 LFMrb3oEuLQfGWb9RzzYLMnXXN6NsKqJeewVtl8k2AiEiPjslvIRkkUn8Xt36PZE5u9J
 fcaM9TgOLWQnqscnyHwV+ybyINYHKAK8NosCUKYsTNZX5pL90X+mayesrI2nWTYiR717
 viIs+XuJlCnPovVcWTwYfJ6NKC9oqhfDKZeDV1JcoDeLXhJEiyzksIprNv7lJkEvKZ3b
 VOPmvA+0DbA7uBVpyx+t7cnDnQJSh/UGJFJ3xrDAa+VhJELTjPBO7iGMs3nRcB+7bHU3
 X4Nw==
X-Gm-Message-State: AOAM533p9lfMC3/H6ZL7YMTpTzOPm1mT9+HsimEdacboj2peu4TRXjyl
 An095Oinxw8SWdfb0daRstqwFn8o2UY=
X-Google-Smtp-Source: ABdhPJyzlcaQ6EAQLE1N355dth8HYZSn7CvXNGTY89gV7VJLsZMaWpfKSQtTTiro+zHWp4/IzeG+rw==
X-Received: by 2002:a17:906:e82:: with SMTP id p2mr2218918ejf.50.1631177673953; 
 Thu, 09 Sep 2021 01:54:33 -0700 (PDT)
Received: from [10.100.102.14] (109-186-228-184.bb.netvision.net.il.
 [109.186.228.184])
 by smtp.gmail.com with ESMTPSA id w9sm670367edr.20.2021.09.09.01.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Sep 2021 01:54:33 -0700 (PDT)
Subject: Re: Command timeouts with NVMe TCP kernel driver
To: Samuel Jones <sjones@kalrayinc.com>
Cc: Keith Busch <kbusch@kernel.org>,
 linux-nvme <linux-nvme@lists.infradead.org>
References: <1058345072.5039165.1630330229081.JavaMail.zimbra@kalray.eu>
 <337815466.5790984.1631005553242.JavaMail.zimbra@kalray.eu>
 <20210907164236.GA367782@dhcp-10-100-145-180.wdc.com>
 <20210907204615.GA591280@dhcp-10-100-145-180.wdc.com>
 <473ad941-a01d-8107-a6a8-6d051f6955a5@grimberg.me>
 <20210908215017.GA2116734@dhcp-10-100-145-180.wdc.com>
 <9266ad25-ec2c-377d-092d-941f26371c7b@grimberg.me>
 <dc84f3ee-5f22-2f79-5483-9ae0235e42fe@grimberg.me>
 <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7e313963-b377-74ef-2fb2-650e15cde2e6@grimberg.me>
Date: Thu, 9 Sep 2021 11:54:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1537083616.6148364.1631174974578.JavaMail.zimbra@kalray.eu>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_015436_184121_081FAF6A 
X-CRM114-Status: GOOD (  11.80  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> Keith, can you send a proper patch with a Fixes: tag and a descriptive
>> title so this can go to stable.
>>
>> And let's wait for Sam to do some more extensive testing. Ideally we can
>> also hear from the WD folks that this doesn't cause any regressions.
> 
> OK, I'll do some more testing over the weekend and let you know next week.

Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
