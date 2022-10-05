Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D9AC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 16:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Beoyi6lpSF5zXtRIxeyO4+gao6QUOyJQkR3U0Fcwf8I=; b=W8tDhL7l0ro+3FQqDg7fSj3WjP
	hSFwMDxqceBy+G6Ai9MySIFCW2C/vQLgz+QFhkDA4ia9Isne6/VnimTGpINBLo5u7bjwt90y5ayer
	AdoD+Wy8ifOw8MEPDHnjJ4MhBSF41G9VxK4xoCuToOYLb/rHr+T6tvtoIkbkBREg2vBU2x/GeOSOC
	ZhYZYt7Hgww+A8j5OWxYDJXd5qFEEXllmsOPsIlX8ZunWVbGV9xtZDB4k1MFhOerPFK0UMEfxV1mr
	qK3PGDhI4FQodOCHtvv0jjziYFzOp19wYLD+Z8vjtHXdOx3EJGcf7dQzos2yA+19sRfirM+0rUFyE
	Cckez9cQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og720-00F3ad-Vb; Wed, 05 Oct 2022 16:14:01 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofwgt-00CX7g-N9
	for linux-nvme@lists.infradead.org; Wed, 05 Oct 2022 05:11:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946691; x=1696482691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t4Ggk8JN7aJqaDrHkVXVhSu8+EOy8cvFecQ8rYNiwuM=;
  b=cnRiYc5JlIIjYMxDhZRhn71iTK/QyVAzGDOyVKgRJ29i6oFSzbB8A8Uz
   XBGEob37WrefwZOVb9wJyRpDQ9GkDqYPnhm/Umw3y4XBGAhMrVoVFT9iy
   TzTssdC2uKWXqWVWJ6RJrmGcgDm8Av2P11oafJ6Jdv/VMrxMNyeuaBYb1
   UzxOrNbsqUjJK1IXdvR9ms0pcaVYV3qgoq0BP+rztX8uH4Y9nP052RVmO
   Se/7tR+ZrrKUsjzZ9MHjWoDbb3ulGVe2cVYzVIa/3V88WpKPivV2HwRZi
   AqQlgvt4WokxSP+J+/3qhNq/Eez0FZ23U4EmqAFvuwkV050QHktm7NpeI
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="218195143"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:11:26 +0800
IronPort-SDR: 5zlz7pgqKSB7piRiNqM452CVKOs0cX9QcmQ8w2xNyI2odHFEBH+rl1Pm0jDO2jO7OPhiicd+TS
 w9MS4t+sv4e8vpXOBlUjs7cNPoHpn9wE+xQ1+izOkUnu0cgUcXBOGjiVPHM19qfC5jV9LCj9c8
 V7M1rVijAm/gdndg7rmCo5OlYLJnRplmzbl/ICuTAlO5w26rM39QzFg2ZK4vnCq/X3ds8luAwX
 tE/8LUXHgB0tHWiQxXZr6EMq/ZaopK2TaW4kABJMD2KPhMCC3fG5A1qxme1zUzPRdd+D7e/tXp
 /jCgCFklgfM2bJ4Hpmz8oUiB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:31:13 -0700
IronPort-SDR: hRM3Lw6JCi72gCHKfYcsYmSKwZygM2GrvyccgSAuy4MGonMijnuNOds/Wks/5h8OoQRUORhyKC
 or82L9LqmNuoCXT7MxV9btTgvPcE0vIZCGueBqeMkToGbL/zIHRrNg7mOA3rGaYF9ER33Z3Cqf
 Wjvr66vqrgjF6n7duhyUohrDoS6V8KfwYbflmFe/2qtglPl4omxkG5+JXbZThGFjkydYndOKuo
 UrFO1SBzUiZpPmqUws59Jk8/aiHov79qhk6T/sTeFnBkb0/tbFMQoGgWPYxf2Cus43Uaj7jWDD
 i7s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:11:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2jT3TcFz1Rwtl
	for <linux-nvme@lists.infradead.org>; Tue,  4 Oct 2022 22:11:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1664946683; x=1667538684; bh=t4Ggk8JN7aJqaDrHkVXVhSu8+EOy8cvFecQ
	8rYNiwuM=; b=TIEBMvTwNbQfRcdLCIdhIV1cDzUY7/zZNt4FTW87ZJI3MGaBzkb
	qqEGe+xann+Fr9ERkXZFiwH9qA5kw9KT1tWAv8xyW22GImuAepWY3G/bUWvxbx3+
	DcHlhNaLqbjABQSXRcSsC/ZJ18eLMou237FM3i8KOcuTsorywWPIdSOHXmXMRQVh
	zKad+6i9lAPQe7q6dcRC1UYzId7HaifDb4E/41pWM2EEiudVUCqUjBTfW0PhB5x4
	L1/2ED3lJAQXvJk1jeoGDt9yB38D0GN1mBooIkJF8nCh8QfQQq+ELcm1zBX6rfoi
	FK/0qGjDUpdCP6zsNMCBumXsyWKKoRV+WFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Q7_HPt1SSmpi for <linux-nvme@lists.infradead.org>;
	Tue,  4 Oct 2022 22:11:23 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2jD37C6z1RvLy;
	Tue,  4 Oct 2022 22:11:12 -0700 (PDT)
