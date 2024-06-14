Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835C2C27C6E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3I8EQqt1crG6Q0TuvnTQoOetYt/333GlTD0SUTj3N30=; b=PeROvYQX9SIDouq8toSUxcs78t
	i5CfNePpwsdBYlqsmz5D2eyhigsTAbC5wKLOoEqW8O1zCfwaEItiSxP1biWe/WITvj3kvxtSDB6aR
	2mVAGah7Yhc4IN5lTczwlM9XyFHVkgV78eMGNf39CxW6yquZylo1cd9fL3ZN4aLPWtFVml38v44VO
	ur3PPBqj0GGjvJ+jf8kdwjjlVGSMemqrjTHGNr22Fjc0wkr/TQlN48u3EYA7voZmDjNHwU2mkLCXY
	bE2VpuStvvA2gYJjnmy11zduoaZKqnUSmXCNBqQbbsPAd6y+wqztooM5GvcYnLAWo0WSyy6v5sLIH
	nek9Ozew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iH-00000003OXx-0cQM;
	Fri, 14 Jun 2024 16:23:41 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI9iD-00000003OX2-2VY6
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 16:23:39 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-64ecc2f111dso219252a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 14 Jun 2024 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718382216; x=1718987016; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3I8EQqt1crG6Q0TuvnTQoOetYt/333GlTD0SUTj3N30=;
        b=DeHLMHOmvz0gZ4MpP+ZE2n1JoYf3mCAlOCCr6Kt4ILfaDvKbPwNpNc0zl/cxXWBrZD
         4KBZFIEBgSvKgXQZ7jMQWST86qv1FSlxBH0zskcLrTp+RV3jRx5rL8v05s4aXHYkjPaM
         ck8ruHqDlIuo4xmOBnr5KJiGK88yiay4deyIclvQPTIuKusSSlgMsIyoVVBKZcRgmbdg
         kSMCW51kxYAnZXVzvKMcWMoQyxPF7x/KPQ1bbBYLHbNwaEyXwzjHozycy2Rg7Zr+DrBo
         AiremcCyWj+4FpVWizAB+Pjml9ovhvaiPwNA18okSPJvshX+K5gfeggr16HQ9g8JmVOl
         4QZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382216; x=1718987016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3I8EQqt1crG6Q0TuvnTQoOetYt/333GlTD0SUTj3N30=;
        b=niCFViVQi0kn1VrN/7BX0UkJtoQW4elbQ/u+ekS+34ZVy+OIhWAbtX4pEbj1KaqMxn
         idpH/MNa9JA2DCB3FQZ/A6CoStOuwhP+iYXvL/NghJU89h1AdnRL1lW5IKr76czBL+WK
         jd2VlGYMTCQHj+6WgVyZKNgPLz58RFlROI4iqZsa+vu8kCLx6GUm8JHveJfT7cyZDZYs
         jIDsmcfW7nCMt05MKC7bJLO89ktVfn6vWmIEt0JJzbG22uqAQZLC85R9UbZT2gz8lwdc
         u1swv+kVJO/d248WuwjqKHqc3zAlLokqhpjwLKGiGVVAGCb11Y2nAclgsZnt1h7VCAUL
         kWCQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4jrVN/tiSugOkhPXV9n0KG3FJDsMsF29eJo1V0kQa5xRNKnRk4JU/cBoE6YmrKJlGlcCOq0Dsk+5+k7esHHJebaQYcq9bA3OxTbWxv1o=
X-Gm-Message-State: AOJu0YwAMefmafiMcrRMCx/8uFtjt4ZEz4wT3wsLWzf5yqbR2JXwJxys
	nIlZaQQSyE9udJE1ECOsERcbrPzsTfpyWIIWMAtqhz/V3z+M8wK6HD7gv9elpME=
X-Google-Smtp-Source: AGHT+IESX47a6MjNSHBX1WWMmqXAUrRz04daSkbqzpNkyc1AvtEK1pUdz6iDmWheXtCqLaPD91gHzA==
X-Received: by 2002:a17:902:d511:b0:1f3:10e8:1e0 with SMTP id d9443c01a7336-1f8627f38bbmr33817845ad.2.1718382216194;
        Fri, 14 Jun 2024 09:23:36 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f525fcsm33896755ad.294.2024.06.14.09.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:23:35 -0700 (PDT)
Message-ID: <2fb3fc18-64fb-4a12-9771-3685111fd19f@kernel.dk>
Date: Fri, 14 Jun 2024 10:23:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: move integrity settings to queue_limits v3
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20240613084839.1044015-1-hch@lst.de>
 <f134f09a-69df-4860-90a9-ec9ad97507b2@kernel.dk>
 <20240614160322.GA16649@lst.de>
 <af0144b5-315e-4af0-a1df-ec422f55e5be@kernel.dk>
 <20240614160708.GA17171@lst.de>
 <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Content-Language: en-US
In-Reply-To: <6c5d4295-098c-4dc2-8ad2-f747a205f689@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_092337_676380_FBC4A712 
X-CRM114-Status: GOOD (  14.56  )
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

On 6/14/24 10:16 AM, Jens Axboe wrote:
> On 6/14/24 10:07 AM, Christoph Hellwig wrote:
>> On Fri, Jun 14, 2024 at 10:04:28AM -0600, Jens Axboe wrote:
>>>> That sounds like you didn't apply the above mentioned
>>>> "convert the SCSI ULDs to the atomic queue limits API v2" series before?
>>>
>>> That might indeed explain it... Surprising it applied without.
>>
>> Also as mentioned a couple weeks ago and again earlier this week,
>> can we please have a shared branch for the SCSI tree to pull in for
>> the limits conversions (including the flags series I need to resend
>> next week) so that Martin can pull it in?
> 
> For some reason, lore is missing 12-14 of that series, which makes applying
> it a bit more difficult... But I can setup a for-6.11/block-limits branch
> off 6.10-rc3 and apply both series, then both scsi and block can pull that
> in.

Done, both series are in for-6.11/block-limits. It's pulled into the main
block branch as well, but SCSI can pull it too as needed.

-- 
Jens Axboe



