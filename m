Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD35C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p09z18MHQtmtgxHUiCsHloFQELrsLU0JKItv2cpiP4w=; b=mqFU2WADL2T7kEFxGepxtRQ051
	WvEslKBtbgcE0LEi47So4XHQ3UQvKlLMXGeQrtxJxFQfks/8wEa9smv8Z8+0dYTKTH/eTyqit/W7x
	UAT5QKnXSA5TDIKjvsqbhTgBKGD3pnWTZeasKHsAkTF8iyLiN27W/FV6iyayXf3a+uWeO9edsyNLt
	PId53Ix+4Zvkps5AxrHLYbwfNxkpxbsfFqW0uE9b5FM3Q+gXiAL7K8lTOL/Ph+DbP9c/8je5SVucs
	kkbp9gUiG6qKXT2pmLjnGgbrbQEuQNHH6ReJVTXIfJPdEs8zInjizNh2YJ8AcEiu6jOG3yOaKcBVJ
	CKrNozTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWiVg-00Bl5K-7G; Tue, 22 Mar 2022 17:41:32 +0000
Received: from foss.arm.com ([217.140.110.172])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWiVU-00Bl0a-Fo; Tue, 22 Mar 2022 17:41:22 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D631042;
 Tue, 22 Mar 2022 10:41:18 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0043F66F;
 Tue, 22 Mar 2022 10:41:15 -0700 (PDT)
Message-ID: <e9e589fe-8363-3f52-e9cd-08778485ad79@arm.com>
Date: Tue, 22 Mar 2022 17:41:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 5/9] soc: apple: Add RTKit IPC library
Content-Language: en-GB
To: Arnd Bergmann <arnd@arndb.de>, Sven Peter <sven@svenpeter.dev>
Cc: Hector Martin <marcan@marcan.st>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Rob Herring <robh+dt@kernel.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Marc Zyngier <maz@kernel.org>, DTML <devicetree@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-6-sven@svenpeter.dev>
 <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAK8P3a2VgrWHerXTX4_wS8UU7fpN9-JZ5xESaWrr-WGYqGty=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_104120_603998_692EDBEC 
X-CRM114-Status: UNSURE (   8.44  )
X-CRM114-Notice: Please train this message.
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

On 2022-03-22 13:13, Arnd Bergmann wrote:
>> +#define rtk_err(format, arg...) dev_err(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_warn(format, arg...) dev_warn(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_info(format, arg...) dev_info(rtk->dev, "RTKit: " format, ##arg)
>> +#define rtk_dbg(format, arg...) dev_dbg(rtk->dev, "RTKit: " format, ##arg)
> 
> I generally don't like the custom printing macros, please just open-code
> the prints where they are used, that makes it easier for other kernel
> developers to see exactly what is being printed

More to the point, implicitly depending on having something named "rtk" 
in scope is pretty much inexcusable, and the only thing left after 
fixing that is what we have pr_fmt for ;)

Robin.

