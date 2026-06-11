Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58159CD8C9D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v5S3zT+XXW2ygKvgVTdNnT0Bu2J/zloh3YLeZvv+Wq4=; b=08O0743dotDTvEhav44mlSYICN
	zqf7cDZaQz3JKeK7e+zeBwrjeXrn3THhBWflD3UnhRheBbS0ibW2gFU7erbZDSQDBBwLC5wZeriKk
	r94bl2JOEofZ3sBXK8fR3a9k4rqgRxCBk3UTwDr5jSm1Crbn+S/EdXP4AToWYFeAfIsrDFYegYMGD
	LmpvC4RPPV+kF/AhPfYoUqYoG+E41f4ER3voUsUpiPptpzNFf+BydakeXNXWt9qhisq580ZawCIBa
	m6j1CbDp/Wy7dRGKjmOBfzrYEdXw9tMZixCPc4vq8DJFyzhhU2w6/CxbCvenlZVMa7lOb0+tRflYw
	+U9galfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXWs6-00000008fj6-02rK;
	Thu, 11 Jun 2026 04:18:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXWs3-00000008fih-3QNY
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:18:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJuDmo677708;
	Thu, 11 Jun 2026 04:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v5S3zT
	+XXW2ygKvgVTdNnT0Bu2J/zloh3YLeZvv+Wq4=; b=ck2I04817QcJrQzLluSKnB
	/pzuz32wzC5nMWMVhBI4Ju+nVhBb5+332ePBFB20wLYBpwPlSEdOcYsFyP+p7ziH
	yrPTB8cMUqHSbz3ZBJ1SyjkpNnH7z5n9HvxJISdtpxcWFvAwpV/EhKuhQOI7avT/
	yJNig71XVB5IVYi/Bhg/5KHijSRujN/uunmvIT3KCVjbyLhTHI/U6ARXzRBRF+xU
	dfU77daJZ4/5z73YZo03JqRA567P8Aq2VDwWxU2Uv53bXGd3OP0BLycvnxdq7vDr
	Y0PMZpua6K9TZ9TW+GCyDkEJotjSTxw4kQHvU5da8EIdcnkXSMBshQoh3SQ1ewiA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ahbdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:18:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B44bfA024503;
	Thu, 11 Jun 2026 04:18:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a1jpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:18:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4I5iK29950618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:18:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ECAA58055;
	Thu, 11 Jun 2026 04:18:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C77958043;
	Thu, 11 Jun 2026 04:18:02 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:18:01 +0000 (GMT)
Message-ID: <57438008-47e2-4a83-8a01-a6554d0eaf2d@linux.ibm.com>
Date: Thu, 11 Jun 2026 09:48:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] nvme: add Clang context annotations for
 nvme_ns_head::requeue_list
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-5-nilay@linux.ibm.com>
 <0b3ab980-db78-4f21-8af7-f74961f5d648@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0b3ab980-db78-4f21-8af7-f74961f5d648@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: onCxt1_Q1vOyJ9y43XVHnIouEiTpKtoY
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2a36ff cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=P2YX_yz4t0Xk7t2HBcYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzNyBTYWx0ZWRfXyZzK3oOD/RW9
 VNRlqdmdKIpJqzqEn5G2YnvdtHhWh8GFKJdAQjFCd+qRsOIdY+/po/xWbHbH/NwHWxxF9jIWpiH
 3zkaJYUiWVLyEmFRwpcEb6HGJci+iGh88wUa/roBXolTpcVGxum7R8Nd2fihcuWrqjEUmtUmXyl
 xIAYX49lDfmUgXx0g6Bc6lX7XpInQzZ9pSMt7NkxhlxPisBj353HF3yuHfXjuDw5vSOOgxLHb0I
 q9LrqZv/KynzpSa2+FHEd24YEq4Evn4n0tyHQdWFVT0dq1URAcDMIppYq2UWF5ANGSsGVSdXLkc
 iVO1VGli3PgkyHiieuf/7ypxxQG4/Zx6nMU6xs7FronW40jvvDwsOjU7qbpon0v3Eq2J22mmOte
 lzc/J5HKM5h79RxGND2iWok3/rIRfPUcdm7hMYD6kevsYgU9WQZgmOAcds/yE9ROrWhPTbgHhpy
 oo1oZFUfIt4TPMOczNw==
X-Proofpoint-GUID: EVZdQ0itDVekK_aFhxSZhe9Ds3d8JoLk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzNyBTYWx0ZWRfXwoFZnzZTN7rF
 ZsHMuspDCMJLuUQM6c+hzqTFXHy+0k0PXbM2Qv4tjG6TVtRdjuk8kyKnmtYup26FjYZbYOQcdWY
 b+ugF3xARHHBewdprjL/3GlwSKqnWa4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_211823_973634_671E9E56 
X-CRM114-Status: GOOD (  11.93  )
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

On 6/10/26 9:55 PM, Bart Van Assche wrote:
> On 6/10/26 7:27 AM, Nilay Shroff wrote:
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index a275c03e7c59..985a8c693c6f 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -706,8 +706,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>       struct queue_limits lim;
>>       mutex_init(&head->lock);
>> +    guard(spinlock_init)(&head->requeue_lock);
>>       bio_list_init(&head->requeue_list);
>> -    spin_lock_init(&head->requeue_lock);
> scoped_guard() is preferred over guard() because with scoped_guard() the
> scope the guard applies to is explicit. When using guard(), if new code
> is added, it may end up being covered by a guard() statement although it
> shouldn't.
> 
Yes makes sense, I'll replace guard() with scoped_guard().

Thanks,
--Nilay

