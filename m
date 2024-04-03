Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5E4CD128A
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 13:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3BQsk9snaGgx5IDIlud3UGCuJDQCK0QVJNDAnVZd8g=; b=1y8nylA8zHxA9dhRHKHK1TPxxe
	wV9tDcUs+Gznchh4q7i7MNaUrD1RaRkia5nMPmVxWaTsKO125cFYooK8sobHR6ftnEzuXjIFlhwzY
	OVeDGGdiFIEKV7orjpp5iwvtZjC8Fmx3ji9d35gmHRIqXCrS2i8qwK9JBJpAKuUhRneE6sNe4mVKo
	Mr9pBoQR5JKq5Tp31m5IecYqnpX8p9HvhGf5mYrkva5gwO4PbLYeOqtyYNNSIjAYv/z/pID0aAmWM
	0NOPRr7BOVP/rQ06LzJHr+Kh3OnN/RM/SQsyHTOJVBKeGZ7+4nOSjqemdwFQ7BblPi9bvqPcdFhF3
	O1j7tOSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0qi-0000000GGN6-20t2;
	Wed, 03 Apr 2024 13:40:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs0qe-0000000GGKc-1juk
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 13:40:18 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433DUTZ0004293;
	Wed, 3 Apr 2024 13:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=j3BQsk9snaGgx5IDIlud3UGCuJDQCK0QVJNDAnVZd8g=;
 b=HICciaNHdkTJH+Pn/63csQ46Mp8hYxb8+RW25k4OKKvSQNz1IkEdQMGPpr+WB1IoQayx
 3KCm55lSG/WGXrQXHViQiF5WzvVTsLIg29KEvcLc41SONLUVM55SMbILrPVN9W/cAHr8
 aOYrrw3yqAnsczDq34kxMMfgegrUllXAl4TV9QvC8fjHmxbzK5Zs4XOziGugJLakaoC7
 9D4yuTWZwBGkCR30lkJFyZMu78zOa3RpZsR6vRZo/+A9wD9HaHOM1KFkOMl4ZCWqllHV
 wIRlQFOAXnhY10dbOdzF+yOLmJZcw8pdVqM0zPsiybCOtsQVqgvuLc+lq/RbeLPm/fyU nA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9828g0yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:40:08 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433AcYJj008422;
	Wed, 3 Apr 2024 13:40:07 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2u5twu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 13:40:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433De4Qo9437890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 13:40:06 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7E85805C;
	Wed,  3 Apr 2024 13:40:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C146F58062;
	Wed,  3 Apr 2024 13:40:02 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 13:40:02 +0000 (GMT)
Message-ID: <77737b7f-8056-4e6f-861e-97e7834ff741@linux.ibm.com>
Date: Wed, 3 Apr 2024 19:10:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't create a multipath node for zero capacity
 devices
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, Gregory Joyce <gjoyce@ibm.com>
References: <20240403124717.931577-1-hch@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240403124717.931577-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: aLpLYKq1DmScHcEbNq_fiN1ijtEtJBPk
X-Proofpoint-GUID: aLpLYKq1DmScHcEbNq_fiN1ijtEtJBPk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_12,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_064016_620247_7B31B2CB 
X-CRM114-Status: GOOD (  23.26  )
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



On 4/3/24 18:17, Christoph Hellwig wrote:
> Apparently there are nvme controllers around that report namespaces
> in the namespace list which have zero capacity.  Return -ENXIO instead
> of -ENODEV from nvme_update_ns_info_block so we don't create a hidden
> multipath node for these namespaces but entirely ignore them.
> 
> Fixes: 46e7422cda84 ("nvme: move common logic into nvme_update_ns_info")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3b0498f320e6b9..ad60cf5581a419 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2089,7 +2089,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  	if (id->ncap == 0) {
>  		/* namespace not allocated or attached */
>  		info->is_removed = true;
> -		ret = -ENODEV;
> +		ret = -ENXIO;
>  		goto out;
>  	}
>  	lbaf = nvme_lbaf_index(id->flbas);
I have tested patch on my controller with zero capacity namespaces.
This looks good and fixing the issue reported here: 
https://lore.kernel.org/all/c0750d96-6bae-46b5-a1cc-2ff9d36eccb3@linux.ibm.com/

Tested-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks,
--Nilay

