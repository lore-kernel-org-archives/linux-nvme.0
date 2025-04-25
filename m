Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6DFC369D3
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 16:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DOF7MEdJZfeltW9hyPd1aEthrbud5eZtYdTNBpurl7U=; b=4OpO0+2eBjRx65D+bUJ/Bcl4wI
	TTfeRZIPHHF/v8gFVwl3HPMbavWvwAQz4ggGfr6AUzW3ahwG1m7FpNXgxM5CLso8J1UT5OB1ZD56Q
	xApZPvjFSZP2HI6Nbt0H/9MogmGozKESr38DAyMmEhIQTIx+bB0wNHyoqBD7gU5K8JIfRsLV2JD/A
	5+J518d0HEgFauPfUcT1Ty3ni4UIdFbkOwxxHR89tlFWdhnya44OMlcQShYnd2rBf9olFxY5NdMUi
	7jegnPnb4/g56ISdJBPBtQ6QWO7Wb2Dz9S3Tm5yxNSHlpjepF+x7jK2oPRX1No0KExQQAx7GaDTCd
	fCJNUmEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Lvc-00000000DdY-2Qy7;
	Fri, 25 Apr 2025 16:29:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Kbx-0000000HYjb-0jYo
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 15:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745593504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DOF7MEdJZfeltW9hyPd1aEthrbud5eZtYdTNBpurl7U=;
	b=A5UMsCZfwWQVC1jAiermt6/q4AfrmKL36z4+TmckvFQcOy2z3mKC/jedFZPWpjprccs0nL
	COY988wovRENUR75LF7cROk/SzD5heosI9ind0npyv3yjcAL1ldjff/gPUc94TaP0HfSsM
	lMziURMHdxYp0PZPGKdgFuTSvQBuJiU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-DcB-nZAyMyGVeHKGzieU4g-1; Fri, 25 Apr 2025 11:05:03 -0400
X-MC-Unique: DcB-nZAyMyGVeHKGzieU4g-1
X-Mimecast-MFC-AGG-ID: DcB-nZAyMyGVeHKGzieU4g_1745593502
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c0b0cf53f3so349578885a.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 08:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745593502; x=1746198302;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOF7MEdJZfeltW9hyPd1aEthrbud5eZtYdTNBpurl7U=;
        b=riJBwh1SDBuSwhFigz2sOVVg/X8J9M0viSw+O8gFDJXH/NPpvN2HGm6kJpk1t6UIq0
         DP8wU9atS0vdFoZEbJi7BszRHPIeGqXxOsiHeY4xlQKjdQBk+mG08wErqZEqpZ7SY3uu
         0mn/5GcH0ZjnyVEXMigpb8rE2s/KCfw9ENkZtwU6nLTTnXZMgfx+zI8SiX/dCOagaD1V
         FlmOueDQPD+u3lsnw1pimq2hceXYWahjYFmc9hL+Q/pw4riRQhR7GK64kz6CodaPqRog
         /5kpWWnhWKHPfrkEPIXQZfm8rHX+iCTotf7MlZ/iML8RgQdPh/1UvxYNKl3/5rc+WBIN
         N0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSnuErLuAeOJ6jubW1Npzrg0RCYjloqOLj11F6Hdq/lFDiz2lBjHBYgybQlqUEXRaGxGzHsn0Cixk/@lists.infradead.org
X-Gm-Message-State: AOJu0Yyb/UQeRwCSykSx0+D10fZ3aVoGc5c4TPofKT++L+NMulvMzkgl
	IvtYNwXTFDrB/gwsaQLSmSZJ3nfK91sM0DC6cGUHL4MZ6bcMVzqQVdHRvus8kKTSQ7AzRCXxfwv
	Kw+z0N4epX/9IcLXhyxWYZyrYJlJgoy4PspHV9LW8u7q69oda/qQSUwq6RxJkhw7a
X-Gm-Gg: ASbGnctwR83X8vXWCwjPZIQ2YIkevM97n0y9AcNa75Fwkg36LXqklahKCxWI/cEJg+b
	u3Tou6S0ZZx23km+mn1tEItFZZy1UabKvyfzONOArRuK+3kC3AwMzAkPG2NpxE5ELNPcbk29cAY
	KzsZw45xbNQxbXTIDyfaEb185JacFfWKvdFxAebXEsmQ9OAI2cx9tOUEcWxNqd3EU/DbWv0VxQZ
	pLz9H0Ped3oMydsCMJ9BW872ZZDMl+dsASf7xaGU4fXFEi3gCUepHEOXrqq0sdjG8zGqDE9g3ar
	xYTiNAXuCy01gBy9z2GBw8mrbNTRa5E9aBXezjQ2QtJkOlPRYQfostZ2+Q==
X-Received: by 2002:a05:620a:45a7:b0:7c9:2787:7a75 with SMTP id af79cd13be357-7c96071a2a9mr416827885a.30.1745593502545;
        Fri, 25 Apr 2025 08:05:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoVO/RlBmRwhTSBxGq+umqayLGF87nDdoCgXkyU71i0ZoeZaGSM6HAOq8f+P1CncBaPECQ9w==
X-Received: by 2002:a05:620a:45a7:b0:7c9:2787:7a75 with SMTP id af79cd13be357-7c96071a2a9mr416806685a.30.1745593500279;
        Fri, 25 Apr 2025 08:05:00 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958d86c6dsm227016985a.71.2025.04.25.08.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 08:04:59 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3fef1073-3a7e-45ab-8448-a144d5fb6a73@redhat.com>
Date: Fri, 25 Apr 2025 11:04:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: cgroup null pointer dereference
To: hch <hch@lst.de>, Kamaljit Singh <Kamaljit.Singh1@wdc.com>
Cc: Waiman Long <llong@redhat.com>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BY5PR04MB68495E9E8A46CA9614D62669BCBB2@BY5PR04MB6849.namprd04.prod.outlook.com>
 <a5eac08e-bdb4-4aa2-bb46-aa89b6eb1871@redhat.com>
 <BY5PR04MB684951591DE83E6FD0CBD364BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <623427dc-b555-4e38-a064-c20c26bb2a21@redhat.com>
 <642a7d6f-9d8b-4204-bc81-4d8e0179715d@redhat.com>
 <BY5PR04MB68493FB61BF28B5268815381BC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <20250425145450.GA12664@lst.de>
In-Reply-To: <20250425145450.GA12664@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HVz_hEPx7Hb_YioeggnhWPrB6AC1k-9siIWiuYjPCvY_1745593502
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_080505_284129_01C46A1A 
X-CRM114-Status: UNSURE (   8.18  )
X-CRM114-Notice: Please train this message.
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


On 4/25/25 10:54 AM, hch wrote:
> On Fri, Apr 25, 2025 at 02:22:31AM +0000, Kamaljit Singh wrote:
>>> It should also be in v6.15-rc1 branch but is missing in the nvme branch
>>> that you are using. So you need to use a more updated nvme, when
>>> available, to avoid this problem.
>>>
>> Thank you for finding that commit. I'll look for it.
>>
>> Christoph, Sagi, Keith, Others,
>> Can this commit be merged into the nvme-6.15 branch please?
> What commit?
>
commit 7d6c63c31914 ("cgroup: rstat: call cgroup_rstat_updated_list with 
cgroup_rstat_lock")

Cheers,
Longman


