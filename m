Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CABEC4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 06:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e5G6/ikrgLZsJqB4Rzr4+hnppcICbekVkIVxCRmZP0k=; b=Ntaw1qi2lvVQcQk2bnb2a7fKpA
	7GNvMCoyAta8lveQfGJ6trUSGFXhOnr7TO5hxFozeQZRzag+fH0FOxpcRlJLWX+Wsh4UrKqSy9uhb
	lanreDv+jHjfbtO2GySS53lNaRkYE8QD7eBNKWN4QpMAfDXtvEQQZXSbvoRNekO3D0P1BlPWlGctg
	e9+PBB5eq/1WP/6w0y1z5bYPz2U7NNj8FVe+ZtBtRSa047/nKs0aYMD11juJRYca7QvcCpCXpotB0
	3uyWI0VqcbzBw/DL8xd8D0iU4NrcUqXEQX9unNLv+DZjFIngOuTsqcs7TCerpUL9QD3RtirZATGT6
	+01hoHpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcgy-0000000B9Bj-3blu;
	Tue, 16 Apr 2024 06:53:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcgw-0000000B9B8-00Z1
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 06:53:19 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G6f0aT010188;
	Tue, 16 Apr 2024 06:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=e5G6/ikrgLZsJqB4Rzr4+hnppcICbekVkIVxCRmZP0k=;
 b=K0Ir3weC1KdzDUgmvBb7e8e4yglwro0zD+jZ8hRAAVPYel/OExOc7GKjz9tQ+y41LZxg
 q9M/WXxkM8SGhKomb4uzUJhFsnaOR+MmteEuz7HKNHECStN7cXANoWRwOwVuHtU7YIGg
 6gNZg08nr0qEkCpnBd3mJToXuJa7MppE27CLsjeI/AsG/M8Tx2/cjDX4SUmaK3l6cbEZ
 T30NLcG+gpnxjgS1J5irTHPvd3fOVkCldssWj+PnOFVqZyLxok1q+GgPL3VgX4DWSGIs
 Zyap80ZotGFWS25xGB4Yfvn3WPGaP0Tj2sSMDN24bLoUrN8o90SADPWlRz3e/fxcqAw6 pg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhkmqg2x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:53:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G51vk6018152;
	Tue, 16 Apr 2024 06:53:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ct4sy4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 06:53:08 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43G6r5uf26608142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 06:53:07 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5583958043;
	Tue, 16 Apr 2024 06:53:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C202A58068;
	Tue, 16 Apr 2024 06:53:02 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Apr 2024 06:53:02 +0000 (GMT)
Message-ID: <391005cb-2a3d-426e-b539-30faf23c6efc@linux.ibm.com>
Date: Tue, 16 Apr 2024 12:23:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: find numa distance only if controller has valid
 numa id
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        "axboe@fb.com" <axboe@fb.com>
References: <20240415142408.889236-1-nilay@linux.ibm.com>
 <a31a6787-16cb-4dfb-afa4-f24d66faab3f@nvidia.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a31a6787-16cb-4dfb-afa4-f24d66faab3f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zJbOTjjmKM1KkBNdVZIatD7HX7d3Weqn
X-Proofpoint-ORIG-GUID: zJbOTjjmKM1KkBNdVZIatD7HX7d3Weqn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_04,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160040
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_235318_147004_A9186005 
X-CRM114-Status: GOOD (  23.23  )
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



On 4/16/24 08:06, Chaitanya Kulkarni wrote:
> On 4/15/24 07:22, Nilay Shroff wrote:
>> On system where native nvme multipath is configured and iopolicy
>> is set to numa but the nvme controller numa node id is undefined
>> or -1 (NUMA_NO_NODE) then avoid calculating node distance for
>> finding optimal io path. In such case we may access numa distance
>> table with invalid index and that may potentially refer to incorrect
>> memory. So this patch ensures that if the nvme controller numa node
>> id is -1 then instead of calculating node distance for finding optimal
>> io path, we set the numa node distance of such controller to default 10
>> (LOCAL_DISTANCE).
>>
>> Link: https://lore.kernel.org/all/20240413090614.678353-1-nilay@linux.ibm.com/
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>> Changes from v1:
>> 	Formatting cleanups (Christoph)
>>
>>   drivers/nvme/host/multipath.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 5397fb428b24..08e598c87b08 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -247,7 +247,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>>   		if (nvme_path_is_disabled(ns))
>>   			continue;
>>   
>> -		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>> +		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
>> +				READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> 
> unless something is wrong when I apply this patch, above line should be
> kept under 80 char ?
> 
> something like following totally untested :-
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 5397fb428b24..d16e976ae1a4 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -247,7 +247,8 @@ static struct nvme_ns *__nvme_find_path(struct 
> nvme_ns_head *head, int node)
>                  if (nvme_path_is_disabled(ns))
>                          continue;
> 
> -               if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> +               if (ns->ctrl->numa_node != NUMA_NO_NODE &&
> +                   READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>                          distance = node_distance(node, 
> ns->ctrl->numa_node);
>                  else
>                          distance = LOCAL_DISTANCE;
> 
> -ck
> 
> 
I don't know but checkpatch.pl didn't complain about my patch overshooting 
80 chars width. Anyways, I will reformat the patch and resend.

Thanks,
--Nilay



