Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE28ACD5BAC
	for <linux-nvme@archiver.kernel.org>; Sat, 23 May 2026 18:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ZoVYhptMmz0YE2dBZtksztH+TTxndTDvkJxDgStbFo=; b=GCanlQcd9NzfMNoocNcyBqSnXR
	NJMNot/Tnm6bvNOLz5JMM1oUoLh4Nt6MtK7Rm5X1a7NRWo8wEfpQtREh0Z7NDms8hrLAkwOrzjXBk
	xI1K637poo5Z3/r6G6MeFyhnQ9jef+4fqvikpkF3H7EhXeDrVIOJ0k7x/2RZzS+uAc+Mz15e/mspi
	peqA0ZBA/JLQpDZT4iYp6NPok/c7LATaq0RTL7SzY2nD83fhJIHTPIdcZEzfhK6j3SjNYpgznQuM+
	oRJog+lPgYuC/tQXtsDRm4Yf0+bawzw4LXhEq6drjjKgS3miPO3rTp8jPitBxOEOx/dFw3utneotl
	o5nhsIHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQrUc-0000000Dkmh-1kYU;
	Sat, 23 May 2026 18:54:38 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQrUY-0000000Dklk-18hr
	for linux-nvme@lists.infradead.org;
	Sat, 23 May 2026 18:54:37 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N8tdau2651203;
	Sat, 23 May 2026 18:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+ZoVYh
	ptMmz0YE2dBZtksztH+TTxndTDvkJxDgStbFo=; b=mxQ47kh7S9g0Ut8GNZ9W9h
	tmB3YIMOatzZR35lDoTXgqmTmqG7OuU7XytQLoHISSzfmBlVNalVgQryJxFplmKR
	HZq9XwDtTCyyQK3Q+J3HNGJeQrdhq4FfZP6zcANnrk4rSeEOv4Wvwwbf5J06Yb+N
	wcTbcILxfc8kGoewDThfPt5U/bpruQ7Va9YSsiJy/n38+kckSPgqs17uJL9HU0ro
	87zqq2ODZZPBRoFr/Y64GBe1s5WEVMJgwllW3KSw4s8INyC5Pnj0nOEJTYW6xrex
	U8G99TJzzjCeRi/4O9DlBTPx9wEgvPFCBevMpQeIoUQ2ySN6nVPseltQ848w2KnA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4npsq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64NIs5o5020843;
	Sat, 23 May 2026 18:54:29 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eb49025n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 May 2026 18:54:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64NIsSJa28836368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 18:54:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E50B58056;
	Sat, 23 May 2026 18:54:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1F658052;
	Sat, 23 May 2026 18:54:26 +0000 (GMT)
Received: from [9.61.182.56] (unknown [9.61.182.56])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 23 May 2026 18:54:26 +0000 (GMT)
Message-ID: <a5c5a183-a846-4fac-ab18-fd957bac6c20@linux.ibm.com>
Date: Sun, 24 May 2026 00:24:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block, nvme: export and use passthrough stats
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20260522151537.1509784-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260522151537.1509784-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rT2lyHpQL3X7_M4X440TRPGbMS3fJkXK
X-Proofpoint-ORIG-GUID: rT2lyHpQL3X7_M4X440TRPGbMS3fJkXK
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a11f7e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=E1viyzfc2PkgsqfBwtAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDE5MCBTYWx0ZWRfX0UX6Rh++txXW
 a2B776bgDeQdu9LLRlWTg+c2qXcYGgV4uthX1PPnIfGnOkmzVrKM82szRFQgXmoY3mJgdPYMjsS
 1QnNVqM3dQjIy0EMFZEtsY5EQjSerE7TwMjAWHVfbcvUjhQ9FGwBqpcx1B5bvTxecs3GpuVipXs
 KxhKv4XMxulhncKuAW6ASOTpb1vZNHuEfBryVQ9RtatY2r9xdilIH4u13o8sOwqfoloUtsygNSF
 zf4kGbIxRaB+9S9leuIVlxLvWTuXDj7w0P628QtlRvtQLVg89AtslsCi44yxDN/HRcgb81bNuP0
 2NN8dKplNMR8YcEmO6HQHtzss1DZpuqyLL7aQqdBHPwwfckGz7jMMVG2wIAKsfGvx4bY7iUiupF
 QxI+9ffij8z9rSBloGvoAfIMjtk2xX71lwBKspBwCYLdga6BkebimkLMmDXkzOBapuULH+VpooA
 Mi4Kb2rS1kkFbXi7lmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605230190
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260523_115434_442397_485D1E50 
X-CRM114-Status: GOOD (  13.63  )
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

On 5/22/26 8:45 PM, Keith Busch wrote:
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 263161cb8ac06..435fab0be6401 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -175,9 +175,11 @@ void nvme_mpath_start_request(struct request *rq)
>   		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>   	}
>   
> -	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
> +	if (!blk_queue_io_stat(disk->queue) ||
>   	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
> +	if (blk_rq_is_passthrough(rq) && !blk_rq_passthrough_stats(rq))
> +		return;
>   
>   	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
>   	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),

Thanks for this patch! It will be very useful for nvme top dashboard for
displaying passthru I/O stat under head node.

Well, I see an issue here with @rq being passed to blk_rq_passthrough_stats()
as the @rq->q points to nvme path queue object rather than the head node queue
object. The intention here is to account passthrough I/O statistics at the
head node level, but with the current implementation the decision depends
on the path queue's iostats_passthrough setting instead of the head queue's
setting. As a result, head-node passthrough I/O statistics may get accounted
based on whether the underlying path queue has iostats_passthrough enabled,
irrespective of the head queue configuration.

Another issue is that nvme_mpath_start_request() is only reached from
nvme_start_request() when REQ_NVME_MPATH is set. Normal bio based I/O
through the head gets that flag in nvme_ns_head_submit_bio(), but the
passthrough ioctl/uring path in the quoted patch does not set it. So
head passthrough I/O would not enter nvme_mpath_start_request() and
would not get head-node stats.

Thanks,
--Nilay

