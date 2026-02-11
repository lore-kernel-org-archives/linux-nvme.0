Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE289EB596B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 07:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tVeBcd15Nr/lYHQPoIK7MUPZrIaiLLh1fg8rsMVWypk=; b=vuETo3mqfb7opTKIYYFgM1GVAU
	KvYCrwVC6j6MBpiqaFyVaPyHVA/1ilIETMYqxK1Eq+VvTYUnpj/MmgangfkAP2PUkU0zpoqqVRazf
	bDEAjTwaRAOH3Yk/yuHnZLlcCKlXMi9YA0NoQHxddHhXYFkfTJVQsyNVMQN7fERDYBQIGpmxiiZcS
	N/Q+DX67/oj89t2Pa+Z8e5AqBghk+VZ9L+rAlz2rwOAjweqv5hi5Yf/bNQpVjYRBSRfkDGudd9yeI
	YklXAE/KUgnreUOxIjJRAfzalJDAY/PDUS7eOoNs0eJZfBVxWlpj05MjLr4Giqj+Wh56be50VmRyR
	8aM32oyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4XU-00000000KPt-2aAZ;
	Wed, 11 Feb 2026 07:21:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vq4XQ-00000000KPU-3k8J;
	Wed, 11 Feb 2026 07:21:30 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AHJqph3145172;
	Wed, 11 Feb 2026 07:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tVeBcd
	15Nr/lYHQPoIK7MUPZrIaiLLh1fg8rsMVWypk=; b=WtEKjO89JiE0MQ4uCyE697
	+hfOWvkm+Q/N2A6zFBhMpw5Iac7CW3j7mysqmPdBVBzIkX9DjVKHiN/ho08GaukF
	5TPKEMVhDn4UT49lcQw6OeyglkSqmGQYxkfRLgpR7y8FR6TMxXTTSF3D7YndLPdl
	z2XXWoEmi8lg6EUqXWLIDQSn+EfbJRlUpShlHQP3/DMdPM4N408q/FBAlboHWtms
	7jYmpBystaFU8AcOwBMGP6KKqeDi4ejN1ohSexKSrjyYyGtUmYE+KmZSgLMKQgyt
	MlJZufdWoI8V6N+fGgYhZG1bvbzuf6kP49NirdYjcgt/Bi+ifhu2MNk5fB9VygQw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v5jcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:20:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61B4bonm012610;
	Wed, 11 Feb 2026 07:20:52 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6h7kcqj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Feb 2026 07:20:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61B7KpTM14615122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Feb 2026 07:20:52 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ED075805C;
	Wed, 11 Feb 2026 07:20:51 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A764358062;
	Wed, 11 Feb 2026 07:20:43 +0000 (GMT)
Received: from [9.111.95.190] (unknown [9.111.95.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Feb 2026 07:20:42 +0000 (GMT)
Message-ID: <f5da8810-84cd-408b-a1e6-8e80c8578168@linux.ibm.com>
Date: Wed, 11 Feb 2026 12:50:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs
 file creation
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, sven@kernel.org, j@jannau.net,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: tj@kernel.org, ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-5-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260209082953.3053721-5-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FlcRqaD5j4-TxqEFZe63x4QhMoW6Obeo
X-Proofpoint-ORIG-GUID: FlcRqaD5j4-TxqEFZe63x4QhMoW6Obeo
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698c2dd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=r8Y53hCUo0QDHyeveBkA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDA1OCBTYWx0ZWRfX+UHbHzSWb7sl
 pGtScLZRicf3aGugnqzbVjXe+OENcCfIF3W4qIAk46692uGrCydXtI7cJg//bXsvSxNhfDlqFBM
 KuZ7lXi59NOlSLr46bF9wbtC5572QFijotW89tJFDBKvpYGMTUlWKwy207RvfBx/Ouz4YY4juD+
 Ilck9DAcsseIfEcJCDAWEcwvHO7sECdILvIaYqNofjrVn2QxoISKCq5O2AMpWqOsF6EZ6ag6wVA
 KpsEi/zjawWIPbdGcKf1++0oNVHpoH/oV5+U7JTAxZATf6zYMwnr/Bz6CDztf1zYGN2K5+Z78qw
 agofRXEVDTBY/ZtBsAv/42DUg4Msai4bYme/LCRIMYvR+ppJhyZFatnsmLHvqzmMR3fnLV4rsB0
 d3loVquzkGGTtJzAHTTB9dKGhcDhKFE/P4T8T7T+6uUK0RamueyFX4vOn2iJzh2ZaoTB5Ol4yh0
 ZjvZe9m/6EfNr2Yujww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_232129_086374_71B78E6E 
X-CRM114-Status: GOOD (  18.84  )
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



On 2/9/26 1:59 PM, Yu Kuai wrote:
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index faeaa1fc86a7..03583d0d3972 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>  				 const struct blk_mq_debugfs_attr *attr)
>  {
>  	lockdep_assert_held(&q->debugfs_mutex);
> -	/*
> -	 * Creating new debugfs entries with queue freezed has the risk of
> -	 * deadlock.
> -	 */
> -	WARN_ON_ONCE(q->mq_freeze_depth != 0);
>  	/*
>  	 * debugfs_mutex should not be nested under other locks that can be
>  	 * grabbed while queue is frozen.
> @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
>  	if (IS_ERR_OR_NULL(parent))
>  		return;
>  
> +	/*
> +	 * Avoid creating debugfs files while the queue is frozen, wait for
> +	 * the queue to be unfrozen and prevent new freeze while creating
> +	 * debugfs files.
> +	 */
> +	if (blk_queue_enter(q, 0))
> +		return;
> +
>  	for (; attr->name; attr++)
>  		debugfs_create_file_aux(attr->name, attr->mode, parent,
>  				    (void *)attr, data, &blk_mq_debugfs_fops);
> +
> +	blk_queue_exit(q);
>  }
>  
>  void blk_mq_debugfs_register(struct request_queue *q)

I also noticed that we use other debugfs helpers such as debugfs_create_dir()
from some block paths, which could run into the same fs-reclaim recursion issue.
So we may need to consider those call sites as well to ensure consistent handling.

On another note, instead of waiting for queue to be unfreezed, does it makes sense to
wrap the debugfs code under NOIO context (as Christoph pointed in another thread)?
IMO, if fs-reclaim recursion is the only issue here we would be better off using
NOIO context instead of blocking for queue to be unfrozen from other contexts.

Thanks,
--Nilay


