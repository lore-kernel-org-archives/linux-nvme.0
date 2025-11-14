Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F09CE7AF9
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kG1p+h6NmWkadBUCs9jMm1+jPfa7sXsq71LDbEX1jNQ=; b=42yYpOXqZfya2FFpY+oLy+6uLt
	SaRou3QuOW2P3s3edjgPWt1fZY3rYAqqhPP4x85xj/X6bSrw/W3CehX5JHwx8exU5d/toAs/VeH0M
	7HKCEIGulnEUBNsVTVaXCXlMEtBK3TUK2I7F4ZFzeDwZbuZb9o3OSyaVPU5raqJM5EjaebsmZj5xw
	Tzu2L2HFzN3XSO8nEu/DKJw6Fmp/fsp2GLv+A8BH+2KLMJiXHfCspo4ejXbEi8km6oraH0acpaE0m
	AKLjOep6GneyXyycn9eSd8IGuyPQq/CwLEImWWQRBFsGSFqdzf3hKZDFaTAQ2lizQFgBewOUmnXc6
	F7JXZZLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJsby-0000000CAit-0mRc;
	Fri, 14 Nov 2025 12:09:06 +0000
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJsbv-0000000CAiU-1LT1
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 12:09:05 +0000
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-948e1ec34afso26245539f.3
        for <linux-nvme@lists.infradead.org>; Fri, 14 Nov 2025 04:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763122141; x=1763726941; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG1p+h6NmWkadBUCs9jMm1+jPfa7sXsq71LDbEX1jNQ=;
        b=iEALgtLkGfxonv1dzc3UzzzzRHiNjUw9ZHi1vH0h5WmBV2DnqKvrHD9m7m3VXtIPN8
         vH2CYgUdlTGCLz+J523E5IgcdwhQ/WZVE0SF+7JvoKbVMnVl+C/Ni5xW8Z2HqqnW2k9j
         2Q/HHw9nuANhcSktjTkK/fyKJUFAItNMyy2sRE4maGOIRXPwDHflFZTf3kFkYZUrVY79
         Q68vZw48eEdta4b+AKw7UbKH7Dz0EIcswjZFiE2665vxpBP1XdeHxfCC5KiJTNNZSAMh
         U04XQQ3I21im37RIitAZu3WS3hlpQpL/HmxNmfWI+8gxcFpNxHUczRmgfweXA3i9diAa
         jVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122141; x=1763726941;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kG1p+h6NmWkadBUCs9jMm1+jPfa7sXsq71LDbEX1jNQ=;
        b=qe1HGaDZVn4x0g7717O9lHCQKAmh8vQelA7sePseeIxjWej54NkpWrCh3PePlA8WIm
         TUSp/EmhhwPvZ2EgoM52qrcxNtCrWDihx/PihCsGJUx1tirXsdDSQitBUTmw/GwVdvsZ
         KtbhrM36O6MAckb4rWGLtFriXSj8awiIX8BXRNUx3MjjPYMjJ+4NbOAN+wCJNw0atuzi
         r/0jS7vssSfDdU/Ovq9fS+unqWbseBqobw+J2i6PNe/xvDHYO6807WqDoiufr3sbCorC
         FedKiUVyYL4TDDAjCLPAFAAGpoCcxI+v5EZjMBLjel1oxyA46zWzzwGXm/6vPPFEA7jE
         XIqw==
X-Forwarded-Encrypted: i=1; AJvYcCXC+ILWUYMh4ZsquNaHgWDnKqKha7vGajSDgmtdpn07G3P0kq4Dql5c3mvrYcgdFk8/VI4CNOMu3T0i@lists.infradead.org
X-Gm-Message-State: AOJu0YzepjkM2i2/flHOuEzFsrnqsbzGv0T8gryWl/SbDZhOBuAyXz99
	RkFrOWlunMh2yN7P4Y403fAyuGk0GAEemYOovdQjp05y+7bCJ03Tho/tyud1gwxkkgU=
X-Gm-Gg: ASbGncuVjYMUFRqEncndHz4e4fGARnw7d4dX8X+oKwyY55hLMSPJxIDxEnIDLpyUs4L
	IjAOK6xDsR4sX6yad+Jq6FUxG4YXEm8sL6X8idVN0CcQdCpKh+UHEgwzVYrWkKreAAhm0F7brer
	Oij9Cvv/5Dps95rmiZqSEEegluP6K3ACeJTjNduFWglAIIOX5Gx5VTCMSlg+2/ikh5HgvXbvaPl
	5gpA4nY0C2B9KFIZxeW7sS7qXU4Fs8dEEQ1HjTXyu4wzSUooEvU0FBImTzY2WcqfmYIdnoRbvD3
	V48OKw2j7WNbLkA/9AtkOWE5ZD1WctM+3EuAwswFC/ttO7JTkZGFFbncxopRYaPPKccT0y/e146
	Fzc/rVtG/xm1dMfU6OLUodeVQ+YAoeY+2vs/TDXbIiH1PJrGF58WdqIIalXpi9D5YLdWvLPcRoa
	7O7f85iglyGftwV5GQSPw=
X-Google-Smtp-Source: AGHT+IEAqyNwPB3UvsxWeYSxCILw7sa+XHuGUVyOutIjmeWKLo9hHPdACjkztTSKX+8Y0R4tMIGQpQ==
X-Received: by 2002:a05:6e02:b49:b0:433:7c77:be58 with SMTP id e9e14a558f8ab-4348c94e27emr41757475ab.29.1763122141106;
        Fri, 14 Nov 2025 04:09:01 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43482bd586esm24371405ab.0.2025.11.14.04.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 04:09:00 -0800 (PST)
Message-ID: <4e24113d-b32e-40fd-baa2-0b878b9a7a15@kernel.dk>
Date: Fri, 14 Nov 2025 05:08:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <aRY28IRvBFmTW6cz@kbusch-mbp>
 <d1641814-5ef8-4ccd-8a41-42bf99a61d0d@kernel.dk>
 <20251114081623.GB147495@unreal>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251114081623.GB147495@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_040903_625420_A601E2D1 
X-CRM114-Status: GOOD (  14.62  )
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

On 11/14/25 1:16 AM, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025 at 01:40:50PM -0700, Jens Axboe wrote:
>> On 11/13/25 12:52 PM, Keith Busch wrote:
>>> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>>>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>>>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>>>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>>>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>>>> be a fatal error. And secondly, this just further backs up that there's
>>>> ZERO testing done on this patchset at all. WTF?
>>>>
>>>> FWIW, the below makes it boot just fine, as expected, as a default zero
>>>> filled iter then matches the UNKNOWN case.
>>>
>>> I think this must mean you don't have CONFIG_PCI_P2PDMA enabled. The
>>
>> Right, like most normal people :-)
> 
> It depends how you are declaring normal people :).
> In my Fedora OS, installed on my laptop, CONFIG_PCI_P2PDMA is enabled by default.
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-fedora.config#_5567
> and in RHEL too
> https://src.fedoraproject.org/rpms/kernel/blob/rawhide/f/kernel-x86_64-rhel.config#_4964

Distros tend to enable everything under the sun, that's hardly news or
surprising to anyone. And also why the usual arguments of "oh but it
only bloats foo or slows down bar when enabled" are utterly bogus.

But I sure as hell don't run a distro config on my vm or my test boxes,
or anything else I use for that matter, if it's not running a distro
kernel.

-- 
Jens Axboe

