Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8394FE7718F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 11:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kSr8QRPbWyeuYtAJXhV7CqtuHNejTbL/irUiflDNBWI=; b=RRHxIfBU7nLZfF5zMr5QUoig+0
	Kb+zm8VWmpVi6cg61bvJx4BmFuRXPr+IbRcq+SV3+17XCMsTIiJyeh4B1t85RENMoFrkByTCEqEBs
	rmXfW8qROpNhOArCq4bmubc7/mYcvueKq/bKaD/WEqlDzn8k02sP7BWMlyNxNW1XzSHx0DcbNAKd+
	8xcLGe3RvdEsVzdn7Kudi7ByEXVPjJbvC3onFR326vLZJnd/GkagDC7iQrt0Geq1pAO3gIjkwcXqO
	AD0962nWZ2RCG+5bhLnaMvlB4avq1UwRKi6b32yRcnPzveGvf0RiA81l4tF2CsaSJVmrFPXL0/Jpn
	WvcXhOlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTgAp-0000000CrXA-3ZKW;
	Fri, 03 Jan 2025 11:49:03 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTgAn-0000000CrWg-279c
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 11:49:02 +0000
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5031iC9i017464
	for <linux-nvme@lists.infradead.org>; Fri, 3 Jan 2025 11:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kSr8QRPbWyeuYtAJXhV7CqtuHNejTbL/irUiflDNBWI=; b=eCsIUbN1EJD6dspX
	Qa5XsuPdhU7dlEEHrNHoj0OsT9moNzhmr//xtCO8BewROYirQK5NTOxbdZJ8oI1B
	VvlcdEjcjjV6VW/KZFcXAJPveRx/ICXxCkzAO/7i2TnLmKcNkcIoYT1QLxQIn8r8
	oOxKsSmnG+UahVQ16MPjFVhc+OIngAG+xx5Ck8ezzLNJbWXF+Y4BrIlQhpc+Hq+z
	+UL9b1/BHBgHlTIwAXmTTPU/DuuyTnA2kMR/s+DngcjV6d/Ho5D5/rMFiUvHYwvc
	WrdpizFg8TPNEbjVuXbm6vpG+xOsqgLRGx2wuOOsvRWOOWYfsf4KLkvbWchO0Sd1
	tb7iUg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43x6g0h706-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 03 Jan 2025 11:48:59 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d8f15481bbso28677026d6.1
        for <linux-nvme@lists.infradead.org>; Fri, 03 Jan 2025 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904939; x=1736509739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSr8QRPbWyeuYtAJXhV7CqtuHNejTbL/irUiflDNBWI=;
        b=Xcgp1nY8bav/+qM5jbYC5DwwiFUNZIA57LdyUagnz2QCmPJWg2Sbc1xXzQNyqSDzmU
         2MUycwyETWziii+riJUtwr1aTl4X0znaWaKdgbhLPl5C4vsSdlqP6W4nESzhzUvzx0rg
         p2L/VXW7DVY2G+3MVH/TDeLf0T12RvkTrS8T/FcM5lJOovqIjaxd3psToxosjeIGpYP2
         F5BriUCsGYA5LkUH4NQ4B6TM6Mg9Hma7yr1Kzzt9EMEYjy5XioEVi6916YKv4QuMET+7
         Q5aZwoh2rxrSUg/ecYpIctklTHIqbYh/w4Va1rogGoPqdAQHFf6faYR+t9bWYt7zEuSn
         hN1A==
X-Forwarded-Encrypted: i=1; AJvYcCUTymxZfVdl99eDj5+dHoLyuriJQE9e/thi/7rYR3jGgSCVw+2LEroHbCmrTNsdKmhRtOpkDi/c3Cs6@lists.infradead.org
X-Gm-Message-State: AOJu0YwJvodYRwGpW1aj+bi0iRM16UTqUIgsspC3/nIfCFinw7VSVMGn
	sZL6fWgLeqaIgUY95pMRJJE9TDr2RjZD1QXnL4pZTPKqMSDmqZwxvStkdyrc5w3eG2h7Oa3j/cZ
	Po8xNKmUydKyYcTuriRKrWErLUyQgDXCDmIUHBjoaRlbTc+RPhFPXuACfRi8HPAFrRQ==
X-Gm-Gg: ASbGncvbNlMGj6voos9P9YyEDHi8QHsTsm3YbLZ4mqq4gD+6HA9HWq7Sriv8MfylZWj
	USc5L91pEs00+khXfpT2zZIfT9igmqgr5EF6Jzl+kYHC4qecxUnUzE77h9/XCmD6S+m6WopcJgT
	viE1ASRXFjtkLKymr5M1u0anEpRIiCBf4O0lYg6/AwP+MnZFMOILSNZBxCq5m9hZcY1ykZMn+xg
	LBiv6tyjrdwCVkVpdAfvnd7mX539Mh/SEVk+8eRlOKgyQdWk1XqWy7S4wL1IAkp+2ephVE06VOC
	z+rTrptHA6L1TmEzs8HufW+0AYylQi0uYUQ=
X-Received: by 2002:a05:622a:199a:b0:467:85f9:2a72 with SMTP id d75a77b69052e-46a4a6a51camr298065041cf.0.1735904938642;
        Fri, 03 Jan 2025 03:48:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeaakE33Peugzgz4XJzULmcsT1OumHdl1qg3wXiidDFearGseoLbBPjIsRixnqTRiKwVCreA==
X-Received: by 2002:a05:622a:199a:b0:467:85f9:2a72 with SMTP id d75a77b69052e-46a4a6a51camr298064781cf.0.1735904938243;
        Fri, 03 Jan 2025 03:48:58 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f60asm1912866266b.28.2025.01.03.03.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:48:57 -0800 (PST)
Message-ID: <95f25457-c1dd-4125-8f0d-46d87a1d5356@oss.qualcomm.com>
Date: Fri, 3 Jan 2025 12:48:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: Christoph Hellwig <hch@lst.de>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
 <20250103072805.GB28920@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250103072805.GB28920@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: TeTHpLW-qkci2CeL19s-JaVRPI_7KhYi
X-Proofpoint-ORIG-GUID: TeTHpLW-qkci2CeL19s-JaVRPI_7KhYi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_034901_552931_881299DC 
X-CRM114-Status: GOOD (  21.15  )
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

On 3.01.2025 8:28 AM, Christoph Hellwig wrote:
> On Fri, Dec 20, 2024 at 04:15:21PM +0100, Konrad Dybcio wrote:
>> The Qualcomm platform (or class of platforms) we're looking at with this
>> specific issue requires PCIe (implying NVMe) shutdown for S2RAM.
>>
>> The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
>> state by Linux as of today, and I'm trying really hard to convince some
>> folks to let me describe it correctly, with little success so far..
> 
> Well, not advertizing the right mechanism isn't going to cause havoc
> to any scheme.
> 
>> That is the real underlying issue and once/if it's solved, this patch
>> will not be necessary.
> 
> Well, maybe this thread gave good enough fodder to finally fix it?

Oh I'd love to..

But my changes are getting rejected over philosophical FW design
disagreements, it seems.

Konrad

> 
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
> 
> FYI, going to D3 for S2RAM seems perfectly reasonable from the NVMe POV.
> 

