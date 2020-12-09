Return-Path: <SRS0=8yfk=FN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D2C4167B
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:51:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FF423888
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Dec 2020 02:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FF423888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M3awts5dGY3xJXRNADiAAc8hY3tS7FRYGWyP5/nVn0E=; b=DUh2njFoYFD+k9RKZnDpxmNCV
	6uY6hbU+RX0XRjdMS5NeL2w1Dv44UUEdPkO7Xh2IzbR//xByNwqnIJoeipNqByC+J3a7lmBzVVY2K
	N3ac78g3rrwyBqgdAHPCuSpv6DxU1tsCwi9391Qtn28vG+PhjnqMVCiSykrRuD8gFicrtoTeL4Mwt
	KX5xCN5o7yo4zS7cNysS0fbCxlqi9WOdc2m4GbYNnf9cSq7EDTypyZQBTqTQXabFkrEbQag2VE1r9
	G/8kBwHoJKTTLmzTPWZfWf3uT/5G/gq8Srh6Jc2ESYa6V5NmdrdB9DoTUTL1HdBhFzn2rHGvJRrTo
	lpYPsQbcQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmpa2-0008TU-V7; Wed, 09 Dec 2020 02:51:51 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmpZx-0008T7-V2
 for linux-nvme@lists.infradead.org; Wed, 09 Dec 2020 02:51:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607482305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8pDCkiQqUQi4Q65srKJy8fmgGe7yBxTF+/wHQ2CwMUo=;
 b=WzsBCeFIFQkrJzvTaRcr7RuyWpQoxzMnjd5ecyxDt8SQWeERnSlPYVdYZxkvI4FisUoQXV
 8nUQUsD1F4NI3bgrqSmDOYvygVGRuZj+uDykIdZlnGUOKjWOkuOCJCbv2TYwt6hHxUIVu1
 k5a4LGm9QjehhWlX081YQ0MRC3VP95k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-4E9pikj7Phyndmk0FTVmHw-1; Tue, 08 Dec 2020 21:51:43 -0500
X-MC-Unique: 4E9pikj7Phyndmk0FTVmHw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A1F0801FD4;
 Wed,  9 Dec 2020 02:51:41 +0000 (UTC)
Received: from T590 (ovpn-12-139.pek2.redhat.com [10.72.12.139])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40E645D6AB;
 Wed,  9 Dec 2020 02:51:25 +0000 (UTC)
Date: Wed, 9 Dec 2020 10:51:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/6] block: propagate BLKROSET on the whole device to all
 partitions
Message-ID: <20201209025121.GD1217988@T590>
References: <20201208162829.2424563-1-hch@lst.de>
 <20201208162829.2424563-5-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201208162829.2424563-5-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_215146_049423_CD601988 
X-CRM114-Status: GOOD (  27.59  )
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

On Tue, Dec 08, 2020 at 05:28:27PM +0100, Christoph Hellwig wrote:
> Change the policy so that a BLKROSET on the whole device also affects
> partitions.  To quote Martin K. Petersen:
> 
> It's very common for database folks to twiddle the read-only state of
> block devices and partitions. I know that our users will find it very
> counter-intuitive that setting /dev/sda read-only won't prevent writes
> to /dev/sda1.
> 
> The existing behavior is inconsistent in the sense that doing:
> 
>   # blockdev --setro /dev/sda
>   # echo foo > /dev/sda1
> 
> permits writes. But:
> 
>   # blockdev --setro /dev/sda
>   <something triggers revalidate>
>   # echo foo > /dev/sda1
> 
> doesn't.
> 
> And a subsequent:
> 
>   # blockdev --setrw /dev/sda
>   # echo foo > /dev/sda1
> 
> doesn't work either since sda1's read-only policy has been inherited
> from the whole-disk device.
> 
> You need to do:
> 
>   # blockdev --rereadpt
> 
> after setting the whole-disk device rw to effectuate the same change on
> the partitions, otherwise they are stuck being read-only indefinitely.
> 
> However, setting the read-only policy on a partition does *not* require
> the revalidate step. As a matter of fact, doing the revalidate will blow
> away the policy setting you just made.
> 
> So the user needs to take different actions depending on whether they
> are trying to read-protect a whole-disk device or a partition. Despite
> using the same ioctl. That is really confusing.
> 
> I have lost count how many times our customers have had data clobbered
> because of ambiguity of the existing whole-disk device policy. The
> current behavior violates the principle of least surprise by letting the
> user think they write protected the whole disk when they actually
> didn't.
> 
> Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> ---
>  block/genhd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index d9f989c1514123..6e51ecb9280aca 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1656,8 +1656,7 @@ EXPORT_SYMBOL(set_disk_ro);
>  
>  int bdev_read_only(struct block_device *bdev)
>  {
> -	return bdev->bd_read_only ||
> -		test_bit(GD_READ_ONLY, &bdev->bd_disk->state);
> +	return bdev->bd_read_only || get_disk_ro(bdev->bd_disk);
>  }
>  EXPORT_SYMBOL(bdev_read_only);
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
