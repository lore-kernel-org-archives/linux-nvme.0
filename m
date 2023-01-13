Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B0C54EBE
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jan 2023 00:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iETZ/ppT1I5S+FDAOeF6ilEfn66LFjmIhqXZeNfMOQo=; b=cNOG1imMbzUJ61k/HQ3/QkOuQH
	vXG+L03JnziFVL4rW0TlZa/zwfBOO4o68AzQ0ae5opJxtnh2KYBm4ZhvWksdLENRYLBZg2C5CR+ZD
	jSQ1baO+0fVFhi3qwJduFwIE+9eVu8WZ0o2UIkBpMy/OQeaf+2i8EMupPNeWz9Z72K1cteIzfc5KL
	nnWxT0Jw44gdtsoJx1RAbgb1u0PL1Pq1hsDo3HYxvqVdhMoECLdX+TjAuNx9I3vYJF4V9xa8ZfK5Z
	kDCs+a+k/OSaseo/LIc5UIgukmH8vgHR2q83n6YtKqebdlvr79lRpuyj7l9PaOuccGZdXhYawA5xq
	b5GkUJrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7un-00HZqB-VF; Fri, 13 Jan 2023 00:27:25 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pG7uk-00HZpi-Mo
	for linux-nvme@lists.infradead.org; Fri, 13 Jan 2023 00:27:24 +0000
Received: by mail-ot1-x336.google.com with SMTP id p17-20020a9d6951000000b00678306ceb94so11499229oto.5
        for <linux-nvme@lists.infradead.org>; Thu, 12 Jan 2023 16:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=iETZ/ppT1I5S+FDAOeF6ilEfn66LFjmIhqXZeNfMOQo=;
        b=i9Gs07Too9OiCIpFoygg7wZYVoCJU5C0YhjpQu7bJ9yvaq870mjaKpeYDzVSPotzk5
         ow1YinMmit7F+gBuzHOjz+0V4MLJZY55q4AoQ6XHf8hmt7n7p07Bmmvuhqbj9I2VBen2
         xJiiyOptPi1fhINwtY6CSt4wRhS3uOfNvWob5vh4lBgFKzaTmvfTsGs9IwcxTYt12CYQ
         /Q0GF73ZfRStl3Yn9og9IZND4kEbbkPqV2vqbFrPj9uclXiUR1ag2ssLbrtYxP4mRmKA
         npXqJRyuqZMW5yrYqlbYhK5zK6IvP9bLeRh3s+Hmd9rgIxEzq/hCXdoB32w+ZzkG5zim
         my8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iETZ/ppT1I5S+FDAOeF6ilEfn66LFjmIhqXZeNfMOQo=;
        b=zIVMvIEslagAAsa8vKfJozTX1Am8Uu/6R6A4gTuRl4wxg+kH6m+5GXqoDSXCyK9LH4
         VAOrEhutP7vQMtMoiHUDDmw7r8JHAjuNaY+PffYFTVfEJKLwDlCgEPaEuDSEn93lPxDw
         h75w0yxYU3pYFAm2XOjilJd0uiI7KGF0TjBSn61UAMsXa5HSk09vNrcWgP2TOH6CqxCQ
         c2aXhkuu6yVXsEHLB7ROVtjeGIVpCeWzDyX8Av1rxm1Dud9acuabPPPB5s88vJqukLuJ
         kDH65Jwrn9NJdznbd2yN7Rf5K5KoMceOE+3c7QwthCUjFrhnxolPRW9tU7/T6XH9RbXs
         8rYA==
X-Gm-Message-State: AFqh2ko+4bqP7EKDOEX1Qi3m51Nwy3GXSnglNjbreX/sB7Y0z3DqB1ML
	Wg81laiDHuXjySYG3Z/ATjopfa4tCRQ=
X-Google-Smtp-Source: AMrXdXuLQjE1Djl4rb4iLWrQ/B9nfjKbjbCMs+IYHFztCHzs748rsNQI8FVNiSXoMreCawjrCVUxzA==
X-Received: by 2002:a05:6830:380c:b0:66e:73ae:547e with SMTP id bh12-20020a056830380c00b0066e73ae547emr46378578otb.1.1673569641196;
        Thu, 12 Jan 2023 16:27:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g26-20020a9d621a000000b0066ca9001e68sm9787394otj.5.2023.01.12.16.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 16:27:20 -0800 (PST)
