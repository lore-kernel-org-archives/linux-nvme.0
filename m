Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF7E77188
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Jan 2025 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WD2d7xyX6tq18qWFDmiwpNZfKZWynPyaVB1Cjq/OlWk=; b=10dIfImq37zIOmpuhBQxqJ5JY4
	74KPqkCUIEHuojrZ+KqEwzVEdxaRqjypmHWlBkzED5naowEyfhfOve90SQUoxQBeiRCGfVur21Wtl
	16vpNsjkHJncaEWRZ9+i4TtgS5xzRcrWNQ1R+CRVN6LaVs7JgdQQQKCObIuLd/a2nFWmSDWQLIqwH
	67CgsixmqMtLtFbM3LS+914q5k/0i218D7kKX/g37bOZZLS2m+5iaKtaznNYtcQtxzRZdpDAP/YHN
	9DSKmR6o+Rg5/EOlacwD+2LUGyQgm8gtScD/dSLkZMUhD3Loaq8gUu+6wek16fHkepUiYIzF4vP4m
	axgNpC3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tU6z1-0000000FGTT-18mc;
	Sat, 04 Jan 2025 16:26:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tU6yz-0000000FGSi-0HSM
	for linux-nvme@lists.infradead.org;
	Sat, 04 Jan 2025 16:26:38 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 504AhxQI013932;
	Sat, 4 Jan 2025 16:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WD2d7x
	yX6tq18qWFDmiwpNZfKZWynPyaVB1Cjq/OlWk=; b=l+1htDWx5pYYzwTX6l85xK
	wUyvOx6rgLsbHEgtUim0Jv4+4MZBT8f4JOaTQp4k6QuZQLkfXGrG9fPkawN1Csk1
	GZBnxoq/FtB2j5AntStUnVHgaU19OI6nftcauIToMWo31x8MpT84SNE1U/kat07t
	llMJfPsoUSfgny9UB1eGVs4fSI4l3EI8uH+hv+jbnUgz3Bk/JJJTQyrbtuTs7R7v
	rwmPPEudLWIN8eaOxlTCL9a3nY3ZCpi62zgxYDMfzOgKzTq+xA6yk9+PYrt08nCa
	ZUgqxz6YiUSz0cL3wcIHdfgQXI49n/BZU6GIKJsfTglclgPGOQEfuSqWmXK7Es7g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xwfb9nw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Jan 2025 16:26:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 504Dn65D016708;
	Sat, 4 Jan 2025 16:26:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tw5ktw12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Jan 2025 16:26:18 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 504GQIbM26804756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 4 Jan 2025 16:26:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0772358055;
	Sat,  4 Jan 2025 16:26:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8303458043;
	Sat,  4 Jan 2025 16:26:15 +0000 (GMT)
