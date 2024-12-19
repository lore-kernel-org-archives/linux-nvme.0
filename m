Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B92E77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 15:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=; b=pThGboaBl0w3Mdrb9QgLUSYzzi
	UaadtX+5nUG2ytTKzDBQ0LcCbpXBnVVWgXoIsVAYnKPMmcnPGIDKM17bok3jjmsrgYzaON+xV7v3c
	iSqidLYCRaU32CdsIQUZ26TpIbSw9fHZhWUeAwEcJ/8TP2ukIcTiYc4e6FHizV/AFrj16IQSTaLlx
	2YYT7rq2QWhO0jvAqx+YEirXoPrXfNX8gS5oEoxh2a2JLsu6Nt3KWkPbJQdu9NqnH9RQ4mPsvMuQV
	IJjZxjaf3dDehj0vJ1S7sCZUXO49E6pgSh5IZ09l6C5VCCW8T4ksUbCX85U85PRy5H8z19a1yAVjE
	EjjyRsqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOItl-00000002EJm-2yWo;
	Thu, 19 Dec 2024 15:57:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOBxu-00000001HjE-41NH
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 08:33:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734597181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
	b=TGNZh66ZSF0UAk9V1Es3wBHvjbnzG1yHREa4Dn3qKfH03RURmJnPKY1ZczEpvyVhC1j6pv
	j5pNBEOAKb/DFJcnzsR6fiKMAEjV38KEpIZAjFRxf8Tb+SORPPfWxly1F78ftC3SmwrDdw
	WqZcHOL4PHECNu6+mLhfaPjnPazOLf8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-oNTrLcXjP16hBRg8i1GktA-1; Thu, 19 Dec 2024 03:31:16 -0500
X-MC-Unique: oNTrLcXjP16hBRg8i1GktA-1
X-Mimecast-MFC-AGG-ID: oNTrLcXjP16hBRg8i1GktA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43582d49dacso4158725e9.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 00:31:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734597075; x=1735201875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKgfqq1V/q2Bw/na+eWOMQ9Qre2mVUN/gi9oaR1AL+A=;
        b=iNY5tGrqRAsTZoql2+mpgXftzQsM1VlRdWnvI9KvgJB7sOxFczl1Y1l5PWX5J41Nb2
         1vaR0Kkv3qJD220qIgQLDMifkyoUYdyCUxzI5HdXnWqDXw1nUpRd8f0JfMUGHDtrpMXl
         FsgSW2/3jwk1FCUecj5R6M7gBXhhEwINaO3ggDsr7T5JVgiEwarNh7+rBed/v6AOFjeZ
         rRWSllSIMG8/W2Lc2ksHv6bOlmyLiqe4vn+WdyOY9GhlJFexOY50spQIJw/GWaw2Lk2X
         R+8O0VjlkWRpky9IHU3VnA3mtsS7wntTZ6GMJODeOckvmBbgqGh66ZVRvDKjIRhPuETD
         XlrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSPwxlkPJ1tM6d2j1irjzrFEjqcIYGHxc/h0pe3z/pt1hdRkOoNtzU4b/pgisUtMv0pkHYcixGjC9n@lists.infradead.org
X-Gm-Message-State: AOJu0YxA/uTz36DAzNhCO/xLSP6EjcS7mJnVj/Y/ztn0iLbCIwiTnJ7M
	tcnapj9LMDHqtlwt30TSsk9Z62POJ2EPVVMvfwuy8YOC150h0fth+I1v9GET+7U1Fqbqq0IYGTp
	pNCqtiBDtWrwy7puDGWvmMa4vWj0rEnxSgpcVPDZNcbUDISMq5rMFTh97EY8V+4Cl
X-Gm-Gg: ASbGncsa2GKTW3H2wmRxrRIQmzJ0IfIH2BxVMVKY1bNJpBgH+wkiehIBgKHptxKP9sm
	3Nc984cxokWrxTONLlRUWvU5PJtksDKQUjmg5y4RH9qICW8ZQBwPMPHkZQZOm/jtfkwQXdnsd4S
	Mb8jZYD4F3vzXM0Sue925NUKGsW0MuOVAfJuWQ9Wplu4nCk60A935XTxDv+Df8eksUzMmIdTCEs
	/pQpKcYX2pCNt0ZAixqMEUs5HnkngVzaXbAXjTQ6wDZfKavzA==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458555e9.14.1734597075386;
        Thu, 19 Dec 2024 00:31:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmEAGsD3J5lAW4FA+s63y3sWjvKNvfQZ3gFL7w0rvckTj28XiNMSxT5zIucbWC042DWgnKHg==
