Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC15C71157
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 13:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvnCbfOUDiYvcGgGz0trrCaQNamMOxXGntALU8Ui+Mc=; b=EnKzWt7i5LqDsawyR4/5Vn0HIb
	WgD2B4AW22xmezdCmMjRor5TKcRE8ZSJLubtIlbTj88Y9xZiUfrsEyqp5SkZaDUwPZk74RszdTprS
	KSlx0GDBe7xNpEBiZet6ottl8FQRddmdd/TAhqorujl3R2dnZJA6zp0vDCSLk9vThbZ7VeqUZHXmv
	Cs2QowtWPRZs8Y2KQPLWdxFHp3TpvzIaeJYyGL5/qyUD395PjFjum3ZAiG7wUuVV0kj5oUsVeEdDQ
	zPOJmqRsXyCnVDhtbr4jGAG0hoL9s8/a8pAKMO9cYHr/GI6mxzHAyh1Al+aCU5+ZdGj/EYRoMi0I9
	NOrSxCeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU49b-00000005o4r-3dPI;
	Tue, 24 Jun 2025 13:57:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU3k1-00000005ifu-424P
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 13:31:15 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55ODN2dx000567;
	Tue, 24 Jun 2025 13:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OvnCbf
	OUDiYvcGgGz0trrCaQNamMOxXGntALU8Ui+Mc=; b=iYIerZdnQkfryPBF4HS67Q
	6PJbNn2N9zP0mdXAyrv1K80BmpwR0QwQ1wmv/2Rw8PnB9EfVu2f8QtG2MzqlXLJ+
	WdlEtF/ivHJ+JTiw3IXD/nPS5+ivtGX8GIkseK3H/K6ju3dTACTggOipFYS5o/FO
	cu8HBKgPXtVSZUvfUHcn/GpPzZNDsFoywons/iOZfCml3WEpjlpT6REmjBmaS6Gt
	5H8nZXQdOt837R3pjwPOM7t/jCsBYmAjhsOTrWF5eP5jyk1xGmmOJyRH/8fUoebl
	EymQuZyXwjVOiqlLspBBkznOgde5jFfr3B+DecUkhMiRS2nyO4c4tVVzQK9AhkdA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8j8xgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:30:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55OAOZo8006397;
	Tue, 24 Jun 2025 13:30:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p479k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Jun 2025 13:30:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ODUcBY1180378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 13:30:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2A3758067;
	Tue, 24 Jun 2025 13:30:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 074EC58052;
	Tue, 24 Jun 2025 13:30:41 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Jun 2025 13:30:40 +0000 (GMT)
Message-ID: <c7abfd6f-f96e-480b-be18-b509a235aa36@linux.ibm.com>
Date: Tue, 24 Jun 2025 19:00:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head reference
 counter
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, hare@suse.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250620080257.27993-1-nilay@linux.ibm.com>
 <e0da70ca-ba39-4511-ab77-ca8b3a6a6c39@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e0da70ca-ba39-4511-ab77-ca8b3a6a6c39@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDExMiBTYWx0ZWRfX1Mn3yj9JLpQ2 aKdfipinLeLz7t4b6w+Gk8u4kUNasmh/l8EzfzGcSS5sHBULpf/8XuKNqnC8rEqPLwrOjMexVNd v7VoiRFl3wDUYI7MRV7R975s+Q5SH2xKU7TZwjFYWPOJMWFBIeyns5MQqC/hra3OizltPzdh33o
 OSGm85MX+PaEwxpmrGqQGVxgPQ735Xd0KqndOosRyLe+1yjEpocjXDCvOop4dztQk950TtdaZHL I0srehK12rq92zrUn6TQL70R3kc4oVqmYqBHzRfMq0NaazRUv36L542VfmagSDhqWztNcqu6dqF 09pvVNVpXgOtUKgFToNTzUmf43rr1kP88B3M+V6nIdoofxs6huAuSf3u4vKZXyDb73cwvIa3jFA
 UZq6nyY2GB2mQLSBENRsinF22JvnZVAXo3TIG8DeTA6+o10DZh1cyUeUmdvPU3DNX7op6nTs
X-Proofpoint-GUID: iX3yS9u7AiRLa2kkqBwHyAJSefpWRfDE
X-Proofpoint-ORIG-GUID: iX3yS9u7AiRLa2kkqBwHyAJSefpWRfDE
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685aa885 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=AeZAzyjCDDjAAwO_g7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_05,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=859 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506240112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_063114_004941_5749792E 
X-CRM114-Status: GOOD (  15.59  )
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



On 6/23/25 1:48 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Fri, Jun 20, 2025 at 01:32:43PM +0530, Nilay Shroff wrote:
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4089,6 +4089,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>  	struct nvme_ns *ns;
>>  	struct gendisk *disk;
>>  	int node = ctrl->numa_node;
>> +	bool last_path = false;
>>  
>>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>>  	if (!ns)
>> @@ -4181,9 +4182,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>>   out_unlink_ns:
>>  	mutex_lock(&ctrl->subsys->lock);
>>  	list_del_rcu(&ns->siblings);
>> -	if (list_empty(&ns->head->list))
>> +	if (list_empty(&ns->head->list)) {
>>  		list_del_init(&ns->head->entry);
>> +		last_path = true;
>> +	}
>>  	mutex_unlock(&ctrl->subsys->lock);
>> +	if (last_path)
>> +		nvme_put_ns_head(ns->head);
>>  	nvme_put_ns_head(ns->head);
> 
> Could the put moved in front of 'goto out_unlink_ns'?

I believe you would want to move the second nvme_put_ns_head()
above as the first statement under out_unlink_ns label as shown
below:

out_unlink_ns:
	nvme_put_ns_head(ns->head);
	mutex_lock(&ctrl->subsys->lock);
	list_del_rcu(&ns->siblings);
	if (list_empty(&ns->head->list)) {
		list_del_init(&ns->head->entry);
                last_path = true;
        }
	mutex_unlock(&ctrl->subsys->lock);
        if (last_path)
                nvme_put_ns_head(ns->head);

If that's the case, and this is indeed the last reference to ns->head,
then nvme_put_ns_head() could potentially free the ns->head object. 
If that happens, any access to ns->head afterward — such as ns->head->list
— would result in a use-after-free and potentially trigger a kernel oops,
correct?

Thanks,
--Nilay


