Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF3FC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:52:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0410E2068D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WuK2f4OG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb/BkUcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0410E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6gVXGJCc7rF9Ymy/p7QWSiKe84GncRqU9N0bnFCmFSI=; b=WuK2f4OGn/JOB3ef5SjjsI4ii
	OIQPDzzxfs2vp2LexYiV3BmRGxfRzzmkQKg1cj+Gg1sGo5BnhkfafMW03FaNtolCX7FuyfX9Nnlrz
	UtTqKkrWPiLhI36UHb4qrWzfIwuGAxT+6M5SCsvgB0UTOmKfUJSQINQuiKzyAoMmup7H1jXYm7MY1
	z3FVzMNZFKPgwlP27p6wfPfsRjjlqu4xgWDEvRFsLb8Ssndq+X5/O70AjOEdmT4obUjFE+WjtF+dY
	bU0HUFLR0cYa6MJJ9rdQ+uVWjWFThR2n3HhGBGBGiEAxeHYjWhDp832naP14bRHHFtAHiVzybDW/g
	cDJPxTnvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc7af-0007FH-Pd; Mon, 09 Nov 2020 13:52:13 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc7ac-0007Df-OV
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 13:52:11 +0000
Received: by mail-il1-x141.google.com with SMTP id x20so8323409ilj.8
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 05:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kU2Lz6FCVrZiuEoHabGbCYI8mZi4aQygf2Kr0fLfGG4=;
 b=Lb/BkUcVIcd6xhv8oVONfECjW/ZB+eIGRHnh0dm3V/Dcve1CHMxGnjqr8op+1v76K7
 BboZLuIC9lFoWJc8zRN7ckG8JYkUCEMrBXYH3LeqwWaeQw6FiksBZKkC4/rY+nMcbUOP
 mcyx+jHFLBCXxcHO2RHq4/pyA2nmEefVK9oOy9OsQ2fr8vLqz43v1yvxxZclHh7D+k2N
 Qw7b/fXaJ5trjyicYsioOneOxQN4Qzfe8MAWER1MvLiN60BX2gzHW6baJIDiu8cGcvYG
 BbC7br0UMOuvYPQzgHxuAO2xrcgSSEORe8jj2L4/gatFyG+wbhw19VFJICOjyYa/QKXf
 TWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kU2Lz6FCVrZiuEoHabGbCYI8mZi4aQygf2Kr0fLfGG4=;
 b=eVbwquXGNR9W2QRl0e36FdzIQTvzy40Wffg2mAL7ufaeVtZ3R/1HDyLf39ORvyS6XE
 F/Z/tEYmurrnlhIYNhOMON/zbwECR4McdVc8SvUiPqvDI1GZWlD0/woBqmpkc/BNQrXl
 rN4HoFbx8h3TOgPWCIRgJYIfNH4u0GQTK0E49QOdxgvn3Yon9h7A4aq1H1TjNePLxqVS
 tXHtRZwjbmzDmhN6wxTnNkRgGyIIxWsU6GvqS1so81wmKgzZ0YmYoCv7HMaAEOScFr30
 L1nedSFg9vhLBEiXmkLUogcAfsqAdYg5uoJNf4jogT2AXZbskAfff4VJNJN+UxzxC6r+
 sbIg==
X-Gm-Message-State: AOAM5321hnUEqngKmaLUF/EV2uO3BilsD7HTyEBLc+RWXzPew7lMbubX
 2RoklYTRNBekxgZlsrC4AB7asbkWOh1+54Uk2Hc=
X-Google-Smtp-Source: ABdhPJyXm5ijaiShQDd7Xj0k0fsOvCm3U5j3JctcQpIY73kNN30YAUsNc9VfJ5DemzskInCCw4oOffcooZ/r5dSiKD8=
X-Received: by 2002:a05:6e02:c:: with SMTP id
 h12mr10623495ilr.177.1604929927708; 
 Mon, 09 Nov 2020 05:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-18-hch@lst.de>
In-Reply-To: <20201106190337.1973127-18-hch@lst.de>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Mon, 9 Nov 2020 14:52:08 +0100
Message-ID: <CAOi1vP83cOt_FOFLXQmgBpDgmaq8o8OQcUYWOb97jzkgOw6r4A@mail.gmail.com>
Subject: Re: [PATCH 17/24] rbd: use set_capacity_and_notify
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_085210_838246_58EDDB3E 
X-CRM114-Status: GOOD (  18.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Lars Ellenberg <drbd-dev@lists.linbit.com>,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Ceph Development <ceph-devel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 6, 2020 at 8:04 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/rbd.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index f84128abade319..b7a194ffda55b4 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4920,8 +4920,7 @@ static void rbd_dev_update_size(struct rbd_device *rbd_dev)
>             !test_bit(RBD_DEV_FLAG_REMOVING, &rbd_dev->flags)) {
>                 size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>                 dout("setting size to %llu sectors", (unsigned long long)size);
> -               set_capacity(rbd_dev->disk, size);
> -               revalidate_disk_size(rbd_dev->disk, true);
> +               set_capacity_and_notify(rbd_dev->disk, size);
>         }
>  }
>
> --
> 2.28.0
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
