Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E52D35690
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 09:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wcmv2pzpCDGs6z4hRe3+HKmdrd/CuzZKNf/l+3924yA=; b=dR93PUDm5KZYgWmd84URTxRtFk
	2SNWKYDBc+H/mWXlR0uuayu87gBuFa+7saejbf2FsuCAob94U53WhI3PRcGsTQ8klsBD6Cq1EEQYo
	2iOVOaKMj8xEDYTD78nWJSV4cs5KyhaUJJNv8MgLCj0v/1XKLAoBRcBFJfJ58ZKGytpVI+TA9pNxr
	NnAw8FN2t44I899hrpJvkzqNVo+4d1GPpVAy6tIr/73qriUYF5NHVg1SiGxfl7PW8Ka+EJYL2LAHj
	HtVHOEE0+GPDlAGQc7YXOnzQcDFirqzB1hQ6WYEEEKZMt1Sk62IEML0aHS/6CJuJujSqfskONkqC2
	E8aQu7UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1xv-0000000Fl2u-2O4H;
	Wed, 28 Jan 2026 09:35:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl1xp-0000000Fl2X-1xY6
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 09:35:57 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60S6VEMN015147;
	Wed, 28 Jan 2026 09:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wcmv2p
	zpCDGs6z4hRe3+HKmdrd/CuzZKNf/l+3924yA=; b=dCpOP/zyPDdXR+c2ep8Se0
	2kD1jM7Zu6YMsrdJGWni5S7J1X8Mj/Xfdcj5GBvoEm0hcPLP3YWcB6eACghdHAbR
	+877k11IWpNS9x0OVblUG6JXe1vmp0YlQwmCIl7LPJoA7zp8m7gVTImvNt0KEJy9
	z8Ry8rfflWhhJjcaZU44fSewg/7xbr4Vs9gWi9acnyQ11baClbn8RjIi1G/1SYiG
	iknw9PjklvdrWIhT6rEX05ibLcjNAKtPFSEFFEd67Qut5nzyXxxXaBiKuYGOKFJW
	bnnLNgk9MULHt1yuS+oMnM8TUpfmfmxLOz4ld4op547KF8oj4L3ge0ogAOquNGaA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgmrhhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 09:35:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60S7fwSf023635;
	Wed, 28 Jan 2026 09:35:43 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwamjvm1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 09:35:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60S9ZgTJ12976882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 09:35:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C3F05805A;
	Wed, 28 Jan 2026 09:35:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183565805F;
	Wed, 28 Jan 2026 09:35:39 +0000 (GMT)
Received: from [9.87.137.8] (unknown [9.87.137.8])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Jan 2026 09:35:38 +0000 (GMT)
Message-ID: <54eee632-0489-4f30-9c2a-ebde4bd30f88@linux.ibm.com>
Date: Wed, 28 Jan 2026 15:05:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: stop using AWUPF
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: martin.petersen@oracle.com, linux-nvme@lists.infradead.org
References: <20260128082623.3945303-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260128082623.3945303-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=6979d870 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=vuobHaRB_AI57xyFkLQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bHNTmFDgyRstRUUXd8P4f2wHf8f1SL_G
X-Proofpoint-ORIG-GUID: bHNTmFDgyRstRUUXd8P4f2wHf8f1SL_G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA3NSBTYWx0ZWRfXxnsele98P5dt
 RBRjrvT9gYc02raJOCqsc+vv9ySVot7rgi3IcEk04YdxInYS8yrxESe17tgvPrj5SoE3LHzBWtZ
 owGN+BK5URxn8ryFjQ7xt0B3dFzQftErMyLlVz+j3ZjOv2Cq8AJ4ayGIN/JxNz41CkQeUEECAYv
 Su+NF5TRywDmEFeJG6uK3lyTegVAYw8EMDzWXtv9E+KJtBsDgGomlcEbhBqmC5Bkqns5hxnprtH
 R5vqTt2LQwy178bYBGrmMeqDCPqluhX43HHDTM/YSdBHwiKNFjE6kdc9yNSLCbCaUP1QHAa1t3M
 nmvYW2o/gQbuSnNTBDB5zo4juuSumNf2rfDSij6W1jWPuJeMkLqIfPodKg056lirQgONSTzKHDD
 bsMY/eX2tLr3tFCw2YRWrKCROGkdh0INZVmiSVvDEXZEaW2NKbSgzme14xf/TABGNkn2kN40c56
 GtX5ckQe3rFQbmtjv6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601280075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_013556_101754_2DDFAB30 
X-CRM114-Status: GOOD (  21.45  )
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



On 1/28/26 1:56 PM, John Garry wrote:
> As described at [0], much of the atomic write parts of the specification
> are lacking.
> 
> For now, there is nothing which we can do in software about the lack of
> a dedicated NVMe write atomic command.
> 
> As for reading the atomic write limits, it is felt that the per-namespace
> values are mostly properly specified and it is assumed that they are
> properly implemented.
> 
> The specification of NAWUPF is quite clear. However the specification of
> NABSPF is less clear. The lack of clarity in NABSPF comes from deciding
> whether NABSPF applies when NSABP is 0 - it is assumed that NSABPF does
> not apply when NSABP is 0.
> 
> As for the per-controller AWUPF, how this value applies to shared
> namespaces is missing in the specification. Furthermore, the value is in
> terms of logical blocks, which is an NS entity.
> 
> Since AWUPF is so poorly defined, stop using it already together.
> Hopefully this will force vendors to implement NAWUPF support always.
> 
> Note that AWUPF not only effects atomic write support, but also the
> physical block size reported for the device.
> 
> To help users know this restriction, log an info message per NS.
> 
> [0] https://lore.kernel.org/linux-nvme/20250707141834.GA30198@lst.de/
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---

Looks good to me. 

Tested this patch on NVMe device reporting non-zero NAWUPF (and zero
AWUPF), as well as on device reporting non-zero AWUPF. In both cases,
the patch works as expected.

Tested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

