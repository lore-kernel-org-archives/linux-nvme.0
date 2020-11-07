Return-Path: <SRS0=JRV9=EN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66454C2D0A3
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 00:40:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA368206A1
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2020 00:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k2N9CQ9s";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaraML33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA368206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=86lM377rV0MMyPE9RNQzH+/iSFRlrmMeW34QgTC9RiU=; b=k2N9CQ9sJryoJCtRI0BTtiWhD
	s+523ZLfTLuAvH1NRdyibAfkxSqbHRHeSGYx16JjCeHybHxaebX39RhWUVp93hpK0GNZHl7BY+mCk
	as8DGpdkhWPP8xnvUBOQLQ7mHCNXEBLN9ZpUkkI4sfjTSM17LhENqsjeeZLnSp6XGduZNDiqGQyKJ
	jSaxqMZiTaLujxMiUBDwImDqfR1kdkTzXMwFlxFH51AgSrgo5V2uPaCSOV0QOO+xapsEvGdX4UEY+
	fpZ0AChZyLqUsyuwNHEPIKhg+xVekn61x4uE1YRjiXZtQ9GZg7X4VXNxSdb+ZY8U2stAHCvqu6veT
	uzCdqZt4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kbCGw-0000un-1d; Sat, 07 Nov 2020 00:40:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kbCGt-0000uG-Fj
 for linux-nvme@lists.infradead.org; Sat, 07 Nov 2020 00:40:00 +0000
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ABE612220B
 for <linux-nvme@lists.infradead.org>; Sat,  7 Nov 2020 00:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604709598;
 bh=yHGYGCtLswTDWsVV8G7btJ2YrfbhRJpoj/2QQHMNku0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JaraML33QnlELqv9b1nVGycC8TqrN2CO3mYGqYHHPbzpftbxLrgkNlDLzNuVKBnOA
 +2GGCnIf2S6SmvnOXWVOrneIGjkyT+jTAQmqF3CZZVfU2qqbBMNpn6QobIOWbu07iq
 qAPvrSntweEuYizqycf91KNQI82ZEYM27rTtgZAw=
Received: by mail-lf1-f43.google.com with SMTP id r19so2056985lfe.6
 for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2020 16:39:57 -0800 (PST)
X-Gm-Message-State: AOAM533Jj65ZTmdqde4Epn++sisBlmie4AGZ/kwngqddN2RViiU7kEiS
 uJpCPfn7nCSBCsLM6GFIZopsruOJAmVZ1LweExs=
X-Google-Smtp-Source: ABdhPJxa7Wve2F+59EP4hPqinvAbRhF4pNbwqT8FgL1QaPoOKbDOM27LB1KUwtpCP4KuABwtVBcs7qNXSe7PRXbnm/0=
X-Received: by 2002:a19:4b45:: with SMTP id y66mr1708840lfa.482.1604709595815; 
 Fri, 06 Nov 2020 16:39:55 -0800 (PST)
MIME-Version: 1.0
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-23-hch@lst.de>
In-Reply-To: <20201106190337.1973127-23-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Fri, 6 Nov 2020 16:39:44 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4TjGZYpf-Ad4sk5WMq8BLGTpxaCd-FnMfmqo49pX1Z9w@mail.gmail.com>
Message-ID: <CAPhsuW4TjGZYpf-Ad4sk5WMq8BLGTpxaCd-FnMfmqo49pX1Z9w@mail.gmail.com>
Subject: Re: [PATCH 22/24] md: remove a spurious call to revalidate_disk_size
 in update_size
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_193959_643911_017484B4 
X-CRM114-Status: GOOD (  18.78  )
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

On Fri, Nov 6, 2020 at 11:04 AM Christoph Hellwig <hch@lst.de> wrote:
>
> None of the ->resize methods updates the disk size, so calling
> revalidate_disk_size here won't do anything.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Song Liu <song@kernel.org>

> ---
>  drivers/md/md-cluster.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
> index 87442dc59f6ca3..35e2690c1803dd 100644
> --- a/drivers/md/md-cluster.c
> +++ b/drivers/md/md-cluster.c
> @@ -1299,8 +1299,6 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
>         } else {
>                 /* revert to previous sectors */
>                 ret = mddev->pers->resize(mddev, old_dev_sectors);
> -               if (!ret)
> -                       revalidate_disk_size(mddev->gendisk, true);
>                 ret = __sendmsg(cinfo, &cmsg);
>                 if (ret)
>                         pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
> --
> 2.28.0
>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
