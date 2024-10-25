Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FAFD149C7
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lEaOQU9DBgykCf+oZ3CPQHYKbHLSQn5HNHOz1fmswvo=; b=jU34BZehYNGD4zPo4x1FHAt6A6
	Q24hHiSeTm5Pp6Jst9F5XoPxbS/i2tDkZ6Ykjy2rLQ6PrApqdJE1zEjFz8She/K83Al2e9g3kZ1rc
	B3apsGaIyEG1gRrdG4zk5qvQrIzVFMYFIFajVkxML8l42ha0Bh8nmwP9uhNAepiefdDr4327BmZa6
	lby3RSRaBHEJU0ZtzeajGDVYGNcQ+bfxG+70pVg+q94hqiWKXwt4Xe2CXRoMqWxC2gweQBD72ns/C
	lNcK2GfEqKXC5VbdBeaiY/cdK09ZjUHVViQcWOHXym9jJfFfBFjIOA70Te8sK/xu0IQpGzF9JojWV
	FIIcQvGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4NNP-00000004T6K-1TPd;
	Fri, 25 Oct 2024 16:41:27 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4NMT-00000004SzS-1hVL
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 16:40:31 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PFf59i020881
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 16:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lEaOQU9DBgykCf+oZ3CPQHYKbHLSQn5HNHOz1fmswvo=; b=EVKSvhZDXM5IXWI7
	X0vHt7x18fecJQn395yHuhphE+vgRKHIICyrtOlEGmVYWAq9PwbwCa6iC8XU0Xfc
	a+0grR2nHyT9LT8Ae/A9CxQBlK3lrR7Xafdij9AgVLwqrAl+InyjCWkY+b34ohJe
	Uhd3m9Thl8CZCK/u5tI4PocyEN6W4UHIlU9h1y0wdDl53bcqQJ1C7r70i4Fsfj7r
	BUMi4XsgqSKX0nhWWxYLl4vPXr1l6OjqJmDm79MqRxFXj03O5Mr4l518WOlR2Iv6
	3yCaKt26TvLSogac8vOBXcUy7U3mTYqcXnIbxk3KZIQAFsJQ7oXjJx1anievdalg
	w10EoQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g6y91p6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 16:40:28 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7180d9a3693so415759a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 09:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729874427; x=1730479227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lEaOQU9DBgykCf+oZ3CPQHYKbHLSQn5HNHOz1fmswvo=;
        b=HT+uGULEgf4QNkQ/jhUPWLDHiQlqEfJjSwza2WuhagT3rB1yvCwnCpcymfv2BrQSZk
         34xoAzdAhNF2aSRR9FzCZGDr9i30Ah8m2Djj1bFj1AkCPzm12jN18YiWXVTrBXQB21Cc
         NoNs5+PrTOnRzRO6qyLrmOarYOQSpZ0P/NvJo1qaRbdIOYaxYiACI0qL1KUk88hZ4YMh
         dktewy3nrVr0BlMuAMH6GUnX8b4Hy+N+1B24kfM19AReBI+Zt5oNRO562lPMJEZ8NUaz
         uuP0fH/HxK/y4+i8hEOSmvpbjCZCicvD89mCLXQ+rFCf8C62qLt/5F0XgefQlz0ZpcXk
         8jMg==
X-Forwarded-Encrypted: i=1; AJvYcCWqyhi03k3c8kxWP5nMa/F1NTVBq8g6erOoZGy7Nhb34zunxEX/Y21uewa7aY0MOEwuM4cXojwshky+@lists.infradead.org
X-Gm-Message-State: AOJu0YzMgdc+SMg/m8OFQ0Or2AGc5v5W4VslPX25kFyC9EmUbIXXCZtz
	yQYqpYzK3FCn9MoSXan643NOpizen2b6oM/ZH0gC6zXq+P+aaNd9tQx+aL98r8TXRyCpNBGmirx
	qPqsVzSZqpSGBkSIPue1KLOnxWLEKOaPX6pHpbh5xBT+I7IDXRuzwmsbS4LeaPNR4nQ==
X-Received: by 2002:a05:6808:1294:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e638248bfcmr49151b6e.2.1729874427071;
        Fri, 25 Oct 2024 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4uoNX6if15zlekW0g/RpZNt3t1OLJyPRCQ0lff/PXV6If5GJ55ORq4YzN4HD1bXV9MwK8zg==
X-Received: by 2002:a05:6808:1294:b0:3e5:f2e7:e093 with SMTP id 5614622812f47-3e638248bfcmr49140b6e.2.1729874426771;
        Fri, 25 Oct 2024 09:40:26 -0700 (PDT)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b32455a14sm89168866b.178.2024.10.25.09.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 09:40:25 -0700 (PDT)
Message-ID: <867d7b15-6861-4300-83aa-55a6cdf87f58@oss.qualcomm.com>
Date: Fri, 25 Oct 2024 18:40:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
To: Keith Busch <kbusch@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
 <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ZxvDZVKtM9qGYBP_@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5fuPu__LB7MmS8ULEHg1RB2Wb7cxQuuw
X-Proofpoint-ORIG-GUID: 5fuPu__LB7MmS8ULEHg1RB2Wb7cxQuuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250128
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_094029_502749_76942EB1 
X-CRM114-Status: GOOD (  15.87  )
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

On 25.10.2024 6:12 PM, Keith Busch wrote:
> On Thu, Oct 24, 2024 at 07:33:07PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
>> before the platform can reach S3-like sleep states. This is very much
>> similar in nature to the issue described in [1].
> 
> The "SIMPLE" quirk is only supposed to affect kernel managed runtime
> suspend states, s2idle or s0ix. Shouldn't s3 already be using the simple
> suspend?

So on these platforms, all system sleep states (incl. S3) are entered
through what Linux sees as s2idle, with a separate MCU doing a lot
behind the scenes. s2idle of course also covers the runtime cpuidle
cases.

All but the deepest state (which Linux doesn't differentiate as of
today) are effectively somewhat like s0ix.
It's a bit hard to draw accurate lines between Intel terminology and
what we have here, as there's way more things onboard than just the CPU
cluster that may be operating independently..

Konrad

