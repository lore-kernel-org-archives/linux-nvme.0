Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A9DCD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 09:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+DQ2k5qfyl9YsJL960GSvIDoOLVKhyCG+Rs8pXZQqg=; b=QZREcutz2yGVZtxmgpNOFrgk7B
	x5mDT1PZyoH+eIvrMp1yTP2uoJawUn+GE00H+XyVagkyUMlbfSx0ENZ4dhZs9+KyqkRKTPrVQ6yo+
	OT+Z8Ja57mJv2fSdKCz7zkyqYDnMFdygnL45tyZPJgo/j1oDObJEJ+Y6eT5meGn8HCpmNFdx3P7+6
	kabBjnM/5ssh7/G0nwwikHh1f7ROkROyJ5tlVddNWP+M59l6cP0/qU0DDb2TZB3f9gh3wQq5IpOIb
	OuQJkwZg9cuSmXSLc8TyjJW7Y2+UmnMC3vy0iZU6mM8k71mX3kYLtIsdFNiX7gA+uE3NS/gXfH5aY
	3gmJfUpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEyO-00000007BVS-3Bxg;
	Wed, 10 Jun 2026 09:11:44 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEyM-00000007BV6-1H1E
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 09:11:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A3gNA53233093;
	Wed, 10 Jun 2026 09:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k+DQ2k
	5qfyl9YsJL960GSvIDoOLVKhyCG+Rs8pXZQqg=; b=Yn/A5nEv/bYk12dzbf+WAZ
	086TCk0peHpTttxKbmIbjoSyAQ9El9LkBF4HNpqn0y/gKGpj0cbyS7d7v5GIDQ92
	UpvrINDxtUioVKRKb0KKYvXUchDOixnU+ZZNYAgrMa89UzFTBsTjJYoQULkwjRM/
	0xekJT9Ucico6x1SlY07hfpvOfmhWCPvq7eN8nMsUJZQXff+mbGfE3B2k23VusjC
	D/OyPEDw0F1HAQXmJbfqw8IgXJoZa7YgJwdn2VXHNOn9DfthKVY8/RPq7b8I8Gw6
	YBjjzMRUc4vFRwJfn0f9ddjLCYNpBEliPa9ITXXnH9gCJe62T8eqshiUVQ3eEXOg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj063j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:11:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8njLY023999;
	Wed, 10 Jun 2026 09:11:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jydqhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 09:11:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65A9BRnV53805382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 09:11:27 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8821E58056;
	Wed, 10 Jun 2026 09:11:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DA9958052;
	Wed, 10 Jun 2026 09:11:25 +0000 (GMT)
Received: from [9.43.34.89] (unknown [9.43.34.89])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 09:11:24 +0000 (GMT)
Message-ID: <6f7fee87-8d2b-472e-94a6-150c25c0465f@linux.ibm.com>
Date: Wed, 10 Jun 2026 14:41:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: make some sysfs diagnostic structures static
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org
References: <20260610085332.3213760-1-john.g.garry@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260610085332.3213760-1-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4NiBTYWx0ZWRfX0Rm1Dz3FgDGG
 4nrxBZ7gjP+9neD7RNGg9ofZfZh20wfC9falWLYorf7yzs63SakglvdaYTZByq77mQwD6NnZ45O
 6YG0cGOL4AYczjOA1IsJjwoHhSwtc0JQQ8AVditmDmN8jusYCBNgohHiqsk2NR96ZW2kb0Ur7Eu
 Bj3j/ZrklArPpiR9oeseTRlRq3/OTUQDVtiETl24ZFFtC5ohr3Kp1Y6Xl4k0ynax7Ujgg/fm4wf
 b7bIXdCkXr3IKExjosOjAVIgNoi0ot1YwZde/b3SfDkgFVPZbtnVd5X9YZFAKke9ZorDWFTw0J9
 0+hZguyAg+UiUKjWWOmblnpR5e5sAeNGpfgRoxPj9Rr/jmHxCfN7h7zXteh0jK6SNPOWn7Em6lX
 algM3/xHgDjSpSrjJ+taRDCogbYS8pt4gnzcj2vb2zIS8ZtQd77nxxEWYf1vHvP4oAikp9rR5qK
 z6qyRYuN5b0y6dYMIwA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a292a41 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=gNXZFrqtU8K9SO2Vi8QA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XSck9g7X40biJPTPtRnmfXtrh1YJHyuE
X-Proofpoint-GUID: XSck9g7X40biJPTPtRnmfXtrh1YJHyuE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100086
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_021142_481917_54DF06AF 
X-CRM114-Status: GOOD (  16.35  )
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

On 6/10/26 2:23 PM, John Garry wrote:
> Building with C=1 generates the following warnings:
> drivers/nvme/host/sysfs.c:397:25: warning: symbol 'dev_attr_io_errors' was not declared. Should it be static?
> drivers/nvme/host/sysfs.c:444:30: warning: symbol 'nvme_ns_diag_attr_group' was not declared. Should it be static?
> drivers/nvme/host/sysfs.c:1150:25: warning: symbol 'dev_attr_adm_errors' was not declared. Should it be static?
> 
> Make those structures static.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 933a5adfb7af5..75b2d69b59578 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -394,7 +394,7 @@ static ssize_t nvme_io_errors_store(struct device *dev,
>   	return count;
>   }
>   
> -struct device_attribute dev_attr_io_errors =
> +static struct device_attribute dev_attr_io_errors =
>   	__ATTR(command_error_count, 0644,
>   		nvme_io_errors_show, nvme_io_errors_store);
>   
> @@ -441,7 +441,7 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
>   	return a->mode;
>   }
>   
> -const struct attribute_group nvme_ns_diag_attr_group = {
> +static const struct attribute_group nvme_ns_diag_attr_group = {
>   	.name		= "diag",
>   	.attrs		= nvme_ns_diag_attrs,
>   	.is_visible	= nvme_ns_diag_attrs_are_visible,
> @@ -1147,7 +1147,7 @@ static ssize_t nvme_adm_errors_store(struct device *dev,
>   	return count;
>   }
>   
> -struct device_attribute dev_attr_adm_errors =
> +static struct device_attribute dev_attr_adm_errors =
>   	__ATTR(command_error_count, 0644,
>   		nvme_adm_errors_show, nvme_adm_errors_store);
>   
BTW, kernel test robot also reported this same issue here:
https://lore.kernel.org/oe-kbuild-all/202606101329.T3zXNqdy-lkp@intel.com/

So you may want to add closes tag pointing to the above link. Otherwise,
this change looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>



