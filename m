Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90963CCD18E
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Oct 2025 06:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uauZGp7oKEwNDbdC1uYuaIw/WNoTH/HilficULh0Buo=; b=As96gyfTfNToUvQt3YeTxfERoS
	FPeHTFDAi8wGVjj0/ntiS9gLAzUbP62BXJHOUgzeKUALJbAUsgbX9OHcRi8wIfa+88ZDh8CnvgWxr
	qJqwfD6ftseMor9bd++wqcyz9+8yjoDemJJyKfkioIAFH7+uOcFSDv2N22DwrB1kFI1TtzgeDYTGa
	BFUEnIWWSof9+85i5heqDnWLJ1FWWAqUlPFovowqiiJEpVstfR8CJ3fjywWt3PG/68TEYynX/xihH
	VtgTRydb8t7Q292xF8GvM0/jxCpfOjPOnOjgPuBvYiIY54OHapQkuAlIRpfPLi6pLhUbHoG4rfdye
	l2RcF1NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8urr-00000000Zqv-06LY;
	Wed, 15 Oct 2025 06:20:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8urn-00000000ZoN-1S0i
	for linux-nvme@lists.infradead.org;
	Wed, 15 Oct 2025 06:20:09 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EJ8dT8004069;
	Wed, 15 Oct 2025 06:20:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uauZGp
	7oKEwNDbdC1uYuaIw/WNoTH/HilficULh0Buo=; b=f9FDWBvwqNdXLw0H6u3dfC
	++nfzLEQAfdkiGrOefStXAxYk2YILMVrYy6Ko3kOIDwVnFjdR1Avr990pl86h5s4
	T+5kUW3lyA4R0GfzCJIEc+KtMkxOx7o/DZAoZCvMGG10quQEuJ2WwHeuWY0UmmFi
	a63lYvp5Xi9QkBiBBlRE0bdvEagYh2hx2uR0hx00Nr5mRhWWsSniLzLzYC55l+k1
	SxalKdwatgHKvzcQEB7PgUCOr2L4FcqIwt6E2qtkLA8Li8QBTvACzUSERJH9ATIa
	OMMum2w1hIiivTTZYgmsOyrkc8sFAszTY1f2RfnA6kYXp9YS4PIItFAePClYo/Uw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qey8tu8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 06:20:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F3gSKG015016;
	Wed, 15 Oct 2025 06:20:02 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjen95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Oct 2025 06:20:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59F6K18e35324486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 06:20:01 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B3C658068;
	Wed, 15 Oct 2025 06:20:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DACE758062;
	Wed, 15 Oct 2025 06:19:58 +0000 (GMT)
Received: from [9.61.83.49] (unknown [9.61.83.49])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Oct 2025 06:19:58 +0000 (GMT)
Message-ID: <4faf672b-ad74-41dc-9518-bbb9af557544@linux.ibm.com>
Date: Wed, 15 Oct 2025 11:49:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for
 adaptive I/O policy stat
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, dwagner@suse.de,
        gjoyce@ibm.com
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
 <20251009100608.1699550-5-nilay@linux.ibm.com>
 <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <359e3d8f-4db7-4430-8520-4fed9de4f48e@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3t2Z5JI8UIfk-WFQ-GZORG1XbvYxQDzn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMSBTYWx0ZWRfX6D75ZoaSUUB+
 juUn3ik2NsNX1V0mq2SGG7yyZaXOu68dGjJVdz7RP0WrqyDi+/WG1RVan/uIKbSwcSqDuCIZZv4
 bpYb3glgVFja/UbGIpwpoAoAniFF7cIxfzh9AX/KM0d52Pvxcp14R4dSCwcK/yorLuVpQvdKOrh
 Yo7Rd4M+PZKPfx7fTbOX/XTr6F4EHORAKbl0s33pYERVwWVIpgJ76mHEdMlHS///NFjsMF3MEmv
 kDBb2j83z/lRqBBLDly56c9960PoXBQrjmkm/VuHd1qPl3aJSg5FTjPjMZbYILt1SMi53C5GGab
 qXXy8EVT/36rqGjvNIultefa26ajOYf7+JMdzsY6Ov4NZ92WAu9sdknu2BvhG+JRmy/wIzluKR+
 6Ed3vcTr65ShWu2DauUAnyZns9xwzw==
X-Proofpoint-GUID: 3t2Z5JI8UIfk-WFQ-GZORG1XbvYxQDzn
X-Authority-Analysis: v=2.4 cv=QZ5rf8bv c=1 sm=1 tr=0 ts=68ef3d13 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=O1fYyZKE8seMAvTDqbsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110011
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251014_232007_749715_E40A37B6 
X-CRM114-Status: GOOD (  13.03  )
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



On 10/13/25 12:03 PM, Hannes Reinecke wrote:
> On 10/9/25 12:05, Nilay Shroff wrote:
>> This commit introduces a new debugfs attribute, "adaptive_stat", under
>> both per-path and head debugfs directories (defined under /sys/kernel/
>> debug/block/). This attribute provides visibility into the internal
>> state of the adaptive I/O policy to aid in debugging and performance
>> analysis.
>>
>> For per-path entries, "adaptive_stat" reports the corresponding path
>> statistics such as I/O weight, selection count, processed samples, and
>> ignored samples.
>>
>> For head entries, it reports per-CPU statistics for each reachable path,
>> including I/O weight, path score, smoothed (EWMA) latency, selection
>> count, processed samples, and ignored samples.
>>
>> These additions enhance observability of the adaptive I/O path selection
>> behavior and help diagnose imbalance or instability in multipath
>> performance.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   drivers/nvme/host/core.c      |   3 +
>>   drivers/nvme/host/debugfs.c   | 117 ++++++++++++++++++++++++++++++++++
>>   drivers/nvme/host/multipath.c |   2 +
>>   3 files changed, 122 insertions(+)
>>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> Might be an idea to have support for queue-depth in here, too.
> 
Currently queue_depth and numa_nodes attributes are created under 
sysfs, so do you meant to move those attributes from sysfs to 
debugfs? 

Thanks,
--Nilay

