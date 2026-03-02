Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2585CEA4E3D
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQN/ziIMNvvcmABSL/XnrbXQAoVzX32PS6a2nZYPawg=; b=JuLThWCOMDjPW0xfU8dZgnuEpz
	afwpyMCtly+pSTY15NGahtagqJN2y6LlFFSAbfOET4WkYxHXYiPkbd0QRBvo0AdkVbmLYN+ffAYSR
	Sob+PZrXSR0dOQD1/V7bZvtrZ5DiKzNJFftR7UqgtkUCuRN7NGZWfUz9Oou4B/LpYUjLUUB+5H/gp
	vwzYSdOR3BvoDnLd+XF1CR+kd7K5o6fIup5sT4CSXYbSQQHmFwIM2lfNAJJ56RiM/9uP0Jb4kBpxV
	2+Pgn6HxpcVO5FH3kTRSvmA+oeWxNsM5qTbvSrO3DYGD4u2qQpFtrZHlteGSrgwt6SLqz2wm9ODBS
	j+aM0kFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx678-0000000DUFY-1A1V;
	Mon, 02 Mar 2026 16:27:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vx675-0000000DUEw-0Aiu
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 16:27:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772468837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQN/ziIMNvvcmABSL/XnrbXQAoVzX32PS6a2nZYPawg=;
	b=eR/9GZvGz1fP47Pj4284hbYGD1JGYJekvVaGxFvcnLgoP100mP0gTqJJ6Lng6Hni5/4PkY
	c312QHY1yPkTEqbs/YoS7GdLZOsqH3xaGEIaQl62l7L2gmCcDRa4Wd3/yK10gS6u/UM0Oa
	RSouXnpl2++WBxxfdFzqTB5OaCwFiNs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-PqyU0_nHMRCe1o3qBY43dw-1; Mon,
 02 Mar 2026 11:27:12 -0500
X-MC-Unique: PqyU0_nHMRCe1o3qBY43dw-1
X-Mimecast-MFC-AGG-ID: PqyU0_nHMRCe1o3qBY43dw_1772468830
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52E61195606B;
	Mon,  2 Mar 2026 16:27:10 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF2DD19560A3;
	Mon,  2 Mar 2026 16:27:08 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 622GR7uF1851868
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Mar 2026 11:27:07 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 622GR6qi1851867;
	Mon, 2 Mar 2026 11:27:06 -0500
Date: Mon, 2 Mar 2026 11:27:06 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/24] scsi-multipath: clone each bio
Message-ID: <aaW6Wp9AJV0emVs_@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-8-john.g.garry@oracle.com>
 <aaUCR-IoNItKVZCh@redhat.com>
 <bfe3a30f-50c1-4ede-a424-f342b80bfdcf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <bfe3a30f-50c1-4ede-a424-f342b80bfdcf@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: jYjYkIN6wa5Sjl2S6sB19to0LFgiVmknElOxw-tfN1c_1772468830
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_082719_157875_5F43DCB7 
X-CRM114-Status: GOOD (  39.08  )
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

