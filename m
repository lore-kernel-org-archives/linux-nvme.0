Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D174CAC5AC
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Sep 2024 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LqWiWz/3Q/QL5GdvcfeJQoC6itwwR8nh7kyhVsUqNbY=; b=SPHrqd2xTO9W9tTyL+ZvhL4us/
	qwdgI9FjUpRJf+0wxR1AY0stdt6YePVEy/5y05O52silDzIkvLOHWYoNRkElJVSTFRw1aQJvvKyKX
	8stQugjgRCYpVZZZYBlat6oKZrdKzOsTYt5FoNJuOe1bHJUfCK3LuL67vWRb7RrVQQiEzkiUOpWCn
	6tF369XselmmhYM7JlHrTjOkHBEbvQL/QJjeDdfdFxS1R90JO7W96lcUdI9pcnDKnafeXRjfIMIe2
	hzt/FjJgtHd0AgVGVC3/SS8Sq/ip/5mcF0E+BsneBwhuB9mPi+Qa7j/Q1+313s/xRTMg+hGPwNULB
	lb1HiWqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sqiRH-00000007CcR-46EQ;
	Wed, 18 Sep 2024 00:20:59 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sqiRA-00000007Cbx-2gE1
	for linux-nvme@lists.infradead.org;
	Wed, 18 Sep 2024 00:20:53 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3e049185cfeso1635516b6e.1
        for <linux-nvme@lists.infradead.org>; Tue, 17 Sep 2024 17:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726618851; x=1727223651; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqWiWz/3Q/QL5GdvcfeJQoC6itwwR8nh7kyhVsUqNbY=;
        b=W0GOnJiThmIaiAdILiKqy3q5duxnx3mToUJNExNksXsp5+8Zhlyx2BcDr7fu7N0kX0
         afVm8SynnV2ytmbzthYoyrPkAiraw3ZTGHzrFPDGPXCob141/7Ql4I+Jf/QX59ympAlO
         JdA7s+M6UXW+vxZe6snqGxz5UkirDNckf+hS0cpoqNTZsZGPOUUyqvka9Z7kZpV16jlr
         CRYKt3xyfqZLNX0dWHWunq5PB8F/BsbkaX2YN7hUXKzURyCrNCFz/AMGoRpwtH4afXsN
         oBcrw3FddNBn+KOqJo21Vf7RBJnjvX0//p4PA2I6jH6zkxGuqo7oShIrX8lDg1CcsdSt
         9MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726618851; x=1727223651;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqWiWz/3Q/QL5GdvcfeJQoC6itwwR8nh7kyhVsUqNbY=;
        b=BauH3989G6nApU63jtQu6sXrEC+H8twCiBJ9TwAKIh+TAiSOm19Q6sirq74c/Syazl
         eS2LSMhQdSqyW6RkV7Ck3nkazKsk5o7ZcOc3QD7yGtg8plJxclqf55Wz9xu8c5mXg9xh
         h2pCkNd/YE9/foL1f6/stItwRIueFPRNlOg9zSDDKBBisYiJQGMjWXIBi7YPrv4braBO
         xtpmFTy2cbZlusRxekGQcHne+x4fgmnfgmAyhWUh0nRS/MPkjldkYgYKAGiIIovB/bet
         liAjI9/bJKs9z2ec9Fvm5zgxXalzBXrpwufaM35UzdNZSAG7K3J60rhScg+KQgZe7ud7
         TJqw==
X-Forwarded-Encrypted: i=1; AJvYcCUgVf729+eNoC4Xqnr7hB2GiAjgx9sel9/8EyQgazHfOMRFDTuH8u5J8W4/55HF3OqGoBBd69OgqgoT@lists.infradead.org
X-Gm-Message-State: AOJu0YyQuLzTwi/H4JuLWoBNbrhY1GrBg84Qt0ApPzF/gpVl2AlhlnTL
	z/Xw1sp4F/MjHvLOhunhDydgLDMxBM82G96LDfv4HsqpQf3xQZC5
X-Google-Smtp-Source: AGHT+IHU5iG9yyO7j+6a1zICs4U4cy/+cqrMCAnH11yBCKuqKS6+7NuNHCoH6dNhLI1L46BiFFtaIw==
X-Received: by 2002:a05:6808:2009:b0:3e0:4ecb:e90b with SMTP id 5614622812f47-3e07a0ed95cmr10499932b6e.1.1726618851372;
        Tue, 17 Sep 2024 17:20:51 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e166cfb847sm1719398b6e.22.2024.09.17.17.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 17:20:50 -0700 (PDT)
Message-ID: <751d4ba8-1e35-47a5-9a94-9873ff2619ae@gmail.com>
Date: Tue, 17 Sep 2024 19:20:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: fix async device shutdown hang
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Nathan Chancellor <nathan@kernel.org>, Jan Kiszka <jan.kiszka@seimens.com>
References: <20240917201517.1145331-1-stuart.w.hayes@gmail.com>
 <2024091753-estate-legroom-5d62@gregkh>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <2024091753-estate-legroom-5d62@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240917_172052_713114_7BACF0F2 
X-CRM114-Status: GOOD (  20.21  )
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



On 9/17/2024 3:42 PM, Greg Kroah-Hartman wrote:
> On Tue, Sep 17, 2024 at 03:15:17PM -0500, Stuart Hayes wrote:
>> Modify device_shutdown() so that supplier devices do not wait for
>> consumer devices to be shut down first when the devlink is sync state
>> only, since the consumer is not dependent on the supplier in this case.
>>
>> Without this change, a circular dependency could hang the system.
>>
>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> What commit id does this fix?  Should it go to stable?
> 
> And what driver is causing this problem, is this a regression or for
> something new that just got added to the tree?
> 
> thanks,
> 
> greg k-h

This fixes commit 8064952c65045f05ee2671fe437770e50c151776, in
driver-core-next & linux-next... it's problem with code that was just
added to the tree (in drivers/base/core.c).  It is not in stable.

Apologies, I should have mentioned that from the start.

The issue was found using qemu... a pl061 device (supplier) and
gpio-keys device (consumer), from a qemu-generated device tree with
the aarch64 architecture.  I don't know why the devlink is in the
sync_state_only state in this case.  I didn't dig into that, because
I figured the shutdown code shouldn't hang regardless.

