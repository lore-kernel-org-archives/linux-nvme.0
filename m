Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4308FEB1070
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 15:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VHucvSpsJZ1hD1W0lD+QRrW+SKG/AnUELnrm6Bsd77M=; b=cw1mc0S2l4gwCkwQh1nMWLjKh1
	5sS53Wuw2nwEp+MXbkABwN+tVqJwKOLgb9HFNEN1CD3vHnDW4brPgJeuJn9z8pvjn+GGZjk2CWZTg
	xSmpOc5bw5bOssj2QFvmJYclK5criV6JbwQfkcncCjuyunNZLSzRdqDQLckxbubKMgpeEPDlAosjz
	0sDxhvKNYDOIlpKci9kyw6Q+TDHR5vpAfwf8C5L3dWrpYgpJ+lP09vpDjYKkfh26Ppy/xhC0V5r+m
	X8XtsaFU97mMHIv+SyW++UDiZ0zH5aoURDa1f27fIRf28bTgZa4jLNvWn1U2weGlxbfRo1PFlmcv/
	G9SZcc6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzysG-00000009mlc-1wWf;
	Tue, 10 Mar 2026 15:19:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzysC-00000009mkU-3LlU
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 15:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773155991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHucvSpsJZ1hD1W0lD+QRrW+SKG/AnUELnrm6Bsd77M=;
	b=iWBVakpGvp3iWe7H7+vYR/8ywt4BkmFg4aYgZBJ1MPx6PC0SZyLnQqda/ObmYF227Rvw6g
	nOqYl0FafOpin4T8bqmtHB9MwDL7mh75YRY9crV55msATe/t/AATczX4zvSzIcJsNXQsd/
	Y+U/ynu+3M+fsp3sk6EfYdUM8vgACJY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-qM-ye5rAOsaELTeyzYFToQ-1; Tue,
 10 Mar 2026 11:19:44 -0400
