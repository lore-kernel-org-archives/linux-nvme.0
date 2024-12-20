Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D05E7718B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2024 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=; b=K58mmOkGhH0yVfSQOVBsALnkOq
	PNiG0CCPgkSTQL+hNkDlfowATaE4aaM1FjW/eoYoaXcNvrtnwBtHEamTaLgMQX+jdcr3vs6cfe3us
	B69nB1CC0/+Tn1mMiL8/aWQGrdwk0m4nBHmAJZKfjUnV1fSUP+S5OpNnWVPDc8/uZx6EX8Cm6Cvob
	zG+ZbXAhnPyIu1rA3awgZTu4UX0e9m2BDbn6L8PqknrhNv1OnolzW7jZLbdorQ6pIqQ+zC3oVwnar
	fBM6+a+upO8BSMgBgaF+FT+LvKGmTi+/BK1IJh9H0zwNd1YDIuB8+gftNsm0akHP2UvH0DbOE/eXZ
	fGZkyUJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOgkm-00000005dAx-2IZd;
	Fri, 20 Dec 2024 17:25:32 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOeit-00000005HvW-1FVw
	for linux-nvme@lists.infradead.org;
	Fri, 20 Dec 2024 15:15:28 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BKCiZbk012729
	for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 15:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=; b=CWkrGgGegK3PkMiY
	21XQ7nuYVRZdULWoQulYqqX8aAHE8jbyNEdEg73YmDZVSxvnURpB4D4bUA+m/kTB
	LO1CY95KY8IVvkA7UHxeL2jUR6ya8zlQljpYX2cWDemMtBTBxIwyQT/J9CgWKBPW
	9sUxYrb6RRpvNNOJWaxLc18BXplb1tD5Rb/YtnO2odLR1Hg4INSoaaBIxhhHsKuV
	/o5/i66CKjOmTe92spTR3caiejJbu24r8RB+RllT4HwZgBQbPp2iYU0wkl5Csv5z
	tCBy0CRXjZdO9bhgYqFHuT2Unuu0R/Lo0AnPZ0heF2W92bgaIriX8GZz9nI059b9
	qGsaIA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n8uvgbew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 15:15:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8e8153104so4840256d6.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Dec 2024 07:15:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707725; x=1735312525;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pdRk1FNEwE15r/NRpb5txdFYJ22rYoCmR29SeDLD9E=;
        b=c4d3BN0a5dPd6V1IvYjD6D3nLhbTHUvurlwFnZZMv/zgwsJ89RhXkmSZrXE1A8r7k/
         wQ6dzZBwiqHQPgZ7M5DQddy8LDzvX5AK6RJGKCdR9bCf78IM3q1FeN1oBMbAzGvLv/K7
         0el2unF7QvsUITHYiGEHrgxd8sbfTtPu+TN92HduRJSal5sEt5PvQyrYX5BkJZXQZbaD
         fViDkTtOUPBccmNbEB8WhpKFz+6w9kW1/nWtMxuVEjjj9s5feMTeuBqdG0dUZ96L+Al3
         G1zjzT2hHYuv/QFbQLwNBIsHdfXT35+M789/3Lb3GTuG2udbGOuvb+ydrk2X8DafRGp7
         pNAA==
X-Forwarded-Encrypted: i=1; AJvYcCVru/k3CqoR8AVYuq8qRtR8mxXeE0Rxjd5I2+5QJomG28Kh47oOfdXBP81kpm+Bq4jVn5R8YlPbk54c@lists.infradead.org
X-Gm-Message-State: AOJu0YzhWJp3vpe2JWdbhFUlG7eiTLQs6eiwFofiHo/2MYoTeVyJyB+P
	ZdM8AjhG6k81+aY6ZVRZOGamFyFfhC9B8klwzJ4ZDW5S54gb7q0mMY/jHcDxIeyeg3mt5W6cZAi
	wyZFV6hv0IO8djD00FSatIB8iK22PiGJf98hqoWF8fqoS+o0/gwGBREAem5QEhOWp9w==
