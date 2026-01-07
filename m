Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E40BCF6BE3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 02:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cmFoPTysutl7lpdqNp7zT7B4cAvUQjN/lrEalOzdDr0=; b=nlNzZDkIuqJDCKLoWMuynI5BdU
	2oUxMS7uLBJA0DyFa8FfWjLDx/CZN0Qr8IY8l8pcfH9640a9TZ/G/nxnj30bOIZgBXGhRw48ZISzp
	fyTiFCaFIlR7O/ROPPOpRxy71cUW2x0UuR7cSbvCuN2VyF9WYkR93RzqI/QoAN9lNTlGGIqeJMPhf
	HXjIHDBGaFOaRxGpuNZo09RaQiGEBQsN90nKyXy4OD9ZVZR1JxsMoy+5UIf7Zv51P41OKU1gIUulW
	KXTxe439Ezn4iKOXLEPkBtLhN+pjAg+ltq1I62u1XSf0OP72eW6A/y+QqUBvCQzn/goTR2S2rM1/B
	Xns2m9aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJ3T-0000000E3hY-31t7;
	Wed, 07 Jan 2026 02:13:47 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdJ3R-0000000E3hE-0qZ1
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 02:13:46 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-3f13043e2fdso661971fac.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Jan 2026 18:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767752024; x=1768356824; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cmFoPTysutl7lpdqNp7zT7B4cAvUQjN/lrEalOzdDr0=;
        b=RrUAnXmA4UcElwBapr70bu7Q3fjfSpBP2KRsM9tSwSQPCI3mN8cuOX+yhemmsvswQX
         CSy9wpYuFCLJJPZ/AKGB/4vGL04dlomf95mZaY0vXueKyNv4kz90azgba0Qieyd0qe3E
         7F+O0SW/ZWOseIx21/sDl1qtjNPaUddENMCByPG3QeS9Rp2gkNHTKNRa+0XUWLchMOks
         Nd6pys9JOxkIho8PNrT1+YWL6Mreme8XHG5J2x+cvsiawAISRCxv0Ho687XV0oXkwqm1
         WhjiOiVCKZ10QDB9PWWrLHGToE3BKVfHPw9+N8DiOThiA96GpE0m6hv4H5HnGce3B2tv
         gOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767752024; x=1768356824;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmFoPTysutl7lpdqNp7zT7B4cAvUQjN/lrEalOzdDr0=;
        b=gMi8LJSI5/u4faoSjvwW3eKjF6MYHUhYnv+ER3ZOljhjQ+iZJA0l7LUbdUkITXC7LB
         XEX7TeDDFadYq15mxj0kev5HyIX6e6LMsH5p+rsoWVcz7oQRAI4174RgPImDwKUvcOZD
         645ByQNypLeSKzgcgn1QSwxTKWhAngcd9omGivAKIx2PbLygwlBsA7ceNoXhG8hU380e
         I41mK5SyBGGM3nI9h/yceiHcu67VrMFpNdyG40Az6KOo8/pHbDWIsHJFrRHRrPwQV6bC
         vJhZaQknl5HFZSSMRY43Kwe1GDLiD5PJPHGHs1N8tretUQ/cmi7AO3W8eGzIAqXr+DET
         ScQg==
X-Forwarded-Encrypted: i=1; AJvYcCW8XQQr8MbnGwyaZqpLpLvyiBn3rRq5mVrBwv8JDqG9mLHB/HCyh/S/v9ZDw1x2FoFik/8EDCyFk1ap@lists.infradead.org
X-Gm-Message-State: AOJu0YwGDkRLsdRCcPgFMvcbn7L3MEn6IowV0z6AUxeYGlWCve7ZDr5R
	l4Zb5Zrbwz8SE2hCZYoskryCLG4LbIunALaFyrN9FTB9u1uSIAvfRmw4ZJnQ21N9EdY=
X-Gm-Gg: AY/fxX6UUGIs+SWWM4qhHq0NOrUYer6cLpiiDWlT/bV5nlVBYTdNXPdARmuVOjF1Ikl
	A+CKRXMp2x1rw1GbCYmv0nJa+iJfETFfwcj42yztz9yvxrvhaLbmC+3jutS6y98CWPZJS68Xc3f
	Wy9KE8HmiFER3De2nRSFGDfX5BxpypiVrO9r8GpI7PKwykXZrszoxupujQx+X9asTFdcg3JGMkF
	mku2eHwE+ByqR23IxIHRjGLUKANt92rwpWAGIJzPkdt4r/M3lQUJQRjvUTfK6nHeMI6k53Lx98V
	CsGdiUmvZ/Sh7VKFXeuBHh93hzFjEaRGsxfSAT12R1BDKvQ2jW4hOlCPkOeulKi83pj8u1EnCkX
	AInd5vJSkB487Fgn7ur4pUq6etmNlJVJcvlNsG9bMud8qDIqmMzk8gMms3RQA4kNpZ7/PR/kCbl
	gIMEMLYFMv
X-Google-Smtp-Source: AGHT+IEppoxbhawLA/RHqdOT5mS+agQwDkfuGX33BEL6nW7U9EwrGzbn/dp5d0/9QmUXu76YicDHeg==
X-Received: by 2002:a05:6820:16a8:b0:65b:ccd9:c9b with SMTP id 006d021491bc7-65f55089d14mr424682eaf.62.1767752023811;
        Tue, 06 Jan 2026 18:13:43 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm2280001fac.5.2026.01.06.18.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 18:13:43 -0800 (PST)
Message-ID: <8f839d6a-02a2-47f2-97af-f77cb10c5790@kernel.dk>
Date: Tue, 6 Jan 2026 19:13:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
From: Jens Axboe <axboe@kernel.dk>
To: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <20260104151517.GA563680@unreal>
 <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Content-Language: en-US
In-Reply-To: <258e49de-7af3-4a35-852a-8f26fcb7ddbd@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_181345_246202_5511FF62 
X-CRM114-Status: GOOD (  11.73  )
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

On 1/6/26 5:46 AM, Jens Axboe wrote:
> On 1/4/26 8:15 AM, Leon Romanovsky wrote:
>> On Wed, Dec 17, 2025 at 11:41:22AM +0200, Leon Romanovsky wrote:
>>> Jens,
>>>
>>> I would like to ask you to put these patches on some shared branch based
>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>> and DMABUF code.
>>
>> Jens,
>>
>> Can we please progress with this simple series?
> 
> If Keith/Christoph are happy with it?

It's here:

for-7.0/blk-pvec

now.

-- 
Jens Axboe


