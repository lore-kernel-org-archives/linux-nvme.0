Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02628C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 04:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=; b=ZMx4i4vuLHOkeMtOZR5xG8wqZ5
	f9SixjDTkYv7MpdiU4HNlNm/rORPWB7HIUCzExkdvZZR+vKNsvkDpcImSrSJ9vOdfFKAvpaNIZIgz
	9c3pCXzs8jU8Orr0ueBGLiRosq5JwbixLIch/6xnilpFXTlxdRNbx2rihkdqC6YkWYqWCcI0iOEGP
	7zOSENOLmavgVgIQhexvnRqyRDSP+D/h3QuQXxKMa+KnALVQjgVtKPU9qnjNTzdfR5hR+wqC7/O0j
	Mk36CKJjTuk4pWmqxi9UrAHHblFYH6adn+U+qTYI4Y2pTTwT3TTFXyysqTNChl+1YTcxjYf+0GATh
	8YtHh88Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngfuA-001WTA-Lg; Tue, 19 Apr 2022 04:55:58 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngfqB-001UCg-A5
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 04:51:53 +0000
Received: by mail-lf1-x129.google.com with SMTP id b21so27355194lfb.5
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ionos.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
 b=SJ+jl8otuJP8V2SgmRrkKx5N5mzchzJWNs3wHGu/KEMaBtHJMlOSyPwEwTYRCJOsK0
 +ub417XW+OB47SmEbjExHhWdvjVWNP6f4maHx7wpcQ/meMLPTDZio2MhC3cJJ+CFcG7A
 WyaAXMErjpaI/XL4ZkxN4ZoByVo51Plmy8MlzTn6CKA4kPvTL6QPTM/FElDnmxz/4bAo
 dNPevLcXfcZa94Hc/QRZN/ahpyGhXVxqtHvMswx1d+ioXM8CH8EB0Ocsp4CDYa7mfCxx
 3EMIYtoYuS9+fNRK0znetQsYbQBpHaSNFwuzb6Pw3NmrbbAzHjf8OVLAsic0niCU/6Hj
 1cWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BI9yKDogyA9J1nIp2A5DqA5VrUzX8xmulCW+rbuq8PY=;
 b=KKN7bTqDIqtmbe0o4PSktZqE8nyHIxdaV3KlJiwxpdIKR/3EadS9QxMd3g12FnZa1e
 1+7km2lBjUgRTgfVmEEvBClJYK9a59Z+JoFMXROWUwhILqM8NVoxcH0sTbskIpG/nX/1
 xSDB3efF1bZx4cOrz5uwzKcyfclkTcw8KCffky2Vliq7RO2zPEkRdO9+aSusf/lrPl7R
 TDXwV5fbLXlShzAwW/KiKs2GmmguGyr5XY5CoWowXwVPTMltb0dYn1dVBarqUTt/DI+r
 zT8o3/2tLRIuhLbDrSm/0yBCBLNbauuNzVhQoj9tevEvE2Em0S4WLY+P2Q0cNA7rlpZK
 Po7w==
X-Gm-Message-State: AOAM5317YMzPpTOtsC21Bbz2PhVfN/17uugqMLtHayGGJbNbfW8vhqkF
 tO6w84L1OjW6uakXOZbTPfANAsmSoBzeE6JGgzKXbg==
X-Google-Smtp-Source: ABdhPJyLR4ZusRr2xSa6FgTHa9kgMMN14+gTuhXJUl7advlAotvmYnqJxqDiVIivr0X1ZGDx839mhVaChBp2powMkIg=
X-Received: by 2002:a05:6512:10c5:b0:471:a703:bca4 with SMTP id
 k5-20020a05651210c500b00471a703bca4mr1289967lfg.581.1650343907228; Mon, 18
 Apr 2022 21:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-11-hch@lst.de>
In-Reply-To: <20220418045314.360785-11-hch@lst.de>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 19 Apr 2022 06:51:12 +0200
Message-ID: <CAMGffEnxwHE_QgN2OS93BHe6U+XdYc_R5OmSROmF5F-HXK_E4A@mail.gmail.com>
Subject: Re: [PATCH 10/11] rnbd-srv: use bdev_discard_alignment
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>, 
 Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, 
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org,
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, 
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-s390@vger.kernel.org, dm-devel@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_215151_500430_E62610BE 
X-CRM114-Status: GOOD (  18.30  )
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

On Mon, Apr 18, 2022 at 6:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Thx!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.h b/drivers/block/rnbd/rnbd-srv-dev.h
> index d080a0de59225..4309e52524691 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.h
> +++ b/drivers/block/rnbd/rnbd-srv-dev.h
> @@ -59,7 +59,7 @@ static inline int rnbd_dev_get_discard_granularity(const struct rnbd_dev *dev)
>
>  static inline int rnbd_dev_get_discard_alignment(const struct rnbd_dev *dev)
>  {
> -       return bdev_get_queue(dev->bdev)->limits.discard_alignment;
> +       return bdev_discard_alignment(dev->bdev);
>  }
>
>  #endif /* RNBD_SRV_DEV_H */
> --
> 2.30.2
>