X-MC-Unique: qM-ye5rAOsaELTeyzYFToQ-1
X-Mimecast-MFC-AGG-ID: qM-ye5rAOsaELTeyzYFToQ_1773155981
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0EF218005BA;
	Tue, 10 Mar 2026 15:19:40 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (bmarzins-01.fast.eng.rdu2.dc.redhat.com [10.6.23.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D994D1800576;
	Tue, 10 Mar 2026 15:19:39 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 62AFJcnA024189
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 11:19:38 -0400
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 62AFJcRo024188;
	Tue, 10 Mar 2026 11:19:38 -0400
Date: Tue, 10 Mar 2026 11:19:38 -0400
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 21/24] scsi: sd: support multipath disk
Message-ID: <abA2irnI-P8kkcgj@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-22-john.g.garry@oracle.com>
 <aa-EtdqIOX603PVu@redhat.com>
 <c204b634-8df8-4495-916b-1209cbd869d6@oracle.com>
MIME-Version: 1.0
In-Reply-To: <c204b634-8df8-4495-916b-1209cbd869d6@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: nL8INdKWKs9pbNtfVs0PafaCVgku-PzTVo3pQ9BePHc_1773155981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_081952_906139_A97C4E46 
X-CRM114-Status: GOOD (  21.25  )
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

On Tue, Mar 10, 2026 at 10:12:07AM +0000, John Garry wrote:
> On 10/03/2026 02:40, Benjamin Marzinski wrote:
> > > +static int sd_mpath_probe(struct scsi_disk *sdkp)
> > > +{
> > > +	struct scsi_device *sdp = sdkp->device;
> > > +	struct scsi_mpath_device *scsi_mpath_dev = sdp->scsi_mpath_dev;
> > > +	struct device *dma_dev = sdp->host->dma_dev;
> > > +	struct scsi_mpath_head *scsi_mpath_head =
> > > +				scsi_mpath_dev->scsi_mpath_head;
> > > +	struct sd_mpath_disk *sd_mpath_disk;
> > > +	struct mpath_head *mpath_head = scsi_mpath_head->mpath_head;
> > > +	struct queue_limits lim;
> > > +	struct gendisk *disk;
> > > +	int error;
> > > +
> > > +	/*
> > > +	 * sd_mpath_disks_list is kept locked if no disk found.
> > > +	 * Otherwise an extra reference is taken.
> > > +	 */
> > Again, I personally think the logic is easier to follow when all the
> > locking isn't split over multiple functions.
> 
> Sure, but I am considering removing the mpath_disk structure, so things may
> change here anyway. Removing mpath_disk should simplify things for the nvme
> driver transition.

Sure.

> 
> > 
> > > +	sd_mpath_disk = sd_mpath_find_disk(sdp);
> > > +	if (sd_mpath_disk) {
> > > +		mutex_lock(&sd_mpath_disk->lock);
> > > +		sd_mpath_disk->disk_count++;
> > > +		mutex_unlock(&sd_mpath_disk->lock);
> > > +		goto found;
> > > +	}
> > > +
> > > +	sd_mpath_disk = kzalloc(sizeof(*sd_mpath_disk), GFP_KERNEL);
> > > +	if (!sd_mpath_disk) {
> > > +		error = -ENOMEM;
> > > +		goto out_unlock;
> > > +	}
> > > +
> > > +	sd_mpath_disk->scsi_mpath_head = scsi_mpath_head;
> > > +	device_initialize(&sd_mpath_disk->dev);
> > > +	mutex_init(&sd_mpath_disk->lock);
> > > +	sd_mpath_disk->dev.class = &sd_mpath_disk_class;
> > > +
> > > +	blk_set_stacking_limits(&lim);
> > > +	lim.dma_alignment = 3;
> > > +	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
> > > +		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
> > > +
> > > +	sd_mpath_disk->mpath_disk = mpath_alloc_head_disk(&lim,
> > > +						dev_to_node(dma_dev));
> > > +	if (!sd_mpath_disk->mpath_disk) {
> > > +		error = -ENOMEM;
> > > +		goto out_free_disk;
> > > +	}
> > > +	disk = sd_mpath_disk->mpath_disk->disk;
> > > +	mpath_get_head(mpath_head); /* undone in mpath_free_disk() */
> > > +
> > > +	sd_mpath_disk->mpath_disk->mpath_head = mpath_head;
> > > +	sd_mpath_disk->mpath_disk->parent = &sd_mpath_disk->dev;
> > > +
> > > +	error = ida_alloc(&sd_index_ida, GFP_KERNEL);
> > > +	if (error < 0) {
> > > +		sdev_printk(KERN_WARNING, sdp, "sd_probe: memory exhausted.\n");
> > > +		goto out_put_disk;
> > > +	}
> > > +	sd_mpath_disk->disk_index = error;
> > > +	error = sd_format_disk_name("sd", sd_mpath_disk->disk_index,
> > > +				disk->disk_name, DISK_NAME_LEN);
> > > +	if (error)
> > > +		goto out_free_index;
> > > +
> > > +	error = dev_set_name(&sd_mpath_disk->dev, "%s",
> > > +				dev_name(&scsi_mpath_head->dev));
> > > +	if (error)
> > > +		goto out_free_index;
> > > +
> > > +	/* undone in sd_mpath_disk_release() */
> > > +	scsi_mpath_get_head(scsi_mpath_head);
> > > +
> > > +	error = device_add(&sd_mpath_disk->dev);
> > > +	if (error) {
> > > +		put_device(&sd_mpath_disk->dev);
> > > +		goto out_unlock;
> > We should clean up when we fail here, instead of just unlocking without
> > fully setting things up.
> 
> I think that the release function is called from put_device(), which should
> do the class tidy up. Something similar is done in sd_probe() for the
> disk_dev.

Oops. You are correct.

-Ben

> Thanks,
> John


