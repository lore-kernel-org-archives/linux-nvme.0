Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4978EC5DF81
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 06:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H1zCBLm8ye0SHQziY+V9WqtdrwBu9qwqvhxptopeel4=; b=vVfG7Y2Bzp7pPjL9TW0qKVswoP
	jae/pJjOQTtFL58DWUwmQvMJCe9jgh/gtnJEs60SRdpEgZKedNWC91HLUDKx+HhSrAkufKA7iH/kV
	6C6VFyKXeX0vdmSgK5v/ClGsbVzl5AqU0PxRekHPWleixOxX8PR4g2ayVROK3juf1lgH0LWKg/aEs
	PqU7Y96/Hpoiqpy0eLc0OK2/hxWhDGex9trCM8mNkmpQ6TL2l9dBpPHYjg/9om7yZjmKr/3gc1Whb
	KDah8qhPx+dDwIS8kByhzVONaLl6HRjZcobn9JQNwhszoM9r+GN7sCbzSktXdvH++ifXaDyDmEiID
	kxQvgKDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1www3m-0000000AvLI-134E;
	Thu, 20 Aug 2026 06:15:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1www3f-0000000AvKO-2o8k
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 06:15:24 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVeQs471650;
	Thu, 20 Aug 2026 06:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H1zCBL
	m8ye0SHQziY+V9WqtdrwBu9qwqvhxptopeel4=; b=ITL6eBCSbXYffoxbXyXLXp
	QRDTXm0heN3gcFK8F4NSMSJCzyOQ4G6FCTrd6+93I41nf9UcoNcy9SSzxIQlIfSj
	HiT5Jsgy5tFRvAzWpGqxS4NL6sHt2o+TZCTpnNFTCbyo8WJ7ue0fMSgghqT7d5FF
	gdAY1lPGV0B16dphCkrjidKXIhWHAzehL9nONRuPhEQ37IjnMxmeICnwG0QdPjMn
	fYbUx+S/IZ9QDyn5VcOzAN2AfWKx6FYXhoQimq+0LPMnAtTYrbi6PrTe2owXn2Wf
	yNpTNTfUM6fJy7Tk6EHGVFx/RAph4S1aHOJvfOcfZeJPxhMySY8twC0yd1ElOu1Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0gdrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 06:15:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K5uQkE021691;
	Thu, 20 Aug 2026 06:15:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqd26g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 06:15:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K6ESaV66847168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 06:14:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D19A758065;
	Thu, 20 Aug 2026 06:15:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 974A558052;
	Thu, 20 Aug 2026 06:15:03 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 06:15:03 +0000 (GMT)
Message-ID: <ec1e55e1-aa84-4fe3-a56f-4caf40080e58@linux.ibm.com>
Date: Thu, 20 Aug 2026 11:45:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/10] block: support nesting for blk-mq flag
 QUEUE_FLAG_SAME_FORCE
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
        kanie@linux.alibaba.com, jmeneghi@redhat.com, randyj@purestorage.com,
        martin.petersen@oracle.com, john.g.garry@oracle.com,
        gjoyce@linux.ibm.com
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
 <20260815173502.1185929-4-nilay@linux.ibm.com>
 <d11d3377-a4b3-45dc-b812-9dd06c8a2a38@suse.de>
 <ebfdc6e5-36ef-43ee-bd19-53b40e4682a2@linux.ibm.com>
 <59a3afbf-421a-40fd-a90d-521004f7de2e@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <59a3afbf-421a-40fd-a90d-521004f7de2e@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a869b6e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=x5vVg43ROtBy5dRk_ZkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HCHP8l4bU9uI3xMuVJh8CPRNK9NvgKY1
X-Proofpoint-GUID: DqZjXSBfr_3nVyvKK75TwFGMc0sWDrKE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfX3zcw2IjDqQ2H
 z8c+Z3RuyXmI/8nbq5+stqWMRYzEnuEfyRfskSfVC8tY2SAhpdpSsr/8NcrGYBb1yoLMi/QeW4X
 Bb0+Hr739dr1hAPo2OQ3apzE6sTym2s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0MiBTYWx0ZWRfX0mxO88YPNvtF
 iHMlbD4yx7s/GL5iU4C29xZpZflZTYQMMrxCPdAF+doFjOQOHYLdVjYPTgvknYies3W15MB19tw
 VWQXrJ0OcgXrOkyFBsyH23LDz/Ba0lIsCVbaMKF8o8oQoPrdxJeBAHkKTkwokXXYPNa0OpsJ73r
 zDt5CLrIxscwVc0ZzPkxPxWVX0PNQhxdfV8QczL3I10NciwzQ7PbwBq5RbO6C/G4pClO1j5QLiI
 jKt7H0Tu0oEMVTxv2P5M2vLmeDos2VJn63ix4gka7qvl0tRz1NBoLFORL+t1kKav9afbhEzH5Ka
 5/ohu6Tcg/+zI8hVC2OFXqJAftYQpLhoh+XkibushO2OTTUVGfqi+oBTjNzX2NBq5yzfD/mFYWU
 LJPK/wp5auUADd0gPGPP/8osKa4XFFpALhwLpV6sPpqmRzbjrxI5APrJFLnTS9dn/ZoOaobaIxM
 eUJuAm3ijB+6LgPR0IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_231523_725380_B7C2235B 
