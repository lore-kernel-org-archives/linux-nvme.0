Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A5BCAC5AE
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 01:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EpH3vDieEOf5P6kACxecFbAgag5Z9fa9GewUJ4RQEl0=; b=ovkjDaTzVFYBuCN77UJUC6Y5CC
	B6rgqfrqe+WKhMgAyFS/YDHEcCYjiCtOq3Kk9LlBTqwJD/UhiR/ygmpEgdEDA16h0/9ZjB9Zvac+G
	vQNdaQR2jfIZBsRIJxSMQiYowOtCx9elxlgefCRuk97Jd0C6OkX5RnVv9inyGJvtGVt/eorjpXjO5
	bQF2DKlFtNFTR3EGmySmjyxrE4bfcVun+cKL07XUxG6E2LqrgaBKMyqQ5k055Fbr7Jd1VA4de8RYP
	nztdeOMUv+RVayiAmrLtyZg1wYjrgDfeK8RU0NXQK+l1zk/P3ZoUtwNmxzCBJ6afshZgTEiETSSb9
	jVe0QHeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1aZ7-00000005ABl-1TnV;
	Thu, 25 Sep 2025 01:14:33 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1aZ4-00000005AAt-2xd3
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 01:14:32 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-77f41086c11so490689b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Sep 2025 18:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758762869; x=1759367669; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EpH3vDieEOf5P6kACxecFbAgag5Z9fa9GewUJ4RQEl0=;
        b=XDOhl1EyWnoAgHvJvDVZaM0pgpUWHnjcq2Su0+f+3FLmXKn7LTmqyt4QrMcQS5zVdJ
         99c34lAmTUjywgkuPp7c56PXINsXyMSmi1cjn+EWsfDtz6Hj+l8T7+tVwlLDuKzVeVT/
         Dh2ceHTL2pfyu3pMXxZJuR0e6MF5ehA8dKxMECfEXbAIqSAlqBx7cY2EhFXP1zV2XVnb
         Ao4GUysUX1zbWHp/Eb572t1znZPT7ZPTLYycVi/8d2Bh2zTWBzZHf8kMShK9ZEu5XJHC
         OrfW/v9UiEKg1h+BJCW0cASqleJhVk+YBxdSzsQaEjtAMk7Sa7bQlnV7wrXYY7ndmaiH
         0Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758762869; x=1759367669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpH3vDieEOf5P6kACxecFbAgag5Z9fa9GewUJ4RQEl0=;
        b=CnROpvtgI13EHkE51Yqv6tx+HdZxK3oP7LkQhDcALYwBEWCY34KaXqgu5mcl7f+bc7
         b62tcJvj4JMfK0kBXVikwikcxdZfKIuXeTtoulrBlBLsCB1k07LredhJxcr1pn37HepF
         cYme47vYRzXclT8h9MTGyfh2w9L4BPFU/6V0AFXeXb2avck0r2B8yNCF9tF5gSxmstUL
         l1qECNrxvE/fHNxX7aPuLj/OLfRhoI6G6lk0RR2Ei8C5sJSrd2pYzA0AWL+SgcF65BD8
         IdUOzUiZHN5WMKY3BHtxWw3eNGcLqQj/y4ydO3vfBphnUvMwGsNOSlj1k+PEbhTE3gCJ
         b83Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMTWR+ljkDxf6zFikOOBVS8gs6AFzHfj1BC4IaZcdk0r3Ecn7L1BUoYncDPgnOuO1TygFvzdVkWTm3@lists.infradead.org
X-Gm-Message-State: AOJu0YwDVb50JM4q7IejDX4aElD4/7UPPZP2gIJf/n08HtFUqdVRKIbG
	aN8qcUbYX29+gNViVz7A8gum0IG1TLmVlZyhbCalmWGDXlJzippdTY2G+vmB8/lIU1A=
X-Gm-Gg: ASbGncu+GGV3dLMsm3RDvwEFaeDa4sBRQqHAPFfm2rGCAgSE243HcIZUwW2Z79MVgyn
	4mV2kKUbkMxplCdRvVaDO75Z6x4Z9B0CmbZiQqDWopHMaV/P8PkuS+kUCy3LDUtSSRoOiznsrAR
	KvY7tEGyg88kkPfDanRzr81qkBdnjGG6NBq4HEVanm70HX7GkZY3Q2f+RAGMZgl0+PQU20MxOJd
	9h8wVQhLTmky3GDTJSDtr3Jpb3arOTniOwiFW6h26zh10gEOo2sVUCIBV6VqbIiYlP3IyKiS+6+
	nkrhl9JT0mE2SrlesHvcXf/teH3fMUmOj+ZYMuNN1Oitx6mae3PfO43z7O0Qiwy2WNgp8QN+v9V
	mh6nAZm/70ZSpbwMMPM0Bj4vZQTEWYPl+5cWZFm6vrYc=
X-Google-Smtp-Source: AGHT+IFbdkdawYQ5DW+wMtEwe5sjA9aOuzPxMZ0/627qe7vqGZqDMaJiDojubyykTXfFK/7YWQNpJA==
X-Received: by 2002:a05:6a20:1588:b0:2d5:e559:d24b with SMTP id adf61e73a8af0-2e7cdda1022mr1961101637.32.1758762869339;
        Wed, 24 Sep 2025 18:14:29 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with UTF8SMTPSA id d2e1a72fcca58-7810238ca29sm337965b3a.6.2025.09.24.18.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 18:14:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 18:14:27 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Amit Chaudhary <achaudhary@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, randyj@purestorage.com,
	jmeneghi@redhat.com, emilne@redhat.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY
 disposition
Message-ID: <20250925011427.GC3269-mkhalfella@purestorage.com>
References: <20250924224319.4557-1-achaudhary@purestorage.com>
 <aNR4m9wrO5cgFZIe@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNR4m9wrO5cgFZIe@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_181430_877867_C645DFF6 
X-CRM114-Status: GOOD (  20.39  )
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

On 2025-09-24 17:02:51 -0600, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 03:43:18PM -0700, Amit Chaudhary wrote:
> >  static inline void nvme_start_request(struct request *rq)
> >  {
> > -	if (rq->cmd_flags & REQ_NVME_MPATH)
> > +	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
> >  		nvme_mpath_start_request(rq);
> >  	blk_mq_start_request(rq);
> >  }
> 
> Using "retries" is bit indirect as a proxy for multipath active counts.
> Could this be moved to the mpath start instead, directly using the flag
> that accounts for the path? This also helps to keep track if the command
> gets retried across a user toggling the policy to "qd".
> 
> ---
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3da980dc60d91..1c630967ddd40 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -182,7 +182,8 @@ void nvme_mpath_start_request(struct request *rq)
>         struct nvme_ns *ns = rq->q->queuedata;
>         struct gendisk *disk = ns->head->disk;
> 
> -       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +       if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD &&
> +           !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
>                 atomic_inc(&ns->ctrl->nr_active);
>                 nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
>         }
> --

193         nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
194         nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
195                                                       jiffies);

Doing it this way might messup with stats accounting because the two
lines above will be executed on request retry. I do not think we need
that, right?

