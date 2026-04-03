Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5602E88D7F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KlucbAEqwcNJwIj7lkZqI+Mpg+aVJI04l6WTdjinCag=; b=FwOGTSKKa36DVjoheJ1tKtOxLH
	UT9Z+x4yq6LbMYa+t2pTnQ22Zer7H0Oveg5nw4M8MBhZbqopykts6uAlXIj/bp8LksYyXNQFrbQDD
	/N/1fg4urWjTpQn48YCg4SLyF2A/0McoKpJj9TsLfJsRBJtWLixI+6zb71efPpc/Q3oZyjHmSGJ4v
	MurAx3gFUnQXb4kBuAo5zQscwkKLzSib+R/C6qj1q+Yp85+qTUYrBmEpuOCtl0YlyInBV6E9fcAGM
	Mlqj1qrQgDyFaMPrjCpKuC1zDTwhkYHzBMIk6H3g0cNeL4EYNYBT598wN8axEtpYn7DYjI7WpOYFy
	jDq58YxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ss7-000000037H0-224o;
	Sat, 04 Apr 2026 04:44:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8TZi-000000013pE-2Hip
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 01:43:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775180633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KlucbAEqwcNJwIj7lkZqI+Mpg+aVJI04l6WTdjinCag=;
	b=THmAuYWzdvHxUCVFRHz6gXtjKMMnAD3iNc3oA1EdPgKhp+lz70Gs5Ovx5drBJLhVk75bql
	ctb3ERmUCZLxQxAIN2O9JRPXc/+hawDHOQP69vPeIQp//JHden7SRfntlSORtFpaMIQJZC
	kqaujEwAp2Ad3xntzxzWOklQcUGAnk0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-7ZLuw8b1OkyBfyGgFcOEeg-1; Thu,
 02 Apr 2026 21:43:47 -0400
X-MC-Unique: 7ZLuw8b1OkyBfyGgFcOEeg-1
X-Mimecast-MFC-AGG-ID: 7ZLuw8b1OkyBfyGgFcOEeg_1775180623
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F31A9180047F;
	Fri,  3 Apr 2026 01:43:40 +0000 (UTC)
