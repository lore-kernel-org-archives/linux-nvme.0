Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131AFEB7ED8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 11:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nuJ+692/j0PYcLR+a9CQWeVOWS8W7ys8LvstW504ltY=; b=A79bVIwTQER0vQFRwa5wPYVTBn
	9wh1sohk2KDyuJ1eOQeyliTKAMesfrF6qGfPHsT9T90HtVlgDHbAsx9briilqhpxT4OAPeRaNz4Ha
	Now8i95awdi996AQsgC++TwAYafCE5VxdDpvYHrBKGUJDU3fANePVA6EUKMrBPNj0q8pOM54Fi1Vy
	RY74niVZhWMO5+2+ZzjeQ4LAM/9GNP6jKce1pvmS4f+nFmnoBMTAssXCEvD5zi0od+RWNS3xOt/5m
	9fcZigwoccNRMolMxx7piyZJKnJY3R3/En+ccZOGc/iVAQTFaBXopmp7cV08jFrP2kPvxAe+9upd7
	lQ0GigBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxkpN-0000000H8uK-1yFJ;
	Wed, 04 Mar 2026 11:55:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxkpK-0000000H8tw-3NLi
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 11:55:44 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623J7Nop2198741;
	Wed, 4 Mar 2026 11:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nuJ+69
	2/j0PYcLR+a9CQWeVOWS8W7ys8LvstW504ltY=; b=AJyjpOuqx6pL6yQNqzNuF3
	TY9GeffpZFCMgMBRwAqFpRmYd4JcDgS5RijNgJwX4vYVuBjn/wrRKR9kxyl1/aZ0
	NdbiLCPraXPYx2gRwvSsN0pQ1xCGDX6yKABQH3CaSuJNCBprrgca4cW1CkmojJJX
	U8jHNsxG/1PJzr8PENDEeJR+LmvsHofbF1YxnJzMAOQuG4k7UbmPPCzqshwOJP5A
	y+rch0Td4zXTL8CztXJ0fza4YNsGe0cDUI/lskEcsZjYz1jt5uPmeZ1WKgRbwqL5
	Q2M6O04HDUlSeGmUYhlEXCE8/tKevAlbMep3EJ55Ja96GzdK2OXCYUX+2I4602YA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksjdf5jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 11:55:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62472KF5008779;
	Wed, 4 Mar 2026 11:55:33 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1e6gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 11:55:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624BtXrr31458034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 11:55:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A86C58052;
	Wed,  4 Mar 2026 11:55:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B9825805E;
	Wed,  4 Mar 2026 11:55:30 +0000 (GMT)
Received: from [9.124.211.174] (unknown [9.124.211.174])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2026 11:55:30 +0000 (GMT)
Message-ID: <d2bc9d0e-dc9b-4c98-b07d-8c8f667b7c0e@linux.ibm.com>
Date: Wed, 4 Mar 2026 17:25:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC-PATCH 2/2] nvme: use the namespace id for block device names
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        mlombard@redhat.com, jmeneghi@redhat.com
References: <20260302222532.3400786-1-kbusch@meta.com>
 <20260302222532.3400786-2-kbusch@meta.com>
 <c2ef8067-a5c9-4be7-8e2a-9d74610d446f@suse.de> <aacAzGpNJ2RXedvG@kbusch-mbp>
 <aacSCnD-ag9-Llfg@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aacSCnD-ag9-Llfg@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M9BA6iws c=1 sm=1 tr=0 ts=69a81db6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=YW141hWbKyY8GUwSU9wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hMMVtL_tzRipgqzLtClE2WoM4at8KG3M
X-Proofpoint-GUID: hMMVtL_tzRipgqzLtClE2WoM4at8KG3M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA5MSBTYWx0ZWRfX2fUGpz8XFDLK
 dc2xawqqXgK48K+5Hw/KuRdHCqiY1gefPIGA6mRaWwu12hXzwcxxMgQiNbgBbHlS00tyuZscILX
 xRgfecme9/UTDrrd00ix8qh+trJQ4+KaCKyJoct3VyWSwqfNPgTuZaFmr4qHPaDKy51BBqJRdtj
 a4E43e8KBgvuGSta7MOB7G5X2Wc+oOcpfeu1pYIr3z81Q8fpr08yAbKUPKtVmQ1CvApkhUl0a6A
 tuEziyndDiA/JW4cH3iFZu9U1XLFIm6B/+mU8DDwgPVP3j4DKh8iLqgbljjrPRnnin+MLY1c0kE
 RwEIVnlfR18oIP273djl+yDWMJhEFJqapi/TSm4fJ4+/fH2mYPYyoZIiIJ7F0r/zI5hfaqy6mp4
 9XvsRwosFPEkYzi72Ew9rmSSZYR1kZ07JdqjksZv8Mv2Xn3wIlOb428EmKEic1QK1S06eDCmjAa
 gVTcC6diXthKOq5yN1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_035543_217244_E78BBC98 
X-CRM114-Status: GOOD (  32.69  )
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

On 3/3/26 10:23 PM, Keith Busch wrote:
> On Tue, Mar 03, 2026 at 08:39:56AM -0700, Keith Busch wrote:
>> On Tue, Mar 03, 2026 at 08:34:38AM +0100, Hannes Reinecke wrote:
>>> The idea is nice, and I would love to go into that
>>> direction.
>>> But have you checked how this holds up under
>>> rescan/remapping (eg things like blktest/nvme/058)?
>>> Removal of the sysfs nodes might be delayed, and we cannot
>>> create new entries with the same name until then.
>>> So if that is taken care of, fine, but I don't see that in
>>> the patch ...
>>
>> I see. I set out to ensure everything was ordered, but apparently I've
>> missed this case. Thanks for pointing out the test.
> 
> Okay, I think it's as simple as the head unlinking prior to actually
> doing the del_gendisk creates a time when one scan work makes a new
> namespace before the stale one is deleted in a different scan. This
> should fix it:
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3f2f9b2be87c2..e8dbb6cb85694 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4246,11 +4246,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
> 
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list)) {
> -		if (!nvme_mpath_queue_if_no_path(ns->head))
> -			list_del_init(&ns->head->entry);
> +	if (list_empty(&ns->head->list))
>   		last_path = true;
> -	}
>   	mutex_unlock(&ns->ctrl->subsys->lock);
>   
>   	/* guarantee not available in head->list */
> --
> 
> This opens a different race where Controller A is deleting the last
> path, and Controller B is bringing up a new namespace that reused the
> NSID. An earlier patch from me should fix that by reschudeling B's
> scan_work once A detects it removed the last path. It should work, but
> it feels a bit off to me, so I'll think about it a little more.
> 

I think we need to ensure that the head disk is fully removed from the 
system before a new head is created that may reuse the same NSID; 
otherwise we may run into name collisions. Since removal of the sysfs 
entries associated with the disk can be delayed, a namespace scan may 
attempt to create a new head with the same name while the previous one 
is still being torn down.

To avoid this, it might be better to defer removing head->entry from the 
subsys->nsheads list until after the head node’s gendisk has been 
removed in nvme_remove_head().

 From your first patch in this series, I see that the removal of
head->entry from subsys->nsheads was moved to the beginning of 
nvme_remove_head(). IMO, in addition to the change you proposed above, 
if we also move the removal of head->entry until after del_gendisk() is 
called, that should ensure the old disk is fully removed before a new 
head with the same NSID can be created.

Thanks,
--Nilay