X-Received: by 2002:a05:600c:4ed2:b0:434:f7ea:fb44 with SMTP id 5b1f17b1804b1-4365535c6a3mr57458095e9.14.1734597074934;
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f6:4834:3deb:8c9:181b:4574])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm44515275e9.41.2024.12.19.00.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 00:31:14 -0800 (PST)
Date: Thu, 19 Dec 2024 03:31:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Wagner <wagi@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	Don Brace <don.brace@microchip.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <llong@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	storagedev@microchip.com, virtualization@lists.linux.dev
Subject: Re: [PATCH v4 6/9] virtio: blk/scsi: use block layer helpers to
 calculate num of queues
Message-ID: <20241219032956-mutt-send-email-mst@kernel.org>
References: <20241217-isolcpus-io-queues-v4-0-5d355fbb1e14@kernel.org>
 <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241217-isolcpus-io-queues-v4-6-5d355fbb1e14@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VOBgZNl4DHwSFRYWgvPy8cD6W9qGncw10kW_ttzeghU_1734597075
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_003303_067607_DA843409 
X-CRM114-Status: GOOD (  24.94  )
X-Mailman-Approved-At: Thu, 19 Dec 2024 07:56:32 -0800
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

On Tue, Dec 17, 2024 at 07:29:40PM +0100, Daniel Wagner wrote:
> Multiqueue devices should only allocate queues for the housekeeping CPUs
> when isolcpus=managed_irq is set. This avoids that the isolated CPUs get
> disturbed with OS workload.
> 
> Use helpers which calculates the correct number of queues which should
> be used when isolcpus is used.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>

The subject is misleading, one thinks it is onlu virtio blk.
It's best to just split each driver in a patch by its own.
for the changes in virtio:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c                | 5 ++---
>  drivers/scsi/megaraid/megaraid_sas_base.c | 3 ++-
>  drivers/scsi/virtio_scsi.c                | 1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ed514ff46dc82acd629ae594cb0fa097bd301a9b..0287ceaaf19972f3a18e81cd2e3252e4d539ba93 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -976,9 +976,8 @@ static int init_vq(struct virtio_blk *vblk)
>  		return -EINVAL;
>  	}
>  
> -	num_vqs = min_t(unsigned int,
> -			min_not_zero(num_request_queues, nr_cpu_ids),
> -			num_vqs);
> +	num_vqs = blk_mq_num_possible_queues(
> +			min_not_zero(num_request_queues, num_vqs));
>  
>  	num_poll_vqs = min_t(unsigned int, poll_queues, num_vqs - 1);
>  
> diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
> index 59d385e5a917979ae2f61f5db2c3355b9cab7e08..3ff0978b3acb5baf757fee25d9fccf4971976272 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_base.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_base.c
> @@ -6236,7 +6236,8 @@ static int megasas_init_fw(struct megasas_instance *instance)
>  		intr_coalescing = (scratch_pad_1 & MR_INTR_COALESCING_SUPPORT_OFFSET) ?
>  								true : false;
>  		if (intr_coalescing &&
> -			(blk_mq_num_online_queues(0) >= MR_HIGH_IOPS_QUEUE_COUNT) &&
> +			(blk_mq_num_online_queues(0) >=
> +			 MR_HIGH_IOPS_QUEUE_COUNT) &&
>  			(instance->msix_vectors == MEGASAS_MAX_MSIX_QUEUES))
>  			instance->perf_mode = MR_BALANCED_PERF_MODE;
>  		else
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index 60be1a0c61836ba643adcf9ad8d5b68563a86cb1..46ca0b82f57ce2211c7e2817dd40ee34e65bcbf9 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -919,6 +919,7 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	/* We need to know how many queues before we allocate. */
>  	num_queues = virtscsi_config_get(vdev, num_queues) ? : 1;
>  	num_queues = min_t(unsigned int, nr_cpu_ids, num_queues);
> +	num_queues = blk_mq_num_possible_queues(num_queues);
>  
>  	num_targets = virtscsi_config_get(vdev, max_target) + 1;
>  
> 
> -- 
> 2.47.1