Received: from fedora (unknown [10.72.116.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74F381978D41;
	Fri,  3 Apr 2026 01:43:17 +0000 (UTC)
Date: Fri, 3 Apr 2026 09:43:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	mst@redhat.com, aacraid@microsemi.com,
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
	liyihang9@h-partners.com, kashyap.desai@broadcom.com,
	sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
	chandrakanth.patil@broadcom.com, sathya.prakash@broadcom.com,
	sreekanth.reddy@broadcom.com, suganath-prabu.subramani@broadcom.com,
	ranjan.kumar@broadcom.com, jinpu.wang@cloud.ionos.com,
	tglx@kernel.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com,
	bigeasy@linutronix.de, yphbchou0911@gmail.com, wagi@kernel.org,
	frederic@kernel.org, longman@redhat.com, chenridong@huawei.com,
	hare@suse.de, kch@nvidia.com, steve@abita.co, sean@ashe.io,
	chjohnst@gmail.com, neelx@suse.com, mproche@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com,
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v9 10/13] blk-mq: use hk cpus only when isolcpus=io_queue
 is enabled
Message-ID: <ac8bMOVqTbpg5Pq_@fedora>
References: <20260330221047.630206-1-atomlin@atomlin.com>
 <20260330221047.630206-11-atomlin@atomlin.com>
MIME-Version: 1.0
In-Reply-To: <20260330221047.630206-11-atomlin@atomlin.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: aRmDTGZBKDQ5-Dew_8gm-QR0hsnm_gXWwmEg4ew529E_1775180623
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_184354_658979_377826C3 
X-CRM114-Status: GOOD (  22.67  )
X-Mailman-Approved-At: Fri, 03 Apr 2026 21:44:33 -0700
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

On Mon, Mar 30, 2026 at 06:10:44PM -0400, Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> Extend the capabilities of the generic CPU to hardware queue (hctx)
> mapping code, so it maps houskeeping CPUs and isolated CPUs to the
> hardware queues evenly.
> 
> A hctx is only operational when there is at least one online
> housekeeping CPU assigned (aka active_hctx). Thus, check the final
> mapping that there is no hctx which has only offline housekeeing CPU and
> online isolated CPUs.
> 
> Example mapping result:
> 
>   16 online CPUs
> 
>   isolcpus=io_queue,2-3,6-7,12-13
> 
> Queue mapping:
>         hctx0: default 0 2
>         hctx1: default 1 3
>         hctx2: default 4 6
>         hctx3: default 5 7
>         hctx4: default 8 12
>         hctx5: default 9 13
>         hctx6: default 10
>         hctx7: default 11
>         hctx8: default 14
>         hctx9: default 15
> 
> IRQ mapping:
>         irq 42 affinity 0 effective 0  nvme0q0
>         irq 43 affinity 0 effective 0  nvme0q1
>         irq 44 affinity 1 effective 1  nvme0q2
>         irq 45 affinity 4 effective 4  nvme0q3
>         irq 46 affinity 5 effective 5  nvme0q4
>         irq 47 affinity 8 effective 8  nvme0q5
>         irq 48 affinity 9 effective 9  nvme0q6
>         irq 49 affinity 10 effective 10  nvme0q7
>         irq 50 affinity 11 effective 11  nvme0q8
>         irq 51 affinity 14 effective 14  nvme0q9
>         irq 52 affinity 15 effective 15  nvme0q10
> 
> A corner case is when the number of online CPUs and present CPUs
> differ and the driver asks for less queues than online CPUs, e.g.
> 
>   8 online CPUs, 16 possible CPUs
> 
>   isolcpus=io_queue,2-3,6-7,12-13
>   virtio_blk.num_request_queues=2
> 
> Queue mapping:
>         hctx0: default 0 1 2 3 4 5 6 7 8 12 13
>         hctx1: default 9 10 11 14 15
> 
> IRQ mapping
>         irq 27 affinity 0 effective 0 virtio0-config
>         irq 28 affinity 0-1,4-5,8 effective 5 virtio0-req.0
>         irq 29 affinity 9-11,14-15 effective 0 virtio0-req.1
> 
> Noteworthy is that for the normal/default configuration (!isoclpus) the
> mapping will change for systems which have non hyperthreading CPUs. The
> main assignment loop will completely rely that group_mask_cpus_evenly to
> do the right thing. The old code would distribute the CPUs linearly over
> the hardware context:
> 
> queue mapping for /dev/nvme0n1
>         hctx0: default 0 8
>         hctx1: default 1 9
>         hctx2: default 2 10
>         hctx3: default 3 11
>         hctx4: default 4 12
>         hctx5: default 5 13
>         hctx6: default 6 14
>         hctx7: default 7 15
> 
> The assign each hardware context the map generated by the
> group_mask_cpus_evenly function:
> 
> queue mapping for /dev/nvme0n1
>         hctx0: default 0 1
>         hctx1: default 2 3
>         hctx2: default 4 5
>         hctx3: default 6 7
>         hctx4: default 8 9
>         hctx5: default 10 11
>         hctx6: default 12 13
>         hctx7: default 14 15
> 
> In case of hyperthreading CPUs, the resulting map stays the same.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>  block/blk-mq-cpumap.c | 177 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 158 insertions(+), 19 deletions(-)
> 
> diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
> index 8244ecf87835..3b4fa3b291c9 100644
> --- a/block/blk-mq-cpumap.c
> +++ b/block/blk-mq-cpumap.c
> @@ -22,7 +22,18 @@ static unsigned int blk_mq_num_queues(const struct cpumask *mask,
>  {
>  	unsigned int num;
>  
> -	num = cpumask_weight(mask);
> +	if (housekeeping_enabled(HK_TYPE_IO_QUEUE)) {
> +		const struct cpumask *hk_mask;
> +		struct cpumask avail_mask;

This may overflow kernel stack.


Thanks,
Ming


