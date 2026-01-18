Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296FD4A5F4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jan 2026 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xe4jmpRoBUFldmYxsM+TCFz25gUOTTr+errdkuJmq6Q=; b=pLAtrngB/jMoVJUE+yBCJPmuqb
	NofrCZlhrF00SfxMDUQb6/32tuczmAX8t1bIQUVis0SaKB9B0dnSLc76xBK5iJ0Spmmp9Nd1E3XFp
	rOPrTu2JWHPxKO8JFWYGwV1dFeuMqbis6puzasLk5LSz7XaGxNmLpX6DN7gKLqQ0VYI4ZfjMbkhO6
	3S6ZqipAEs3mBfLrXGQmu0UXAgSQUUvY1DcMzrvxi6+H25ckVnIGYAGSisUKTLbNvrgwLMyCN+BLz
	AtueoCvUnQPWNRyXnHcY0L2DCel+ao3V0wLGNuURzBmjkaS6TBjK8+cAwzS33i09zW33olSNHa08F
	ZF6FP3Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhSpb-000000006wB-0SqZ;
	Sun, 18 Jan 2026 13:28:39 +0000
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhSpT-000000006uu-1MiT
	for linux-nvme@lists.infradead.org;
	Sun, 18 Jan 2026 13:28:33 +0000
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so1758162a34.2
        for <linux-nvme@lists.infradead.org>; Sun, 18 Jan 2026 05:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768742909; x=1769347709; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe4jmpRoBUFldmYxsM+TCFz25gUOTTr+errdkuJmq6Q=;
        b=mCF5GcIGprkjcvERqpSY76kK3zYww/JWWpnpJkmwb7AYvUACVriOHjf7sFAwSGZFJT
         XIMixBPBzZkTKTBll4Ex7iTl6WRXSO8pn8O/hdTgBxcmo5ddFNBg3kHy6FBU1aSJ3RRb
         yeDmC6hlKUa7Bcm5/rOV8bAV6In8Z7T9KqcK6rNYgoUk0iwvnqFkhg1UBnxaFlgNJXLl
         f2W8In021TnXIY0qbo6s6R3xRDScWXKZML21z0biDZ8Y/Dy3uwehIS63gp0XhWm8fjQA
         HhdwHO8NihAVXzzCUckzozYnHG9bcmuY2FOHLtAt3FAswZH/+gOwrzZjVu0sK2GqnK60
         GrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768742909; x=1769347709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xe4jmpRoBUFldmYxsM+TCFz25gUOTTr+errdkuJmq6Q=;
        b=hyOhLu6E3zyEA88ZpM6VWVBnc+8OhM7/cM8CD28spHhwIs1XenZNMSMHa4SEUrF26V
         bNBdiV6jlnKppl/q6R1hzsgXvUyKCN6iahFqRtTL8QKGYnHX38aNT92Pp5dQ0KGghemT
         n8Sr7mR9DkEhDgkQMTIy413OsMhMYgYiQHcYloZUj+pS5JhNZpt6W9BXA4qtinBJ7sXW
         fcQ7EAFuTCkRw0mou3sVMFXA6HnLM/c3GIVSY1sdUYJafHeqqBuDwXBTPCmhStfS1j+J
         J9yU2QxeS4e/6mj/41K4pkFyvLCx95U+U6kZP4zPGKudwGyWZ6AnXth3T3aia9tc1Kpb
         Walg==
X-Forwarded-Encrypted: i=1; AJvYcCWdGGmIIj2hcM924ZlRrGqIXYigG3DVOTf3NJq7IMcZHShLCD9MAiY3KmUF+i69HFfWBJ0anlEM5tXK@lists.infradead.org
X-Gm-Message-State: AOJu0YxTSK1twuDyMrEgLD5v/BezSRuQJUiwsdfW38Xubzx2ZSJ1NJal
	mmo5Gt73f7HzShe5Y9aWe8c9j8Co9Q9jwKEHWO0+CGIpD0b3XmTSbE/trYikyonxbnQ=
X-Gm-Gg: AY/fxX4dvqTk2uSntP4eFhMmnueeg0V+OPdKTI4rzMaZQg2JaGqeSN3Y70Qn98CMZia
	t8E926LB6BvJQb4D6yJIF2NJC65CpsxJUmo/AodXUXMJFwxhNwMnjO0rSSiyVCINvZuoS8y5Wxz
	iauLIgogzXXb4SW2W9cVPa0DkMKFhr4SqbQ4xvirvnWP1EPDF5sJarMNmLgk2kUKQnsbi80Q+Mi
	HJfGqrqdnAp1QLa7TsCXcr1jiRBVW3VXUbSrfYmZ0LTZofYROR/Y0a2w/X0CVFWe9jtc7EGIk8R
	PXmJpQYxjyuyi4+WOjNDICP5ieAMQrA+oH/IF8f3j53zjjLpg6CX/eoDNgC8WbS45PZJiT4pjvK
	ApIvvLkQ4yVuATvpNFT1ay0CaisEamdmp4QVMFIjNDOHVy4FzBUwjWKzMJN3h392S+9RfyiF2AE
	4JnUgy1VnPhQ/1gNasq/e8mgOsa/g0upHZyCPRTRAAv23/CKvcg+Bd2uxfGBtmJc2NRgbtJB2gQ
	iEbu6Lq
X-Received: by 2002:a05:6808:50a2:b0:455:8400:f078 with SMTP id 5614622812f47-45c9d740b59mr3689428b6e.25.1768742909285;
        Sun, 18 Jan 2026 05:28:29 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9dec6619sm4135385b6e.3.2026.01.18.05.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 05:28:28 -0800 (PST)
Message-ID: <9ee2af51-9716-469e-97c3-dc59c545085a@kernel.dk>
Date: Sun, 18 Jan 2026 06:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
To: Alex Williamson <alex@shazbot.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Leon Romanovsky <leon@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
 <20260114133241.5b876b40@shazbot.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260114133241.5b876b40@shazbot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260118_052831_616485_8A4A5F10 
X-CRM114-Status: GOOD (  14.39  )
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

On 1/14/26 1:32 PM, Alex Williamson wrote:
> On Tue, 06 Jan 2026 19:10:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
>>> Jens,
>>>
>>> I would like to ask you to put these patches on some shared branch based
>>> on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
>>> and DMABUF code.
>>>
>>> --------------------------------------------------------------------------------
>>> Changelog:
>>> v3:
>>>  * Rebased on top v6.19-rc1
>>>  * Added note that memory size is not changed despite change in the
>>>    variable type.
>>> v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
>>>  * Added Chaitanya's Reviewed-by tags.
>>>  * Removed explicit casting from size_t to unsigned int.
>>> v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
>>>
>>> [...]  
>>
>> Applied, thanks!
>>
>> [1/2] nvme-pci: Use size_t for length fields to handle larger sizes
>>       commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
>> [2/2] types: move phys_vec definition to common header
>>       commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b
> 
> Hi Jens,
> 
> I see this is currently on your for-7.0/blk-pvec branch, thanks for
> splitting it out.  I haven't seen this merged into your for-next branch
> though, which gives me some pause merging it for a dependent series
> from Leon.  Is there anything blocking that merge?  Thanks,

Nope, I can certainly merge it in. Did so now.

-- 
Jens Axboe


