Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67F9C7EE22
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uqc8N53ZwcRysbOJxGrXHPppVyJCQvKCb0bSM/Hdsuo=; b=fYqqrb8RzcgSNAHJB4NWVlOFrg
	5jm14tOe5u50IUhQw1w702lQy/G+u/GvfDC3cZ7OEEWC6MSRQHNfbZZ5QwrAg7h6MhJyTjHcMKoaG
	dlrZhFBo1LiXDapHqgmlZLn7rSGSB3mHJlkAV5N9SVDOqEwhE57pHOT/0aVIOkhoe/KIoa2ItJwFL
	YVaLm6Iv6Y50c9/IL7gT/AwLURr3u1evy/WRLB6spCURTQ1yExMfDzVsOUcDVyJBCl29fT5u9rcrd
	trQL+D7Pwl4HFNtwIupANbhDeT1fczmENcxfU7FsqAwJuiQ6yZcTWaU+/zuqiAcoDaFy9yT4iFK5F
	GCT1lKLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwB5H-001oS7-2m;
	Tue, 09 May 2023 00:20:03 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwB5E-001oRN-34
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 00:20:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B8C1E630B0
	for <linux-nvme@lists.infradead.org>; Tue,  9 May 2023 00:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71D9C433AA
	for <linux-nvme@lists.infradead.org>; Tue,  9 May 2023 00:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683591598;
	bh=MjkItiypktEo25V6DO99EB7GxcQEs1EfAiVhHUuOnbQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RSSudBY16vz4RroQGxUhku5OYcaCkTjMO58/KDOi1njcr8zgMeihbJkxIfe65FdwA
	 WTKRFk6yLOIpAzrnwSc0mgGoLoqHAmwLcw5j+/ZcE4ExvVWFtdQZHfyiT5v2LqPQAL
	 CJjAqVGQZKTLiM7Geg+UAZwtw9PLqV72x8dfHDiQPcnMah4gDRlxD0mfA6PQtR1ygY
	 tSHHJaV+yO9jZA69YjZYgxwTxbKWNwxGoRQkoKHqh2LcT4jRNC4u7QTtaySrD+bmEI
	 Jwb9ej+fJqbGeMH8Q1vK9wkTdfbBAJF3cszo7dZOpRxsmLDp07qqoh+s+uHedZ8+xd
	 8LPuzMoSTBDxA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so9501157a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 08 May 2023 17:19:58 -0700 (PDT)
X-Gm-Message-State: AC+VfDxk80w23MfLqOJyE15XJAEAByZWisTRITNd7+n1orMcmbAeSd0J
	KCYXnS+jGIPLpZzjtgsIyR8fddiUfISwas/F6VwF
X-Google-Smtp-Source: ACHHUZ6XguvB359TJD5EVeTjXaiA2ucEsERS2+WbXhgo3pznKhng9msxWTb8gnB50Rzaq/efZNnWYP+FsScnG1YYBIM=
X-Received: by 2002:a17:907:9808:b0:94f:4801:6d08 with SMTP id
 ji8-20020a170907980800b0094f48016d08mr10822326ejc.71.1683591597081; Mon, 08
 May 2023 17:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230503183821.1473305-1-john.g.garry@oracle.com> <20230503183821.1473305-2-john.g.garry@oracle.com>
In-Reply-To: <20230503183821.1473305-2-john.g.garry@oracle.com>
From: Mike Snitzer <snitzer@kernel.org>
Date: Mon, 8 May 2023 20:19:46 -0400
X-Gmail-Original-Message-ID: <CAH6w=ay1NNxh=9mQv5PCcDi3OY0mgvRXO_0VrmKBLAd1dcUQqQ@mail.gmail.com>
Message-ID: <CAH6w=ay1NNxh=9mQv5PCcDi3OY0mgvRXO_0VrmKBLAd1dcUQqQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/16] block: Add atomic write operations to
 request_queue limits
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, dchinner@redhat.com, jejb@linux.ibm.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, Himanshu Madhani <himanshu.madhani@oracle.com>, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230508_172001_097923_D122C342 
X-CRM114-Status: GOOD (  16.89  )
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

On Wed, May 3, 2023 at 2:40=E2=80=AFPM John Garry <john.g.garry@oracle.com>=
 wrote:
>
> From: Himanshu Madhani <himanshu.madhani@oracle.com>
>
> Add the following limits:
> - atomic_write_boundary
> - atomic_write_max_bytes
> - atomic_write_unit_max
> - atomic_write_unit_min
>
> Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 42 +++++++++++++++++++++
>  block/blk-settings.c                 | 56 ++++++++++++++++++++++++++++
>  block/blk-sysfs.c                    | 33 ++++++++++++++++
>  include/linux/blkdev.h               | 23 ++++++++++++
>  4 files changed, 154 insertions(+)
>

...

> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..e21731715a12 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,9 @@ void blk_set_default_limits(struct queue_limits *lim)
>         lim->zoned =3D BLK_ZONED_NONE;
>         lim->zone_write_granularity =3D 0;
>         lim->dma_alignment =3D 511;
> +       lim->atomic_write_unit_min =3D lim->atomic_write_unit_max =3D 1;
> +       lim->atomic_write_max_bytes =3D 512;
> +       lim->atomic_write_boundary =3D 0;
>  }

Not seeing required changes to blk_set_stacking_limits() nor blk_stack_limi=
ts().

Sorry to remind you of DM and MD limits stacking requirements. ;)

Mike

