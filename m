Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E7FC369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nc5sGGF3L8/wJHVP3oGXkCMBHi6xzZLZKtDy3YpoBQY=; b=RohN2OfmjxgRA0RKLad6apVUCX
	mOltnU4LSwnqlHeNGaY4omQSIJ0uV5hxD2bNV2cXixMchZFr6N2uPU/Z+0hKVNkr1/2WDrk20v2mq
	A8UOrn4IgZ/h3yX6wFcj6s6uz4EZXmKTSI5iXKIpIWZkcumH+w+4oD+XJKD+0vzPvFCBt9xzb8BED
	OA+2M3X2WFQeY99twSV8M8qqxEHztPsywS21i0j233hDxYw6je8yDmm7YwqW/FLbnTkDVHSCGpOjr
	zS3aw/3HT2kuLgf2q8tRR6Xtu20Fz+eykpFoJSwUFttrXJ74UdsB2KFxRzAKo2bKgO68iwR08s5lh
	NHE6booA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7FrW-00000007n16-1NCQ;
	Tue, 22 Apr 2025 15:48:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7EgG-00000007Vtl-1W9g
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:33:01 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MCb5W7006025;
	Tue, 22 Apr 2025 14:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nc5sGG
	F3L8/wJHVP3oGXkCMBHi6xzZLZKtDy3YpoBQY=; b=hIl5HIA8tMtWKf6Q9xVpcp
	8yNwCm8a6uLZjpB9WM7KOqwP0F7MO0Md+lNdP2Ijos0Fnsb5iDhNW7L+sMuelZqk
	j3zVo1J95m8CKw4MleX6gQ6sDWddy09s1sNh2csg41go962racs0/8frc/ziDsXr
	BjY6xcCbvOlkxiVZBs6wFFZOdN2Ao9oWcKe10IF8shZsYaKphIXCCCpGohdKhQpm
	eW69EhMy7asMdzpBzuqwr7xUSkfUk7RsSTOwhmgtZMHbyGJMJP56arHTuMlCoA0a
	ploYoIX7iIINvujSdYKT29zlte3XU7f7JpEqOBfjCx9LGpdtAmvypOuosrQJ3ldg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466b97gjk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:32:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBIRo0002904;
	Tue, 22 Apr 2025 14:32:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 464q5nk83g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 14:32:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MEWsCB22610354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 14:32:54 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CB7E58052;
	Tue, 22 Apr 2025 14:32:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 760E158045;
	Tue, 22 Apr 2025 14:32:51 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 14:32:51 +0000 (GMT)
Message-ID: <20e5b90b-3c2c-4be8-8119-b14fab733a5a@linux.ibm.com>
Date: Tue, 22 Apr 2025 20:02:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] tree: add queue-depth attribute for nvme path
 object
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-3-nilay@linux.ibm.com>
 <0e70314a-3c08-40ab-ac53-e9fb7e379f44@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0e70314a-3c08-40ab-ac53-e9fb7e379f44@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nyb_L5DPRudiUCkKOCytI3mSDVSexh50
X-Proofpoint-ORIG-GUID: nyb_L5DPRudiUCkKOCytI3mSDVSexh50
X-Authority-Analysis: v=2.4 cv=FIgbx/os c=1 sm=1 tr=0 ts=6807a897 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=zH0chscHYlN6rDLQaksA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_07,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_073300_540800_12B0603E 
X-CRM114-Status: GOOD (  23.84  )
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



