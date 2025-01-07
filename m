Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E329E77198
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 06:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KpHXMOm+9p/COV0RdgDfwai744BO7sKjXnaTUC9X0uo=; b=nE+BMDqlgURfrmopuGKKrcSUPd
	79v3B2V9cAz4yuVb6LX8IT9bqAdWpHEzWY/otlI4/HXrteoVueyoD7Pv3WcIxWzmbu0XcsEy4ck9Z
	p6BE03sjbR2DTZcKGYA+AlKEGrJoyLpeoJh2tK0a9MzUC9wCw7Ublt8NgBLveMXUFc2bvC3DAAd4F
	KsG32gPFdqJfDptobgTs0lo10vk64F8gg/6dVOHHinTAqx59OAtZesPND8U4Lq4D1zTJIuDRNuLdw
	E/AQjFqORq4vLmUGUFD87D1Qa6C0hnRQLJGb0ADwB+3wg4/a0p5rObM4mJw12zdNzEKxYXpkxVZS1
	mFcvPdvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV3Y1-00000003hVs-3fag;
	Tue, 07 Jan 2025 06:58:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV3Xz-00000003hV1-304f
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 06:58:40 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506NwAfp022105;
	Tue, 7 Jan 2025 06:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KpHXMO
	m+9p/COV0RdgDfwai744BO7sKjXnaTUC9X0uo=; b=BLJTkUOslJSkfwnep9sLve
	9amCSDaeDT06kf+Kj3t58BXFmfZj4S8ucCZvlA8HUscaqbz0aS7w6kWOFRrWTXc3
	5K2QLZzKlpW8NYKVp9J1UsIlpjjxUKTkHEse4ITI0c67wat4YOrUNSsg8WMcAvc0
	upTHlwY/cUOrkNj7zV4wqCINWKndHUKSu/EyFo0ejCwYTO5z3LDaW70J5rqEwtzH
	hyh7RnmavAcmRsB+VXXuFf6WhzRMv4aVI49gElRzAXIDsQuMehc+9j9syvJg4UT/
	d/5GbNSfykf8TYS8D2S11OTXCSPf+G+VVlCMjOEqfHUeAGakr5QqWdxU6nWnEv5g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440sahhcv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 06:58:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5073hxua003572;
	Tue, 7 Jan 2025 06:58:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat1f3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 06:58:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5076wXt224969974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 06:58:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81A3F58056;
	Tue,  7 Jan 2025 06:58:33 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88B325805A;
	Tue,  7 Jan 2025 06:58:30 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 06:58:30 +0000 (GMT)
Message-ID: <96c48ba0-3db5-4504-a456-e57440aa1b56@linux.ibm.com>
Date: Tue, 7 Jan 2025 12:28:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-7-hch@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250107063120.1011593-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kNDX2K_hOJmEPH2iCzn3cqGxjK01fk3U
X-Proofpoint-ORIG-GUID: kNDX2K_hOJmEPH2iCzn3cqGxjK01fk3U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_225839_764516_80B26832 
X-CRM114-Status: GOOD (  21.44  )
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



On 1/7/25 12:00 PM, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock.
> 
> Unlike most queue updates this does not use the
> queue_limits_commit_update_frozen helper as the nvme driver want the
> queue frozen for more than just the limits update.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2250ddef5a2..1ccf17f6ea7f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2128,9 +2128,10 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
>  	struct queue_limits lim;
>  	int ret;
>  
> -	blk_mq_freeze_queue(ns->disk->queue);
>  	lim = queue_limits_start_update(ns->disk->queue);
>  	nvme_set_ctrl_limits(ns->ctrl, &lim);
> +
> +	blk_mq_freeze_queue(ns->disk->queue);
>  	ret = queue_limits_commit_update(ns->disk->queue, &lim);
>  	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>  	blk_mq_unfreeze_queue(ns->disk->queue);

I think we should freeze queue before nvme_set_ctrl_limits(). 

> @@ -2177,12 +2178,12 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  			goto out;
>  	}
>  
> +	lim = queue_limits_start_update(ns->disk->queue);
> +
>  	blk_mq_freeze_queue(ns->disk->queue);
>  	ns->head->lba_shift = id->lbaf[lbaf].ds;
>  	ns->head->nuse = le64_to_cpu(id->nuse);
>  	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
> -
> -	lim = queue_limits_start_update(ns->disk->queue);
>  	nvme_set_ctrl_limits(ns->ctrl, &lim);
>  	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
>  	nvme_set_chunk_sectors(ns, id, &lim);
> @@ -2285,6 +2286,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		struct queue_limits *ns_lim = &ns->disk->queue->limits;
>  		struct queue_limits lim;
>  
> +		lim = queue_limits_start_update(ns->head->disk->queue);
>  		blk_mq_freeze_queue(ns->head->disk->queue);
>  		/*
>  		 * queue_limits mixes values that are the hardware limitations
> @@ -2301,7 +2303,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  		 * the splitting limits in to make sure we still obey possibly
>  		 * lower limitations of other controllers.
>  		 */
> -		lim = queue_limits_start_update(ns->head->disk->queue);
>  		lim.logical_block_size = ns_lim->logical_block_size;
>  		lim.physical_block_size = ns_lim->physical_block_size;
>  		lim.io_min = ns_lim->io_min;


