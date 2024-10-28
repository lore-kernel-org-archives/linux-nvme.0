Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC21D1039A
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 13:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ifb8zjw3v2iBatpJle5WTa1xRKVueOsAKKz6U+K/pxM=; b=V/Po6y0WhDjTj5o77EREZTpRJb
	1zSwOFLz48ji6mMUhUdosCVRG/xMP+sZ3yvDque/Pn5vPlm66IWpnb9byG8TziYWuMTTd4VpMGeC4
	s/5oWWdvi8+Gk3lqjn8yGQF5hYLAAcktzo0n4qlM/uTBHsw96lmOPFixuihhYn/WVkK9E5ltqOmoP
	H010sWoWS4v367fHmtgCLgpdJ28pXalQurl/Rop2Quvdz7VNHA2aDzo5oBzlQignWMFw3Q6i3A3yi
	dSfB3cqKuIZDuUDZvmBnbwFIxIOuhTGVh+5HnjqbMvhzVlje/tYZOYccT5fDCFE5j+D1Ds3Vm3K9p
	eatlbUHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Pal-0000000Au0M-13Y8;
	Mon, 28 Oct 2024 13:15:31 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5Pah-0000000Atzw-3fDt
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 13:15:29 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49SBBSNc011999
	for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 13:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ifb8zjw3v2iBatpJle5WTa1xRKVueOsAKKz6U+K/pxM=; b=HVfRUUaAZtUyPMO8
	SzlObd9QDGRiCSNY2fFnql7Fyr1JGIrg3jPWV+S/Nx/lPG7oZWwVX/KV8yz94UvR
	U0/9g2BXiRkIK20UZlcG1TzTmSy8oCG5OPUeM9dBfZJZbZwbGFytvVZMxfSdByKV
	2VUgezFZB/wOJtAkfbZsF8VSjNA1nV3uXpe2/pXThSFCBbbSHsTXEiVjMuZ9yXRq
	YqJIMd6xxM8VdEyFNTHSWEB+tEvN4GqTto7b1CZvPM+Hgk2/FH2Q50AEbsCdxlO/
	TniQdOc4wdn+YHtRJaXoyoNR9nsJxj6r/WEimklmD819146srIXBcqJUPMop/+qa
	6BvhWA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gr0x4ydf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 13:15:25 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6cbf4770c18so15252296d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 28 Oct 2024 06:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730121325; x=1730726125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifb8zjw3v2iBatpJle5WTa1xRKVueOsAKKz6U+K/pxM=;
        b=n4Af15uSDCzKT5OyLrPX4+EyeRyYMU7FdRVx4M8mz5VcN/q8+CivZQwGhiVGT1ivr/
         omt+qKuPIwX66aMJ+rjgb9/fBjtP0OP/zWUNEdowLZPSBOp1BSFxUDiWEgj4CDLD3PsZ
         7Q05wVtkW60VhG6dsCCkwwXJZW0V65PvZEe0fmmep3uk3LHfn3msjntuXBVfltlMstIa
         M9h/11ZQUlFK0n5zOtwIuDEyCoaa0xdTbQe7AVHLwZ1UKSK7dEpQGdAkID0Gsw0BGJD1
         Qah34PJspwDpAubz+/BHrpYY/7v8rpC8urxUioq7/pfsH/A+m65BWauMCrOwqAumVHEO
         YjSA==
X-Forwarded-Encrypted: i=1; AJvYcCWjzI+PnXv1AcXJN2X1sLFzkymq6Bt3Hfge7y+fjpsiRwDDTOUAaEzPYsXGMk/py5NUFvbgF3JzPWbM@lists.infradead.org
X-Gm-Message-State: AOJu0Yy+O3hgu/kxUKuhP+9SH0bwiFBOGS+OpDlm8a9njq82+NvztoTL
	0cZV0TvtSGeDEFFC4UnkedQz3jRplU/l5Te2C7i+c01obC8TjaxZDTA43cNgGN8iLgC661XtTG0
	DGkRFopYwQa0HHo+6nuVMudWPrSi//LH4YhYWpZHkHjrLgbKLVSHGK3sDkQDy7AFOlA==
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr66301886d6.11.1730121324806;
        Mon, 28 Oct 2024 06:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPp3HhrkQM++wgb9tbT0Thc9Kg53phrLc+8j4bVo16zKwnqWsHZentYg3L81uv1ieo8RIaGA==
X-Received: by 2002:a05:6214:234d:b0:6c5:3338:2503 with SMTP id 6a1803df08f44-6d1858886d8mr66301566d6.11.1730121324269;
        Mon, 28 Oct 2024 06:15:24 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f296c66sm375804566b.109.2024.10.28.06.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 06:15:23 -0700 (PDT)
Message-ID: <0b5d01b6-988c-4d3c-b4dd-ee0afc288166@oss.qualcomm.com>
Date: Mon, 28 Oct 2024 14:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Christoph Hellwig <hch@lst.de>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <20241025113520.GA19521@lst.de>
 <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
 <20241028091941.GA29461@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241028091941.GA29461@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: Nu7gv9kziXwiYaHCQJ1_AeqdBXuzjIub
X-Proofpoint-GUID: Nu7gv9kziXwiYaHCQJ1_AeqdBXuzjIub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=712 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410280107
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_061528_105185_0E163CA3 
X-CRM114-Status: GOOD (  18.15  )
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

On 28.10.2024 10:19 AM, Christoph Hellwig wrote:
> On Fri, Oct 25, 2024 at 05:30:05PM +0200, Konrad Dybcio wrote:
>> (Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.
> 
> Then generalize the acpi helper to a generic one checking ACPI and
> DT and specify a proper DT binding.
> 
> If th requirement to put all devices into D3 is a plaform propery
> a specific driver is always the wrong place for it.
> 
>> b) Adding such a property to the PCIe host node sounds a bit
>>    saner, but the NVMe code isn't aware of the RC. We could add
>>    something like:
> 
> Again, this all belongs into core code.  The nvme driver is just
> a consumer of this information, just like for example the AHCI
> driver.

Alright, I'll try to pursue that angle instead,

Konrad

