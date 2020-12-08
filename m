Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:00:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A80E217A0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A80E217A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0G4AJ6gYafQ2D/fgg63glZFF+fDciWSP1R5wXli9f6M=; b=KEFZHX1uT2jPeHIufDy20j+vQ
	BlYasDdPDquAxtfbOpDNcbYaQuPemdQfbASCgAi7Xqr0p2kZ1xiDqUKfI4+D+wU9fPDaMnlVkAHhg
	86lEwjt7BLE2xJ7cNbehwq1nap75xpjdIBoJm8huojIra4g4T0WYxJdQPIP+sZ+NeHu676vZ7dohz
	KJY8ymczxn0twmhhuuBdO+86N4+7UZU4sMLxoFrX0TacYR8bB/Nj4lxASDtyLlV0XXZKeKof/Bnie
	2yB50KFyxmz3h6aD/2kYKDyXcoyLsboqmSqxq2jBC6ZQVu187jjrF1opJ5g4jmjjWNJxZ0IFfWtk3
	8/q/XnoBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmZn2-00060L-Q7; Tue, 08 Dec 2020 10:00:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmZn0-0005zq-LE
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 10:00:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607421608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0iZqkZAphNZf99PJFIaYexFrQFdjyflH/vT614+uZb8=;
 b=ZJt2GBq8EDxiQZO3MnAP7b51S8dpvPO4IniN1G18ZzMPbHv7YDDvPYMZxCZdeDvvbsoD99
 o2r/Szb5p2uAIC5XvjeMaN655bAdzlKCiynO03oJf9CPZF6El61n6fe7ZLy7utsCVGKCke
 j8oQtAQ1QZPb7k+lbaElne5zhPyc8gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-k_m0i4LmMCqeNxMYW764Fg-1; Tue, 08 Dec 2020 05:00:04 -0500
X-MC-Unique: k_m0i4LmMCqeNxMYW764Fg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9573F10054FF;
 Tue,  8 Dec 2020 09:59:59 +0000 (UTC)
Received: from T590 (ovpn-12-237.pek2.redhat.com [10.72.12.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F1AF2B394;
 Tue,  8 Dec 2020 09:59:40 +0000 (UTC)
Date: Tue, 8 Dec 2020 17:59:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] dm: use bdev_read_only to check if a device is
 read-only
Message-ID: <20201208095935.GA1202995@T590>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207131918.2252553-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_050010_744248_A605CFAE 
X-CRM114-Status: GOOD (  19.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Mike Snitzer <snitzer@redhat.com>, Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 02:19:13PM +0100, Christoph Hellwig wrote:
> dm-thin and dm-cache also work on partitions, so use the proper
> interface to check if the device is read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/md/dm-cache-metadata.c | 2 +-
>  drivers/md/dm-thin-metadata.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
> index af6d4f898e4c1d..89a73204dbf47f 100644
> --- a/drivers/md/dm-cache-metadata.c
> +++ b/drivers/md/dm-cache-metadata.c
> @@ -449,7 +449,7 @@ static int __check_incompat_features(struct cache_disk_superblock *disk_super,
>  	/*
>  	 * Check for read-only metadata to skip the following RDWR checks.
>  	 */
> -	if (get_disk_ro(cmd->bdev->bd_disk))
> +	if (bdev_read_only(cmd->bdev))
>  		return 0;
>  
>  	features = le32_to_cpu(disk_super->compat_ro_flags) & ~DM_CACHE_FEATURE_COMPAT_RO_SUPP;
> diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
> index 6ebb2127f3e2e0..e75b20480e460e 100644
> --- a/drivers/md/dm-thin-metadata.c
> +++ b/drivers/md/dm-thin-metadata.c
> @@ -636,7 +636,7 @@ static int __check_incompat_features(struct thin_disk_superblock *disk_super,
>  	/*
>  	 * Check for read-only metadata to skip the following RDWR checks.
>  	 */
> -	if (get_disk_ro(pmd->bdev->bd_disk))
> +	if (bdev_read_only(pmd->bdev))
>  		return 0;
>  
>  	features = le32_to_cpu(disk_super->compat_ro_flags) & ~THIN_FEATURE_COMPAT_RO_SUPP;
> -- 
> 2.29.2
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
