Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF79C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 08:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y02JWI/K0q8R4/edCRp3hv3YCpmoDIJK/Py8rJC//fk=; b=3FZeGLEfNB0e3W82NNr9+WoBCO
	TEU6irm24WNeOMJNkzBR+kc8+R4R2osLlSIYSlMZku2A5FTYb1CYs+yIp2oy1Fh0CFOA/70AlIaY+
	ZNj8x9PmdR15HCgux2cCa7TfozoGfZwotCLD0niBBW+uqfINpy78PTRY83N91R0hchkXmkjPrpGy+
	mBiLOwKBrpXN5Ebo+rj+3drIlhdLI0sPcOf9AkwsUWriloMG2K7sJuADG4OUUiInj4FqqKt6PWYMC
	yx1+MFUOnJcz8+fnBNsd2uZIhdNqCx69fxGukAmJ04wEC15D9KI7i7U/GuciQoIUC/Q3l19jUL4hs
	AZqIrY5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwkH-00A5cM-16;
	Wed, 03 Jan 2024 08:37:01 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKwkD-00A5aZ-1e
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 08:36:59 +0000
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33728f82a71so639085f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jan 2024 00:36:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704271011; x=1704875811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y02JWI/K0q8R4/edCRp3hv3YCpmoDIJK/Py8rJC//fk=;
        b=xMaQb9na4rcRLiAJ5sxeVfQwkyeG9fb6VdC57qasoazpxnsZ5omFnfraYxielZf6Gu
         abeRvVXAQYi2Nsjbq/sOYoQ+PtjJbxSI2lLwKwt2a8nN7ysFbmhjIir5O8Aso/35DgpH
         Av5fKYAORAadUY7tZ3WUkxpk4z8PHK0SYIXzjlhACbUSHNcP77BKbl4AjLdFUGYbUFsJ
         T6b5sSolDpZxX2+1VdSI2tJ4iEUo6TK5iu4QZc5LM7iLQxFkwK4jrL5/olKcIvq6udeP
         GlRP0yrK8+eY6skV+aHkSiBsEx/cSDOkkHbRopt1MWz5u9CtG4ABDNpDkuI48IkqS/Pq
         vN5w==
X-Gm-Message-State: AOJu0Yytw4SKYg4X+7Gl2XaAXcTRQhDesW5MCGBtDMkMwi2gRXATxSpS
	/McZHXWFcA/YpBKREYXCclc=
X-Google-Smtp-Source: AGHT+IFVadnLsRoBOZD5nlQBbbK92RwvKXi47Gkt23+FCw3ObailQv0O8IZiHWLKgfNT/PmYKMBRdw==
X-Received: by 2002:a05:600c:22ca:b0:40d:123a:50eb with SMTP id 10-20020a05600c22ca00b0040d123a50ebmr22442533wmg.3.1704271011025;
        Wed, 03 Jan 2024 00:36:51 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d2-20020a05600c34c200b0040d61b1cecasm1578211wmq.33.2024.01.03.00.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 00:36:50 -0800 (PST)
Message-ID: <c134b7f7-f5bf-4670-87be-0ef928145c65@grimberg.me>
Date: Wed, 3 Jan 2024 10:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: Add two-pass shutdown support
Content-Language: en-US
To: Jeremy Allison <jra@samba.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com, hch@lst.de,
 gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 linux-nvme@lists.infradead.org
References: <20231221172257.2234320-1-jallison@ciq.com>
 <20231221172257.2234320-5-jallison@ciq.com>
 <694ac9af-ac3b-41a0-a50d-abb89503d453@grimberg.me>
 <ZYt1o/n8qymZC65g@jeremy-HP-Z840-Workstation>
 <e2001f25-ee04-4f34-823c-7647ab58da13@grimberg.me>
 <ZZRP730tbkXNndZl@jeremy-HP-Z840-Workstation>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZZRP730tbkXNndZl@jeremy-HP-Z840-Workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_003657_572314_0C7B8511 
X-CRM114-Status: GOOD (  10.58  )
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


>>>> On 12/21/23 19:22, Jeremy Allison wrote:
>>>>>  EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
>>>>> +int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
>>>>> +{
>>>>> +    ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
>>>>> +    ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
>>>>
>>>> Why is ctrl_config being set again?
>>>
>>> Good catch. There's no need for that. I'll fix
>>> in the next iteration, thanks !
>>>
>>>>> +EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
>>>>
>>>> Why export the symbol?
>>>
>>> nvme_wait_for_shutdown_cmpl() calls nvme_wait_ready(),
>>> which is a static function defined in drivers/nvme/host/core.c.
>>>
>>> The only way to inline the functionality of 
>>> nvme_wait_for_shutdown_cmpl()
>>> into nvme_shutdown_wait() is to export nvme_wait_ready() instead.
>>>
>>> If you're OK with that I can remove the intermediate
>>> function nvme_wait_for_shutdown_cmpl() (and indeed as
>>> you've pointed out there's no need to set ctrl->ctrl_config
>>> again).
>>
>> I think it is small enough to make it static inline in nvme.h
> 
> Sorry, just looking for some clarification here. Are
> you talking about inlining nvme_wait_ready() ? There
> are indeed larger functions already inlined in nvme.h.

No, these wrappers are getting confusing.

Exporting nvme_wait_ready and calling it from a static
nvme_shutdown_wait in pci.c is fine I think.

