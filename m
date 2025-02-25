Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917E4C021B8
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Feb 2025 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x4N1f9iXyUEE9R0XtdUwvI7VazKKWScHiIVwTpn393A=; b=rRfKFpUu9FOibYvb7T8IIuAIAg
	iaDdzyHFOYwVCEO6HNxTE0zTWG9qiXVFcZyRgVENW9ZRLHcFyOiVPab/i3dS0SAF0bMATFKUIWjOF
	rTO6KciTUYWBR0ll9oQMR6KmxRfWI+CwYhfDo/sAPoJupqYL5CGbZkW9F201pZ9m1rSM6XiGbiJDZ
	Ba5SklfMEzlnaD08qT4FUv2IGnA4N1WGW1G78RKre6GHd/osZfyD8owFrs2QT3j6UBccM+KSBNlEo
	AIS2xlxibGXIq2mTygD1/21FQsADK3InvQc9rdjyL/2Ao2RzA12B4pJ1/cXecNPdXchSoENs6IQTs
	8W/aXceQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmxz0-00000000Iko-0tQz;
	Tue, 25 Feb 2025 16:40:34 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmvwq-0000000HX7i-28Mq
	for linux-nvme@lists.infradead.org;
	Tue, 25 Feb 2025 14:30:13 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PDjZJU027007;
	Tue, 25 Feb 2025 14:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x4N1f9
	iXyUEE9R0XtdUwvI7VazKKWScHiIVwTpn393A=; b=UhJCcfjXOBX2VKnf9DBvrH
	qOt63mF1DnBrdLqCbfenw2YrKGoMbZN20YBMrdbd5aGIIpEt8Ua7c5hMLZPHj2AO
	A67rz83AFmHphrjlSNVK76TGzxk+/zkeZSMpKvfFvNyur73GsB/BMKVTjgkbj9ne
	DHvjHRcWcY3qdMi6lhvovCNTKqZuBftTQwAzoZmgPoN7rFMmcFrkizesRSVQuVHm
	DyKF3FSWVoSUw5hioVsb68lIdhKEk6s8zuONZKOUkmYuFobcRUVqQ9LaBhGDWlRu
	w7HdMIzpie4NaIQi5Mfw9stcHgraNg5nmVWiDErauwVu4AH02X4c1HGwRo9oeX+A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4513x9ue4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 14:30:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51PC0g2E027344;
	Tue, 25 Feb 2025 14:30:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum1vwwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 14:30:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PEU3qV30605568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 14:30:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3278B5804B;
	Tue, 25 Feb 2025 14:30:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629135806A;
	Tue, 25 Feb 2025 14:30:01 +0000 (GMT)
Received: from [9.61.156.112] (unknown [9.61.156.112])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 14:30:01 +0000 (GMT)
Message-ID: <456288e1-9c17-4284-892f-c6ccba45f2cc@linux.ibm.com>
Date: Tue, 25 Feb 2025 19:59:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-3-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250224182128.2042061-3-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Js3f6gblbSdnSkUqUq_KPPud664XjSD2
X-Proofpoint-GUID: Js3f6gblbSdnSkUqUq_KPPud664XjSD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250225_063012_562112_0C840B20 
X-CRM114-Status: GOOD (  19.48  )
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



On 2/24/25 11:51 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The data type is represented as a u64, but the metadata type as a __user
> void *. These two fields represent the same thing, so treating them so
> differently looks a bit odd. Just pick one consistent type of
> representation.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/ioctl.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index a3082414c7714..f1233a280d3b3 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -114,7 +114,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
>  }
>  
>  static int nvme_map_user_request(struct request *req, u64 ubuffer,
> -		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
> +		unsigned bufflen, u64 meta_buffer, unsigned meta_len,
>  		struct io_uring_cmd *ioucmd, unsigned int flags)
>  {
>  	struct request_queue *q = req->q;
> @@ -161,7 +161,8 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
>  		bio_set_dev(bio, bdev);
>  
>  	if (has_metadata) {
> -		ret = blk_rq_integrity_map_user(req, meta_buffer, meta_len);
> +		ret = blk_rq_integrity_map_user(req,
> +				nvme_to_user_ptr(meta_buffer), meta_len);
>  		if (ret)
>  			goto out_unmap;
>  	}
As we're stripping __user, for readability, can we name it as "umeta_buffer" or 
"user_meta_buffer"? The regular user data buffer is already named as "ubuffer". 
Otherwise this is good.

Thanks,
--Nilay


