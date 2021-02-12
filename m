Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A31C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:45:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5949364E65
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 15:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5949364E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EWp9JLX1umRa7+YNLu3LgQO7AvNbLpcwU1eXfqqzbxM=; b=lTLg1cw92Zc0zQlXU7sKqUFAt
	GFXHGCerrhsiQ3Oeo4nolIghAiYxbLQJXZaWfpUpqtfx+KzDodN+TAK/hInCvrFfUYcTW9I4hldy+
	AqsX6itcCJVSP5F8agJTlEVmVXZZL7kyAHO4zcoVkZegLmMdsHQ8Va4KLpl60sFzkc/hvt+0ooi1S
	zidaRESPDMxmXgGPC3jKtwlCS9wB4/haaEfLVWbAipboRAWZ4onA5fANUJB63iFKD420s10ttkR+j
	d0KD5ETSSsWR7HDfb7oFDa5HbHlm8be2vLM4iGSuR27JZJOHQMFbOPDVd3tJbLRoJq37OujXEIPgT
	81C3Q1lcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAadg-0004bw-LQ; Fri, 12 Feb 2021 15:45:48 +0000
Received: from mail-pl1-f181.google.com ([209.85.214.181])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAadd-0004bE-NJ
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 15:45:46 +0000
Received: by mail-pl1-f181.google.com with SMTP id d15so64488plh.4
 for <linux-nvme@lists.infradead.org>; Fri, 12 Feb 2021 07:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M8C1yZZgp4rNPfghNpxWN41GpCK1+InKLAelhxbvplw=;
 b=lz9hiGJSZqxwy3Od1Y6vRWK12osCxadR4NSpc5BvKfpd+FvLcnfBunKGsAxyV8WD9S
 WQ+DJjFI4U2cKXJiavkv3K9CAemfHvxGzj8CFuQgAey7kZZzETJR32jAgz8+B70KLDoo
 rGRy9m0j7ms8esoeCPHFLuuIa5fO+kBVd5QRQU5i7OYsssn3oQ1qGn1SRGQe2+63/ceb
 wH8BYz7MY8/A+zSILGW++9mTOtvdv13W+MYlClR+IbBslr3nMEK5jAKgWWXxUJ0xaz+T
 izgk0E2oFhu2KR88g/s2DtkvhTh2wArLS/fn3teGL0oY/qtIiITtFdUqc1bV7F3aGMks
 LhGg==
X-Gm-Message-State: AOAM532t1HkwHeA6bByS3KSnb92oeqkJeJ619hlbLbkozi6SyeSFT1SA
 WI8ksrVAoK9qgXLcxyjfqxvJAk/CkAXMzbjA3rk=
X-Google-Smtp-Source: ABdhPJyYCXBmQgiV5syIf5Cv8mFWKTwy1gjS5Yhyhg4Qi/jYzZasdmgfRgJp2ybsEGtlgybQDIghy8J0Yy2+jaKx2kI=
X-Received: by 2002:a17:90a:4e1:: with SMTP id g88mr3222886pjg.7.1613144743400; 
 Fri, 12 Feb 2021 07:45:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-13-hch@lst.de>
In-Reply-To: <20201116145809.410558-13-hch@lst.de>
From: Mike Snitzer <snitzer@redhat.com>
Date: Fri, 12 Feb 2021 10:45:32 -0500
Message-ID: <CAMM=eLfD0_Am3--X+PsKPTfc9qzejxpMNjYwEh=WtjSa-iSncg@mail.gmail.com>
Subject: Re: [PATCH 12/78] dm: use set_capacity_and_notify
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_104545_776633_51413F5C 
X-CRM114-Status: GOOD (  18.20  )
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
Cc: Justin Sanders <justin@coraid.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
 Song Liu <song@kernel.org>, device-mapper development <dm-devel@redhat.com>,
 drbd-dev@lists.linbit.com,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
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

On Mon, Nov 16, 2020 at 10:05 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Use set_capacity_and_notify to set the size of both the disk and block
> device.  This also gets the uevent notifications for the resize for free.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/md/dm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index c18fc25485186d..62ad44925e73ec 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1971,8 +1971,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>         if (size != dm_get_size(md))
>                 memset(&md->geometry, 0, sizeof(md->geometry));
>
> -       set_capacity(md->disk, size);
> -       bd_set_nr_sectors(md->bdev, size);
> +       set_capacity_and_notify(md->disk, size);
>
>         dm_table_event_callback(t, event_callback, md);
>

Not yet pinned down _why_ DM is calling set_capacity_and_notify() with
a size of 0 but, when running various DM regression tests, I'm seeing
a lot of noise like:

[  689.240037] dm-2: detected capacity change from 2097152 to 0

Is this pr_info really useful?  Should it be moved to below: if
(!capacity || !size) so that it only prints if a uevent is sent?

Mike

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
