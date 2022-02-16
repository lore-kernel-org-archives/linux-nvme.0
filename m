Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC98BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Feb 2022 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ugIJWQk3SMKfMsohcYmO1QoDdMHhYRu0T2WPYwlO3u4=; b=z4FuJuJALVbKL7I44XkqvFRaxE
	6VRHVlv9QOTLATPCWgTRUDSNFXrBmhJ3oVAdNfKEevkI2+3PykMOuqSEqV8Ihj0nKpuWHU157+03Y
	d9YMF3JvEwnaTpumMI0xYKrLbO0xpDmxALMXbOy6zhkn6yg+AGs6m00zB2Q6FWRZXOKHk+l59Fde5
	7sPRgvJrzyxKs4Yf5dqJBTqpdwEtcyixc8LmjeuK1WuAfoaKI/LrU6wzWed1tR3ppHfjapyGMsZmM
	Q+bXoKi5i0HhvCerIwevEjl5JTTwQhMfeULSYl6ueoCeeOaSTNbi+o8hDTkYMLdJzsmc4j4EMtkAb
	ukqIJVkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKKQW-007Cj8-Sw; Wed, 16 Feb 2022 13:33:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nKKQU-007ChZ-7G
 for linux-nvme@lists.infradead.org; Wed, 16 Feb 2022 13:32:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645018375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ugIJWQk3SMKfMsohcYmO1QoDdMHhYRu0T2WPYwlO3u4=;
 b=a3DHbiTdZW7GiFXM5hJHNepjGqZ4Q4+ahc7Sw7r0/V2w70Fig8KDonqwTRk9bqN3o8PgD4
 5WlN8KSAx92vKj3WzFay6/muM4s/5mqyuK5epoPVm2e11s4G5pDA3o8XR34UYm9nSeUdIY
 yTNC83mFfot0g2Ev+7eK6wgcpLht3zA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-z8ORJ7cSMN6lryLeURn9Xg-1; Wed, 16 Feb 2022 08:32:54 -0500
X-MC-Unique: z8ORJ7cSMN6lryLeURn9Xg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDB4814246;
 Wed, 16 Feb 2022 13:32:50 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com
 (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFDB32AA93;
 Wed, 16 Feb 2022 13:32:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id
 21GDWli7022921; Wed, 16 Feb 2022 08:32:47 -0500
Received: from localhost (mpatocka@localhost)
 by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP
 id 21GDWjiY022917; Wed, 16 Feb 2022 08:32:46 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka
 owned process doing -bs
Date: Wed, 16 Feb 2022 08:32:45 -0500 (EST)
From: Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To: Nitesh Shetty <nj.shetty@samsung.com>
cc: javier@javigon.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
 martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 zach.brown@ni.com, osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
 tytso@mit.edu, jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH v2 05/10] block: add emulation for copy
In-Reply-To: <20220207141348.4235-6-nj.shetty@samsung.com>
Message-ID: <alpine.LRH.2.02.2202160830150.22021@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
 <20220207141348.4235-1-nj.shetty@samsung.com>
 <CGME20220207141930epcas5p2bcbff65f78ad1dede64648d73ddb3770@epcas5p2.samsung.com>
 <20220207141348.4235-6-nj.shetty@samsung.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220216_053258_356627_AE86967D 
X-CRM114-Status: GOOD (  15.39  )
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



On Mon, 7 Feb 2022, Nitesh Shetty wrote:

> +				goto retry;
> +			return PTR_ERR(bio);
> +		}
> +
> +		bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
> +		bio->bi_opf = op;
> +		bio_set_dev(bio, bdev);
> @@ -346,6 +463,8 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr,
>  
>  	if (blk_check_copy_offload(src_q, dest_q))
>  		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
> +	else
> +		ret = blk_copy_emulate(src_bdev, nr, rlist, dest_bdev, gfp_mask);
>  
>  	return ret;
>  }

The emulation is not reliable because a device mapper device may be 
reconfigured and it may lose the copy capability between the calls to 
blk_check_copy_offload and blk_copy_offload.

You should call blk_copy_emulate if blk_copy_offload returns an error.

Mikulas


