Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FC8CF6D2C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ATO5nzXBRKuk5zIyka26b7+2X+oqvRAeNDNerUiZPQ=; b=oKzwKe+QB3nd3wglTCJhz11jv+
	n1eC/6OQ063EQaXi+O116MhsTIOVdlgB6lsqmY1TIN3+FHOduZsOmR5cJWD8klf3GYN/AVnSkKiWG
	5ajEcPSinnniGWFPHSe333QGJGe/yO6edwG6x0AHOeR01e8NdFYrbagKVWJjd7FwGRPggRCUJtPqd
	rrCP6VAD8ti+XCWDrhMIBd1qoMEOIC0Sy5kQb4+J96cGv3QsNbR/nD3NNLtvqJvAEigWoz2qUnS4P
	rdyo7B3Mxc//JO2PrKAFezOpMwwlA/CoBQAAF23eeVQs4HCeP5vrndpIiLVcRG4z6chtsHPUGOg8G
	6KrAjGrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0q2-00000006Vfh-02Ri;
	Wed, 02 Oct 2024 15:00:26 +0000
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0pp-00000006VX2-1AjB
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:00:14 +0000
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-3a3445ab7b5so3216775ab.0
        for <linux-nvme@lists.infradead.org>; Wed, 02 Oct 2024 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727881212; x=1728486012; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ATO5nzXBRKuk5zIyka26b7+2X+oqvRAeNDNerUiZPQ=;
        b=Xq9v7raNSqi+hXDQYz8tLXTg4C+96aPbff1jVpkaR6te1yFzraAeGy+a8aiQFNMz8A
         BoiCC5nMoOo4XiqJDPdrj8OV21u9F4K9G6Ptwqdcz1706vEwPEfMIlujEf2u5kbI0o7Q
         T2Wdnx26Y+4sI3AiXsMXDzlNWMo1/rTIe3xXq5Rp0L60B82/+xsnPELESvcaR4H8dkIi
         KeE2exk5djsktjIUe0NEWBUBLod0/gH0XWNZpFm2ElYt/65SsmES2zPpHAaF8LQ5OPcL
         iXTS3INLjxwE7T9g0L2uP5bM2Zrfz5M3Nlj14MO3EaR8R+8SeCXnEJn4JzjMR27Ds/p2
         jewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881212; x=1728486012;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ATO5nzXBRKuk5zIyka26b7+2X+oqvRAeNDNerUiZPQ=;
        b=c9cKhhbjdwh/+7/DNkjn26W/uzgZA5zIWQPeHzR/PkuYZXSzMHu/clx0187vcvxUX0
         /2xs29ls15DuXwTiYf7qdA9vWzpW5L5ZaE/F1GS0vK3Td2nhf7LfdgPsLaYDW620/Hzm
         TaQO3+DiqTEMidVq5BvFu1ywVaAwzPCl/kj1jueIAMAOZ4IXIHYefum4RlpFeS/YLgHR
         in1EMC+SyRYewIFihXQ+SbEvIR2kK7M+GirZOtdYkPL/2SyXI39nzocOVVN+yuGAyE9N
         O0hV2YtQON6vn1Sj/qRAuRZJClJ/TqkqNBI0alt4zll3rvYhh/+qlzlrAgjp2K0jaOOW
         GlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2LfhjJJr7Y+MqyWHWjupmL30uT0XgarmEGpeO34NnYQ/0HEwUpKm9d7z/V9T1tlttiEWmgtAz7V6l@lists.infradead.org
X-Gm-Message-State: AOJu0YxFMRHhtPkctIQlzqjBCbwM3bZHzMclTNnI11g2H5LcnzmLzU0C
	5sBLHiyE1U1zmfjTfluhFFOsoruR2MsDQzjD/SgzemB8ugGMXQBvkrmsKctG+9I=
X-Google-Smtp-Source: AGHT+IHex8HS6m/uMgtGBHqHA7E/dbDjbWiTPY1GdyYsbd449LVjuZyZTpNsMhmhRF47klqBZJ3/jg==
X-Received: by 2002:a05:6e02:1a4c:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-3a35eb0211dmr53524285ab.1.1727881211298;
        Wed, 02 Oct 2024 08:00:11 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9d33sm3158793173.163.2024.10.02.08.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:00:10 -0700 (PDT)
Message-ID: <397fe31d-413d-4ef7-ab56-0a7b3b51d79a@kernel.dk>
Date: Wed, 2 Oct 2024 09:00:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
 martin.petersen@oracle.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
 jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org, dhowells@redhat.com,
 bvanassche@acm.org, asml.silence@gmail.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-block@vger.kernel.org, linux-aio@kvack.org, gost.dev@samsung.com,
 vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net> <20241002074926.GA20819@lst.de>
 <Zv1fC3qYVDfxn3lQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zv1fC3qYVDfxn3lQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_080013_355664_F32EA745 
X-CRM114-Status: GOOD (  14.71  )
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

On 10/2/24 8:56 AM, Keith Busch wrote:
> On Wed, Oct 02, 2024 at 09:49:26AM +0200, Christoph Hellwig wrote:
>> On Tue, Oct 01, 2024 at 10:23:43AM -0600, Keith Busch wrote:
>>> I think because he's getting conflicting feedback. The arguments against
>>> it being that it's not a good match, however it's the same match created
>>> for streams, and no one complained then, and it's an existing user ABI.
>>
>> People complained, and the streams code got removed pretty quickly
>> because it did not work as expected.  I don't think that counts as
>> a big success.
> 
> I don't think the kernel API was the problem. Capable devices never
> materialized, so the code wasn't doing anything useful.

Exactly. I never saw ones that kept the stream persistent across GC,
and hence they ended up being pretty useless in practice.

-- 
Jens Axboe