On 4/22/25 11:56 AM, Hannes Reinecke wrote:
> On 4/17/25 15:59, Nilay Shroff wrote:
>> Add a new attribute named "queue_depth" under the NVMe path object. This
>> attribute is used by the iopolicy "queue-depth", which was introduced in
>> kernel v6.11. However, the corresponding sysfs attribute for queue depth
>> was only added in kernel v6.14.
>>
>> The queue_depth value can be useful for observing which paths are selected
>> for I/O forwarding, based on the depth of each path. To support this,
>> export the attribute in libnvme.map so it can be accessed via nvme-cli.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   src/libnvme.map    |  1 +
>>   src/nvme/private.h |  1 +
>>   src/nvme/tree.c    | 12 +++++++++++-
>>   src/nvme/tree.h    |  8 ++++++++
>>   4 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/libnvme.map b/src/libnvme.map
>> index 4314705f..e53fad6b 100644
>> --- a/src/libnvme.map
>> +++ b/src/libnvme.map
>> @@ -317,6 +317,7 @@ LIBNVME_1_0 {
>>           nvme_path_get_ctrl;
>>           nvme_path_get_name;
>>           nvme_path_get_ns;
>> +        nvme_path_get_queue_depth;
>>           nvme_path_get_sysfs_dir;
>>           nvme_paths_filter;
>>           nvme_read_config;
>> diff --git a/src/nvme/private.h b/src/nvme/private.h
>> index f45c5823..f94276e2 100644
>> --- a/src/nvme/private.h
>> +++ b/src/nvme/private.h
>> @@ -34,6 +34,7 @@ struct nvme_path {
>>       char *sysfs_dir;
>>       char *ana_state;
>>       int grpid;
>> +    int queue_depth;
>>   };
>>     struct nvme_ns_head {
>> diff --git a/src/nvme/tree.c b/src/nvme/tree.c
>> index bd7fb53e..b7a38a07 100644
>> --- a/src/nvme/tree.c
>> +++ b/src/nvme/tree.c
>> @@ -903,6 +903,11 @@ const char *nvme_path_get_name(nvme_path_t p)
>>       return p->name;
>>   }
>>   +int nvme_path_get_queue_depth(nvme_path_t p)
>> +{
>> +    return p->queue_depth;
>> +}
>> +
>>   const char *nvme_path_get_ana_state(nvme_path_t p)
>>   {
>>       return p->ana_state;
>> @@ -921,7 +926,7 @@ void nvme_free_path(struct nvme_path *p)
>>   static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>>   {
>>       struct nvme_path *p;
>> -    _cleanup_free_ char *path = NULL, *grpid = NULL;
>> +    _cleanup_free_ char *path = NULL, *grpid = NULL, *queue_depth = NULL;
>>       int ret;
>>         nvme_msg(r, LOG_DEBUG, "scan controller %s path %s\n",
>> @@ -955,6 +960,11 @@ static int nvme_ctrl_scan_path(nvme_root_t r, struct nvme_ctrl *c, char *name)
>>           sscanf(grpid, "%d", &p->grpid);
>>       }
>>   +    queue_depth = nvme_get_path_attr(p, "queue_depth");
>> +    if (queue_depth) {
>> +        sscanf(queue_depth, "%d", &p->queue_depth);
>> +    }
>> +
>>       list_node_init(&p->nentry);
>>       list_node_init(&p->entry);
>>       list_add_tail(&c->paths, &p->entry);
>> diff --git a/src/nvme/tree.h b/src/nvme/tree.h
>> index 9f382e9c..a9082f8e 100644
>> --- a/src/nvme/tree.h
>> +++ b/src/nvme/tree.h
>> @@ -867,6 +867,14 @@ const char *nvme_path_get_sysfs_dir(nvme_path_t p);
>>    */
>>   const char *nvme_path_get_ana_state(nvme_path_t p);
>>   +/**
>> + * nvme_path_get_queue_depth() - Queue depth of an nvme_path_t object
>> + * @p: &nvme_path_t object
>> + *
>> + * Return: Queue depth of @p
>> + */
>> +int nvme_path_get_queue_depth(nvme_path_t p);
>> +
>>   /**
>>    * nvme_path_get_ctrl() - Parent controller of an nvme_path_t object
>>    * @p:    &nvme_path_t object
> 
> As discussed: saving the 'queue_depth' attribute is a bad idea, as it
> changes frequently.
> I'd rather read the attribute value from sysfs whenever
> 'nvme_path_get_queue_depth' is called, and use the tree structure only
> to hold the pathname.
> 
Yes correct, but I thought we discussed about implementing non-cached
version of API in libnvme 2.x. So I implemented cached version of 
queue_depth API. Daniel can you confirm? 

Thanks,
--Nilay


