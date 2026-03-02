Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D8DD58E4B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lr1K3+67qIkavCXb7dXKJoUo01SRTqdLi2G1D317JG8=; b=PWcfGMSbk8+nR4wd4uqnXL44sF
	ip/IVjh2GGxACgxhBKXDcsGPJ8IbEtghQQ8sjakXlfMH2ZXp7foVowWaX5oJaFAZ9As6DjDjlWgXm
	FChpwNQ2JmgD0CZG62owLkPyehNAHaMZJ0gL9EZpPBRHM4Ns/KAqtLVxUYyuaILeZJEw9tJfY3ePG
	h/Jz0MEn8mPP720qrRY0Qz56W2zNc3dMhmYHKfKuUQPWXKa0uzwF9jqMa+41kiUYJKT4i5FI0ULZr
	VC/5be6nu/KWp2FfC7jAqpOwVxwKXRmMApgtuAOJCC5eLpRVZShP6/NOasOIj5d1oqU7SpznOUDvd
	vfsbwXdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtr4-0000000CAkR-1SsK;
	Mon, 02 Mar 2026 03:21:58 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwtr1-0000000CAid-1U86
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 03:21:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772421714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lr1K3+67qIkavCXb7dXKJoUo01SRTqdLi2G1D317JG8=;
	b=XTyGkiPyz4iHCUw53b1XhhiDidTfjf54i5Q8lX5HLtFR+GSNtzjQpDmrsGWm8JsEFc3flp
	IxWNzJwobkzE75P3Kxm0hKP2WoqiJPT0Q8sMmFRoQDpt7syHtm5Sjctor0rkQD3OotXXGK
	GgkwSi3ninMRBkMyZp6YG0J6GIMbN2A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-LPdki3zNORyns8xHFA34QQ-1; Sun,
 01 Mar 2026 22:21:48 -0500
X-MC-Unique: LPdki3zNORyns8xHFA34QQ-1
X-Mimecast-MFC-AGG-ID: LPdki3zNORyns8xHFA34QQ_1772421706
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A342C1800342;
	Mon,  2 Mar 2026 03:21:45 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (unknown [10.6.23.247])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 714C61800297;
	Mon,  2 Mar 2026 03:21:44 +0000 (UTC)
Received: from bmarzins-01.fast.eng.rdu2.dc.redhat.com (localhost [127.0.0.1])
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.17.1) with ESMTPS id 6223LhRu1830920
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 1 Mar 2026 22:21:43 -0500
Received: (from bmarzins@localhost)
	by bmarzins-01.fast.eng.rdu2.dc.redhat.com (8.18.1/8.18.1/Submit) id 6223LhVm1830919;
	Sun, 1 Mar 2026 22:21:43 -0500
Date: Sun, 1 Mar 2026 22:21:43 -0500
From: Benjamin Marzinski <bmarzins@redhat.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/24] scsi-multipath: clone each bio
Message-ID: <aaUCR-IoNItKVZCh@redhat.com>
References: <20260225153627.1032500-1-john.g.garry@oracle.com>
 <20260225153627.1032500-8-john.g.garry@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20260225153627.1032500-8-john.g.garry@oracle.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7sjutaTGn58bI4WA-RaXuMcTsSEO8uJnKnzqmC3kTSo_1772421706
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260301_192155_494022_A9B15EDF 
X-CRM114-Status: GOOD (  25.47  )
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

