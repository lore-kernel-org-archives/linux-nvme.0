Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29D8C54EBE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 19:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NsOBWIJteC0VRYZtDbjr5jj3gIxlOseLxW6/1XxZLe0=; b=TXg42p3BqzFJ9G05fTwZ6keqor
	5B5xgYl8kz0Fuce50ItHjg6mNdKtiT6wAib5YsPQBM7beSG2OnVPNDv1R/medUIONPba6W9xHMoIa
	bhLHnQpKEYlXJxKQqDebWHLbdSQggiO651//7+oJEtQXk31iVI81U0DI4//wOsrVYd3z2T7J4kNP5
	OqqIdJAFuThK32dTZRoFhs1wfCMd9qs9ljvbo+OCB4ZP18oFh2/ZHfsnwCCZZqhV7fxDJS4ccMsDj
	MkQUDBSZWjEbmamzl2QRE4Wrvv4jCvbLfxqcy5znssl2A+cdsLldM2eea2SDv3OYtH17CS+702nzY
	MYtaasIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG32C-00GPjY-6o; Thu, 12 Jan 2023 19:14:44 +0000
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG329-00GPiq-A6
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 19:14:42 +0000
Received: by mail-oi1-x22c.google.com with SMTP id d127so16034286oif.12
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 11:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NsOBWIJteC0VRYZtDbjr5jj3gIxlOseLxW6/1XxZLe0=;
        b=eNPG6S5fUjVw+Ey08QFTQkOynPTzVj+KWmMnw69e3fHXBA7HCzsbBwjbTPJfIZ7Kb/
         gX70piwIMpzm/h3nFNeOQkp4yHwCTinh59sNUMy8hde6dVNtyK+41cd/BB0LZiT4iJiU
         cjbUwdN8VFXclu2NH/V+oGaJ4GsKnS3nJw5yQyGfmVVJ+N6C8w6B9Wr2bvqE8G9vBUG0
         gZ+E2Pa6VTBu3zca6Zp1EuIBuEsg2Owv1cQmuBG1/tNsObhFL/jeXuQE3gdcdI9IvPjT
         n4o/6CxtuTAC1up/zZXQcv297Q7bpaWQ/42sa/ftnmb3kKW5Sw9Bz/mIxg7rFuyAaqw0
         yEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsOBWIJteC0VRYZtDbjr5jj3gIxlOseLxW6/1XxZLe0=;
        b=K+1X68kw6IIPiYX1nm4VNyPD7DOpMdnRRM9dupDO1RjRAklDRGND0WAu3F2n0OO3yN
         J1mAdFF2S6ybhtya4g9iMjo30dgqZC8BYT7iDQ0MRNsoiIBhe7KPE72vgjHTcjsiqq2G
         g7N3QZfB8cwPPF9wxrkekoUUQFGJ0Ho8vWFjvixxuiKSFuhEClTH7/EAnXQuwaba+8FY
         sQFontuqQvjWwvKNDZyXLU5BH11QoEn5O7adqSQXXw6mTtBmfqTCWVD9ltqVa2KU+iXN
         mOGpzycHLWeRIeU8rZrtcWzdDpMamkkOOQhLERWsrD1aKdGJkdyFdBw3lkqsUWDMqUNR
         Lc+A==
X-Gm-Message-State: AFqh2kpQHzOg7yZ5/cslwjyMud8s3I9c3v+E0PZF7Sf74PzdApWb46+S
	zckUMK1UOX5jotAb6m0+EjU=
X-Google-Smtp-Source: AMrXdXuSM6vAPiDC3hYPl1UXoJfs7PQQsJthqXYogK1JY80jp3kRsns6XlEKhceAuNUVrXtTT2wd0Q==
X-Received: by 2002:a05:6808:8e4:b0:363:8f75:a1bc with SMTP id d4-20020a05680808e400b003638f75a1bcmr23328385oic.15.1673550879738;
        Thu, 12 Jan 2023 11:14:39 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q2-20020a9d6542000000b0067088ff2b45sm9381708otl.37.2023.01.12.11.14.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:14:39 -0800 (PST)
Message-ID: <3044a2d0-9e77-c936-b6e3-dfd9ad7d2c06@roeck-us.net>
Date: Thu, 12 Jan 2023 11:14:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
 <Y8BHUzcbdQ/SFBY9@cormorant.local>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
In-Reply-To: <Y8BHUzcbdQ/SFBY9@cormorant.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_111441_397382_F39EDC5C 
X-CRM114-Status: GOOD (  24.49  )
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

On 1/12/23 09:45, Klaus Jensen wrote:
> On Jan 12 09:34, Keith Busch wrote:
>> On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
>>>
>>> The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
>>> am wondering if there is something going on with the kernel driver (but
>>> I certainly do not rule out that hw/nvme is at fault here, since
>>> pin-based interrupts has also been a source of several issues in the
>>> past).
>>
>> Does it work if you change the pci_irq_assert() back to pci_irq_pulse()?
>> While probably not the "correct" thing to do, it has better results in
>> my testing.
>>
> 
> A simple s/pci_irq_assert/pci_irq_pulse broke the device. However,
> 
> 	diff --git i/hw/nvme/ctrl.c w/hw/nvme/ctrl.c
> 	index 03760ddeae8c..0fc46dcb9ec4 100644
> 	--- i/hw/nvme/ctrl.c
> 	+++ w/hw/nvme/ctrl.c
> 	@@ -477,6 +477,7 @@ static void nvme_irq_check(NvmeCtrl *n)
> 		 return;
> 	     }
> 	     if (~intms & n->irq_status) {
> 	+        pci_irq_deassert(&n->parent_obj);
> 		 pci_irq_assert(&n->parent_obj);
> 	     } else {
> 		 pci_irq_deassert(&n->parent_obj);
> 
> 
> seems to do the trick (pulse is the other way around, assert, then
> deassert).
> 
> Probably not the "correct" thing to do, but I'll take it since it seems
> to fix it. On a simple boot loop I got the timeout about 1 out of 5. I'm
> on ~20 runs now and have not encountered it.
> 
> I'll see if I can set up a mips rootfs and test that. Guenter, what MIPS
> machine/board(s) are you testing?

See
https://github.com/groeck/linux-build-test/blob/master/rootfs/mips/run-qemu-mips.sh
and
https://github.com/groeck/linux-build-test/blob/master/rootfs/mipsel/run-qemu-mipsel.sh

I'll apply the change suggested above to my version of qemu (7.2.0)
and give it a try.

Guenter


