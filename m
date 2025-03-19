Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF3FC35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 19:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UoMsJz6uQ9Xsq6hoAcbPVlQz7ODTaS5nZ9IsZpDthKQ=; b=MCUNltf9f2dNT8eMYeF9aomj4E
	EZOTWhLSG9N7nA/rYRPHnwUNpTG+vhW4Th0GkJ8GhAQeTtZGrBHs/hXdb9IA9vwm4xuZqKKyA5p1L
	y1PsEAByxQ4DFpuDmQaYbWIxCS2i7E83vL+YbOvuZ8Rl5OIKrTPmyES4d0n8U49T2xoMxyb1BUG1W
	3MEcmYmkBKNPFmxQMCJa2cw3ZL7QYvYVqFmQ3jejcTUMotkGCKuAlDeOwI7+NFMs5vcPVm6H/21UN
	T63uaphNJxhhLg1WG+upJeYFAC4zX0y4OkHf61lzWG6F5PXEdW7VwM99+nsXui2H/S7/lhP3Y83/5
	BpwCEXTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuzSh-0000000A1Yo-08Pi;
	Wed, 19 Mar 2025 19:52:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuzSe-0000000A1Y7-30qU
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 19:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742413938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UoMsJz6uQ9Xsq6hoAcbPVlQz7ODTaS5nZ9IsZpDthKQ=;
	b=dXTbKcAECJTGq8a00vTTFKZa41lO5nogZ5Cpp9WYzi/xvEGM9VabMHqd+oFV1ETMDQiziv
	oCT6C91IIPm3tJcfmo/fiOAOKtaOs2jMMOQx/4AZJHtlp05hS9Oe1F7s8pIHw7Qmp4EN0b
	xOF/WbJPnfG5QZY2eGZt2qQ5XyXJZT4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-pc5hPzSgOM-Mh3OFUt2lmQ-1; Wed,
 19 Mar 2025 15:50:38 -0400
X-MC-Unique: pc5hPzSgOM-Mh3OFUt2lmQ-1
X-Mimecast-MFC-AGG-ID: pc5hPzSgOM-Mh3OFUt2lmQ_1742413836
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B028180AB19;
	Wed, 19 Mar 2025 19:50:33 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E6C11956095;
	Wed, 19 Mar 2025 19:50:31 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 52JJoUdr2309780
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 15:50:30 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 52JJoRRp2309779;
	Wed, 19 Mar 2025 15:50:27 -0400
Date: Wed, 19 Mar 2025 15:50:27 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, john.g.garry@oracle.com,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com,
        yi.zhang@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [RFC PATCH -next v3 06/10] dm: add BLK_FEAT_WRITE_ZEROES_UNMAP
 support
Message-ID: <Z9sgAxM-hZZJtZu9@redhat.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
 <20250318073545.3518707-7-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318073545.3518707-7-yi.zhang@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_125220_881715_6F3E3DF1 
X-CRM114-Status: GOOD (  19.37  )
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

On Tue, Mar 18, 2025 at 03:35:41PM +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Set the BLK_FEAT_WRITE_ZEROES_UNMAP feature on stacking queue limits by
> default. This feature shall be disabled if any underlying device does
> not support it.
> 
Reviewed-by: Benjamin Marzinski <bmarzins@redhat.com>

> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  drivers/md/dm-table.c | 7 +++++--
>  drivers/md/dm.c       | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 453803f1edf5..d4a483287e26 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -598,7 +598,8 @@ int dm_split_args(int *argc, char ***argvp, char *input)
>  static void dm_set_stacking_limits(struct queue_limits *limits)
>  {
>  	blk_set_stacking_limits(limits);
> -	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> +	limits->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL |
> +			    BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  
>  /*
> @@ -1848,8 +1849,10 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  		limits->discard_alignment = 0;
>  	}
>  
> -	if (!dm_table_supports_write_zeroes(t))
> +	if (!dm_table_supports_write_zeroes(t)) {
>  		limits->max_write_zeroes_sectors = 0;
> +		limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
> +	}
>  
>  	if (!dm_table_supports_secure_erase(t))
>  		limits->max_secure_erase_sectors = 0;
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 5ab7574c0c76..b59c3dbeaaf1 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1096,6 +1096,7 @@ void disable_write_zeroes(struct mapped_device *md)
>  
>  	/* device doesn't really support WRITE ZEROES, disable it */
>  	limits->max_write_zeroes_sectors = 0;
> +	limits->features &= ~BLK_FEAT_WRITE_ZEROES_UNMAP;
>  }
>  
>  static bool swap_bios_limit(struct dm_target *ti, struct bio *bio)
> -- 
> 2.46.1


