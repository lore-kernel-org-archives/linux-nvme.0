Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEFDC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 06:57:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D3F20665
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 06:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s/obFTOa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="OlOP6e+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D3F20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o3dORA8MIgcOZjZtXfTa7C/jY5xY3g9EkTgZGFMnVKc=; b=s/obFTOavtj3iCftLJ2+emyDk
	F8AAcUBl8jhIcxp3VxfDE9NkwSXxIuxOiXJyxVrg0aN6qsuGY+jSzyDMXIYX5NfplEzDn669KqzzP
	WeFS/xUEnPdb6XPdj+VWZsRQ1VSwlEuBOA94g4ISeU6CtWSSAOusI/iFGkaTwA4FukMPHS+i1Lxpa
	vt7EZMcq2e72V1Drd1m9al+ENvAHRU10tNDUsftvYxriCNXLMehyndDyqdEZZL5jodgXR7/a9o6U5
	D0EckFh5WDOMt35nnrqtuLuh41ic5Dp3mmwNGnhvgYx5KN6lrQggIH2uiZa52Food2tgKsnW6k73S
	pWG/wgrPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc16i-0007KD-Cy; Mon, 09 Nov 2020 06:56:52 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc16c-0007Jr-Px
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 06:56:47 +0000
Received: by mail-ed1-x541.google.com with SMTP id p93so7522804edd.7
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 22:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lhEWojdnEETMpoDmZaKWZITR453k36pmv/sfAr6vN/Q=;
 b=OlOP6e+hTTnzcMIwdaF/T/hnfIBf/9oJMDqvqjYzplHIQ4xMgH25+911Ixq0B3+K58
 5Dj/JmHZRD8Yi8zqOu+1rKF07XS2mrjA0Wv9PMukIV3uX40Qn/weu/uMdAMCHG7RU935
 A8pgkbko6hNqb1nFuLU3A3PiBPYVj8XjATb55mVvvHvMOvvFHanlnCDmyhaMxkXN6DKS
 Bf5AgcB50gTwwmoZvVJaG5dtCbnwCB8M7N5x+uhcjSrbjJF9nKnn2cuHHSz7I/a4akR/
 xE89AMdrexbc31NBbIF2vvHpBBUezGpS6XdWxnMo7c/NgKk9nHTIb/0D5wlGo0gz8gEr
 D1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lhEWojdnEETMpoDmZaKWZITR453k36pmv/sfAr6vN/Q=;
 b=Z0uu0RMS+PAT4vSvtwgpoBp912bSYlP5Djqgd+PmjAmfnJLxGvgqxMfQWT1EHFbsRV
 FLChl3HmhWDi5Lfa9Chsqxg3YOcInpWL7h2BUowTnow8V5Va9KznXlFkWZ676WfBryg5
 rytfzJhscxY0KFuA2l0t1EeYaQcH03OIWg7aNB31ACPtzf0NtbNIPgZfcmkRnlY6IMma
 HElOuGE+YrRObtODCY3GZ5gVMlz7ZFI8mdNKQ4xbNdFyJuODFhQntvW3+WfJuI20baGJ
 UA0feJc6mEhPmeFdrgSdjlFFMQVi3hrrnjZ9KjflhHPTuzJU+BBJ1U1u35twoFkcRFN7
 boKw==
X-Gm-Message-State: AOAM5329+tHOL280y3A4PpmGhIWp6YFxhkPamlQYut0W1SI54UgRyvuj
 hrcTzlvFcC3CSMPfgvxO2ZvVUKOfEvUqn6KKg3lmqQ==
X-Google-Smtp-Source: ABdhPJy5lMTAmAT8/Ewb7MyKs6V0kAUlIo1q9lM6dl2oB700nsAVEi6e4At1FesCFzDNwPnUu593st+zxY/BthW2KiM=
X-Received: by 2002:a50:fc89:: with SMTP id f9mr14573990edq.89.1604905003672; 
 Sun, 08 Nov 2020 22:56:43 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-19-hch@lst.de>
In-Reply-To: <20201106190337.1973127-19-hch@lst.de>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Mon, 9 Nov 2020 07:56:32 +0100
Message-ID: <CAMGffEnRgesKniK_X5b2nAoiQ_i6xqL4gnCw7dJxapkD-6Dvwg@mail.gmail.com>
Subject: Re: [PATCH 18/24] rnbd: use set_capacity_and_notify
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_015646_869273_B597EDE7 
X-CRM114-Status: GOOD (  18.28  )
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
 device-mapper development <dm-devel@redhat.com>, drbd-dev@lists.linbit.com,
 Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid <linux-raid@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
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
Thanks, Christoph!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 8b2411ccbda97c..bb13d7dd195a08 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -100,8 +100,7 @@ static int rnbd_clt_change_capacity(struct rnbd_clt_dev *dev,
>         rnbd_clt_info(dev, "Device size changed from %zu to %zu sectors\n",
>                        dev->nsectors, new_nsectors);
>         dev->nsectors = new_nsectors;
> -       set_capacity(dev->gd, dev->nsectors);
> -       revalidate_disk_size(dev->gd, true);
> +       set_capacity_and_notify(dev->gd, dev->nsectors);
>         return 0;
>  }
>
> --
> 2.28.0
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
