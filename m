Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4B1FC5905
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8l4kqlbE2gAMDnm//dHr1GMAMKN6dS+chhJVsTYu7L4=; b=LDQIiTQBFJxuyPYKvO1JCsfbKA
	tfJqH8QEwiGeE4CT5RZiSdcrmFMCEhiRQSOCr2W+a0cOUmqTPv2SKwPEuosoo3BOxH0afX3z4Hu7Z
	iKyU7Cf4gfZ94GQEDU30s8SYOLmM5A7/FaowhU+aqtRmc6AG+v098R7zRQlWjHgrDaV8wN/1C+Ru6
	WRbptWW+Ln9TSz6v6rSVgyqBSblLJuNkEX5ute81AkrAuuIKziNBuMyUv1ID/jFcXoeicWE0t/yLE
	EaJd5VQd2BTzfZtGQQ7G5NxI042YyIfB2avcIIpUwH82zVBCr6spevlpNJM8QXRm6iiuBMq91nNGH
	HqmgP51w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvVQY-00000005XFq-1ekR;
	Thu, 26 Feb 2026 07:04:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvVQU-00000005XEj-2WmP
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 07:04:47 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PMUDGj2785927;
	Thu, 26 Feb 2026 07:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8l4kql
	bE2gAMDnm//dHr1GMAMKN6dS+chhJVsTYu7L4=; b=F7Mtx9Fo7JWV54uwf1JCSP
	3HgHrdEjto9hxgThuIUiW5Rkxm6hdCEIarBMgSiHzgz/TCDnWVsY3l9DeVEmLkyW
	6jZKPKhRggsNpzsxtxLUYbe1Wnk3irNS17B5b7r/UrMWsAmTSmgq8ucVYDplFpGC
	kLpr73aGAHfxzShbMEHGc1jdz/cs/jADFZccEQvWPVQe1UOv7QBl9lqLQrc03p6l
	OmHFqWnY70xOsBrPZpegQKwv4+Y0ledi5T94T/AeAA26GJP94AsbTZqsgXjCw0FQ
	055wVNVp4YaxxA6Au73Sxwv/xt7CoIK+SeKNBXS/KRWPuHs3ySc37h1qyMw0bf1w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cr4t2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 07:04:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q3Pf8u030256;
	Thu, 26 Feb 2026 07:04:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfrhkhqeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 07:04:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q74gJk18219572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 07:04:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D34358043;
	Thu, 26 Feb 2026 07:04:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B52B058055;
	Thu, 26 Feb 2026 07:04:40 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 07:04:40 +0000 (GMT)
Message-ID: <20114be6-d1f7-4678-be25-90016e864c1e@linux.ibm.com>
Date: Thu, 26 Feb 2026 12:34:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20260225202109.447144-1-kbusch@meta.com>
 <20260225202109.447144-2-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260225202109.447144-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ML3MA2oWcaRf6AKLRMzQv970ePCOii-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1NyBTYWx0ZWRfXzscsrQDQ1i5y
 0MTwNsj5h+g2ePQI0i0YWEd8TvhBLvnuZnpdW/mmAHw1rP206iI5/gYhB2u/ZFS0rWDc4L0pGzB
 p3cQ+GzdKJYlu58XpWotolKMtgtEGNKHUOAIB2/REo11BStaEuDx+bKSqMBRkf8M8iU2mcrRB4v
 Y6JPZUhJ8AXHiXb18+bliZR0+tII69xi3gnbwJgQRA6BGW9bNV3/xsGz+hXuzCclbhuTG0tz2ER
 1B/CuS9VIW64vqeeVw7OxBXrCn3oG/P/AVgaIMlfgO/nIEBz3GSe4LjlW5t3S33C+Org/dH9SO8
 +OUfJGyZ7NVnYGScV3KxwVEodRHff13FdqRZEYBSXmioqbDiVRhdMtizhbXWRoIAc3eZTiBQnEb
 4sgG34oy1af2dsOqNyFPxLygfYOSEzk3csSoML5Krd6wl5rE0DXiP40UwvFv9O+ioPQEcPJEsfU
 v5SStYOyVgRgGBCqLDQ==
X-Proofpoint-GUID: ML3MA2oWcaRf6AKLRMzQv970ePCOii-Y
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699ff08c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=-h7Xec-tAQGfP5JERJ8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_230446_647278_123EBF35 
X-CRM114-Status: GOOD (  22.92  )
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



On 2/26/26 1:51 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The NVMe controller is allowed to reuse an NSID for a new namespace after
> deleting the previous namespace that had been using it. The delayed removal may
> have the stale namespace head in the subsystem list pending the timer, which
> would cause the scan to falsely report an ID mismatch error for the new
> namespace. Flush the pending removal work and retry to resolve this.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3de52f1d27234..e731d3182f095 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3966,6 +3966,7 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
>  
>  static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  {
> +	bool retry = IS_ENABLED(CONFIG_NVME_MULTIPATH);
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_ns_head *head = NULL;
>  	int ret;
> @@ -4008,6 +4009,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
>  	}
>  
> +again:
>  	mutex_lock(&ctrl->subsys->lock);
>  	head = nvme_find_ns_head(ctrl, info->nsid);
>  	if (!head) {
> @@ -4033,6 +4035,22 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>  			goto out_put_ns_head;
>  		}
>  		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
> +			/*
> +			 * A newly created namespace can reuse an NSID that was
> +			 * previously deleted. If the head has no active paths,
> +			 * it is pending delayed removal and still occupying
> +			 * this NSID in the subsystem list. Flush the removal
> +			 * work to clear the stale head and retry.
> +			 */
> +			if (retry && list_empty(&head->list)) {
> +				mutex_unlock(&ctrl->subsys->lock);
> +				flush_delayed_work(&head->remove_work);
> +				nvme_put_ns_head(head);
> +				retry = false;
> +				goto again;
> +			}
> +
> +			WARN_ONCE(list_empty(&head->list));

We need to replace WARN_ONCE with WARN_ON_ONCE (as you already mentioned 
in another thread), so with that change applied, this looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