Message-ID: <6fee2d7a-7fd1-73ee-2911-87a4ed3e8769@opensource.wdc.com>
Date: Wed, 5 Oct 2022 14:11:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH 01/21] block: add and use init tagset helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-remoteproc@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: axboe@kernel.dk, efremov@linux.com, josef@toxicpanda.com,
 idryomov@gmail.com, dongsheng.yang@easystack.cn, haris.iqbal@ionos.com,
 jinpu.wang@ionos.com, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, stefanha@redhat.com, ohad@wizery.com,
 andersson@kernel.org, baolin.wang@linux.alibaba.com, ulf.hansson@linaro.org,
 richard@nod.at, miquel.raynal@bootlin.com, vigneshr@ti.com,
 marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, sth@linux.ibm.com,
 hoeppner@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
 bhelgaas@google.com, john.garry@huawei.com, mcgrof@kernel.org,
 christophe.jaillet@wanadoo.fr, vaibhavgupta40@gmail.com,
 wsa+renesas@sang-engineering.com, johannes.thumshirn@wdc.com,
 bvanassche@acm.org, ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
 vincent.fu@samsung.com, christoph.boehmwalder@linbit.com, joel@jms.id.au,
 vincent.whitchurch@axis.com, nbd@other.debian.org,
 ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 asahi@lists.linux.dev
References: <20221005032257.80681-1-kch@nvidia.com>
 <20221005032257.80681-2-kch@nvidia.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005032257.80681-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_221131_816203_D331D26C 
X-CRM114-Status: GOOD (  24.83  )
X-Mailman-Approved-At: Wed, 05 Oct 2022 09:06:48 -0700
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

On 10/5/22 12:22, Chaitanya Kulkarni wrote:
> Add and use the helper to initialize the common fields of the tag_set
> such as blk_mq_ops, number of h/w queues, queue depth, command size,
> numa_node, timeout, BLK_MQ_F_XXX flags, driver data. This initialization
> is spread all over the block drivers. This avoids the code repetation of
> the inialization code of the tag set in current block drivers and any

s/inialization/initialization
s/repetation/repetition

> future ones.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  block/blk-mq.c                | 20 ++++++++++++++++++++
>  drivers/block/null_blk/main.c | 10 +++-------
>  include/linux/blk-mq.h        |  5 +++++
>  3 files changed, 28 insertions(+), 7 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..e3a8dd81bbe2 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4341,6 +4341,26 @@ static int blk_mq_alloc_tag_set_tags(struct blk_mq_tag_set *set,
>  	return blk_mq_realloc_tag_set_tags(set, 0, new_nr_hw_queues);
>  }
>  
> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> +		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> +		unsigned int timeout, unsigned int flags, void *driver_data)

That is an awful lot of arguments... I would be tempted to say pack all
these into a struct but then that would kind of negate this patchset goal.
Using a function with that many arguments will be error prone, and hard to
review... Not a fan.

> +{
> +	if (!set)
> +		return;
> +
> +	set->ops = ops;
> +	set->nr_hw_queues = nr_hw_queues;
> +	set->queue_depth = queue_depth;
> +	set->cmd_size = cmd_size;
> +	set->numa_node = numa_node;
> +	set->timeout = timeout;
> +	set->flags = flags;
> +	set->driver_data = driver_data;
> +}
> +

No blank line here.

> +EXPORT_SYMBOL_GPL(blk_mq_init_tag_set);
> +
>  /*
>   * Alloc a tag set to be associated with one or more request queues.
>   * May fail with EINVAL for various error conditions. May adjust the
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 1f154f92f4c2..0b07aab980c4 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1926,13 +1926,9 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
>  			flags |= BLK_MQ_F_BLOCKING;
>  	}
>  
> -	set->ops = &null_mq_ops;
> -	set->cmd_size	= sizeof(struct nullb_cmd);
> -	set->flags = flags;
> -	set->driver_data = nullb;
> -	set->nr_hw_queues = hw_queues;
> -	set->queue_depth = queue_depth;
> -	set->numa_node = numa_node;
> +	blk_mq_init_tag_set(set, &null_mq_ops, hw_queues, queue_depth,
> +			sizeof(struct nullb_cmd), numa_node, 0, flags, nullb);
> +
>  	if (poll_queues) {
>  		set->nr_hw_queues += poll_queues;
>  		set->nr_maps = 3;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799..06087a8e4398 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -708,6 +708,11 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
>  		struct request_queue *q);
>  void blk_mq_destroy_queue(struct request_queue *);
>  
> +

No need for the extra whiteline.

> +void blk_mq_init_tag_set(struct blk_mq_tag_set *set,
> +		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
> +		unsigned int queue_depth, unsigned int cmd_size, int numa_node,
> +		unsigned int timeout, unsigned int flags, void *driver_data);
>  int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
>  int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
>  		const struct blk_mq_ops *ops, unsigned int queue_depth,

-- 
Damien Le Moal
Western Digital Research


