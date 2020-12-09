Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4222C4361B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:55:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D81A23888
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:55:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D81A23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PYFOaJM89/q8YVK3Jl8zFZx1eANu5y6dCcSVW3ye2/M=; b=aeHzUOwfoRDwcns4inVLi/pW9
	4L+Z57jH3o2boiZR30+wx1dvggfGGvLpaUojt32n6gT/TknYnyJ5+pqAkyTagZ4YPYuuXIVO85DxC
	Rala8fQNeurw/BojHCg/4C3PHsKe+lsroM16BhFl2SP4OmlngJGRefo0HL60zrW4wnlqrcMV/aE7y
	CITpo3mxv/KgU7t2F3noNAwjNDOpLl5rcutcWdq83dE5jtjUYR4hl0NQ7xZveduEWqHlxl1mnjGZB
	F3GYEVYIwpD5b6Xtsc862RGXtuy1K2AU2CFpiN1fNwcPxBlSJifq7oG2w3Y2RK+06pI7qmOimEpEr
	pfLAS3+pA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmpdW-0000UI-5H; Wed, 09 Dec 2020 02:55:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmpdT-0000TU-9a
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 02:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607482523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0WZQF5SlAEi9+waVA6LQzgtvN5ftR3nM5/xd5tk5h3g=;
 b=VFsUCELRHREyRktOKgD6uGfs+RIdQxHy+O5UUjac8bcEt5owEo45JOofcCTyYOeag9azVl
 ogv01weuOwiSQDrkAxypnBw21/n1K2qhvKOyXfajFq4N/SswIMBmIfKCUmIezsQmb7sJl7
 85/NhD6qpG4S6UP/f7xJxqFZtFH5cVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-7xfTxa8XOY-IC20s3V-rdQ-1; Tue, 08 Dec 2020 21:55:19 -0500
X-MC-Unique: 7xfTxa8XOY-IC20s3V-rdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F945107ACE3;
 Wed,  9 Dec 2020 02:55:17 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B90D019725;
 Wed,  9 Dec 2020 02:55:01 +0000 (UTC)
Date: Wed, 9 Dec 2020 10:54:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/6] nvme: allow revalidate to set a namespace read-only
Message-ID: <20201209025456.GF1217988@T590>
References: <20201208162829.2424563-1-hch@lst.de>
 <20201208162829.2424563-7-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208162829.2424563-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_215523_398397_9117DED7 
X-CRM114-Status: GOOD (  17.81  )
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
 Keith Busch <kbusch@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
 ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 08, 2020 at 05:28:29PM +0100, Christoph Hellwig wrote:
> Unconditionally call set_disk_ro now that it only updates the hardware
> state.  This allows to properly set up the Linux devices read-only when
> the controller turns a previously writable namespace read-only.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  drivers/nvme/host/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ce1b6151944131..3a0557ccc9fc5d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2114,9 +2114,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
>  	nvme_config_discard(disk, ns);
>  	nvme_config_write_zeroes(disk, ns);
>  
> -	if ((id->nsattr & NVME_NS_ATTR_RO) ||
> -	    test_bit(NVME_NS_FORCE_RO, &ns->flags))
> -		set_disk_ro(disk, true);
> +	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
> +		test_bit(NVME_NS_FORCE_RO, &ns->flags));
>  }
>  
>  static inline bool nvme_first_scan(struct gendisk *disk)
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
