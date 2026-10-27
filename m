Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA5606A31D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2026 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=AQIejA+B;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ms+H6bUY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VpFo+gUlQpYUZgbUClJEyH5z5myD99mraguGCQYm3pk=; b=AQIejA+Bg6kzplxRFqz1AiO+v6
	X9tSABLggqYxOPXEOWA4KLhn0OSSBIwxM2RBCotrGXZ82IzqTv8ZmMoxc3IwxSJ6dGrEx/qic65JK
	L0YAIeCAczB2YMei6KosHjI+JfcxF6BfpxBqjxOI/Kx/cId8H8PBMBA/5BRb342ixx3ZA15N4qvjA
	KcZlxzZpsdxA3i+GHws0AB39V2aHv9twIHzPlMEDPDckZuDSareNJEaKQLkDkf5QA4jUJxxM/u3G5
	jtVuXzVQrCTB0daMCDoy2mqb3dbn3lzKs0psivNoTtvCwhJDovw9j566Mr124Da3/wEcV4i6euPfQ
	dC2JVu0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqTK-00000005uwQ-17D7;
	Tue, 27 Oct 2026 23:20:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLqTI-00000005uvs-3JGD
	for linux-nvme@lists.infradead.org;
	Tue, 27 Oct 2026 23:20:48 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B351E60098;
	Tue, 27 Oct 2026 23:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0AF1F01825;
	Tue, 27 Oct 2026 23:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793143247;
	bh=VpFo+gUlQpYUZgbUClJEyH5z5myD99mraguGCQYm3pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ms+H6bUYo6meIs/3lSPOF1snn5pvBZNPkGg/Bbd6kpf8mqc0akef01s5iGiv++W98
	 WkfEC1qyJxL9Obt3c24QeiURIk9OaIE7Sym72mTkvBXF5L7fjxiyxZQ/8tnn6Gf9gm
	 +GwWBq4ORJqPM/hvYn4yacdTK5JnFce3a5ER5TH+exYXfI2Ze0fcHfBxCeyX67fCUa
	 h7rRal/ozdl+Mn82zdKmjwwWfjeMcX3lStml9uQIt5yb0p9ow6vDuclI8Tq72LiQHR
	 VS9q7ENRwBgoIGZep1rRsWsDV+7I2nw8fVWCM/Wu2LitiVHxTCaYDNhjlAiXiL4bs6
	 r2TIsKlS77kHA==
Date: Tue, 27 Oct 2026 17:20:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
Message-ID: <auExzRCjbyQeOU78@kbusch-mbp>
References: <20261027123950.3122316-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027123950.3122316-1-kanie@linux.alibaba.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 08:39:50PM +0800, Guixin Liu wrote:
> @@ -3035,6 +3048,14 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>  		goto out_free_ctrl;
>  	}
>  
> +	/*
> +	 * The queue locks are owned by the controller, not the queues:
> +	 * they outlive the per-queue connect/disconnect cycles so that
> +	 * sysfs readers can never race their destruction.
> +	 */
> +	for (i = 0; i < ctrl->ctrl.queue_count; i++)
> +		mutex_init(&ctrl->queues[i].queue_lock);
> +

Could you rebase to the latest nvme-7.4 branch? There is already a loop
happening here to initialize other fields in the queue.