On Mon, Mar 02, 2026 at 12:12:54PM +0000, John Garry wrote:
> On 02/03/2026 03:21, Benjamin Marzinski wrote:
> > On Wed, Feb 25, 2026 at 03:36:10PM +0000, John Garry wrote:
> > > For failover handling, we must resubmit each bio.
> > > 
> > > However, unlike NVMe, for SCSI there is no guarantee that any bio submitted
> > > is either all or none completed.
> > > 
> > > As such, for SCSI, for failover handling we will take the approach to
> > > just re-submit the original bio. For this clone and submit each bio.
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   drivers/scsi/scsi_multipath.c | 51 ++++++++++++++++++++++++++++++++++-
> > >   include/scsi/scsi_multipath.h |  1 +
> > >   2 files changed, 51 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> > > index 4b7984e7e74ba..d79a92ec0cf6c 100644
> > > --- a/drivers/scsi/scsi_multipath.c
> > > +++ b/drivers/scsi/scsi_multipath.c
> > > @@ -89,6 +89,14 @@ module_param_call(iopolicy, scsi_set_iopolicy, scsi_get_iopolicy,
> > >   MODULE_PARM_DESC(iopolicy,
> > >   	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
> > > +struct scsi_mpath_clone_bio {
> > > +	struct bio		*master_bio;
> > > +	struct bio		clone;
> > > +};
> > 
> > If the only extra information you need for your clone bios is a pointer
> > to the original bio, I think you can just store that in bi_private. So
> > you shouldn't actually need to allocate any front pad for your bioset.
> 
> Yes, seems a decent idea
> 
> > 
> > > +
> > > +#define scsi_mpath_to_master_bio(clone) \
> > > +		container_of(clone, struct scsi_mpath_clone_bio, clone)
> > > +
> > >   static int scsi_mpath_unique_lun_id(struct scsi_device *sdev)
> > >   {
> > >   	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
> > 
> > > @@ -260,6 +269,39 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
> > >   	return 0;
> > >   }
> > > +static void scsi_mpath_clone_end_io(struct bio *clone)
> > > +{
> > > +	struct scsi_mpath_clone_bio *scsi_mpath_clone_bio =
> > > +			scsi_mpath_to_master_bio(clone);
> > > +	struct bio *master_bio = scsi_mpath_clone_bio->master_bio;
> > > +
> > > +	master_bio->bi_status = clone->bi_status;
> > > +	bio_put(clone);
> > > +	bio_endio(master_bio);
> > > +}
> > > +
> > > +static struct bio *scsi_mpath_clone_bio(struct bio *bio)
> > > +{
> > > +	struct mpath_disk *mpath_disk = bio->bi_bdev->bd_disk->private_data;
> > > +	struct mpath_head *mpath_head = mpath_disk->mpath_head;
> > > +	struct scsi_mpath_clone_bio *scsi_mpath_clone_bio;
> > > +	struct scsi_mpath_head *scsi_mpath_head = mpath_head->drvdata;
> > > +	struct bio *clone;
> > > +
> > > +	clone = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOWAIT,
> > > +				&scsi_mpath_head->bio_pool);
> > 
> > Why use GFP_NOWAIT? It's more likely to fail than GFP_NOIO. If the bio
> > has REQ_NOWAIT set, I can see where you would need this, but otherwise,
> > I don't see why GFP_NOIO wouldn't be better here.
> 
> Seems reasonable to try GFP_NOIO. Furthermore, we really can't tolerate the
> clone to fail. So, if it does, we should return an error pointer here and
> mpath_bdev_submit_bio() should error the original bio.
> 
> > 
> > > +	if (!clone)
> > > +		return NULL;
> > > +
> > > +	clone->bi_end_io = scsi_mpath_clone_end_io;
> > > +
> > > +	scsi_mpath_clone_bio = container_of(clone,
> > > +					struct scsi_mpath_clone_bio, clone);
> > > +	scsi_mpath_clone_bio->master_bio = bio;
> > > +
> > > +	return clone;
> > > +}
> > > +
> > >   static enum mpath_iopolicy_e scsi_mpath_get_iopolicy(struct mpath_head *mpath_head)
> > >   {
> > >   	struct scsi_mpath_head *scsi_mpath_head = mpath_head->drvdata;
> > > @@ -269,6 +311,7 @@ static enum mpath_iopolicy_e scsi_mpath_get_iopolicy(struct mpath_head *mpath_he
> > >   struct mpath_head_template smpdt_pr = {
> > >   	.get_iopolicy = scsi_mpath_get_iopolicy,
> > > +	.clone_bio = scsi_mpath_clone_bio,
> > >   };
> > >   static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
> > > @@ -283,9 +326,13 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
> > >   	ida_init(&scsi_mpath_head->ida);
> > >   	mutex_init(&scsi_mpath_head->lock);
> > > +	if (bioset_init(&scsi_mpath_head->bio_pool, SCSI_MAX_QUEUE_DEPTH,
> > > +			offsetof(struct scsi_mpath_clone_bio, clone),
> > > +			BIOSET_NEED_BVECS|BIOSET_PERCPU_CACHE))
> > 
> > You don't need 4096 cached bios to guarantee forward progress. I don't
> > see why BIO_POOL_SIZE won't work fine here.
> 
> Every bio which we are sent is cloned. And SCSI_MAX_QUEUE_DEPTH is used as
> the cached bio size - wouldn't it make sense to cache more than 2 bios?

IIRC, the reserved pool is there to guarantee forward progress under
memory pressure, so that if the system is short on memory, and it needs
to write out data to this multipath device in order to free up memory,
it there will be enough resources to do that.

Under normal conditions, your new bios should be getting pulled from the
per-cpu cache anyways, since you set BIOSET_PERCPU_CACHE. That's going
to be the fastest way to get one.

-Ben

> 
> > Also, since you are cloning
> > bios, they are sharing the original bio's iovecs, so you don't need
> > BIOSET_NEED_BVECS.
> > 
> 
> ok
> 
> thanks!


