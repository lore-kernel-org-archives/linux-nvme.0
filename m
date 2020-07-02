Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88619C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:22:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 582C620885
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 18:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kFu5D8mi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoegUq2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582C620885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M09k43la5IyDlMAcHdlOxEMt43gHINNXOz5ObUYGhyE=; b=kFu5D8mikCAzeQj3CM5cMSXrw
	DXU8FdDUE9sm9LKMKeh1A5CpqRNEvlR2/EJzBr+LzPyRFs4epMc88DY1N3TjyDLMKYj50+pZ3lNk1
	8QMTYTCKpCMkCfxKntLSkdDIwZK1lDC6NfKM1wlYjhNNG50u+bH0BIGPCcMKhZBTJ74XJTQkbibqT
	XM8759IMsbnkyXvW0RpTK3mIX/5KeSZWCSgwUvYVcpeA1GB9vKAei3q3Hm6aEHzn84+Om53NN6Zt1
	G85Nrq7cNTTfyoOkf9wyvGdRMEir2yN1s5N0c70bHhgZ7okiXCC+KGRV27xU3NOue0pRAb1lKQQGq
	7cCpF5q2g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr3qu-0002Pq-Ty; Thu, 02 Jul 2020 18:22:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr3qs-0002Ow-7K
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 18:22:26 +0000
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com
 [209.85.208.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4CFE2212CC
 for <linux-nvme@lists.infradead.org>; Thu,  2 Jul 2020 18:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593714145;
 bh=2Ob+guxRY0fDcRz+P555VDdl6+UEf5NKd/ZEgEjmyqA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=OoegUq2L0uxSt3rrR3lcoqsDAOAxdO0rE6tlewRsGb9eiQzLEa9GcLv3f53+JJtIq
 Tu4dmdJlB98mXwT/7grCGi1Eg4sXkxKx8O4HxETnxcls0gt5Kok143rso1DF1RnUs7
 J+0BQhidD4fUWOWUJ491VzOjYlY2TbrXcU05LAhg=
Received: by mail-lj1-f176.google.com with SMTP id n23so33480508ljh.7
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 11:22:25 -0700 (PDT)
X-Gm-Message-State: AOAM533R9EEkgjUeUjx+iUg3zn/ntSZNqYhOTcH4OYCThvzFe/3YzFzH
 ArmgxhElkUtoMb/hxR8weoh8zEBbyAqvqZUSBVE=
X-Google-Smtp-Source: ABdhPJwzHQSAgDG5LZKrrq4sCwOryNIpxeUx+J+pLZvaBWcsyRJefETEyU+mlLl9hUoA9U/QBDPE51PBpf0COAdEZgQ=
X-Received: by 2002:a2e:9901:: with SMTP id v1mr17432874lji.41.1593714143665; 
 Thu, 02 Jul 2020 11:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200701085947.3354405-1-hch@lst.de>
 <20200701085947.3354405-18-hch@lst.de>
In-Reply-To: <20200701085947.3354405-18-hch@lst.de>
From: Song Liu <song@kernel.org>
Date: Thu, 2 Jul 2020 11:22:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4=eiN2-_cy5vCn_RGwmYRf37jOX4DWTvUCDWAqRzU+pw@mail.gmail.com>
Message-ID: <CAPhsuW4=eiN2-_cy5vCn_RGwmYRf37jOX4DWTvUCDWAqRzU+pw@mail.gmail.com>
Subject: Re: [PATCH 17/20] block: rename generic_make_request to
 submit_bio_noacct
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_142226_334804_EB1DA3D9 
X-CRM114-Status: GOOD (  11.55  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
 open list <linux-kernel@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
 linux-bcache@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jul 1, 2020 at 2:01 AM Christoph Hellwig <hch@lst.de> wrote:
>
> generic_make_request has always been very confusingly misnamed, so rename
> it to submit_bio_noacct to make it clear that it is submit_bio minus
> accounting and a few checks.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
[...]

>  drivers/md/md-faulty.c                        |  4 +--
>  drivers/md/md-linear.c                        |  4 +--
>  drivers/md/md-multipath.c                     |  4 +--
>  drivers/md/raid0.c                            |  8 ++---
>  drivers/md/raid1.c                            | 14 ++++----
>  drivers/md/raid10.c                           | 28 ++++++++--------
>  drivers/md/raid5.c                            | 10 +++---

For md part:

Acked-by: Song Liu <song@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
