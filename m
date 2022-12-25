Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F35C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Dec 2022 01:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QOhJqsn2I5YI8XZK+8NgG0hywtzT/xnBSalKwrrs1f0=; b=o1HO4namvuqBFwcMc4VBte1f3h
	Vl1CmJfAKEKyeN48VF0BQj1FQpC+6hioWeszeItq2NPJTuE4TQ2kGPzXdspWuUtcbCDrnhwBEm0Nn
	qGmZeJwmExb6o/Hwj3NJAPMv9i3iAlm79bcjedt56X2Kh5mD+KXMNFAWOjjzceUv4UBP1O793EyQM
	D+WRc1yW0v3+7bywWq8HjrfVaOFs80irV+ZfOei8PCFrw+n8ZJUXLzNrF6ZQ6ECbs2MO/P35em5QQ
	YlwovMI/vpPp+MN2pOsS6eqST2z24eho3BJrDPM0We/vlVm1aVaSjsT0ucQBKq5oSWOUmsMsrXy+k
	gRgzb8iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9c92-0009JX-PB; Mon, 26 Dec 2022 01:19:12 +0000
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p9YR2-00FaaA-Fa
	for linux-nvme@lists.infradead.org; Sun, 25 Dec 2022 21:21:33 +0000
Received: by mail-qt1-x82d.google.com with SMTP id h26so7469574qtu.2
        for <linux-nvme@lists.infradead.org>; Sun, 25 Dec 2022 13:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOhJqsn2I5YI8XZK+8NgG0hywtzT/xnBSalKwrrs1f0=;
        b=VcQLV6B5WyLI8K34RzYeCfEUNVX/A9hlopHVDCNRZwgsgRxxd0Zhz4HQBDIR1wyqqP
         wDQU+nfG8ZUQp528Bl/SWBtp838oh4zn/3fqiaWFZO+y/lc/75OEGL3qas13UizeKMQz
         Hir9MTiEqT/TJ64tGAO3ZMkL3qWKlFcD0npzdhtmhADmTrRWGPlbLxWUR0oQKIqJl6JV
         Y1tQzE4u3M3+Y2SUd5shyAim/XTfQ9di05Jeat24omMOzPi4kJN7HmxjduJ+/E9nwTok
         59H/KSQXmnRnp9TOYoc2bhg78CkL01ZwmLXjbNNQoDihLynBJvQfd0xhPitYf4+fAMa2
         XOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOhJqsn2I5YI8XZK+8NgG0hywtzT/xnBSalKwrrs1f0=;
        b=awN6wstfN8G/wuKF99hoyYlNWCpuc3kqqxl0r8e3QeqMpDWIyEe6ePPT5ImLJzZzTF
         cQicFFaAz8/xTxcZAtqTq9pEh5sMa0cxdvJhqqDLfN5o+Q/M5BJWs1nCcpWjkF6rZX+D
         SwyZRE+LD20XVg36WAOK47mX/N2UObQMRSIsf6lEvV5sjP5nxSsEaz+dEKmFQDXbjzzM
         iubPNmpCaJzNpyyfi6QPe9tEJdoi/qQa8UW8taYSXfdLzV1mxxDQp9LBm5CxrXfu4zEB
         421+qw2BDEFtugRB8ivSGngzmPTCG9vXxEaA6/gs8Z08HnZr4zDgcSZ/dnmoYrCFUKxC
         Ou3A==
X-Gm-Message-State: AFqh2koyw4FuEur/K3u6hRpfhxY8zx4s1SbCVSF9ZdfNXSn+fZEJn5d0
	avgRncRdQV+NipQvfjSJOFCMUQ==
X-Google-Smtp-Source: AMrXdXtxj9XeIVodCdzyySlUUBvpuW9rtXjKh1FnMx+KaWyAboAF3PsrKwkQDJEeP3hLt/qkQACITQ==
X-Received: by 2002:a05:622a:34b:b0:3ab:6c32:800 with SMTP id r11-20020a05622a034b00b003ab6c320800mr20208641qtw.28.1672003290339;
        Sun, 25 Dec 2022 13:21:30 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bq22-20020a05622a1c1600b0039c7b9522ecsm5660379qtb.35.2022.12.25.13.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 13:21:29 -0800 (PST)
Date: Sun, 25 Dec 2022 13:21:28 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Christoph Hellwig <hch@lst.de>
cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <axboe@fb.com>, 
    Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
    Hugh Dickins <hughd@google.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme-pci: update sqsize when adjusting the queue
 depth
In-Reply-To: <20221225103234.226794-3-hch@lst.de>
Message-ID: <5844a9a0-c039-6c87-914f-4d240b8a634@google.com>
References: <20221225103234.226794-1-hch@lst.de> <20221225103234.226794-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221225_132132_557025_7A5C058F 
X-CRM114-Status: GOOD (  21.89  )
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

On Sun, 25 Dec 2022, Christoph Hellwig wrote:

> Update the core sqsize field in addition to the PCIe-specific
> q_depth field as the core tagset allocation helpers rely on it.
> 
> Fixes: 0da7feaa5913 ("nvme-pci: use the tagset alloc/free helpers")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Hugh Dickins <hughd@google.com>

(I'm not saying Tested-by, because although the equivalent of this
was in my testing last night, I don't believe it would have been
hitting the cases which this patch repairs.

And I won't be looking at 3/4 or 4/4 today: but certainly agree
that reducing the number of fields which need to be kept in sync
is a good step forward.)

> ---
>  drivers/nvme/host/pci.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 804b6a6cb43a9c..b13baccedb4a95 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2333,10 +2333,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>  	if (dev->cmb_use_sqes) {
>  		result = nvme_cmb_qdepth(dev, nr_io_queues,
>  				sizeof(struct nvme_command));
> -		if (result > 0)
> +		if (result > 0) {
>  			dev->q_depth = result;
> -		else
> +			dev->ctrl.sqsize = result - 1;
> +		} else {
>  			dev->cmb_use_sqes = false;
> +		}
>  	}
>  
>  	do {
> @@ -2537,7 +2539,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  
>  	dev->q_depth = min_t(u32, NVME_CAP_MQES(dev->ctrl.cap) + 1,
>  				io_queue_depth);
> -	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
>  	dev->dbs = dev->bar + 4096;
>  
> @@ -2578,7 +2579,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  		dev_warn(dev->ctrl.device, "IO queue depth clamped to %d\n",
>  			 dev->q_depth);
>  	}
> -
> +	dev->ctrl.sqsize = dev->q_depth - 1; /* 0's based queue depth */
>  
>  	nvme_map_cmb(dev);
>  
> -- 
> 2.35.1

