Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D41C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 05:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrMrgxptaW3L+rjHrP1yFlkiEVOJShrICLuowVANElk=; b=lCB7OGoJAwIzj15a5Te1lX0CFS
	PEBUoGOtRbaNgxd2OYO6e2ctSj8YNw/8Lika0ozLO6nf+6rk7GSRs5Vsdp+QTHfF+JcKGZ5A/uN+/
	9KmQwQ7SIEycHEMwqaJuM2rRfCJtqaRbF+B4GrPHNj2jyYpuYfQI4nE2+aCEF5NR2NTE6O20o/2P9
	TON5gKPhZR+my2sbvngf7jRS7U4OOZH3XYT1TbYNon3F6oqUT8xROVpW0oSzSNmML8J0fD7o2+7Rz
	iXVN7qOmQdI2RGdjl9HU0uukO0HHJufI42M5dhhIT92TfGjID73rJ48jWnn7EykjfCGCxGgysViLG
	a4zuxjTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXFP-00000005oDJ-0GMV;
	Fri, 22 Mar 2024 05:15:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnXFM-00000005oCM-3fBC
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 05:15:18 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42M4G8IG022198;
	Fri, 22 Mar 2024 05:15:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RrMrgxptaW3L+rjHrP1yFlkiEVOJShrICLuowVANElk=;
 b=r4HsVNe8f3qg2GOybuofqoYIl1GnGqh55/ZyTwpP7ZqGYYzRYRiKwuMjmnUPgijPF41Q
 ebx4e8q598Ie3J1qUzIB1M/haj/dqxj76jw9e9XtIpY7wu2UhhCKtGC25/m4+fDwJA0Y
 FzBESsu+YyMvvIr963KNhXbbVBoudO8qH/4S6a9TRj6Mcs2qzDguTQCU8r8+E5f/P7/0
 44yUAfegJmcCq7KYRliv1SkRnqk1GpLdult2DERk69plJTb3eEYoVjFX1kWfCsJboG+D
 KbZsOtAQmfI1TJ31vwsatXrS1R6l8IAR+yMFibjdL4rTqr/Itg3+U3odJKKwPiUyRBy6 OA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x10s9gacq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:15:11 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42M2DcV9026714;
	Fri, 22 Mar 2024 05:15:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x0x171ng8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 05:15:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42M5F8je40894908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 05:15:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F204A58059;
	Fri, 22 Mar 2024 05:15:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1785C58055;
	Fri, 22 Mar 2024 05:15:06 +0000 (GMT)
Received: from [9.109.198.202] (unknown [9.109.198.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Mar 2024 05:15:05 +0000 (GMT)
Message-ID: <2c89c1d8-d3d1-40ca-9e3a-48697ddc042b@linux.ibm.com>
Date: Fri, 22 Mar 2024 10:45:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: don't inherit LBA-related fields for the
 multipath node
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com
References: <20240321210819.1246749-1-hch@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240321210819.1246749-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MPghqTIwx-vWXm6lLqIi7-iB4I57GpNU
X-Proofpoint-GUID: MPghqTIwx-vWXm6lLqIi7-iB4I57GpNU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_01,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403220034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_221516_959619_7B8D70A9 
X-CRM114-Status: GOOD (  32.92  )
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



On 3/22/24 02:38, Christoph Hellwig wrote:
> Linux 6.9 made the nvme multipath nodes not properly pick up changes when
> the LBA size goes smaller after an nvme format.  This is because we now
> try to inherit the queue settings for the multipath node entirely from
> the individual paths.  That is the right thing to do for I/O size
> limitations, which make up most of the queue limits, but it is wrong for
> changes to the namespace configuration, where we do want to pick up the
> new format, which will eventually show up on all paths once they are
> re-queried.
> 
> Fix this by not inheriting the block size and related fields and always
> for updating them.
> 
> Fixes: 8f03cfa117e0 ("nvme: don't use nvme_update_disk_info for the multipath disk")
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 00864a63447099..4bac54d4e0015b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2204,6 +2204,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  	}
>  
>  	if (!ret && nvme_ns_head_multipath(ns->head)) {
> +		struct queue_limits *ns_lim = &ns->disk->queue->limits;
>  		struct queue_limits lim;
>  
>  		blk_mq_freeze_queue(ns->head->disk->queue);
> @@ -2215,7 +2216,26 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
>  		nvme_mpath_revalidate_paths(ns);
>  
> +		/*
> +		 * queue_limits mixes values that are the hardware limitations
> +		 * for bio splitting with what is the device configuration.
> +		 *
> +		 * For NVMe the device configuration can change after e.g. a
> +		 * Format command, and we really want to pick up the new format
> +		 * value here.  But we must still stack the queue limits to the
> +		 * least common denominator for multipathing to split the bios
> +		 * properly.
> +		 *
> +		 * To work around this, we explicitly set the device
> +		 * configuration to those that we just queried, but only stack
> +		 * the splitting limits in to make sure we still obey possibly
> +		 * lower limitations of other controllers.
> +		 */
>  		lim = queue_limits_start_update(ns->head->disk->queue);
> +		lim.logical_block_size = ns_lim->logical_block_size;
> +		lim.physical_block_size = ns_lim->physical_block_size;
> +		lim.io_min = ns_lim->io_min;
> +		lim.io_opt = ns_lim->io_opt;
>  		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
>  					ns->head->disk->disk_name);
>  		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);

I had tested the above patch from Christoph and it looks good.

Test results could be found here: 
https://lore.kernel.org/all/239228ec-6c8d-432c-905d-b477014deee3@linux.ibm.com/

Thanks,
--Nilay


