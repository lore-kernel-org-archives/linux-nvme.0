Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01688CA600E
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lbmy/rU+QZ+TLu4YR7LaKloP5QAv5Le0xQuN4Wu7W0I=; b=yh+uK4s3uBv3d1MdvMn9t07V5A
	Jwr23N4T5zJabQJbML8baXlflZCiprVdiH4Bx7EjYPqnXaZj+tV1mqcsEC9Xsh3/YRlxb1dGS/OMC
	ZpdWpLa6Og+SuNsN/IcuD5WKheZYupl6HpYS21RwpH7wruSc3i5BVqEOA3ehq/Dpk12RZjMJdqrwC
	7euYZ0VSH7uw80LIXgPc/AKd+uEcP6O1SLyOlHW3g7VOCS6KRV0d9UfhUuWWUzLx/kUT4jHrwLssC
	JVe4zgHVxNXZ14orjMR2/pP36aWy9LOqUqBM7M9sjtxJtuViu+7qocRCu7bXld5M9uY2VktdfAxPT
	7XAMBUkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkuH-0000000436w-0yj4;
	Thu, 08 Oct 2026 09:59:21 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEkuE-0000000436Y-0QXn
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 09:59:19 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZUDY731193;
	Thu, 8 Oct 2026 09:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=lbmy/r
	U+QZ+TLu4YR7LaKloP5QAv5Le0xQuN4Wu7W0I=; b=Y4KidBO8ajT/DI7ZlSLQAq
	QnQsGYlpTRErv3JnvS9ofb0OZK+cEGw7RfyNTCrE2kFlTs4Xd4t7KwS+qKgJwsYi
	8AO0OfF35OnPYqm0tejDedOmo2BFTXdX+gy2OpRgTU9L1bAD9+BDU3aMEju4D+3j
	5QysCXe2UoiqbjLkOmMcb7netzKwjIK+pAUueXX5te+b5+JWVPVI95C9KifspcaV
	L6Bh9DVul6pZlW1IYnbzQ8PtDDq2xWpvuJjVQWbRQaJzcR3tGT2KeIp0Fl4zdBS7
	vhvTDEmBIH3olihtooxF7jbxh2C2Tpk6nspN8TXuYsIRHAXpF/5a3g2wrbu9k9EQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvjkgc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:59:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IZnP3107270;
	Thu, 8 Oct 2026 09:59:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek6usw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 09:59:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6989x5qN33030910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 09:59:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B995A58056;
	Thu,  8 Oct 2026 09:59:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1A5458052;
	Thu,  8 Oct 2026 09:59:01 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 09:59:01 +0000 (GMT)
Message-ID: <24700bd8-c627-40a6-abe2-433399072a6c@linux.ibm.com>
Date: Thu, 8 Oct 2026 15:29:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] nvme: add per-queue sysfs directories
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
        kiyer@crusoe.ai, ganbalagane@crusoe.ai, sj@kernel.org
References: <20260927070925.47209-1-saravanand@crusoe.ai>
 <20260927070925.47209-2-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260927070925.47209-2-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Az-9c5A6brIsjwiRXqLeAMQv6NKIIyeT
X-Proofpoint-ORIG-GUID: Az-9c5A6brIsjwiRXqLeAMQv6NKIIyeT
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac7696b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=bZvm_KZs-9OTagBdk5QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfX6hCUbUCk0EvD
 B030sC2dzFavUWbQSe6R1+ZP1c+jtJXJs7Th6OmPjZvr7ttXN/L3Fy+OTXjrgHRsQcT0LU0Mhrk
 TNx/b2hKEQXsjxKqKec16K8j6v6vV2M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzOCBTYWx0ZWRfXx2UMBjwjMypb
 JWNvG8GtwNanaYSyzyuvy6AqeXg4zN89e9khLQpVNy2+8FGp/7U+HK3BgnsILqNJnj2mdMX6duK
 oIV+QrVY9r6DwkCuoE0aCpYd6BvibAjcwPtWsf98KhbbQ0xo1RRDgZd2ZlkI6BD90T6itEiKnLD
 PeFyIZTdnnV/Uek8yI+AL/CRJAxjjxZ4N+kqWxq8NQzpT+TW4Z6lW9VsuU6lBKZEx5dJZRP9TtN
 Nzo8C6LMsdcmJVOtsOjcaVdNhi6C9ZIru3dQ735sjIbwZTNC+tNwO9bI1WV2bhbbAfd+K/fpZRS
 jGVLb5FFU9kdp+QPgjULg99G6Ko4eQ+L96s+WUGgRK8i6jTSYO2jpCS97X2kLaGLUf79A9KC+e3
 EYRauasXABrT0saNKM+UVwlM7Xaj6vcCBTyxy1345z41TdFKQ+TUho0R/wjs1RCa4Hn/jJCkJtC
 QcVkdAo7LGMbUsCMQ8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080038
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_025918_263611_35D29469 
X-CRM114-Status: GOOD (  22.11  )
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


> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bac25b287d25..20410f0d6118 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -339,6 +339,28 @@ enum nvme_ctrl_flags {
>   	NVME_CTRL_FROZEN		= 6,
>   };
>   
> +enum nvme_queue_info_flags {
> +	NVME_QUEUE_INFO_REGISTERED	= 0,
> +	NVME_QUEUE_INFO_IO_CPU_USER	= 1,
> +};

NVME_QUEUE_INFO_IO_CPU_USER appears to be a transport-specific flag,
so I don't think it belongs in the common NVMe core code. It would
be better to keep this state in the transport-specific queue structure.

[...]

> +/*
> + * Per-queue sysfs directories under /sys/class/nvme/nvmeX/queues/. The
> + * transport backing the controller registers a directory for each of its
> + * queues and provides the attributes through the ktype. Registration is
> + * expected once per controller lifetime, so the directories persist while
> + * the transport's queues cycle across reconnects. The queues directory
> + * itself is released with the controller device.
> + */
> +int nvme_register_queue_info(struct nvme_ctrl *ctrl,
> +			     struct nvme_queue_info *qinfo, unsigned int qid,
> +			     const struct kobj_type *ktype)
> +{
> +	int ret;
> +
> +	if (!ctrl->queues_kobj) {
> +		ctrl->queues_kobj = kobject_create_and_add("queues",
> +							   &ctrl->device->kobj);
> +		if (!ctrl->queues_kobj)
> +			return -ENOMEM;
> +	}
> +
If this function can be invoked concurrently, how is ctrl->queues_kobj creation
serialized? For example, if two callers concurrently pass the !ctrl->queues_kobj
check, both could call kobject_create_and_add(), which is not what we want.

I understand that the current user of this API in patch 2/2 invokes it serially.
If serialization is an API requirement, could we document that in the function
comment? Alternatively, if this API is expected to be safe for concurrent callers,
the creation of queues_kobj should be serialized within this function.

In particular, I'd prefer the API contract to make the expected serialization
explicit rather than relying on the current caller to invoke it serially.

Thanks,
--Nilay

