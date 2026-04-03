Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED86BE88D7F
	for <linux-nvme@archiver.kernel.org>; Sat,  4 Apr 2026 04:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hk3l4sJZ8VQmwKxYtifv90rkgr2B19mqHbHCn7fohLk=; b=fyhLl9PghlqlV1LQS4oRFv+sbo
	yvkcsaCJFkIqmLUirqFqCFVRkIti31GZ37tjDb2t8Eq3ImVrgLXqehohb/WYZDGOi9sPbS1QukC55
	2/xcPzalfs2CJMuE0LQN8CaazHz3PZuZJfj29IWR9lIwha7qs4LwNtjbmcGrq72839t0x6jwHv9mk
	Iy+ZsTtOYnmicJINGuJV4AgtbiBNDEo262+FHixSI+YvwlyZNVeKDSdijrm8hHYqA4+SZOZ3ro0/I
	WIDv5yP9CdUW7RriNLgpR2IZ7NrMNLYQnkm4CAU91FxAkCfkjpGHtX34YnghHe7nLFYh9jDMk8S+T
	2mz+ga4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ssC-000000037LG-0ZdX;
	Sat, 04 Apr 2026 04:44:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8UJN-000000016QB-01ob
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 02:31:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775183463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hk3l4sJZ8VQmwKxYtifv90rkgr2B19mqHbHCn7fohLk=;
	b=W9m3Nu02qntgCgQhAt9NaZPPh8ReiMXGHS80uiR+X3g16KuAHAAG8c/iMcCqzvD449y0Xi
	CxLQz1DlycX01qPApNt9ItwEhfoZT0Uu7Zkx5BwjLMWVaqKW9pB5xYbUO+tKyavsTXW3Zg
	vx9fhOYnU7r4x4kKCCxYubxxpre/K94=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-rCXx2cJTP-Klv46VrVi2tw-1; Thu,
 02 Apr 2026 22:30:59 -0400
X-MC-Unique: rCXx2cJTP-Klv46VrVi2tw-1
X-Mimecast-MFC-AGG-ID: rCXx2cJTP-Klv46VrVi2tw_1775183455
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 752D518005B0;
	Fri,  3 Apr 2026 02:30:53 +0000 (UTC)
Received: from fedora (unknown [10.72.116.83])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3908A1801A52;
	Fri,  3 Apr 2026 02:30:30 +0000 (UTC)
Date: Fri, 3 Apr 2026 10:30:26 +0800
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
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
Message-ID: <ac8l-w8ERG1YN2Wm@fedora>
References: <20260401222312.772334-1-atomlin@atomlin.com>
 <20260401222312.772334-14-atomlin@atomlin.com>
MIME-Version: 1.0
In-Reply-To: <20260401222312.772334-14-atomlin@atomlin.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: A3O93JIfGHlrI03w7LVUSLhGW1A83LMf2BKeeftUQ0o_1775183455
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_193105_128858_B3DFED5D 
X-CRM114-Status: GOOD (  23.39  )
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

On Wed, Apr 01, 2026 at 06:23:12PM -0400, Aaron Tomlin wrote:
> From: Daniel Wagner <wagi@kernel.org>
> 
> The io_queue flag informs multiqueue device drivers where to place
> hardware queues. Document this new flag in the isolcpus
> command-line argument description.
> 
> Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
>  .../admin-guide/kernel-parameters.txt         | 22 ++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 03a550630644..9ed7c3ecd158 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2816,7 +2816,6 @@ Kernel parameters
>  			  "number of CPUs in system - 1".
>  
>  			managed_irq
> -
>  			  Isolate from being targeted by managed interrupts
>  			  which have an interrupt mask containing isolated
>  			  CPUs. The affinity of managed interrupts is
> @@ -2839,6 +2838,27 @@ Kernel parameters
>  			  housekeeping CPUs has no influence on those
>  			  queues.
>  
> +			io_queue
> +			  Isolate from I/O queue work caused by multiqueue
> +			  device drivers. Restrict the placement of
> +			  queues to housekeeping CPUs only, ensuring that
> +			  all I/O work is processed by a housekeeping CPU.

All these can be supported by `managed_irq` already, please document the thing
which `io_queue` solves, and `managed_irq` can't cover, so user can know
how to choose between the two command lines.

`Restrict the placement of queues to housekeeping CPUs only` looks totally
stale, please see patch 10, in which isolated CPUs are spread too.

> +
> +			  The io_queue configuration takes precedence
> +			  over managed_irq. When io_queue is used,
> +			  managed_irq placement constrains have no
> +			  effect.
> +
> +			  Note: Offlining housekeeping CPUS which serve
> +			  isolated CPUs will be rejected. Isolated CPUs
> +			  need to be offlined before offlining the
> +			  housekeeping CPUs.
> +
> +			  Note: When an isolated CPU issues an I/O request,
> +			  it is forwarded to a housekeeping CPU. This will
> +			  trigger a software interrupt on the completion
> +			  path.

`io_queue` doesn't touch io completion code path, which is more
implementation details, so not sure if the above Note is needed.


Thanks,
Ming


