Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC4BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jan 2022 08:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qbUXbdIpxR2xFT2q0NmyKpU21hdp1+TV9GE31xW0gGk=; b=oVaMCeoe7nQvf7//7VBoQG5wi1
	RplcmjsGxYeLmJFzLJnCYmiWSS8IIdGqh4CcXP4+C6Ey7T6MJInziq7dAT1YwijQId72WQhlCZURp
	/rP+ilp8KwvwZ0ZxTz6RVDbPJdRay8bJQELvyi8OmklQ7oHYDdHafFe7VVrkMGK+Of2OSsPCt3x2K
	3WsIg3J9iL12Vn6fnqH5+kQQwEVDBkZgTH4kJNspKdHS2mcVD9cK2JVkeq0pVjfpRfXOSqj6D2NsM
	49f5b3aW5GEC+LMeJ8armUh/OsKUzeKQ/0pWu60l+OnWu/JrOVpMNkvKRX4883UEYgQHvs9wVJ/vg
	1uhVzoNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nCHc8-006uyy-Qe; Tue, 25 Jan 2022 08:55:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nCHc0-006uuh-8F
 for linux-nvme@lists.infradead.org; Tue, 25 Jan 2022 08:55:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643100934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qbUXbdIpxR2xFT2q0NmyKpU21hdp1+TV9GE31xW0gGk=;
 b=RBu875JpBhGTzd7T+5MW9QkYmrcRhEPb/gEQGpuxRovPqUbY74aVrhUNaD9TC+qVgS6hXv
 LF4mhaV9tAgdYesM2VCl3PwDS4Z3btk0xafgKcIbjtZy8pIbdQ8pL4Y9WBAGpYLdT4J8d9
 Af37lF7OIXk7WFHOaoJvnuBcf88zc3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-sZYhBf1lO---MmiEipssQg-1; Tue, 25 Jan 2022 03:55:31 -0500
X-MC-Unique: sZYhBf1lO---MmiEipssQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEB19190A7A4;
 Tue, 25 Jan 2022 08:55:29 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 098C01F30C;
 Tue, 25 Jan 2022 08:54:48 +0000 (UTC)
Date: Tue, 25 Jan 2022 16:54:43 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 09/13] scsi: force unfreezing queue into atomic mode
Message-ID: <Ye+605vZEyx3ofi2@T590>
References: <20220122111054.1126146-1-ming.lei@redhat.com>
 <20220122111054.1126146-10-ming.lei@redhat.com>
 <20220124131516.GH27269@lst.de> <Ye80kxTBojm6GN8k@T590>
 <20220125072739.GA27777@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125072739.GA27777@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220125_005536_503005_B76D92FC 
X-CRM114-Status: GOOD (  26.95  )
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

On Tue, Jan 25, 2022 at 08:27:39AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 25, 2022 at 07:21:55AM +0800, Ming Lei wrote:
> > > > @@ -3670,7 +3670,7 @@ static void scsi_disk_release(struct device *dev)
> > > >  	 * in case multiple processes open a /dev/sd... node concurrently.
> > > >  	 */
> > > >  	blk_mq_freeze_queue(q);
> > > > -	blk_mq_unfreeze_queue(q);
> > > > +	__blk_mq_unfreeze_queue(q, true);
> > > 
> > > I think the right thing here is to drop the freeze/unfreeze pair.
> > > Now that del_gendisk properly freezes the queue, we don't need this
> > > protection as the issue that Bart fixed with it can't happen any more.
> > 
> > As you see, the last patch removes freeze/unfreeze pair in del_gendisk(),
> > which looks not very useful: it can't drain IO on bio based driver, and
> > del_gendisk() is supposed to provide consistent behavior for both request
> > and bio based driver.
> 
> So what is the advantage of trying to remove the freeze from where
> it belongs (common unregister code) while keeping it where it is a bandaid
> (driver specific unregister code)?

freeze in common unregister code is actually not good, because it provide
nothing for bio based driver, so we can't move blk-cgroup shutdown into
del_gendisk. Also we can't move elevator shutdown to del_gendisk for
similar reason.

Secondly freeze is pretty slow in percpu mode, so why slow down removing every
disk just for scsi's bandaid?


Thanks,
Ming


