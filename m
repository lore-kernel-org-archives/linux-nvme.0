Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68016C54EBE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 23:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12vlNogeAjPeZ5vEuK5DcrEwh/Fjwxuilk73/GGjPfg=; b=gOP5iMRPK6kGU26AjkiI/DlAqP
	OeYm0Va19YNzUctLT9tG1s1lo6Pnj2CKqA33xqw5BgvYppyCIm6L3D6nrzseUHVA0b07L1H2gDDNH
	h1tsE7F+kJnGV7LfdrVlQKcFWNUuEpLG7dwPyKiZjgoRP+KuoBL2HWYj5gOoRRHS+JjSYetOhDKFo
	1eCnQH+TItTcleK40Az6muN00QD3LvXiUgjK6GcjYEEc2r+4rioeWCGHrAD+fIAtw8Z1InAOsizaq
	67HodGxOtDqoFMxvSUAEh8c/CxRuVBz/0lKHasqJiaiR8LUWnK/GqLaHwJpzb8U/W98HVnTtLoTXS
	OddZM7tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7SG-00HWI0-Fo; Thu, 12 Jan 2023 23:57:56 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7SD-00HWHA-BT
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 23:57:54 +0000
Received: by mail-oi1-x22f.google.com with SMTP id o66so16571894oia.6
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 15:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12vlNogeAjPeZ5vEuK5DcrEwh/Fjwxuilk73/GGjPfg=;
        b=NMVFE/A599F2BmvazvkAXKstwrTfcd5YqVr6z2ammKU/XWwFhhjW2BL1oZwB7fo3mS
         lzhV8DG89EWJaMUsZcuPxD+7DuWk5X4ArFf4ZxIv8Bltw94BPIZAeLiikb1Vh8EeAYwv
         3ED4vcEXvMRXExDirSDGvqiLdQHn9Z6bJ8y31nJqPiND3xf2MjBt1VT7EQiQfOH/nnSP
         e6CZXERsKTdQrryg1EIwXqNVDqFa+tmSVWg34DZ77VlPFLLBSh3KT80r8Gg/N3QV+vFt
         63cKqpGiE9lEkiHt4jg8tMqALlkRA/BI5k7DXBbfmoW1esam2MUU1P+CCcdaF60w3fDi
         Dt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12vlNogeAjPeZ5vEuK5DcrEwh/Fjwxuilk73/GGjPfg=;
        b=TnzwI0z0b0eZrM8gqnBo3jMYnF8wwSzv75UhnMQt5gdsnsNaoZVtyyPBhZqNPnpJ2E
         T0H6zw4AqELiKXzcaflf4yCeh/qSa4ku1t0YsnkUWQllZnGtS4w86Fr0t/S9ij5YwJtN
         WqU+xm0R+ITPsriqoj1wFg3oJ3Le8JZQq4OSoyupkCcNTE/rfiTvQF6SbyjADZRdJHpZ
         mHPtl8ZOGaHFPbsFWb95yfXhiZRQ+zlQjjpqVGm2XRebUj8yV3n95qKOzaDhREZ4Z1Ck
         G3fnxWGqpH6fSWmbiBy19pMvg2ItbA54tKss25x+xl76qcnfNbUHAKvSVtkz4AQAEyqK
         dnXg==
X-Gm-Message-State: AFqh2kqseVn4k/+jzasXkUiLRidLU962cyA+aecXH6MjxO1Vgz7VkLYQ
	1OsTFlOSHC1HTC80lsBVvAM=
X-Google-Smtp-Source: AMrXdXvkyOv9cX1CPAsyCOn4OyE7FHGXX+1a1Tj3qa6RccP7w8XcQw5nDA9BhkSU/8Dnp9lxA6w4Fg==
X-Received: by 2002:a54:4e83:0:b0:363:b918:6467 with SMTP id c3-20020a544e83000000b00363b9186467mr16877321oiy.10.1673567871747;
        Thu, 12 Jan 2023 15:57:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-20020aca0f03000000b0035acd0a6eb2sm8568038oip.41.2023.01.12.15.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 15:57:50 -0800 (PST)
Message-ID: <c42afb39-db63-eeb4-3f53-e9684dca5938@roeck-us.net>
Date: Thu, 12 Jan 2023 15:57:48 -0800
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
X-CRM114-CacheID: sfid-20230112_155753_447610_871089EF 
X-CRM114-Status: GOOD (  25.05  )
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

So, for mipsel, two sets of results for the above:

First, qemu v7.2 is already much better than qemu v7.1. With qemu v7.1,
the boot test fails roughly every other test. Failure rate with qemu v7.2
is much less.

Second, my nvme boot test with qemu 7.2 fails after ~5-10 iterations.
After the above change, I did not see a single failure in 50 boot tests.

I'll test the other suggested change next.

Guenter


