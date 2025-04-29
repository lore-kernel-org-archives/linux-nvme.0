Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1F0C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GAf18Ji9JgpAG5KOErephGKphdnSleRNqAmCLZCu10k=; b=vS5nlv5rw6Cvn+VFMOtShowqME
	CBSwi/oIN6fwpS+jxFX+cUgjEHVoqY/ghbbydCbGTvgeq8J6Nq5y/fR8PlxcT/xoQHX8Ukmj2Et6+
	wHS8b2ZVV+GO+BTKEZUKce/uBG+Q5C2XzUtLL96qCvCyHgn2CJBkub32NUvO3EynSSt9fbi3mnzQW
	VddjMhsTH8vNhM7m9F1LbPaf5Cw+j002/XHPBC2/1atSUINNIHqb4JAh6bc2/WfTMlAamsSZb7KfM
	DWP9JuNnE0Vo3GyjCZ7szJ9fgh/4+q6dkMxSy3xOSGt/mOKAE92O73Mqfx9bVUw8/NC3eQ99QrntH
	pTiruwug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pdp-0000000AY8N-3lLe;
	Tue, 29 Apr 2025 18:25:13 +0000
Received: from mail-pl1-f171.google.com ([209.85.214.171])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pc9-0000000AWtx-0N9H
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 18:23:37 +0000
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c3407a87aso94347045ad.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745951008; x=1746555808; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GAf18Ji9JgpAG5KOErephGKphdnSleRNqAmCLZCu10k=;
        b=XYM4qs0H/EdbR/TKazA6jYZpUwoRNzZHSJFMLoUb+91gaFBXuR6z/0wQBuuJ3lo5d/
         5syEBVmdXpoBiXOGKlTLcfA+GTjraOKPavPAuDlWlU5q0MNP6ZJKys0meXJzyRR0VF/Q
         1B0rjE29HO38n5bKMvFsd5f0faUYPPjvzt/aDIYe9E1SGUaF5BizjxWUyzaMVrM/Z1B3
         anszotBnAoNIl01amdXQebMGQilpVHlweW7KiZsQDMj4uJkFvvcdIocrn5UsMJa7EFUl
         RLf8rTJ36m1nVgNaPSUn1VxjHUmFnqYrXXt7UdJ2S9CwQsI7TSe9TuxlWT1u/cL1ms1x
         VRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745951008; x=1746555808;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAf18Ji9JgpAG5KOErephGKphdnSleRNqAmCLZCu10k=;
        b=DXoxAVIAigfxsaRzfyV0IF1rD125jv8VgPJiyinvX6uGnj1ep0Ke1wjnXgfCCaI8SO
         bIOxEHbwnxo+00RXXvWpsR5NqSOKjwPLN4Ra98dv2ilEpJgCUueNJ5yCw5YCauIRz1QI
         NARgkTNVttT6yeR8VjHkCteCKwcrzV7f44Mq+p2SGTf32MJRx1pU7ho5Ap0qiMJn7/G8
         hvAijQfSG4rT5U7RpyJl41ZoKBn2aoZRVfq7j2qnXo5ZsEoL0V/ZVlQnkoJqcuDpjpQ/
         mXsbQwI/TziTFwBdK4CTfqAsmWQvHDB2twHIqPN8FGaxzVsS099YQZuZcPAJMO3OYkRO
         3hsg==
X-Forwarded-Encrypted: i=1; AJvYcCXxA5mMFrOGEnw8EXCUDvfY+wH7bJSd6STaKjhnLDDXo0Vzu7we8VWZ/PUrwreWDezxx1ylP5F5lkIu@lists.infradead.org
X-Gm-Message-State: AOJu0YxEHK4uX0UT0Kua9gW9wA4bfyPLCHT7NY92MvYIr5ITDOgYbElq
	NegdSIdtkecXV4rpbiu8PcSNGTKZD7u8TK1jlri5v2ZVsXjCEnh9
X-Gm-Gg: ASbGncss7VjFqH53ZVrFwk9+aoYbGm42Z4HiPobNGuGJXqP1mklhV6/0zgF4082rnRu
	hQCi/t1PECZNoJDftM2wTrfRQRUS29jrT3Cw4ZXavrMVq4KjTgdKVMvcubUVdCSZQnVCDhkevrg
	qx9vh6/UDCwPQDojiFczp2Eeaf7/E8/unTz5tloEEQ27pY31v9A59Db+Xuc4FKXeN7DIauSk2gQ
	0T3pfgyLbZRRPN5aFLsoqqnlF0khtTG79nsYEglaX7WOEYtVXnEikHBdpOjKn8G0eE8oSeHPxYT
	l1msOy8nHmO4Ep4D9PiUhPy0p4oELRJDBUW3dNaVx/8m5nezybDVQeJ1KatyAvvWix1WYPEA1wD
	ba8XjZ6OM28BfsA==
X-Google-Smtp-Source: AGHT+IHMpQLALORtMi9sKVun9/H4ZHJwdsRSTKawyGw0F3/yv4RnrEuqwPv26YZAfD7Xo43y6ZqldQ==
X-Received: by 2002:a17:903:3c48:b0:223:668d:eba9 with SMTP id d9443c01a7336-22df34a97c3mr6447415ad.10.1745951007718;
        Tue, 29 Apr 2025 11:23:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15fa80fa75sm9329038a12.56.2025.04.29.11.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Apr 2025 11:23:27 -0700 (PDT)
Message-ID: <253e0551-d4d7-4ffe-8842-daecf1f6c753@roeck-us.net>
Date: Tue, 29 Apr 2025 11:23:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <0134ea15-8d5f-41f7-9e9a-d7e6d82accaa@roeck-us.net>
 <cb46aa83-8033-4d64-a3c7-420172c3f3f5@flourine.local>
 <9763c4cf-8ca5-45d4-b723-270548ca1001@suse.de> <aBEW4W40ZelIXfs2@kbusch-mbp>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <aBEW4W40ZelIXfs2@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_112329_242054_1576524E 
X-CRM114-Status: GOOD (  16.55  )
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

On 4/29/25 11:13, Keith Busch wrote:
> On Mon, Apr 28, 2025 at 03:21:18PM +0200, Hannes Reinecke wrote:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index b502ac07483b..d3c4eacf607f 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -4493,7 +4493,8 @@ static void nvme_fw_act_work(struct work_struct *work)
>>>                   msleep(100);
>>>           }
>>>
>>> -       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>>>                   return;
>>>
>>>           nvme_unquiesce_io_queues(ctrl);
>>
>> I would rather have a separate state for firmware activation.
>> (Ab-)using the 'RESETTING' state here has direct implications
>> with the error handler, as for the error handler 'RESETTING'
>> means that the error handler has been scheduled.
>> Which is not true for firmware activation.
> 
> But the point of having firmware activation set the state to RESETTING
> was to fence off error handling from trying to schedule a real reset.
> The fw activation work schedules its own recovery if it times out, but
> we don't want any other recovery action or user requested resets to
> proceed while an activation is still pending.

Not only that; there are various checks against NVME_CTRL_RESETTING
sprinkled through the code. What is the impact of introducing a new state
without handling all those checks ?

Guenter