On Wed, Feb 25, 2026 at 03:36:10PM +0000, John Garry wrote:
> For failover handling, we must resubmit each bio.
> 
> However, unlike NVMe, for SCSI there is no guarantee that any bio submitted
> is either all or none completed.
> 
> As such, for SCSI, for failover handling we will take the approach to
> just re-submit the original bio. For this clone and submit each bio.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  drivers/scsi/scsi_multipath.c | 51 ++++++++++++++++++++++++++++++++++-
>  include/scsi/scsi_multipath.h |  1 +
>  2 files changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
> index 4b7984e7e74ba..d79a92ec0cf6c 100644
> --- a/drivers/scsi/scsi_multipath.c
> +++ b/drivers/scsi/scsi_multipath.c
> @@ -89,6 +89,14 @@ module_param_call(iopolicy, scsi_set_iopolicy, scsi_get_iopolicy,
>  MODULE_PARM_DESC(iopolicy,
>  	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
>  
> +struct scsi_mpath_clone_bio {
> +	struct bio		*master_bio;
> +	struct bio		clone;
> +};

If the only extra information you need for your clone bios is a pointer
to the original bio, I think you can just store that in bi_private. So
you shouldn't actually need to allocate any front pad for your bioset.

> +
> +#define scsi_mpath_to_master_bio(clone) \
> +		container_of(clone, struct scsi_mpath_clone_bio, clone)
> +
>  static int scsi_mpath_unique_lun_id(struct scsi_device *sdev)
>  {
>  	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;

> @@ -260,6 +269,39 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
>  	return 0;
>  }
>  
> +static void scsi_mpath_clone_end_io(struct bio *clone)
> +{
> +	struct scsi_mpath_clone_bio *scsi_mpath_clone_bio =
> +			scsi_mpath_to_master_bio(clone);
> +	struct bio *master_bio = scsi_mpath_clone_bio->master_bio;
> +
> +	master_bio->bi_status = clone->bi_status;
> +	bio_put(clone);
> +	bio_endio(master_bio);
> +}
> +
> +static struct bio *scsi_mpath_clone_bio(struct bio *bio)
> +{
> +	struct mpath_disk *mpath_disk = bio->bi_bdev->bd_disk->private_data;
> +	struct mpath_head *mpath_head = mpath_disk->mpath_head;
> +	struct scsi_mpath_clone_bio *scsi_mpath_clone_bio;
> +	struct scsi_mpath_head *scsi_mpath_head = mpath_head->drvdata;
> +	struct bio *clone;
> +
> +	clone = bio_alloc_clone(bio->bi_bdev, bio, GFP_NOWAIT,
> +				&scsi_mpath_head->bio_pool);

Why use GFP_NOWAIT? It's more likely to fail than GFP_NOIO. If the bio
has REQ_NOWAIT set, I can see where you would need this, but otherwise,
I don't see why GFP_NOIO wouldn't be better here.

> +	if (!clone)
> +		return NULL;
> +
> +	clone->bi_end_io = scsi_mpath_clone_end_io;
> +
> +	scsi_mpath_clone_bio = container_of(clone,
> +					struct scsi_mpath_clone_bio, clone);
> +	scsi_mpath_clone_bio->master_bio = bio;
> +
> +	return clone;
> +}
> +
>  static enum mpath_iopolicy_e scsi_mpath_get_iopolicy(struct mpath_head *mpath_head)
>  {
>  	struct scsi_mpath_head *scsi_mpath_head = mpath_head->drvdata;
> @@ -269,6 +311,7 @@ static enum mpath_iopolicy_e scsi_mpath_get_iopolicy(struct mpath_head *mpath_he
>  
>  struct mpath_head_template smpdt_pr = {
>  	.get_iopolicy = scsi_mpath_get_iopolicy,
> +	.clone_bio = scsi_mpath_clone_bio,
>  };
>  
>  static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
> @@ -283,9 +326,13 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(void)
>  	ida_init(&scsi_mpath_head->ida);
>  	mutex_init(&scsi_mpath_head->lock);
>  
> +	if (bioset_init(&scsi_mpath_head->bio_pool, SCSI_MAX_QUEUE_DEPTH,
> +			offsetof(struct scsi_mpath_clone_bio, clone),
> +			BIOSET_NEED_BVECS|BIOSET_PERCPU_CACHE))

You don't need 4096 cached bios to guarantee forward progress. I don't
see why BIO_POOL_SIZE won't work fine here. Also, since you are cloning
bios, they are sharing the original bio's iovecs, so you don't need
BIOSET_NEED_BVECS.

-Ben


