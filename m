Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE272C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 09:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hJNoa6jGs6ri5wzHEjiChjmdz+hHMhuIX5BmeXd8l98=; b=xlJPJB6G0yNRuyQg47B2TPnT6J
	6Nuhc/xgbN3IW7hi82++IwygiofwveWKaLcfAdFR1+BhzYvkV5cpoWIDsVTuQxyTHnjmCrYypprn7
	1pXQCqfksbUxUjeP2BKQl5SXBais9d4huCnjDDshHXfuVdf3qLQLw1GoFzqv+DUuOMmP298HUhj37
	Hp8IPExQUwkhzytk0BXbswYGaVqagCQtEuj9PUFp+4wT1YvuRcsNxt1jF/9kSbCJImZy5e89Bw/+j
	HrWM9CsBEoyTyQLgT8jYrLD+z9g26V6CnJaUmjGESzD4vXavXSQn88z8es0xlB2VZwZqMT7ZGpZpF
	BNbuH0tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaZnF-002Y76-PX; Tue, 20 Sep 2022 09:43:53 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaZlW-002X5C-3d
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 09:42:08 +0000
Received: from [2a02:8108:963f:de38:eca4:7d19:f9a2:22c5]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1oaZlP-0004Pr-FG; Tue, 20 Sep 2022 11:41:59 +0200
Message-ID: <18e67378-1365-5e36-981b-13cada73bcda@leemhuis.info>
Date: Tue, 20 Sep 2022 11:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: "nvme nvmeX: IO queues not created" with "Amazon.com, Inc. NVMe
 SSD Controller" from 5.19.y (issue bisected)
Content-Language: en-US, de-DE
To: "Sironi, Filippo" <sironi@amazon.de>, Christoph Hellwig <hch@lst.de>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 "Greenberg, Aviv" <aggreenb@amazon.com>,
 "Dutta, Soumyaroop" <duttaso@amazon.com>,
 "Priescu, Valentin" <priescuv@amazon.de>, "Machulsky, Zorik"
 <zorik@amazon.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "niklas.cassel@wdc.com" <niklas.cassel@wdc.com>
References: <CAK8fFZ5vajOJGSwA53tU=Y2-jf0rnJWOjkadgqRCTf38bF0YXw@mail.gmail.com>
 <20220907062919.GA21266@lst.de>
 <010D1898-D943-44D6-9EB3-44E599F8AE84@amazon.de>
 <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <3E46620F-C371-4108-9A74-AA1A624AA9A5@amazon.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1663666926;e5ac02af;
X-HE-SMSGID: 1oaZlP-0004Pr-FG
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_024206_355928_13521C3A 
X-CRM114-Status: GOOD (  21.36  )
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

Hi, this is your Linux kernel regression tracker.

On 07.09.22 11:58, Sironi, Filippo wrote:
> Adding more folks (Soumyaroop, Valentin, and Zorik) involved in the investigation, which is by now concluded.

Has any progress been made to get this regression fixed? I might be
missing something, but from here it looks like nothing happened since
two weeks. Thing is: ideally it shouldn't take this long to fix
regressions in production releases, as explained in
https://docs.kernel.org/process/handling-regressions.html

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I deal with a lot of
reports and sometimes miss something important when writing mails like
this. If that's the case here, don't hesitate to tell me in a public
reply, it's in everyone's interest to set the public record straight.

#regzbot poke

> ﻿On 07.09.22, 11:13, "Sironi, Filippo" <sironi@amazon.de> wrote:
> 
>     I'm aware of a customer contact regarding this issue and I know that the team responsible for the NVMe implementation is investigating.
>     Adding Aviv since he's closer to this space than I am and may have more insights into how the investigation is progressing. 
> 
>     On 07.09.22, 08:30, "Christoph Hellwig" <hch@lst.de> wrote:
> 
>         CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> 
> 
> 
>         Filippo,
> 
>         can you help figuring out what is going on with this Amazon controller?
> 
>         On Wed, Sep 07, 2022 at 08:05:05AM +0200, Jaroslav Pulchart wrote:
>         > Hello,
>         >
>         > I would like to report a regression issue in 5.19.y in NVMe driver.
>         >
>         > The issue is reproducible at AWS EC2 instances with local NVMe storage
>         > like "r5d.*". Kernel report "IO queues not created":
>         > [    2.936641] nvme nvme0: 2/0/0 default/read/poll queues  <- EBS volume
>         > [    2.939493] nvme nvme1: 2/0/0 default/read/poll queues  <- EBS volume
>         > [    2.940797] nvme nvme2: IO queues not created              <- Local volume
>         > with 5.19.y (kernel 5.19) and the nvme storage cannot be used.
>         >
>         > I bisected the issue to commit
>         > "aa41d2fe60ee2e4452b0f9ca9f0f6d80a4ff9f9d" (nvme: set controller
>         > enable bit in a separate write). Reverting it makes the nvme device
>         > working again:
>         > [    3.025599] nvme nvme0: 2/0/0 default/read/poll queues
>         > [    3.032467] nvme nvme2: 8/0/0 default/read/poll queues
>         > [    3.040040] nvme nvme1: 2/0/0 default/read/poll queues
>         >
>         > Best,
>         > --
>         > Jaroslav Pulchart
>         > Sr. Principal SW Engineer
>         > GoodData
>         ---end quoted text---
> 
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

