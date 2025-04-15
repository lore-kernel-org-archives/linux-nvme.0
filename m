Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD5DC369AB
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Apr 2025 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=98Cs/KM3N1PiCCSdRnlzQMrJPCjp8FGsOmQQ7gDoalk=; b=r0RgObnssFdw14Ew2Aom022f2V
	FpgE6diaxPLy2mra10MzyDCumRT7aYRxGkaNM0e+jM4oXq35IxiDbIkAfuYaufU/N7imJhxRQPIvt
	nX4nTePYP6vn42BZCTOGmPKflQeYQBlh10CIiigB209L3A2uMKEf1BFZdL5+5d/UXDFof9vab7cxd
	9UacqCa7UABYVcuvs2tR+9J8bG8+EM7WaGY6oneNeEQtl05OzoKeeLL8ibutshCfLbayKXYKaKw9n
	auLNRvs3TsWozsFXm2y0i7LwiSraqd4RQ9IRmnCgsl8EwVGarlNnBMd/4I4DhwggpGW8lO8sYBzzb
	1GCcfxXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZRt-00000004dTv-2sWq;
	Tue, 15 Apr 2025 06:07:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ZRq-00000004dTN-415t
	for linux-nvme@lists.infradead.org;
	Tue, 15 Apr 2025 06:07:08 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELgVmF030091;
	Tue, 15 Apr 2025 06:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=98Cs/K
	M3N1PiCCSdRnlzQMrJPCjp8FGsOmQQ7gDoalk=; b=imNbsTIZWSQiDMKBB4yvzV
	3qYJ9/HdSlHSUEU4ND95XlA7nCR78XDH4dSXFvA23vzKeyIiVt4J+n4vy1F9LTm7
	09Nl+cUifTyPqAQ0cAtUo+YCO6FwJ0g+yvjk+dZUItmlASu8ITLHArDwoTutCBWq
	mn5vDqlT7Y+i6TrmX4T35PEDI4cSKVGuCyDEO4sETjKxS2KY8MpUm8hFURy3+G4G
	CKIKT3eK0GYU2Z03HL2WE5G7knp98ndbXev3ofQYQ3kvxHcdrspK3ttSW+GSNxkj
	01wtdbNBfEa6itpuygerwMtNBGhTr+lQIcfIWlPt54N/nMT/Y4skEY1hrWzuZr9g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461agt1hpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 06:06:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53F2vZiK010387;
	Tue, 15 Apr 2025 06:06:48 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk1dba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 06:06:48 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53F66lqm21693056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 06:06:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C9658043;
	Tue, 15 Apr 2025 06:06:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE0D158053;
	Tue, 15 Apr 2025 06:06:45 +0000 (GMT)
Received: from [9.179.13.11] (unknown [9.179.13.11])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 06:06:44 +0000 (GMT)
Message-ID: <0d0ce4e7-02e8-4d68-9a12-396b71940565@linux.ibm.com>
Date: Tue, 15 Apr 2025 11:36:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: clear NVME_NS_SYSFS_ATTR_LINK when disk
 is not added
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250414122545.140531-1-hare@kernel.org>
 <59574ff2-ad14-4df9-8202-b4997c3c34ee@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <59574ff2-ad14-4df9-8202-b4997c3c34ee@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4uyrTLcM7j9wa4Ik2ZdgDjQ5MVXx7Hvg
X-Proofpoint-GUID: 4uyrTLcM7j9wa4Ik2ZdgDjQ5MVXx7Hvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_230707_129085_4C29D0C9 
X-CRM114-Status: GOOD (  19.85  )
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



On 4/15/25 2:02 AM, Sagi Grimberg wrote:
> 
> 
> On 14/04/2025 15:25, Hannes Reinecke wrote:
>> If the namespace disk is not added we need to clear NVME_NS_SYSFS_ATTR_LINK,
>> otherwise the link will never be created upon rescan.
>>
>> Fixes: 4dbd2b2ebe4c ("nvme-multipath: Add visibility for round-robin io-policy")
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> Cc: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/multipath.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 05eccd96d34a..5c28f0dc6fad 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -1069,8 +1069,10 @@ void nvme_mpath_add_sysfs_link(struct nvme_ns_head *head)
>>            * Ensure that ns path disk node is already added otherwise we
>>            * may get invalid kobj name for target
>>            */
>> -        if (!test_bit(GD_ADDED, &ns->disk->state))
>> +        if (!test_bit(GD_ADDED, &ns->disk->state)) {
>> +            clear_bit(NVME_NS_SYSFS_ATTR_LINK, &ns->flags);
>>               continue;
>> +        }
>>             target = disk_to_dev(ns->disk);
>>           /*
> 
> Why not change the ordering of GD_ADDED and NVME_NS_SYSFS_ATTR_LINK checks?

This is exactly same issue I also encountered last week while unit testing 
changes while adding support for this feature in libnvme. Then I fixed it 
locally and queued it up for upstream. But anyways, I'm glad that you already
fixed it and send the fix upstream :) 

However my changes were exactly same as Sagi suggested. I just changed the 
order of setting NVME_NS_SYSFS_ATTR_LINK and GD_ADDED. So I also recommend
we may just switch the order and fix it.

Thanks,
--Nilay


