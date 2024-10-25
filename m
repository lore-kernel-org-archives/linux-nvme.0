Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683B0D149DB
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 18:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ioJoqSdO3mYmi5MI3yxlXmhEsUY+jkvC0eBwhFf0TrU=; b=swF1vtQf3HNB8Z9aKHTfWOlaIz
	Bj9W9E7mrOC1idE+4473q4/tjTgF81/3kWmg1LAa2+ToJcR1NXrRA//KnTcFqvYfYfgq5+4o9HduQ
	9bRlMzh/91Q2Td+5ApJLl/sZp/uUdHEGRZGCqb4XOT16A0jv7Lmltk7iLM8it9aD8mNwWybr6/Q40
	vrwQmr2xZhPrxgYB/Hh3eOcV8V90WrmYekeSveQFGWZ46bv/ArlbXx8xGaFNs+/WeSQuZfPGYtMus
	7dAhtdyuUCf4HzpVoYovtZL2WF2DmQy9ue5yYIt59TuMdX9neWrhRhAlmujjfTj2QbagVB1XAD+bF
	cOMCw8dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4OwD-00000004mCW-0mWx;
	Fri, 25 Oct 2024 18:21:29 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Nz6-00000004ZAf-3Cqi
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 17:20:26 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PAfqC9009410
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 17:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ioJoqSdO3mYmi5MI3yxlXmhEsUY+jkvC0eBwhFf0TrU=; b=pL14LhjPj4eN6+Qj
	+r9vc02RTNoQC30/mBHJnrfr4gbiLNJJGPZY+NPeB2xhvZFI4pPjdH4oAKoqbuqF
	UG+bH/ZUudsrDc/y35DHBlvlaLFcfFKxesYJLNa5qq6l/9dXqeMqCM6CqTcmm9bI
	Ut4gFlFZ+5KmDxdeWCCl+Wgaas8Mh8+LaEqVlwoXUTKQhIpl0HiSpyEZjqgwH07O
	d32TUAWd2NG6TMH8UeovB1hzoXsUq88M0yc1pVEz3metR67BJR94AMjzItfy33Wx
	u6V7UxfUXWt6a3lUDmI8Z2Zj5JrmA2XAPspqvkTisUAzB6tC6KnpL1U7Ex1cX7Um
	82A6kg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em43hx2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 17:20:22 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6cbf3f7273cso6421876d6.3
        for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 10:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876822; x=1730481622;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ioJoqSdO3mYmi5MI3yxlXmhEsUY+jkvC0eBwhFf0TrU=;
        b=ispF//RFpQ1MATw8UTOS6kOkCmm5eobQ8nZ+o44TsJkwEJ6UvilV5o8ceOBtrOPhA3
         S2pIdnP6Bi19J9QFkd7FjN/dyRnvNdx280zctY0t7/I+hmKbckHf1BnMlsbbThTDcomY
         lGxNOW1Yt2krrTZTg4NswsVrBr/0UcDqq8um4jYINg3j/Avv6Qv1XHJmaAI7fbGWWLCa
         OesE4gzg/hC/v2VwRgVq7XzYtfg93kujQNdaAZguirkB6I6YnBGQ3Jc3EyzHjqe4Fpfp
         qeszC5rq2gAXDquxubPCdpC29nqHjx0uHBRZYJVYUJwCabDDyDMJJ0BjqxQnBVDQnMqD
         dqvw==
X-Forwarded-Encrypted: i=1; AJvYcCVa8kE4V8+1IGvogDBctoTg6N4KZyTNL3IfVcN8upoGuFG/qablXziTc2UAqljdwwxF0giTbhWlmIhg@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5o8/igbncBNih/4UQNrAqPSNhC9YOUt+Y9ZRpVd2pGsUqvFxx
	mPppi3ZCHAYfx6F0yZlQL1lrFxLi7N0gVZaTXJqofvMqTVVMrNHB/pnLnBIXY/4hIGztLq1E6Bx
	oeIlf6h9CL3z3q8lNPA3ryUFw1DVlyqLikj9gZmoz3OzJdBViqEAV4gmhamQAy97WfQ==
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr1256686d6.5.1729876822070;
        Fri, 25 Oct 2024 10:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVRtOxwLAfBjXD25YCeJd2XrgSjviqO4RyNQJHomWQ/y7f5nG0bpuWE3oRUPkM3IbuyZoGog==
X-Received: by 2002:a0c:fc48:0:b0:6cc:2295:8724 with SMTP id 6a1803df08f44-6d185682eafmr1256506d6.5.1729876821721;
        Fri, 25 Oct 2024 10:20:21 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb62c4547sm813471a12.53.2024.10.25.10.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 10:20:20 -0700 (PDT)
Message-ID: <955e6f06-ab4c-49d9-bfe6-d96d2a81f656@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 19:20:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Keith Busch <kbusch@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
 <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
 <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ZxvOEOXzLIsbEbve@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KffNSBL-i6AXIYPrHYVyodzPI63I9Fyo
X-Proofpoint-ORIG-GUID: KffNSBL-i6AXIYPrHYVyodzPI63I9Fyo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_102024_972619_A025DB01 
X-CRM114-Status: GOOD (  21.88  )
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

On 25.10.2024 6:57 PM, Keith Busch wrote:
> On Fri, Oct 25, 2024 at 06:40:23PM +0200, Konrad Dybcio wrote:
>> On 25.10.2024 6:12 PM, Keith Busch wrote:
>>> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>>>> before the platform can reach S3-like sleep states. This is very much
>>>> similar in nature to the issue described in [1].
>>>
>>> The "SIMPLE" quirk is only supposed to affect kernel managed runtime
>>> suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
>>> suspend?
>>
>> So on these platforms, all system sleep states (incl. S3) are entered
>> through what Linux sees as s2idle, with a separate MCU doing a lot
>> behind the scenes. s2idle of course also covers the runtime cpuidle
>> cases.
>>
>> All but the deepest state (which Linux doesn't differentiate as of
>> today) are effectively somewhat like s0ix.
>> It's a bit hard to draw accurate lines between Intel terminology and
>> what we have here, as there's way more things onboard than just the CPU
>> cluster that may be operating independently..
> 
> Gotcha.
> 
> Is there any sleep state on this where using the nvme managed power is
> advantageous, or is the simple suspend preferred in every scenario for
> this platform?

On the special snowflake SC8280XP, simple suspend is the only choice
that makes sense here. Otherwise, you'd need to keep the entire SoC
powered, which (even if most of it would be driver-suspended) ruins
battery life.

On other platforms (where we'll be able to sustain the PCIe link,
eventually), I can see both options being useful for different use
cases. But again, that's only for when we can actually get that working
on mainline.

Konrad

