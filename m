Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69807C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r/g+Wx9Hm2rhyYaTUofmlqgiLOYhMwW2+7a7AlyG+k4=; b=AnfYEgYnyBaF8TQ0k0NuQIkiIj
	IkRzQ1kT25RS9XtuKiCKqcsYmUfGXTp8PrBugm4Bgt7pvQQ+NifhfrywNkr/fzn0utHa7wAkhWSQY
	xY6U3SaYEqAfyK5uqm+TeNbWpNwW4VLUHWuzI++wF4TGl9fwnNPweLcH9ByzhzMgqXhAeQHbOkova
	o9inKO2FGQbUzhWi3AyDOZwpkxAlsISZ2svdZZvmEcCDKucKnZylRYdFgoSK1OEbjPAatYNMUA4Ul
	5ngisPKS6PjGvC52KtpQASbPxccuUCSzjtn9MBxPnrRkIwdThekMgtMhHKsa+9qGgNmUICXN4kLsV
	Q4ZwDBvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3yA-0000000FcKI-03O7;
	Wed, 12 Aug 2026 08:05:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3y7-0000000FcJj-2bxp
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 08:05:48 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C6360k1579898;
	Wed, 12 Aug 2026 08:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r/g+Wx
	9Hm2rhyYaTUofmlqgiLOYhMwW2+7a7AlyG+k4=; b=Nc3CoLTz5S7sVhMhkkru8G
	KXCWOMmt1WqRgO41x2Aws+baUh9y1I3Z+6XlGvZLrzd/91f129hByiYvUUk7/XDB
	vWdDXkXzXzZd8n9YLU+r6e2cr9w9yPw0AwndLkuA46gLGVhWQtBOvgE/74boILKN
	M8mbrgUy0vA6Pw9/h7ceEjpFMjFKWktArvsdJ73056Qov4eXn2Yc0zNGkbuVo3e6
	Jm8i9zW9z9EXc518PHpG5hKe/ot8A4ZdSNNyHcfvEdF8Nn6911Jh3ZFN6IRcOKfH
	NmyJbkZnurXkY8xKKthcOQWaVHuGDEGLm72LvI3gGLjWZVQcuCq3PMPk/+D5Y4Xg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23t1uy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:05:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7uUeb027028;
	Wed, 12 Aug 2026 08:05:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h52dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:05:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C85fqe40305382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:05:41 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2033758052;
	Wed, 12 Aug 2026 08:05:41 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18B2D58056;
	Wed, 12 Aug 2026 08:05:37 +0000 (GMT)
