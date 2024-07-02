Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7785C30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEPcVloGJVi0kMi856li8WXobhyjRWBvmAFJPrUl1oc=; b=GnaOZxh7DxK3Mmr8wlBH+7yZPk
	VCCiP0K6PTEAbUQ+ceqsB5L6IhyypSAPz+9MgqJQGH7tQ+4IPd/wiRDKIU8jJl3ID3RrUjrpIANhn
	MNaGYO3dSbLkCKfkAgIe/miOxs18OFbpnn+/CKWx8JmwDCTnJdvKYWVTBBgIGN+oHMi6+wOO9ho22
	Xrj5Ela/aKfy7KEefMcCHFnWH0YeWfx+lzfOMhlnbkrvb/SKkS9oE2dbMLYE5CUGpQw167ia7f8ut
	96hniJLB/EQdHoK1y6TA9/WirB4bV3vEaCwMwMoN2YyEhUezOGrVxEyPEIb8FP5DXsFsTmpDBgWjS
	NJQSYPkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOijd-00000007hyo-1KeK;
	Tue, 02 Jul 2024 19:00:13 +0000
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOija-00000007hwV-12fM
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 19:00:12 +0000
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3d841a56e1dso1204968b6e.2
        for <linux-nvme@lists.infradead.org>; Tue, 02 Jul 2024 12:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719946808; x=1720551608; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEPcVloGJVi0kMi856li8WXobhyjRWBvmAFJPrUl1oc=;
        b=dh7ihlsmxPB/qLrAOtjjNWE7Al4/2ifZb9EZi6Jl2BA0ew8aIrB4R4Ay06WVOJmxHi
         ij0SLL5IXOv0bgjpQVkrKJZ2ot28whI/9bxAFNDeN/OrUWveaABnY4sLamSQbOEfusge
         xXg2OhWQsWvlHWw+tqKfa3Po3AOIxxbfMUsFBnPzIftK9JAEH6t81GU9YvgYULIJw9BA
         57WBN2fBWTc9ixfZrEA4fkmqVOhxuZvpWUgjD6jCtVxIrzXYozw7unoUIb7saJWXwTae
         zCX2RRyXZoSApLBDI36fOjUtUjuku4amd59JDiD4kdQpVf/9BGk7DzDZx3s3OXhGgPiZ
         K1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719946808; x=1720551608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEPcVloGJVi0kMi856li8WXobhyjRWBvmAFJPrUl1oc=;
        b=l46D/uqVn28jtvw8M4Qm9kgAf4ghFCd0wOVSWqwPefftr0JvT+CMlr2Hfdix9WK+zn
         al3DrHyR2ail8DgHt3Y5LjcjslZ08SgwPofOJwcTfO+lJAh3V3Xqb/YO8cAM+2eL/yI3
         okGxfXGHdyzBJjRWyS6wRsOc6hqDwHIHUggZJhmrk11Fu3tWiXtn5dnJgUC+DqGlFiOx
         zVi2xHlxjJvxjX7lombJ0voPZnqTN+ztF+4AhMjSF8ilkSSqMoK51gBxCKj0JPYp+BCR
         IcB0M30bB1DYMHk4FA357ljlqXpzUceHGlwTeH8ectmsmmqU5UZt/EwdSH0AndIK74h0
         zdyw==
X-Forwarded-Encrypted: i=1; AJvYcCVBg1G+P0yPTVFRDXsDxpQX0GiGu/gfcT506Bac9ocsDakIg4U8IFZcdTs5h3231Gc+L35Qe0UgBXG/Oefek3CMzFqioXArsREkzat64Ig=
X-Gm-Message-State: AOJu0YzCLsKtSJ8/r0gl35VzUasIWSXxeQBm0xQqM1+OPqCha57/BWWE
	L29LxP4ivf1z5phjSO/KqTuHnI3Cdyi406Ql7zdr8r0ssIDkSqW7
X-Google-Smtp-Source: AGHT+IGFvWHJtacROjfKFmOg43PzeldA66DcuTBL4Gi+UrJFsKFpDfb1I7YxraopyCUscgjBJNzn/g==
X-Received: by 2002:a05:6808:1823:b0:3d6:9c05:1aff with SMTP id 5614622812f47-3d6b2b257e1mr14737075b6e.10.1719946808156;
        Tue, 02 Jul 2024 12:00:08 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20963sm1824515a34.49.2024.07.02.12.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 12:00:07 -0700 (PDT)
Message-ID: <13d0a0db-e113-42c4-9fbe-74ebfa46f46b@gmail.com>
Date: Tue, 2 Jul 2024 14:00:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com>
 <20240626194650.3837-4-stuart.w.hayes@gmail.com>
 <20240627055515.GC15415@lst.de>
 <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
 <20240702050414.GA22160@lst.de>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240702050414.GA22160@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_120010_378878_F7B5D35A 
X-CRM114-Status: GOOD (  24.99  )
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



On 7/2/2024 12:04 AM, Christoph Hellwig wrote:
> On Mon, Jul 01, 2024 at 12:57:40PM -0500, stuart hayes wrote:
>>> We discussed this before, but there is no summary of it and I of course
>>> forgot the conclusion:
>>>
>>>    - why don't we do this by default?
>>
>> It is done by default in this version, for devices whose drivers opt-in.
>>
>> In the previous discussion, you mentioned that you thought "safe" was the
>> only sensible option (where "safe" was driver opt-in to async shutdown)...
>> that is the default (and only) option with this version.  Greg K-H also
>> requested opt-in as well, and suggested that "on" (driver opt-out) could
>> be removed.
>>
>>>    - why is it safe to user enable it?
>>
>> I guess it isn't necessarily safe, if there are any drivers that can't
>> handle their devices shutting down asynchronously. I thought it would be
>> nice to be able to enable driver opt-in from user space for testing, before
>> changing the default setting for the driver.
> 
> I was mostly getting into the contradiction that either we think the
> async shutdown is safe everywhere, in which case we don't need a driver
> opt-in, or it is not, in which case allowing user to just enabled it
> also seems like a bad idea.
> 

I understand. My thinking was that is was very likely to be safe (the initial
version of this patch didn't have an opt-in or opt-out).

I have no issue removing the sysfs attribute if you think that's best.

>> I can correct these lines. I thought that an 80 character line length limit
>> was no longer required, and saw another line a few lines above these that was
>> even longer... and the checkpatch script didn't flag it either.
> 
> checkpatch is unfortunately completely broken, it flags totally harmless
> things and doesn't catch other things.  > 80 characters are allowed for
> individual lines where it improves readability.  The exact definition
> of that depends on the maintainers and reviewers, but outside of
> string constants I can't really find anything where it does.

Got it, thanks for the feedback.

