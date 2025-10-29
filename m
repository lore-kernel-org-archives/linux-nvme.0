Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDF5CCF9EE
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 23:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ev4MgcEU/YMM004s+ooaPWltT7gsDwUNX82Pw1HrpeM=; b=xWi57Eut680TrP2st1kyJt66wv
	zG7nDLOHMldi7XH1gqECmcG/kcIAJURqRSHoLHzG6KVCXMzGtRW4mhUXH8ctMFOjCBVSdny67LyLE
	w72h7Tg74c0vJZSAsOTVV0/KvcnUT6dG9ShPFm2kZT0x46328254QJvxT/6wi1ij3wtxPbM9PJMPQ
	otkmlIfgpWB4p567y9UVLgAfuoTbkNdVMPCWBCKVIlthHyWQwmjfiXlac2UnY8lfgG2BT1lj71kTH
	HplYW1Q4P4KS2IRzez29dmLkwgTND2hGrhrQQeoZTk3FnuPCK9pdo4gMtVDk7qFkWEg3ivpC5Ezra
	5L6v1UlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEFgD-00000003Fdz-147O;
	Wed, 29 Oct 2025 23:34:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEFgA-00000003Fdb-2rT2
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 23:34:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761780848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev4MgcEU/YMM004s+ooaPWltT7gsDwUNX82Pw1HrpeM=;
	b=IaWz9xVmNlfUr9mEoOHLCYPZcKC0wBwjdn+JmRLlrSQGrlxx5kFHvrgcSI6562K3dQwPCC
	4lZncBQOndcFFAlhnuGfswmiJvRqpdt3a7q/v34PdnH+iKgXJk2F/ncL63yGq/P2Sm6xWl
	KMsgWbzvjmN75fva6VqEF6du3fDCJTs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-p1peaPsTPyennamT6acj3A-1; Wed,
 29 Oct 2025 19:34:05 -0400
X-MC-Unique: p1peaPsTPyennamT6acj3A-1
X-Mimecast-MFC-AGG-ID: p1peaPsTPyennamT6acj3A_1761780843
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 58D581800D8F;
	Wed, 29 Oct 2025 23:34:03 +0000 (UTC)
Received: from fedora (unknown [10.72.120.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 03278180057C;
	Wed, 29 Oct 2025 23:33:57 +0000 (UTC)
Date: Thu, 30 Oct 2025 07:33:52 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yzhong@purestorage.com" <yzhong@purestorage.com>,
	"sconnor@purestorage.com" <sconnor@purestorage.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"mkhalfella@purestorage.com" <mkhalfella@purestorage.com>
Subject: Re: [PATCH 1/1] nvme: fix use-after-free of admin queue via stale
 pointer
Message-ID: <aQKkYCdao3eyDdB7@fedora>
References: <20251029210853.20768-1-cachen@purestorage.com>
 <20251029210853.20768-2-cachen@purestorage.com>
 <65062542-e87c-4026-a58a-d5a29d03b8c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65062542-e87c-4026-a58a-d5a29d03b8c9@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_163410_795798_45998B2D 
X-CRM114-Status: GOOD (  21.91  )
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

On Wed, Oct 29, 2025 at 11:00:29PM +0000, Chaitanya Kulkarni wrote:
> On 10/29/25 2:08 PM, Casey Chen wrote:
> > From: Yuanyuan Zhong <yzhong@purestorage.com>
> >
> > When a controller is deleted (e.g., via sysfs delete_controller), the
> > admin queue is freed while userspace may still have open fd to the
> > namespace block device. Userspace can issue IOCTLs on the open fd
> > that access the freed admin queue through the stale ns->ctrl->admin_q
> > pointer, causing a use-after-free.
> >
> > Fix this by taking an additional reference on the admin queue during
> > namespace allocation and releasing it during namespace cleanup.
> >
> > Signed-off-by: Casey Chen <cachen@purestorage.com>
> > Signed-off-by: Seamus Connor <sconnor@purestorage.com>
> > ---
> >   drivers/nvme/host/core.c | 10 +++++++++-
> >   1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 8d8af58e79d1..184a6096a2be 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -687,6 +687,7 @@ static void nvme_free_ns(struct kref *kref)
> >   {
> >   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
> >   
> > +	blk_put_queue(ns->ctrl->admin_q);
> >   	put_disk(ns->disk);
> >   	nvme_put_ns_head(ns->head);
> >   	nvme_put_ctrl(ns->ctrl);
> > @@ -3903,9 +3904,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
> >   	struct gendisk *disk;
> >   	int node = ctrl->numa_node;
> >   
> 
> would be a good idea to add a comment at both places to explain why we 
> are taking this additional reference ? since this is specifically needed 
> for userspace.

Yes, it needs documentation, I believe it is because the reference of
`struct nvme_ctrl` doesn't cover ctrl->admin_queue & ctrl->admin_tagset.

Thanks,
Ming


