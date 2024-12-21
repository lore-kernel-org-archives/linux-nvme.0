Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC872E77184
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Dec 2024 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PviBgmbTXKBNX4qAGuEbhZpgWfmtVEh2UszefQDNd8Y=; b=irJYIIk/mpHoH+V7zWSm/uGpye
	DLdo1PISAYENqZGcQv18qL3B74WvfONmm5X6IxGdnKc9wIYbqPZyApkrM+KCy2iDQwvxjcO0AX+VQ
	bAVjCaQZ+HS3Za+CHFunsNuUybKYJM9qvxgrGD601Xo0wPvOw09iE/0k4+4x7qp6uh0eYKKPdPTd/
	wQVDJ35LTDru2ZAJi603EYA8GENYDxryVbsWjrgz+bxz09ylKyLbvomYE3Hj8SD0bAsEsVjgg507H
	3+U6seh+wvLibnQmDrsuF1gU3K5aCwn5qycO/ldjtHiYM6JR07ta+VC7IiceZ9S9rrQ0INcuGh4Tm
	7CUlEULQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOxTr-00000006uCd-3ndZ;
	Sat, 21 Dec 2024 11:17:11 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOxTo-00000006uCI-0TGk
	for linux-nvme@lists.infradead.org;
	Sat, 21 Dec 2024 11:17:09 +0000
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BL4BoFA008739
	for <linux-nvme@lists.infradead.org>; Sat, 21 Dec 2024 11:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PviBgmbTXKBNX4qAGuEbhZpgWfmtVEh2UszefQDNd8Y=; b=l3yAc36c14puS7M5
	4qvDsMiIdErI1uYhsAldWTRoupTTOSGQ5OSjnEmaXTwdh+JXtOb86dna4VgNdjAa
	yCta6SqYUx594SxOwCdv5hoLAOqyqoN4dMV1eKE7+1jT+2PIcPzJFgA2/7/+y3m4
	Ghctg5QCT90XONkG0YWEfPa4bQuFSKHPdnOvS/JHFaCwC0/RjC16mtY2JDKeLuFv
	jDp0iB9ukEPE2JzlwolEr3brl6E7HyCE1lQt+imZIQyVtDQB3D/4LmeC0oihGEdi
	oiX/ugL5kyHeD5gLA9JfYoqodFut3Fx12670b2d/2Ci5e6qdjj+1lM4VfmxM8D57
	UYDTvA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43npeh8yba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sat, 21 Dec 2024 11:17:06 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d8a3cb9dbfso4287796d6.1
        for <linux-nvme@lists.infradead.org>; Sat, 21 Dec 2024 03:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734779825; x=1735384625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PviBgmbTXKBNX4qAGuEbhZpgWfmtVEh2UszefQDNd8Y=;
        b=AGvpNoIJsd+mWJY1KSPyEppjnjHsBZTRlnQ40GJM+qKZddO93HMeZKbYJfdKT9LIFK
         9M92HRrPUzTnUawAJs1woL6aWYDEwe/G39dLF+7Pa59I318rCvNFbx7IBS9tRwhsq8NF
         2cNT9DlX618LO+4vZKoTo5hs3ZLHWdqbT0iOz87AN+kKTLhctrH2M/uTLgUpHUnKmpUi
         ZuYrD871Odcb1RW3akO4Yn23FE67Nar/QKOUd2HBeDULEUCEqVWHY7kHPNhcggrZB5jG
         0VvYENyskLKajm+xrUAStav1uyvBOLhEc5AVBsHfWKH2gnDRyodMYeqeXyaS3Iu7VZcs
         SuZw==
X-Forwarded-Encrypted: i=1; AJvYcCUoHqHc+qXk9IEcTrbNNM2+p07Fqg650IFdwUaQwTz7jxfRrH4MvgxxkwOQfODuSxZOXMfG6EeKDVNm@lists.infradead.org
X-Gm-Message-State: AOJu0YwmEX8a1+do/SB/9B+y85KNGVQUwTRflpmRfXKHwQYAsu1KRSzj
	BWBCxjxTOoJyOFIzloAcAQnXg5Bx4XwML6m0Lc5H4GwC8Ly4DNfqcwzhB6uOJZXDWCAx7/TW00u
	gsfcWQ8fioWKhdWN4FSRjULF/z721XyiFO6xsZnyxauSTRjt3mmnmkZYTsbgYp0R1wg==
X-Gm-Gg: ASbGncsWLM4KYRK/33lqJ83XuLNONNjFq+LQs6po9Nr52vZOqrICiSJHJH7T4+1EmJs
	su5Cm67rcfn/GjGYaGWCQ4JJvr+MLTJAMRIe2ETvePwCsQ4PpDNBz5yN+Aw6LBaDpxNpA3Vbfdy
	If3p6dLfDvaH1b56f6l3H1w8nTM2F/IwrzGEJliCKt7GojE/FauDdhdJcYL6DTUKrAbSYtY42+y
	YH93CGk/4tksEK+ao9s+QNBnF6tEVBQZaQLJHq540C6IYYl2FjBX7v0imBrTxwCmp4ZpqLZitq7
	IQB1jZcSkLfVDK608qFnsW6xk+Ww/Sf1j+E=