Received: from [9.171.91.57] (unknown [9.171.91.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  4 Jan 2025 16:26:15 +0000 (GMT)
Message-ID: <977ab809-ba06-4537-b568-cc25f56b5b7a@linux.ibm.com>
Date: Sat, 4 Jan 2025 21:56:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250104132522.247376-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ShOvUFRYE3DlLhYdwVPEZxwNXQLJ-QLl
X-Proofpoint-GUID: ShOvUFRYE3DlLhYdwVPEZxwNXQLJ-QLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 suspectscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501040141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250104_082637_142931_E489CFB1 
X-CRM114-Status: GOOD (  34.94  )
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



On 1/4/25 6:55 PM, Damien Le Moal wrote:
> queue_attr_store() always freezes a device queue before calling the
> attribute store operation. For attributes that control queue limits, the
> store operation will also lock the queue limits with a call to
> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
> need to issue commands to a device to obtain limit values from the
> hardware with the queue limits locked. This creates a potential ABBA
> deadlock situation if a user attempts to modify a limit (thus freezing
> the device queue) while the device driver starts a revalidation of the
> device queue limits.
> 
> Avoid such deadlock by introducing the ->store_limit() operation in
> struct queue_sysfs_entry and use this operation for all attributes that
> modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
> definition. queue_attr_store() is modified to call the ->store_limit()
> operation (if it is defined) without the device queue frozen. The device
> queue freeze for attributes defining the ->stor_limit() operation is
> moved to after the operation completes and is done only around the call
> to queue_limits_commit_update().
> 
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>  block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
>  1 file changed, 64 insertions(+), 59 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 767598e719ab..4fc0020c73a5 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -24,6 +24,8 @@ struct queue_sysfs_entry {
>  	struct attribute attr;
>  	ssize_t (*show)(struct gendisk *disk, char *page);
>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
> +	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
> +			       const char *page, size_t count);
>  	void (*load_module)(struct gendisk *disk, const char *page, size_t count);
>  };
>  
> @@ -154,55 +156,46 @@ QUEUE_SYSFS_SHOW_CONST(write_same_max, 0)
>  QUEUE_SYSFS_SHOW_CONST(poll_delay, -1)
>  
>  static ssize_t queue_max_discard_sectors_store(struct gendisk *disk,
> -		const char *page, size_t count)
> +		struct queue_limits *lim, const char *page, size_t count)
>  {
>  	unsigned long max_discard_bytes;
> -	struct queue_limits lim;
>  	ssize_t ret;
> -	int err;
>  
>  	ret = queue_var_store(&max_discard_bytes, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (max_discard_bytes & (disk->queue->limits.discard_granularity - 1))
> +	if (max_discard_bytes & (lim->discard_granularity - 1))
>  		return -EINVAL;
>  
>  	if ((max_discard_bytes >> SECTOR_SHIFT) > UINT_MAX)
>  		return -EINVAL;
>  
> -	lim = queue_limits_start_update(disk->queue);
> -	lim.max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> -	err = queue_limits_commit_update(disk->queue, &lim);
> -	if (err)
> -		return err;
> -	return ret;
> +	lim->max_user_discard_sectors = max_discard_bytes >> SECTOR_SHIFT;
> +
> +	return count;
>  }
>  
>  static ssize_t
> -queue_max_sectors_store(struct gendisk *disk, const char *page, size_t count)
> +queue_max_sectors_store(struct gendisk *disk, struct queue_limits *lim,
> +			const char *page, size_t count)
>  {
>  	unsigned long max_sectors_kb;
> -	struct queue_limits lim;
>  	ssize_t ret;
> -	int err;
>  
>  	ret = queue_var_store(&max_sectors_kb, page, count);
>  	if (ret < 0)
>  		return ret;
>  
> -	lim = queue_limits_start_update(disk->queue);
> -	lim.max_user_sectors = max_sectors_kb << 1;
> -	err = queue_limits_commit_update(disk->queue, &lim);
> -	if (err)
> -		return err;
> -	return ret;
> +	lim->max_user_sectors = max_sectors_kb << 1;
> +
> +	return count;
>  }
>  
> -static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
> +static ssize_t queue_feature_store(struct gendisk *disk,
> +		struct queue_limits *lim, const char *page,
>  		size_t count, blk_features_t feature)
>  {
> -	struct queue_limits lim;
>  	unsigned long val;
>  	ssize_t ret;
>  
> @@ -210,14 +203,10 @@ static ssize_t queue_feature_store(struct gendisk *disk, const char *page,
>  	if (ret < 0)
>  		return ret;
>  
> -	lim = queue_limits_start_update(disk->queue);
>  	if (val)
> -		lim.features |= feature;
> +		lim->features |= feature;
>  	else
> -		lim.features &= ~feature;
> -	ret = queue_limits_commit_update(disk->queue, &lim);
> -	if (ret)
> -		return ret;
> +		lim->features &= ~feature;
>  	return count;
>  }
>  
> @@ -228,9 +217,10 @@ static ssize_t queue_##_name##_show(struct gendisk *disk, char *page)	\
>  		!!(disk->queue->limits.features & _feature));		\
>  }									\
>  static ssize_t queue_##_name##_store(struct gendisk *disk,		\
> +		struct queue_limits *lim,				\
>  		const char *page, size_t count)				\
>  {									\
> -	return queue_feature_store(disk, page, count, _feature);	\
> +	return queue_feature_store(disk, lim, page, count, _feature);	\
>  }
>  
>  QUEUE_SYSFS_FEATURE(rotational, BLK_FEAT_ROTATIONAL)
> @@ -267,9 +257,8 @@ static ssize_t queue_iostats_passthrough_show(struct gendisk *disk, char *page)
>  }
>  
>  static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
> -					       const char *page, size_t count)
> +		struct queue_limits *lim, const char *page, size_t count)
>  {
> -	struct queue_limits lim;
>  	unsigned long ios;
>  	ssize_t ret;
>  
> @@ -277,15 +266,10 @@ static ssize_t queue_iostats_passthrough_store(struct gendisk *disk,
>  	if (ret < 0)
>  		return ret;
>  
> -	lim = queue_limits_start_update(disk->queue);
>  	if (ios)
> -		lim.flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
> +		lim->flags |= BLK_FLAG_IOSTATS_PASSTHROUGH;
>  	else
> -		lim.flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
> -
> -	ret = queue_limits_commit_update(disk->queue, &lim);
> -	if (ret)
> -		return ret;
> +		lim->flags &= ~BLK_FLAG_IOSTATS_PASSTHROUGH;
>  
>  	return count;
>  }
> @@ -391,12 +375,10 @@ static ssize_t queue_wc_show(struct gendisk *disk, char *page)
>  	return sysfs_emit(page, "write through\n");
>  }
>  
> -static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
> -			      size_t count)
> +static ssize_t queue_wc_store(struct gendisk *disk, struct queue_limits *lim,
> +			      const char *page, size_t count)
>  {
> -	struct queue_limits lim;
>  	bool disable;
> -	int err;
>  
>  	if (!strncmp(page, "write back", 10)) {
>  		disable = false;
> @@ -407,14 +389,10 @@ static ssize_t queue_wc_store(struct gendisk *disk, const char *page,
>  		return -EINVAL;
>  	}
>  
> -	lim = queue_limits_start_update(disk->queue);
>  	if (disable)
> -		lim.flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
> +		lim->flags |= BLK_FLAG_WRITE_CACHE_DISABLED;
>  	else
> -		lim.flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
> -	err = queue_limits_commit_update(disk->queue, &lim);
> -	if (err)
> -		return err;
> +		lim->flags &= ~BLK_FLAG_WRITE_CACHE_DISABLED;
>  	return count;
>  }
>  
> @@ -439,9 +417,16 @@ static struct queue_sysfs_entry _prefix##_entry = {		\
>  	.store		= _prefix##_store,			\
>  }
>  
> +#define QUEUE_RW_LIMIT_ENTRY(_prefix, _name)				\
> +static struct queue_sysfs_entry _prefix##_entry = {		\
> +	.attr		= { .name = _name, .mode = 0644 },	\
> +	.show		= _prefix##_show,			\
> +	.store_limit	= _prefix##_store,			\
> +}
> +
>  QUEUE_RW_ENTRY(queue_requests, "nr_requests");
>  QUEUE_RW_ENTRY(queue_ra, "read_ahead_kb");
> -QUEUE_RW_ENTRY(queue_max_sectors, "max_sectors_kb");
> +QUEUE_RW_LIMIT_ENTRY(queue_max_sectors, "max_sectors_kb");
>  QUEUE_RO_ENTRY(queue_max_hw_sectors, "max_hw_sectors_kb");
>  QUEUE_RO_ENTRY(queue_max_segments, "max_segments");
>  QUEUE_RO_ENTRY(queue_max_integrity_segments, "max_integrity_segments");
> @@ -457,7 +442,7 @@ QUEUE_RO_ENTRY(queue_io_opt, "optimal_io_size");
>  QUEUE_RO_ENTRY(queue_max_discard_segments, "max_discard_segments");
>  QUEUE_RO_ENTRY(queue_discard_granularity, "discard_granularity");
>  QUEUE_RO_ENTRY(queue_max_hw_discard_sectors, "discard_max_hw_bytes");
> -QUEUE_RW_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
> +QUEUE_RW_LIMIT_ENTRY(queue_max_discard_sectors, "discard_max_bytes");
>  QUEUE_RO_ENTRY(queue_discard_zeroes_data, "discard_zeroes_data");
>  
>  QUEUE_RO_ENTRY(queue_atomic_write_max_sectors, "atomic_write_max_bytes");
> @@ -477,11 +462,11 @@ QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
> -QUEUE_RW_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
> +QUEUE_RW_LIMIT_ENTRY(queue_iostats_passthrough, "iostats_passthrough");
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
>  QUEUE_RW_ENTRY(queue_poll_delay, "io_poll_delay");
> -QUEUE_RW_ENTRY(queue_wc, "write_cache");
> +QUEUE_RW_LIMIT_ENTRY(queue_wc, "write_cache");
>  QUEUE_RO_ENTRY(queue_fua, "fua");
>  QUEUE_RO_ENTRY(queue_dax, "dax");
>  QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
> @@ -494,10 +479,10 @@ static struct queue_sysfs_entry queue_hw_sector_size_entry = {
>  	.show = queue_logical_block_size_show,
>  };
>  
> -QUEUE_RW_ENTRY(queue_rotational, "rotational");
> -QUEUE_RW_ENTRY(queue_iostats, "iostats");
> -QUEUE_RW_ENTRY(queue_add_random, "add_random");
> -QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
> +QUEUE_RW_LIMIT_ENTRY(queue_rotational, "rotational");
> +QUEUE_RW_LIMIT_ENTRY(queue_iostats, "iostats");
> +QUEUE_RW_LIMIT_ENTRY(queue_add_random, "add_random");
> +QUEUE_RW_LIMIT_ENTRY(queue_stable_writes, "stable_writes");
>  
>  #ifdef CONFIG_BLK_WBT
>  static ssize_t queue_var_store64(s64 *var, const char *page)
> @@ -693,9 +678,11 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	struct queue_sysfs_entry *entry = to_queue(attr);
>  	struct gendisk *disk = container_of(kobj, struct gendisk, queue_kobj);
>  	struct request_queue *q = disk->queue;
> +	struct queue_limits lim = { };
>  	ssize_t res;
> +	int ret;
>  
> -	if (!entry->store)
> +	if (!entry->store && !entry->store_limit)
>  		return -EIO;
>  
>  	/*
> @@ -706,12 +693,30 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
>  	if (entry->load_module)
>  		entry->load_module(disk, page, length);
>  
> -	blk_mq_freeze_queue(q);
> +	if (entry->store) {
> +		blk_mq_freeze_queue(q);
> +		mutex_lock(&q->sysfs_lock);
> +		res = entry->store(disk, page, length);
> +		mutex_unlock(&q->sysfs_lock);
> +		blk_mq_unfreeze_queue(q);
> +		return res;
> +	}
> +
Can we move ->sysfs_lock before freezing queue? We follow the locking order 
of acquiring ->sysfs_lock before freeze lock. For instance, we've these 
call sites (elevator_disable(), elevator_switch()) where we first acquire 
->sysfs_lock and then freezes the queue. It's OK if you think this patchset
fixes locking order between limits lock and queue freeze and so we may address 
it in another patch. 

> +	lim = queue_limits_start_update(q);
> +
>  	mutex_lock(&q->sysfs_lock);
> -	res = entry->store(disk, page, length);
> +	res = entry->store_limit(disk, &lim, page, length);
>  	mutex_unlock(&q->sysfs_lock);
> +	if (res < 0) {
> +		queue_limits_cancel_update(q);
> +		return res;
> +	}
> +
> +	blk_mq_freeze_queue(q);
> +	ret = queue_limits_commit_update(disk->queue, &lim);
>  	blk_mq_unfreeze_queue(q);
> -	return res;
> +
> +	return ret ? ret : res;
>  }
>  
>  static const struct sysfs_ops queue_sysfs_ops = {

Thanks,
--Nilay

