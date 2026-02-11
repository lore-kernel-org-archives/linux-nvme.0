Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E832FEB5974
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbFbMGKGwczJGeughqgC+i4ifzpDtTy2cw00+qAm9iE=; b=3lJHQRZ3UYYejZ+BiI1Xlya9kB
	P9MmYHRSLxXgpnnLSlIwPP/vFNEGu1aVWIQ6IYc5mNtaHFgae7ZfjTE9/AdpRxXVthhedUDBtECYj
	aUNODSRlFKnmzNSdsGViwfqxrgtGLpO7RUtiie5KKcotesg/eVZGavjRNBizkiBsXEot27Bbw1dUc
	uztMA8fMUQqLAW8tahA9CFXFh09rV5fUJntSclaDg+KW8fhWSnfgwre/JiEZdKYQQhr34xKV71Wcy
	A4ygNq8ZyQaC09O9ZxKisFEA1xdetAtWuobzTj2x251gJxaZhGoX9IR58geAuhHkJ0yu0zZMiIkyf
	v/CWM15A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4ZZ-00000000Kw8-12S3;
	Wed, 11 Feb 2026 07:23:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4ZW-00000000KvR-0WQy;
	Wed, 11 Feb 2026 07:23:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61B3siUm2909620;
	Wed, 11 Feb 2026 07:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pbFbMG
	KGwczJGeughqgC+i4ifzpDtTy2cw00+qAm9iE=; b=XFMn8JDM4A+Yi+1l44nm83
	N0aVEOkS53wgp3g/1NOQykjDnyMHJjwfJgu2M3O1aOSGs421bm2quFXoIDfTMLHE
	4kdlT52Vdak4/LcxD963uHDBCDQA+PAsrd3UfjCT42cOMSZnWDD7wqiUwvd29uRt
	xkOiZLYGQRH9GbyDeduBFZNE7bTONj5iklFbvK4f6mWgTkhJGFPwvIQFM8i2Gk33
	wFyZfX3SyfIRZZgsrXfPsBgyaogGbt+ay/LRQ+JOY1NY1E83WxAg0QG/T3seL+MC
	Erx884Ue8u4ahcFley7msdGK5Xzyxcou+qC4Q+wFComZhHuZ+TIWnlFiCUrV21Iw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696ug02m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:23:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B2Trrk002567;
	Wed, 11 Feb 2026 07:23:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6fqsn1ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:23:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B7NKTN20185818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 07:23:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6D7558051;
	Wed, 11 Feb 2026 07:23:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B40AB58066;
	Wed, 11 Feb 2026 07:23:13 +0000 (GMT)
Received: from [9.111.95.190] (unknown [9.111.95.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 07:23:13 +0000 (GMT)
Message-ID: <0a78d8d2-2774-4037-b18a-f0799637f92c@linux.ibm.com>
Date: Wed, 11 Feb 2026 12:53:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sven@kernel.org, j@jannau.net,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260209082953.3053721-4-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=YZiwJgRf c=1 sm=1 tr=0 ts=698c2e6a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=tJLSzyRPAAAA:8
 a=VnNF1IyMAAAA:8 a=FTURTjTvBs5KYphvcsoA:9 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: 0mjw6HA6xeDIK05M5H6xunoKZfVVQiBV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OCBTYWx0ZWRfX+KMCqTIaCpW0
 pMowx0omGulSYcbN+6nnCRWNFFKfP037lMm61MrEJAh1tIZO4X7INlNs54qupzd26DrbwTnUbmB
 kV2Q6KfrLLqNNy4AfH6JUsiJE+1TyLXDy5r6iSL1s6T2kfFMEWldvhps0ge+O2rt44oMBcA8+Gh
 jTZRs1eTrjRHd5PFvu+GWiZ2Y9L7YpylYwOFz+rSPDaOtlv4QkYpJ+U6lN+DZSoiTxZ/XR5MpT4
 edJtb/Gen9SQFIDmsLvGZBtfraW6FZVz3CLjTklSB1Zzp8tSs498fabbCKJCgJowU8qqmGmzeWm
 KBvLVsCDxdSksZ0Z/Lm71gRIP2Y90Onf5fzZvQVB7pIfupL2hCOTDIP1lY8sy8HUMZgoyXLUjd1
 x1IkrEVgQ/HKPlJJtP3LEecp51pncUQi5b5mc2N++Wm4t90qxI4S7alEu7SAVRmwwED/rAaI9LE
 +jwU4V9Q8Wn01matSUQ==
X-Proofpoint-GUID: 0mjw6HA6xeDIK05M5H6xunoKZfVVQiBV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602110058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_232338_175711_9F791A9E 
X-CRM114-Status: GOOD (  15.04  )
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



On 2/9/26 1:59 PM, Yu Kuai wrote:
> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
> When the queue is already frozen before this call (from nvme_start_freeze
> in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
> only decrements it to 1, leaving the queue still frozen when
> debugfs_create_files() is called.
> 
> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
> debugfs_create_files() and risks deadlock.
> 
> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
> so the queue is unfrozen before the call, allowing the internal
> freeze/unfreeze to work correctly.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
> ---
>  drivers/nvme/host/apple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

