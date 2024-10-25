Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC458D0BB56
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 15:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxQDiRendUtZbpNXv2gz63FMfIBDq8Ao3KkaY8zNodE=; b=ccVaMif7LC4GFF8wIlMNoF+mgm
	zvnpHEzrTjtJwJPG7q39Wv+YO13ot1vdggEzr124l0PtIYtNRcyaa+r6NbLI3MEiGOr3jS5RK2UDq
	cWAgrmrxr4amouwjzlLV/vWq4H3CybUC3qqDsudS5z0nG1n93/sxMEKxUy95aJcAoKkn6OPYWhmUS
	GhzIOeJLJIIs1fmr6u1jHiHrMoF2N54bLENZGsHNNslmFm9mabGgWnYocMqfvsUYpKEezr17oDMh6
	IB9C1M6yXlgrk4C61Y3cmBzyYvceNLD3oxVmYtqm0Xo23ta81crN4v43jvr26CEhanVwHLDFXdAIW
	g1+jkAyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MTf-00000004IVN-1QjF;
	Fri, 25 Oct 2024 15:43:51 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4MGS-00000004Ffv-1TZS
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 15:30:15 +0000
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBgnas009081
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 15:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oxQDiRendUtZbpNXv2gz63FMfIBDq8Ao3KkaY8zNodE=; b=IHkpxnC7CqL8P30+
	xwCoXmRGOrg9eP3OVi2NyK8RhKNRcBK1W9thJdRIGNpkx+AL1NgFHbANhiBjnvKI
	BnoIEtDbwFU3n601F3oBlIzpMscEcGHPsHpXdEe3ErYNgHSgs21r+CXVLvnPdQYi
	EUJrfj8xXc7MYVBD08QdfFOmfNx3QJIadSfIH28Seb1hIxsJC3KJC2l7lyXpoFMO
	1F7ZRXCB3Ebw+rb1SXMlg8wdcClRdS2LDJDPUmgWxwjqisU9B8U2GPmf44S8IkmU
	ojz0n6EFjtUMsg+wEtyZHWsvEiQm7/vrVE7h4AXR6b8QSyYA/kFCLjEaq5GbJTwf
	F5N6Jw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em43hntw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 15:30:10 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71841b0ee34so275563a34.3
        for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 08:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729870209; x=1730475009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oxQDiRendUtZbpNXv2gz63FMfIBDq8Ao3KkaY8zNodE=;
        b=r95S2RIkK+8xFDKHsECxKlQJtXgIeRGe97zrPldZwwwZuNoQ5iGJasvHQ79Vy/Rpc8
         TgMR1rC93muX/y93rPZcSSqOKnM71Sm/MFMAGuPNb1W5OtzH7JmSu/0Xmg2hTRS0u5dZ
         oLO4M08SighRXdTBhObtBF9ifpQOW37dk9Y67ZU57L45IXE9HpJ0vniZBUjVOrcfOekA
         VCaH/Fx5e4tgH2M6LrviYp3YRqntIijWbzmKBCLjQ6wqOGZCF1f2ZYTPoqM8kAHHhLX/
         IymjEgU3tIATrqeBLOKCiUz7Aael8RNwcDMPWAqfjJvI6REP/JgoK+A9juirXrqQvA5F
         Lg+A==
X-Forwarded-Encrypted: i=1; AJvYcCVE44wqYlzfxlHFlEehQDZDcQF/RC1s32Qba/dwwcCXTcR3cNnS0c45T6p9PUwQ31Wbj8idzUGi7CBB@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5m41cKf2PpR9cXxX9WW9bCElN05l/GGY+SELcCHAZQrZjb9ic
	STHi3KEgXNqAcoyiSdw3v2/soY2QVX0pMWwRQnD+wf46rR6f7KI/0Vki1pj/iu7bR1yEH7PDVpa
	DnvbGGjYFktXJ1ki5pu78dxFNbIbFPzebeKTGoWspN35MXh+UJ/xxDsbmZ0eNPqOipA==
X-Received: by 2002:a05:6830:410d:b0:710:f408:bd54 with SMTP id 46e09a7af769-71863d5ccf5mr506929a34.2.1729870209613;
        Fri, 25 Oct 2024 08:30:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7XbilQJu9FD6jaLp/3NeXoBbqPifFUOCb3VAKss/uYt9A40EYWhxDcJonOImwVjjWdw0z2A==
X-Received: by 2002:a05:6830:410d:b0:710:f408:bd54 with SMTP id 46e09a7af769-71863d5ccf5mr506913a34.2.1729870209237;
        Fri, 25 Oct 2024 08:30:09 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f298ef6sm82309966b.136.2024.10.25.08.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 08:30:07 -0700 (PDT)
Message-ID: <0fac5de3-3f35-4fc2-bbdc-411dc1018a85@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 17:30:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Christoph Hellwig <hch@lst.de>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <20241025113520.GA19521@lst.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241025113520.GA19521@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oqxvseqva1DPZU2jwQqhQftDMx_YqBrD
X-Proofpoint-ORIG-GUID: oqxvseqva1DPZU2jwQqhQftDMx_YqBrD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410250120
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_083012_561169_B00ACCC8 
X-CRM114-Status: GOOD (  21.86  )
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

On 25.10.2024 1:35 PM, Christoph Hellwig wrote:
> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>> before the platform can reach S3-like sleep states. This is very much
>> similar in nature to the issue described in [1].
>>
>> Other Qualcomm platforms we support upstream require more complex code
>> additions across both the PCIe RC driver and other platform-specific
>> ones, before the link can be sustained in suspend. Hence, they
>> effectively need the same treatment for now.
>>
>> Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
>> identified by the upstream bridge having a Qualcomm VID) to address
>> that. Once the aforementioned issues on non-SC8280XP platforms are
>> addressed, the condition will be made more specific, with a PID check
>> limiting it to only the platform(s) that require it due to HW design.
> 
> The NVMe driver is the wrong place for this, it needs to happen in the
> core by making acpi_storage_d3() evaluate to true.  Preferably by
> actually setting the right ACPI attributes because a check for 
> PCI vendor ID absolutely will never do the right thing in the long run.

(Un?)fortunately, said platforms use FDT, so we can't fix that in ACPI.

We also considered a DT property to indicate this, but:

a) PCIe devices are discoverable and it's really really really
   discouraged to hardcode devices that are likely to be present
   on the bus (and this wouldn't work if a NVMe device showed up
   on a different-than-usual RC)

b) Adding such a property to the PCIe host node sounds a bit
   saner, but the NVMe code isn't aware of the RC. We could add
   something like:


struct pci_bus *pbus = pdev->bus;

while (!(pci_is_root_bus(pbus)))
	pbus = pbus->parent;

if (of_property_present(pbus->dev.of_node, "broken-sleep-foo-bar"))
	return NVME_QUIRK_SIMPLE_SUSPEND;


..but that implies we have to set that quirk in DT on all platforms
which only require an equivalent workaround temporarily. That in turn
is later much harder to undo than a simple driver change (e.g. if your
FDT is provided by the firmware).

In general, I don't think we can at all rely on firmware updates for
devices that are already on the market.

Konrad

