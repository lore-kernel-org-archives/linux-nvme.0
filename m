Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4B2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 23:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=roW5J7iac8fftPWGb47ZXrc4wN3kazKOO4vYqBt3HH8=; b=eURJtuknoSXqrBM3ODdakmi8zK
	mAHfDrmOFqP1lcmGN7HNM/cA+i8+j8b6KUYJNa33BAS8xj9d/7LwE/jJts5q4kwLznZ/10f8xfwL/
	uGmh6V/LMqLHl5jgBBeoeSc54gydqEq193kjmQWijyrslGmhthrDOviQheLu0NThUfWHpAc56eVlQ
	ffbSbH8J0cvQ4sixnMJ/VKGr7cpa+3OHAiv76Te3j5sV9jWYev6bUi73p/nZTpfX1kFqGPZx03t+J
	ruQJ80+e0/6xxkbi2t+ArGVxPTOx4l3XfczXxxhxr0wd+XuI8aUyOZExhdKj2z5D8BMW68azfvPpC
	p8PWdGfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC8fM-005ZM2-4F; Mon, 24 Jan 2022 23:22:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC8fJ-005ZKp-D9
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 23:22:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643066544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=roW5J7iac8fftPWGb47ZXrc4wN3kazKOO4vYqBt3HH8=;
 b=WZpSgbHQJvcU9Gmq6qdzUiKoE91YiK/Lq82soHr+MyMo6RkiNX2ZRk+0JLAoDU2nINofaC
 gQJSpMAISxuCOLQzA2EHJmSMU7MkkgkxQGLZzSPg19hosfSbsVIPuZAQh7FAcT4NSoeLVr
 9+JNrKtl5AC+DriNTiObYWuLQuHH19U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-LxYTban4Na-bPjpDFcffpg-1; Mon, 24 Jan 2022 18:22:18 -0500
X-MC-Unique: LxYTban4Na-bPjpDFcffpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AE4F1006AA8;
 Mon, 24 Jan 2022 23:22:17 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 442025ED55;
 Mon, 24 Jan 2022 23:21:59 +0000 (UTC)
Date: Tue, 25 Jan 2022 07:21:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <Ye80kxTBojm6GN8k@T590>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-10-ming.lei@redhat.com>
 <20220124131516.GH27269@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124131516.GH27269@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_152225_541040_C2EC35E9 
X-CRM114-Status: GOOD (  26.45  )
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

On Mon, Jan 24, 2022 at 02:15:16PM +0100, Christoph Hellwig wrote:
> On Sat, Jan 22, 2022 at 07:10:50PM +0800, Ming Lei wrote:
> > In scsi_disk_release() request queue is frozen for clearing
> > disk->private_data, and there can't be any FS IO issued to
> > this queue, and only private passthrough request will be handled, so
> > force unfreezing queue into atomic mode.
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/scsi/sd.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> > index 0e73c3f2f381..27f04c860f00 100644
> > --- a/drivers/scsi/sd.c
> > +++ b/drivers/scsi/sd.c
> > @@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
> >  	 * in case multiple processes open a /dev/sd... node concurrently.
> >  	 */
> >  	blk_mq_freeze_queue(q);
> > -	blk_mq_unfreeze_queue(q);
> > +	__blk_mq_unfreeze_queue(q, true);
> 
> I think the right thing here is to drop the freeze/unfreeze pair.
> Now that del_gendisk properly freezes the queue, we don't need this
> protection as the issue that Bart fixed with it can't happen any more.

As you see, the last patch removes freeze/unfreeze pair in del_gendisk(),
which looks not very useful: it can't drain IO on bio based driver, and
del_gendisk() is supposed to provide consistent behavior for both request
and bio based driver.


Thanks,
Ming


