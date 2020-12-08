Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF66BC2BB9A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:06:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A25623A9A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 10:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A25623A9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u0xP6iriu7xGKlLIQykdAIU8GnGy52EkYFozcimFen8=; b=ETv7J7hk5ImnwJ6cLWwEPlh3E
	PmmuVdA2XJb8oqNtMXO2HjHM8ZjY+2K21Cl8Di04McW8W8/yuRZbJ1TNEhYMbpib5lpq6wMr2X5rf
	Y3UxW2Xtbh+NESxE3HjVG7/neT1EY3yFVi1dTbuNomCvbY1zKzM28ZTHSzHYw6i0cjtAvjeYqkIPm
	fZFhCatVO3rlu8PlNwOqT1aATCPHoyFX0nqLxzLQLjiA/zELcNAutqeLkIYfmFQ97JcXCOuyoBYoV
	ebvKjUhXTrBYXMakg9xCxIfh4tY73intq5qwlETpuJiFC6eK7stUbtaW34rw5A6vuo7QNfQooytda
	97v6Q7T6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmZtW-0007Wh-9e; Tue, 08 Dec 2020 10:06:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmZtT-0007Vd-0N
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 10:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607422010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sko6C5wfWDgDz/llZ4T/WVRUdYqT5janpxHYpC7QfeM=;
 b=CYjiDIBxlggrd+CEZp8cB3an9Uy5dZPzr3NiNftUNqDHWXBTeQdhFbGAHFZLGIbUhqR532
 VY6ZScBkZgTzqZctZFrtDuWO3AN02R5LAE4VGn7Iiv9tXfH6O4LPqgm7wvxbOprO1kL+0M
 aSyviMBu0Jr7+8IWmOnpp9eolAEgfig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-4DRUqOqZO8mqDRBrFYJALQ-1; Tue, 08 Dec 2020 05:06:46 -0500
X-MC-Unique: 4DRUqOqZO8mqDRBrFYJALQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58F63107ACE3;
 Tue,  8 Dec 2020 10:06:44 +0000 (UTC)
Received: from T590 (ovpn-12-237.pek2.redhat.com [10.72.12.237])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0471960BE2;
 Tue,  8 Dec 2020 10:06:26 +0000 (UTC)
Date: Tue, 8 Dec 2020 18:06:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] block: remove the NULL bdev check in bdev_read_only
Message-ID: <20201208100621.GB1202995@T590>
References: <20201207131918.2252553-1-hch@lst.de>
 <20201207131918.2252553-3-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201207131918.2252553-3-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_050651_142561_EB1DEEC4 
X-CRM114-Status: GOOD (  19.74  )
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
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Dec 07, 2020 at 02:19:14PM +0100, Christoph Hellwig wrote:
> Only a single caller can end up in bdev_read_only, so move the check there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c | 3 ---
>  fs/super.c    | 3 ++-
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 09ff6cef028729..c87013879b8650 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1445,11 +1445,8 @@ EXPORT_SYMBOL(set_disk_ro);
>  
>  int bdev_read_only(struct block_device *bdev)
>  {
> -	if (!bdev)
> -		return 0;
>  	return bdev->bd_read_only;
>  }
> -
>  EXPORT_SYMBOL(bdev_read_only);
>  
>  /*
> diff --git a/fs/super.c b/fs/super.c
> index 2c6cdea2ab2d9e..5a1f384ffc74f6 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -865,7 +865,8 @@ int reconfigure_super(struct fs_context *fc)
>  
>  	if (fc->sb_flags_mask & SB_RDONLY) {
>  #ifdef CONFIG_BLOCK
> -		if (!(fc->sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
> +		if (!(fc->sb_flags & SB_RDONLY) && sb->s_bdev &&
> +		    bdev_read_only(sb->s_bdev))
>  			return -EACCES;
>  #endif
>  
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