X-Received: by 2002:a05:620a:4116:b0:7b6:cb9a:e0d4 with SMTP id af79cd13be357-7b9ba7d89b7mr317909385a.15.1734779825325;
        Sat, 21 Dec 2024 03:17:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr1Wi8ZZI27rCO1os4kGR09bu4rvLnhtSDLOTZS9z4c7OepAJHRXZEQU8Hm0VJwaoP7XsYUw==
X-Received: by 2002:a05:620a:4116:b0:7b6:cb9a:e0d4 with SMTP id af79cd13be357-7b9ba7d89b7mr317907985a.15.1734779824888;
        Sat, 21 Dec 2024 03:17:04 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe48aasm269194566b.112.2024.12.21.03.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 03:17:04 -0800 (PST)
Message-ID: <a514f047-d56e-40a1-ad36-b655cc8cddb7@oss.qualcomm.com>
Date: Sat, 21 Dec 2024 12:17:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org
References: <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
 <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
 <20241221033842.6nvmd4clkb3r4roh@thinkpad>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241221033842.6nvmd4clkb3r4roh@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MZD5wxrBW-KDs3H6wzLauhcDXrNatjTO
X-Proofpoint-ORIG-GUID: MZD5wxrBW-KDs3H6wzLauhcDXrNatjTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412210099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241221_031708_181970_7235C1D4 
X-CRM114-Status: GOOD (  38.73  )
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

On 21.12.2024 4:38 AM, Manivannan Sadhasivam wrote:
> On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
>> On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
>>> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
>>>>> We need a PM core API that tells the device drivers when it is safe to powerdown
>>>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
>>>>> applicable to other devices as well.
>>>>
>>>> Maybe I'm misunderstanding things, but I think the important part is
>>>> to indicate when a suspend actually MUST put the device into D3.  Because
>>>> doing that should always be safe, but not always optimal.
>>>
>>> I'm not aware of any cases when a device must be put into D3cold
>>> (which I think is what you mean) during system-wide suspend.
>>>
>>> Suspend-to-idle on x86 doesn't require this, at least not for
>>> correctness.  I don't think any platforms using DT require it either.
>>
>> That would be correct.
>>
>> The Qualcomm platform (or class of platforms) we're looking at with this
>> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
>>
>> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
>> state by Linux as of today, and I'm trying really hard to convince some
>> folks to let me describe it correctly, with little success so far..
>>
> 
> Perhaps you should say 'S2RAM is misrepresented as S2Idle by the firmware as of
> today'...
> 
> But I'll leave it up to the PSCI folks to decide whether it makes sense to
> expose PSCI SYSTEM_SUSPEND through CPU_SUSPEND or not.

The firmware happily performs the actions required to put the platform
in S2RAM, but the interface used to request entry (CPU_SUSPEND) is
mostly used for entering CPU/cluster idle states on arm64.

(although the PSCI spec also clearly states that using CPU_SUSPEND for
system-level low power states is allowed *plus* the reference
implementation literally just calls CPU_SUSPEND internally whenever
the """proper""" SYSTEM_SUSPEND call is used, anyway)

> 
> For the people in this thread, I'm leaving the link to the PSCI discussion here:
> https://lore.kernel.org/all/20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com/
> 
>> That is the real underlying issue and once/if it's solved, this patch
>> will not be necessary.
>>
>>> In theory, ACPI S3 or hibernation may request that, but I've never
>>> seen it happen in practice.
>>>
>>> Suspend-to-idle on x86 may want devices to end up in specific power
>>> states in order to be able to switch the entire platform into a deep
>>> energy-saving mode, but that's never been D3cold so far.
>>
>> In our case the plug is only pulled in S2RAM, otherwise the best we can
>> do is just turn off the devices individually to decrease the overall
>> power draw
>>
> 
> I don't think this is accurate. Qcom FW (the one we are discussing in this
> thread) doesn't pull the plug (except on platforms like x13s due to hw
> limitation). On ACPI though, the FW *might* pull the plug, so that's why drivers
> prepare the devices by powering down them (largely) if pm_suspend_via_firmware()
> succeeds. On Qcom platforms, we are trying to allow the SoC to transition to low
> power state and that requires relinquishing the resource votes by the drivers.

Look, I have a power measurement device before my eyes and I clearly see
the main power rail being cut on successful S2RAM entry.

In s2idle/runtime cpuidle, no power is removed to anything except CPUs
(as decided by the adjacent uncore MCU) and Linux-PM-managed devices.
This is what the "pure software, light-weight variant of system suspend"
wording refers to in the doc - we shut off some peripheral devices and
put the CPUs in some sort of a wait-for-event state, opportunistically
cutting power from them.


For S2RAM, in the special snowflake sc8280xp/x13s case, we need to
shut down all PCIe RCs manually from Linux, so that another power
management MCU can then cut the system power rail.

But on other platforms it'd be enough to put the RCs in a lower power
state and have something that's not controlled by the OS decide
whether power should flow to them (more like the ACPI scenario).

The latter we don't/can't support as of now, so at least getting the
first case squared out would be good, as tearing down RCs always
works, even if it's not preferred for $REASONS.

Konrad

> 
> I still have doubt that pm_set_suspend_via_firmware() applies to Qcom FW or not.
> Also the API description doesn't exactly match its usecase.



