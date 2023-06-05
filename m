Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1C0C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2LOUE1+edZo8CLP02ssMHBKJqlKpC7hvUhEkUiHsJl4=; b=kNZPjY7dvzRgj6L2TULHUDcmOe
	rAhfhEiJUvdIxFUBj6KfTfjznmiF8Fsl1Aq7nBi9oeZ6EPqm2WP0IHAEubpy3OkUGldq6Mx52jeKB
	ptt+D/jSSjKbt4GNZ8wcP8oZJ1CJV7pNp0RUciNaGALxGAzMFy7iXrRV+z+CPL6AhocsQKf4KxNJc
	w4Hh/zzybG90t5Yk20cSqhybgkwn3ULXz+p/tPfmFOnZOVQqp+xq2KwumUYPo6BKfIfW0qZZlptEp
	LsFqebVYUqqUf94BIBQ0x/VHSm1ajymXFLj/b1SL5NTSxVeSCJLEn5z2v4t48Q9WBUGZRE65leyAy
	P0ZlfTGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6BFh-00FneA-37;
	Mon, 05 Jun 2023 14:32:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6BFf-00Fncg-2F
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 14:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685975523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LOUE1+edZo8CLP02ssMHBKJqlKpC7hvUhEkUiHsJl4=;
	b=QLzo1eFFl+ObvLDbLS2FH2rufend9Sb9+GiNTwXcS/trPDny4d5pZcnv97Iq1Vnk+dKBOS
	FTZo3sHDNEb47DHk6qix0c3VNt6wRLL/aoXdFLlo1vJS2Uvk1po1v1954Ux0XuE/6Zatsc
	mPpmgyIfKOIGCp7Ta3y87CjXU8CwJDE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-cEylvR2XOKi1e-ZpzK_G-A-1; Mon, 05 Jun 2023 10:32:02 -0400
X-MC-Unique: cEylvR2XOKi1e-ZpzK_G-A-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2568fd3f360so1663854a91.2
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 07:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975521; x=1688567521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LOUE1+edZo8CLP02ssMHBKJqlKpC7hvUhEkUiHsJl4=;
        b=IP3TL/GTsiGQ4c5QibqU7541Ogb9GwhUQg34VizdsJLZYqoU4fFAzHRZx1g5DJ0VI6
         41YwtB7rliGDQllsdcpCfxesfXfQMuUGnK5HGMuc8TErfXW+WUOEGNh4Lkg30S7KXawZ
         N4iE7D9JSg3JcEEbSWXuRCtEkRNWhGloUXdD5iz4tFTLHPQCwTOwlM43Sh7zEAN+Lh77
         Fbmh/PFlzQZBmTO4061cAWxd64/hcqvjijxCyEq1Pj/yctscpdG/UiXqS82hks6AxSgA
         XHxpyIAKcVbnHwBr8HBz0HCPhophSXzT69QuWh9f4CzKnbJD7xQXQLiAguZSoV/0LZ3x
         0yrA==
X-Gm-Message-State: AC+VfDyg4vScqBgV+kAaFRVSqem7v/U7FIvdsJ7IFaJf+PKE48Z6HNNL
	uk0CTrbAWezoggbHE7Bq3P7e2nSRoVkCQ7E0NRK6UOfnUH1HJTZUkP3Ra7mZQHnUjKDHwl5hm8m
	VV7KbMZFRSk7N/Qmc/y8buhajkm8Cwy+lYaLDmVXADeQ=
X-Received: by 2002:a17:90b:1241:b0:24c:5e6:7035 with SMTP id gx1-20020a17090b124100b0024c05e67035mr3740246pjb.30.1685975520835;
        Mon, 05 Jun 2023 07:32:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79eo6F/FYMQnL0znbN05LlFP4162WJ1RiEELM6PG6eNAfkSk/s/IY1CZksWJQ9xwWpnmdlbar2+RMMM6vMzlY=
X-Received: by 2002:a17:90b:1241:b0:24c:5e6:7035 with SMTP id
 gx1-20020a17090b124100b0024c05e67035mr3740228pjb.30.1685975520512; Mon, 05
 Jun 2023 07:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230530094322.258090-1-ming.lei@redhat.com> <20230530094322.258090-3-ming.lei@redhat.com>
In-Reply-To: <20230530094322.258090-3-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Mon, 5 Jun 2023 22:31:48 +0800
Message-ID: <CAHj4cs-4gQHnp5aiekvJmb6o8qAcb6nLV61uOGFiisCzM49_dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nvme: rdma/tcp: call nvme_delete_dead_ctrl for
 handling reconnect failure
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_073207_900257_9A93FFEE 
X-CRM114-Status: GOOD (  20.74  )
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

Thanks Ming, feel free to add:
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, May 30, 2023 at 5:44=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Reconnect failure has been reached after trying enough times, and control=
ler
> is actually incapable of handling IO, so it should be marked as dead, so =
call
> nvme_delete_dead_ctrl() to handle the failure for avoiding the following =
IO
> deadlock:
>
> 1) writeback IO waits in __bio_queue_enter() because queue is frozen
> during error recovery
>
> 2) reconnect failure handler removes controller, and del_gendisk() waits
> for above writeback IO in fsync/invalidate bdev
>
> Fix the issue by calling nvme_delete_dead_ctrl() which call
> nvme_mark_namespaces_dead() before deleting disk, so the above writeback
> IO will be failed, and IO deadlock is avoided.
>
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/rdma.c | 2 +-
>  drivers/nvme/host/tcp.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb73..cdf5855c3009 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1028,7 +1028,7 @@ static void nvme_rdma_reconnect_or_remove(struct nv=
me_rdma_ctrl *ctrl)
>                 queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
>                                 ctrl->ctrl.opts->reconnect_delay * HZ);
>         } else {
> -               nvme_delete_ctrl(&ctrl->ctrl);
> +               nvme_delete_dead_ctrl(&ctrl->ctrl);
>         }
>  }
>
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d57..2c119bff7010 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2047,7 +2047,7 @@ static void nvme_tcp_reconnect_or_remove(struct nvm=
e_ctrl *ctrl)
>                                 ctrl->opts->reconnect_delay * HZ);
>         } else {
>                 dev_info(ctrl->device, "Removing controller...\n");
> -               nvme_delete_ctrl(ctrl);
> +               nvme_delete_dead_ctrl(ctrl);
>         }
>  }
>
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang


