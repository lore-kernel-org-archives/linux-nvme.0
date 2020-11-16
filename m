Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3C8C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:37:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB2020B80
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1EJ5cqNF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wH0K96ai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB2020B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=K/394rfO/f5SBdD2uP4+XMl09X33vVLkuz1t35rpnTA=; b=1EJ5cqNFnzttuznpIBr+GRdt9
	8CiwdzYdfAEBX2JuxZlnPUwx0GjNHTWRJoN/AuCAKRMWjNyhHpwMz2Y8bYPFDSBaZ3twhpE1Acmny
	oWJNE0A1qf3Sak6uraXaAvFgW2NXeV4GV8bC7q2ioHcJX+l4CknZ5HpQedbcEMLdA7rSmHYqQhaPZ
	l6V84NcDcD9crUSenrFC/GuFl1Cpt9Xg2ccOpXz4jmHdgy9mNojLJbeC2C9A/EDL5NIW4IegmGz+G
	u9Ncojqais7Vaus+xR3R9WQKNgtcjmNhXF0yOIq0wcifhdtRUIR77XU/FRIP3hpYcFIxVSv1nSoXf
	C2zbj8zqQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keiRr-00039J-MP; Mon, 16 Nov 2020 17:37:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keiRo-00038C-ME
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 17:37:49 +0000
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1E6C522453
 for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2020 17:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605548267;
 bh=ftduAERcAIXDqH3TIoaKNDFMaog9lpKkHZKNbYpzPJA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=wH0K96aiOcV3zWDXEfO4eGXrSbfel4fzpavvJrcvlGnm+IOvE6CCXcyPRZ9CDEpWQ
 ERyPgn3goZaj4Rjri8kCDsRD2QqVIDrl9bwMtmzAsZXelVyGcoi/J8IVVb6h9ki8ms
 Nt6zKSXy/JZjbcTnM2HNzH4y+CQMSryqUl+eemUA=
Received: by mail-wm1-f51.google.com with SMTP id s13so17284wmh.4
 for <linux-nvme@lists.infradead.org>; Mon, 16 Nov 2020 09:37:47 -0800 (PST)
X-Gm-Message-State: AOAM533TOPdBF765lW1dDo0QdyupMjf4PsX+5iESkFwZBj/2LyDnjhw6
 bWuGHLzrtHObTQLjqoL2z/LUIu6Mgrz9hJCbVJ8=
X-Google-Smtp-Source: ABdhPJwSJNXG5A+c75VC7fB+eg5ocrYD0cMopnWErnzA3/FY5Qe4JfgRdEHZElz1KxxX9qTRF1opV72EejXl51sD+G0=
X-Received: by 2002:a1c:bbc4:: with SMTP id
 l187mr17490114wmf.133.1605548265533; 
 Mon, 16 Nov 2020 09:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-29-hch@lst.de>
In-Reply-To: <20201116145809.410558-29-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Mon, 16 Nov 2020 09:37:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5YeO0-Cb=avHu2osRKjz19Lvk4jWqaCdaqFnjbdPJtrw@mail.gmail.com>
Message-ID: <CAPhsuW5YeO0-Cb=avHu2osRKjz19Lvk4jWqaCdaqFnjbdPJtrw@mail.gmail.com>
Subject: Re: [PATCH 28/78] md: implement ->set_read_only to hook into BLKROSET
 processing
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_123748_826526_012C3242 
X-CRM114-Status: GOOD (  12.23  )
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
 linux-nvme@lists.infradead.org, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid <linux-raid@vger.kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>,
 Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 6:58 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Implement the ->set_read_only method instead of parsing the actual
> ioctl command.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

[...]

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