Received: from [9.61.0.237] (unknown [9.61.0.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:05:36 +0000 (GMT)
Message-ID: <1debeecf-672a-453d-b4d4-7f798045ae48@linux.ibm.com>
Date: Wed, 12 Aug 2026 13:35:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] nvme-multipath: pass I/O type to nvme_find_path()
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-4-nilay@linux.ibm.com>
 <f6daf09b-338d-4518-9d1a-a172b3c2bef5@oracle.com>
 <dc2bb999-ca97-4899-8470-c95a80ae1229@linux.ibm.com>
 <70b23be2-0cb3-49fe-bff4-237082caaab3@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <70b23be2-0cb3-49fe-bff4-237082caaab3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7c2956 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=44NF9CiQjhv3s04OhcQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX8pZqEkRM/sMt
 j5HWgU+B1izZAhaCcxLB/n03euxKyxY6qtwQNrPG4YWXbtSbAtyqScf2bgIAx9oTXS2th+gDz9A
 ud1QjzsFoj+gbtjxSVEE6lfioWn8OExCbxhdA8yfJz6MsoCGi0uFVCM+S2m/J2vxBYhqO0Ms5aj
 i3C9B3jyaXD1cGWTm/eQ5NceWliMkGdOZHKDqOMvuFZBjgS4eiED9TYdaFGDwSS/5Mh5ikgF0px
 8Yrn3BeSMpqQPxeywMRc8GDO7GofB3HPFk+re82+p9p75Z0qyzAw814TdQeQl9IP7J/Rtb83XQ7
 7MXpJ3M1IXHLTUfcYtkqU9aLSsdixbxZOi4bAQ3cIdPr46IRIrK57TCLDLqab1SHUITJGpPHJ6b
 d5LJkZEszPSqP3ag7JuuWlE/fr/XV+qqzq2xC9JBAnEGB1qG9lSKr2HluzTB4aElGqLibcNer59
 MCy8//grbn2dUMOwlkQ==
X-Proofpoint-ORIG-GUID: _PJfUfAr9J7_k75z79YMbMK1fxrp9uAA
X-Proofpoint-GUID: 0JrTMaORkFgQiiG0Q8UR--8JwyOhzKi8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX99c8fhHAK+Kk
 d/hfzUUokhnKKNlOOu0cAZM21sTBUE2FA4Sw1V9TrIXQNB5UiZVSmDOFoDxHVn6zit/jA7DTPmo
 /8V9uKHXovMKnf9EXmZcDTp7N2SNe4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_010547_785925_F75B86B5 
X-CRM114-Status: GOOD (  22.53  )
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

On 8/11/26 4:06 PM, John Garry wrote:
> On 10/08/2026 18:19, Nilay Shroff wrote:
>>> It's a but unfortunate that we have to find op_type even for when not using the latency iopolicy.
>>>
>> I looked at a few alternatives to avoid passing op_type into
>> nvme_find_path(), but couldn't find a cleaner approach.
>> Fortunately, determining op_type is inexpensive, so I don't
>> expect it to have any measurable performance impact.
> 
> All I can think of is a variant of nvme_find_path() which accepts the bio, but that means more complication and code duplication - but not too much.
> 
> As you mentioned, the processing should be small for this.
> 
>>
>>>>        if (likely(ns)) {
>>>>            bio_set_dev(bio, ns->disk->part0);
>>>>            /*
>>>> @@ -572,7 +573,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
>>>>        int srcu_idx, ret = -EWOULDBLOCK;
>>>>        srcu_idx = srcu_read_lock(&head->srcu);
>>>> -    ns = nvme_find_path(head);
>>>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>>>        if (ns)
>>>>            ret = nvme_ns_get_unique_id(ns, id, type);
>>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>>> @@ -588,7 +589,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>>>>        int srcu_idx, ret = -EWOULDBLOCK;
>>>>        srcu_idx = srcu_read_lock(&head->srcu);
>>>> -    ns = nvme_find_path(head);
>>>> +    ns = nvme_find_path(head, NVME_STAT_OTHER);
>>>>        if (ns)
>>>>            ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
>>>>        srcu_read_unlock(&head->srcu, srcu_idx);
>>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>>> index 824651cc898d..8a9ec502912d 100644
>>>> --- a/drivers/nvme/host/nvme.h
>>>> +++ b/drivers/nvme/host/nvme.h
>>>> @@ -520,6 +520,13 @@ struct nvme_ns_ids {
>>>>        u8    csi;
>>>>    };
>>>> +enum nvme_stat_group {
>>>> +    NVME_STAT_READ,
>>>> +    NVME_STAT_WRITE,
>>>> +    NVME_STAT_OTHER,
>>>
>>> Would NVME_STAT_OTHER ever be used in high frequency scenarios such that it is worth having its own type? If not, could NVME_STAT_READ be reused?
>>>
>> It may not be used in high-throughput scenarios, but treating these
>> commands as READ or WRITE would unnecessarily skew the latency statistics
>> for actual read/write workloads. Keeping them in a separate category
>> avoids that distortion, so I think having NVME_STAT_OTHER makes sense.
> 
> I can't imagine that NVME_STAT_OTHER could skew the READ/WRITE results too much, but I don't know the full range of IO for which NVME_STAT_OTHER would be used (so I may be wrong).
> 
There're many opcodes which falls in other catogory here for instance,
flush/write-zeros/compare/verify/dsm and few others...

> BTW, it would be nice to mention the reason behind NVME_STAT_OTHER in the commit message. None of enum nvme_stat_group is described in much detail.
> 
Yes make sense, I'd do the needful.

Thanks,
--Nilay