X-CRM114-Status: GOOD (  23.54  )
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

On 8/19/26 7:21 PM, Hannes Reinecke wrote:
> On 8/18/26 1:59 PM, Nilay Shroff wrote:
>> On 8/18/26 3:28 PM, Hannes Reinecke wrote:
>>> On 8/15/26 7:34 PM, Nilay Shroff wrote:
>>>> QUEUE_FLAG_SAME_FORCE is currently used when setting rq_affinity
>>>> through sysfs as well as by UFS mediatek driver while configuring scsi
>>>> parameters. A subsequent patch adding a latency-based I/O policy
>>>> for NVMe multipath will also use this flag.
>>>>
>>>> With multiple users able to set and clear QUEUE_FLAG_SAME_FORCE, the
>>>> flag needs to support nesting so that one user clearing the flag does
>>>> not inadvertently disable it for another user.
>>>>
>>>> Add a nesting counter, q->same_force_depth, for QUEUE_FLAG_SAME_FORCE.
>>>> The flag is set when the first user acquires it and the nesting counter
>>>> is incremented for each subsequent user. Similarly, each user releases
>>>> its reference by decrementing the counter. The flag is cleared only
>>>> when the last user releases it and the counter reaches zero.
>>>>
>>>> Preserve the existing sysfs rq_affinity semantics with a new
>>>> q->same_force_sysfs flag. When userspace enables QUEUE_FLAG_SAME_FORCE
>>>> by writing 2 to rq_affinity, mark q->same_force_sysfs as set and
>>>> increment q->same_force_depth by one. Subsequent writes of 2 to
>>>> rq_affinity while q->same_force_sysfs is already set are ignored, so
>>>> repeated writes of 2 from userspace do not increase q->same_force_depth.
>>>> Similarly, writing 0 or 1 decrements the q->same_force_depth and if
>>>> nesting counter reached to 0 then clears the QUEUE_FLAG_SAME_FORCE.
>>>> This ensures that multiple writes of 2 to rq_affinity do not require
>>>> multiple writes of 0 or 1.
>>>>
>>>> This change ensures that sysfs interface retains its existing set/clear
>>>> semantics while also allowing other kernel users to hold or release
>>>> QUEUE_FLAG_SAME_FORCE.
>>>>
>>>> Added two new APIs blk_mq_same_force_set() and blk_mq_same_force_clear()
>>>> to set and clear QUEUE_FLAG_SAME_FORCE respectively. Also, updated
>>>> existing call paths using these new APIs which toggles
>>>> QUEUE_FLAG_SAME_FORCE.
>>>>
>>> Yikes. Is this really necessary?
>>> The flag can be set by different subsystems/drivers, sure, but from
>>> what I've seen each user is mutually exclusive.
>>> I'd rather disallow modifying this flag if the driver sets it, to
>>> avoid upper layers or sysfs modifying it.
>>>
>>
>> If we want to disallow userspace from modifying QUEUE_FLAG_SAME_FORCE
>> while a driver owns it, then a userspace write to rq_affinity would have
>> to either fail (e.g. with -EINVAL) or be silently ignored. In either case,
>> that changes the existing userspace/sysfs semantics and may break userspace
>> that expects the write to succeed.
>>
> But _allowing_ userspace to modify it for drivers which requires it to
> be set will break the drivers.
> Similar for the upcoming latency-based I/O scheduler; disabling
> QUEUE_FLAG_SAME_FORCE there will cause misaccounting and the scheduler
> will not work properly.
> 
> So I would argue to have a flag for making QUEUE_FLAG_SAME_FORCE driver owned, and reject any attempts to change it via sysfs with EINVAL.
> 

I understand your concern. However, with the nesting counter, a userspace
clear cannot disable QUEUE_FLAG_SAME_FORCE while another user, such as a
driver or the latency-based I/O policy, still holds a reference to it.

For example, starting with:
q->same_force_depth = 0;
q->same_force_sysfs = false;

The sequence would be:

1. Userspace enables QUEUE_FLAG_SAME_FORCE by writing 2 to rq_affinity:
    q->same_force_depth = 1;
    q->same_force_sysfs = true;
    QUEUE_FLAG_SAME_FORCE = set;

2. The driver then enables QUEUE_FLAG_SAME_FORCE:
    q->same_force_depth = 2;
    QUEUE_FLAG_SAME_FORCE = set;

3. Userspace disables it by writing 0 or 1 to rq_affinity:
    q->same_force_depth = 1;
    q->same_force_sysfs = false;
    QUEUE_FLAG_SAME_FORCE = still set; 4. The driver subsequently releases its reference:
    q->same_force_depth = 0;
    QUEUE_FLAG_SAME_FORCE = clear;

Thus, the userspace clear only releases the sysfs reference; it does not
actually clear QUEUE_FLAG_SAME_FORCE while the driver still holds its
reference.

The same applies to the upcoming latency-based I/O policy. As long as the
policy holds a reference, a userspace write to rq_affinity cannot disable
QUEUE_FLAG_SAME_FORCE underneath it.

This is the motivation for the nesting support: it allows multiple users
to independently acquire and release the flag without one user
inadvertently affecting another user's requirement for the flag.

Does the above explanation help address your concern, or do you have any
further concern?

Thanks,
--Nilay