Message-ID: <93ddcedd-d419-81ee-466b-a5285c45ed36@roeck-us.net>
Date: Thu, 12 Jan 2023 16:27:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <Y8AG21o/9/3eUMIg@cormorant.local>
 <Y8A2qdbDZPicuZfL@kbusch-mbp.dhcp.thefacebook.com>
 <Y8BHUzcbdQ/SFBY9@cormorant.local>
 <Y8BfJdTiHlaPdddR@kbusch-mbp.dhcp.thefacebook.com>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y8BfJdTiHlaPdddR@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230112_162722_799041_2688F1EF 
X-CRM114-Status: GOOD (  29.04  )
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

On 1/12/23 11:27, Keith Busch wrote:
> On Thu, Jan 12, 2023 at 06:45:55PM +0100, Klaus Jensen wrote:
>> On Jan 12 09:34, Keith Busch wrote:
>>> On Thu, Jan 12, 2023 at 02:10:51PM +0100, Klaus Jensen wrote:
>>>>
>>>> The pin-based interrupt logic in hw/nvme seems sound enough to me, so I
>>>> am wondering if there is something going on with the kernel driver (but
>>>> I certainly do not rule out that hw/nvme is at fault here, since
>>>> pin-based interrupts has also been a source of several issues in the
>>>> past).
>>>
>>> Does it work if you change the pci_irq_assert() back to pci_irq_pulse()?
>>> While probably not the "correct" thing to do, it has better results in
>>> my testing.
>>>
>>
>> A simple s/pci_irq_assert/pci_irq_pulse broke the device. However,
>>
>> 	diff --git i/hw/nvme/ctrl.c w/hw/nvme/ctrl.c
>> 	index 03760ddeae8c..0fc46dcb9ec4 100644
>> 	--- i/hw/nvme/ctrl.c
>> 	+++ w/hw/nvme/ctrl.c
>> 	@@ -477,6 +477,7 @@ static void nvme_irq_check(NvmeCtrl *n)
>> 		 return;
>> 	     }
>> 	     if (~intms & n->irq_status) {
>> 	+        pci_irq_deassert(&n->parent_obj);
>> 		 pci_irq_assert(&n->parent_obj);
>> 	     } else {
>> 		 pci_irq_deassert(&n->parent_obj);
>>
>>
>> seems to do the trick (pulse is the other way around, assert, then
>> deassert).
>>
>> Probably not the "correct" thing to do, but I'll take it since it seems
>> to fix it. On a simple boot loop I got the timeout about 1 out of 5. I'm
>> on ~20 runs now and have not encountered it.
>>
>> I'll see if I can set up a mips rootfs and test that. Guenter, what MIPS
>> machine/board(s) are you testing?
> 
> Could you try the below?
> 

This works as well: 50 iterations with no failures after applying the patch
below on top of qemu v7.2.0. Tested with qemu-system-mipsel.

Guenter

> ---
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index 2c85de4700..521c3c80c1 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -558,6 +558,20 @@ static void nvme_irq_deassert(NvmeCtrl *n, NvmeCQueue *cq)
>       }
>   }
>   
> +static void nvme_irq_pulse(NvmeCtrl *n, NvmeCQueue *cq)
> +{
> +    if (!cq->irq_enabled) {
> +        return;
> +    }
> +
> +    if (msix_enabled(&(n->parent_obj))) {
> +        msix_notify(&(n->parent_obj), cq->vector);
> +        return;
> +    }
> +
> +    pci_irq_pulse(&n->parent_obj);
> +}
> +
>   static void nvme_req_clear(NvmeRequest *req)
>   {
>       req->ns = NULL;
> @@ -6917,6 +6931,12 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
>               }
>   
>               nvme_irq_deassert(n, cq);
> +        } else {
> +            /*
> +             * Retrigger the irq just to make sure the host has no excuse for
> +             * not knowing there's more work to complete on this CQ.
> +             */
> +            nvme_irq_pulse(n, cq);
>           }
>       } else {
>           /* Submission queue doorbell write */
> --


