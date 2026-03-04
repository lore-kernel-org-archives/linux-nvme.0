Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34436EB7EB6
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BPigoSYmg8LVmc0ulN1tLtRw3HA0BukgwUSoeuIc5m4=; b=DxySZSiPbJQOXSnOayhF7I9Lh3
	KrP9HIeGayci5/cmrkUw1c5NcXDnjA6e7oU0rZnz23dmDTnV7bGq5Oahw6tblgKn6Y0VUnS+Fmkk/
	06CAysK7OGHlgLQ4GK1EEmcBB58vPb+tFIDcAniQRfMNP4F8I3TvM+YmpDtWpiOZvYvbcUw9XjqCT
	+8Z7wdUAwMqCvXJMiHUJ/7WSrwsQZ426TTbSHv6GqXOW8M/7WGpRMylbwZqwy2bDedq9kvmER4ncR
	riHvZs+R/rxPPVgZSxTGv3lLFg95LgfFRfPsW6XGJhQin/d3RaJiWiifz84kwWBGJU2z5cDllk2J/
	TMK35LMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjRv-0000000GzbA-1F61;
	Wed, 04 Mar 2026 10:27:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxjRs-0000000GzaC-3eyT
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 10:27:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623L7LD92186284;
	Wed, 4 Mar 2026 10:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BPigoS
	Ymg8LVmc0ulN1tLtRw3HA0BukgwUSoeuIc5m4=; b=cNHPyJHZ0x3WmT5XhZ/RW1
	uOyB6UduOIgBmEHhV79hEqUxDE6tsqosw4tk6ZQUmMi9DmzEUDthSaiaZQUHQcE5
	k83ScpYUtJ0EuwMCIFNI6YHA8Srt/ZSkj5OTNc1XdWirZ6zQ94ErJc37AdO7OvpU
	VpLp4rRnB35cLWHuSH4kCsMJMop3RmDeiXmC0+etQ7ocP4aA0yHvU+Blb0++/3HB
	5W8IgDGRtY6rK2Z+vq9fjhKKUuYPuyZOQTW3/EwkL26jdQLvNfyuIu0m8TgYatjE
	frjxCtsTwhF7ADzMYgfB8qWhEhNcDc9lokoR25Z70wah4N6+sFQ24iJdcIX8nUWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk3xgq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 10:27:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6249Mqp1003200;
	Wed, 4 Mar 2026 10:27:03 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2y6bnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 10:27:03 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624AR2Wv31654490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 10:27:02 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C11E58056;
	Wed,  4 Mar 2026 10:27:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D73395805A;
	Wed,  4 Mar 2026 10:26:56 +0000 (GMT)
Received: from [9.124.211.174] (unknown [9.124.211.174])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2026 10:26:56 +0000 (GMT)
Message-ID: <02288590-486e-4243-8352-c756c6879629@linux.ibm.com>
Date: Wed, 4 Mar 2026 15:56:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] libmultipath: Add path selection support
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
        james.bottomley@hansenpartnership.com, hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-4-john.g.garry@oracle.com>
 <775dd360-ea41-4e27-9690-e0633e0522d7@linux.ibm.com>
 <f9fb6d73-9b90-4c11-ae1f-3f2e76773d7f@oracle.com>
 <bb4df6e1-cd83-4a73-af67-f83c543d6e6c@linux.ibm.com>
 <bfd8c2c2-65f7-44f0-a4ec-01158e249505@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <bfd8c2c2-65f7-44f0-a4ec-01158e249505@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wNdMAJ64d3mlu4w06oN3uBVodrM75bmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA3OCBTYWx0ZWRfX7aCZjoK/0h89
 nfkoJhaNkFP30m55Iua+DttUn+MkRh89/flMWcylmjPQRdCQHBxM4CPWt+zXWlarviKrVZ1jAVP
 K0W931geLEdpHezq4/kIUjNVbocFBLdYMiFn+c6ovGXUpjn8KmFZf4g6lY+gPdEC9fV+bTKiW6l
 REy/4qBcu9OyEDG+NX/BTBCTp/4hxr6TiRnUPNHfyU4gyE83nd5nrXYyz5Th4noFkCrJvaDBu28
 XgKj7Amx9keoMkyH9E9oEtQeXAsGlXo1DeuSlIZTt9FdywMOcbKiaoYpuCvvruLmeEc+6A/8hok
 TjpcV48HPp0OnESFdrk9mxVDfOQl2QzfO0+qX8650mubePBJF/GdthXwrIeVU8EuF9GyYeSFBqu
 6poJX0WnmP6CV1reMe8B5Uou7q5s4sRXXaa4CZD0klEFTrXUfhXpP+Os+IS40AwPXaVnAtkb1lP
 VF/CZ5zlieVTVbKmiPQ==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a808f7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=xTIvoFW6gsbRu0B_4BsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wNdMAJ64d3mlu4w06oN3uBVodrM75bmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_022725_225852_110D8D4A 
X-CRM114-Status: GOOD (  24.05  )
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

On 3/3/26 6:11 PM, John Garry wrote:
>>>
>> The nvme_mpath_start_request() increments ns->ctrl->nr_active, and 
>> nvme_mpath_end_request() decrements it. This means that nr_active is 
>> maintained per controller. If multiple NVMe namespaces are created and 
>> attached to the same controller, their I/O activity is accumulated in 
>> the single ctrl->nr_active counter.
>>
>> In contrast, libmultipath defines nr_active in struct mpath_device, 
>> which is referenced from struct nvme_ns. Even if we add code to update 
>> mpath_device->nr_active, that accounting would effectively be per 
>> namespace, not per controller.
> 
> Right, I need to change that back to per-controller.
> 
>>
>> The nr_active value is used by the queue-depth policy. Currently, 
>> mpath_queue_depth_path() accesses mpath_device->nr_active to make 
>> forwarding decisions. However, if mpath_device->nr_active is 
>> maintained per namespace, it does not correctly reflect controller- 
>> wide load when multiple namespaces share the same controller.
> 
> Yes
> 
>>
>> Therefore, instead of maintaining a separate nr_active in struct 
>> mpath_device, it may be more appropriate for mpath_queue_depth_path() 
>> to reference ns->ctrl->nr_active directly. In that case, nr_active 
>> could be removed from struct mpath_device entirely.
>>
> 
> I think so, but we will need scsi to maintain such a count internally to 
> support this policy. And for NVMe we will need some abstraction to 
> lookup the per-controller QD for a mpath_device.
> 
This raises another question regarding the current framework. From what 
I can see, all NVMe multipath I/O policies are currently supported for 
SCSI as well. Going forward, if we introduce a new I/O policy for NVMe 
that does not make sense for SCSI, how can we ensure that the new policy 
is supported only for NVMe and not for SCSI? Conversely, we may also 
want to introduce a policy that is relevant only for SCSI but not for NVMe.

With the current framework, it seems difficult to restrict a policy to a 
specific transport. It appears that all policies are implicitly shared 
between NVMe and SCSI.

Would it make sense to introduce some abstraction for I/O policies in 
the framework so that a given policy can be implemented and exposed only 
for the relevant transport (e.g., NVMe-only or SCSI-only), rather than 
requiring it to be supported by both?

Thanks,
--Nilay