X-Gm-Gg: ASbGnctAJaI/kS/h/Ag8HhEyodBfEvQKQMXKjc8QLQoMhwRSBULEmsO15hpFWoOyoJJ
	lGmDr3RaYPwgj7urdzplw9GEUCda2+5CGMDrTuoj3Jm5S4/F4EEOxMN+7eJBWh8KTQYIM8XdZ+R
	chmVg2Qg+8W3KHbqY73jg0kw7H8pHoNIpMhDFabHuGLxHcOeTlpEpbgH6to6T/rLgJQRV9siE85
	RnNHGwkT8UOxpVnrGdAf390EHNCG3m4ZjkFe1KyY+DZlruFcELmK+lIAs7ChpET+e8tGJS4pItF
	HgpkQM+quFWWKw29dZgM9pq4yuSnyrPuYV4=
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170656485a.9.1734707725301;
        Fri, 20 Dec 2024 07:15:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD5koPpJL0wKEso3nr+u+1J+IrI3s+lO5cyWCeEsrPYRbTAkLqKhgQ19j1vhTaqjkKzFcUzQ==
X-Received: by 2002:a05:620a:2454:b0:7b6:c8a4:ba09 with SMTP id af79cd13be357-7b9ba7be496mr170652685a.9.1734707724779;
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a741sm1818444a12.12.2024.12.20.07.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:15:24 -0800 (PST)
Message-ID: <dd557897-f2e0-4347-ae67-27cd45920159@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 16:15:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the
 user
To: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
 <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        Len Brown
 <len.brown@intel.com>, linux-pm@vger.kernel.org
References: <20241205232900.GA3072557@bhelgaas>
 <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de>
 <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de>
 <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <20241216162303.GA26434@lst.de>
 <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAJZ5v0g8CdGgWA7e6TXpUjYNkU1zX46Rz3ELiun42MayoN0osA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sQKHFX1tar-6-K7wyFFaNShcz7k9WTS8
X-Proofpoint-ORIG-GUID: sQKHFX1tar-6-K7wyFFaNShcz7k9WTS8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200124
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_071527_339224_9EC4B0D0 
X-CRM114-Status: GOOD (  25.89  )
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

On 16.12.2024 5:42 PM, Rafael J. Wysocki wrote:
> On Mon, Dec 16, 2024 at 5:23 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
>>> We need a PM core API that tells the device drivers when it is safe to powerdown
>>> the devices. The usecase here is with PCIe based NVMe devices but the problem is
>>> applicable to other devices as well.
>>
>> Maybe I'm misunderstanding things, but I think the important part is
>> to indicate when a suspend actually MUST put the device into D3.  Because
>> doing that should always be safe, but not always optimal.
> 
> I'm not aware of any cases when a device must be put into D3cold
> (which I think is what you mean) during system-wide suspend.
> 
> Suspend-to-idle on x86 doesn't require this, at least not for
> correctness.  I don't think any platforms using DT require it either.

That would be correct.

The Qualcomm platform (or class of platforms) we're looking at with this
specific issue requires PCIe (implying NVMe) shutdown for S2RAM.

The S2RAM entry mechanism is unfortunately misrepresented as an S2Idle
state by Linux as of today, and I'm trying really hard to convince some
folks to let me describe it correctly, with little success so far..

That is the real underlying issue and once/if it's solved, this patch
will not be necessary.

> In theory, ACPI S3 or hibernation may request that, but I've never
> seen it happen in practice.
> 
> Suspend-to-idle on x86 may want devices to end up in specific power
> states in order to be able to switch the entire platform into a deep
> energy-saving mode, but that's never been D3cold so far.

In our case the plug is only pulled in S2RAM, otherwise the best we can
do is just turn off the devices individually to decrease the overall
power draw

(simplifying some small edge cases here, but that's mostly the story)

Konrad

