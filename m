Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C22EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3G0CnLasAwk7QEzGMF4ayHtEf2TKT8SrgGzAZhiKurE=; b=fEAhOiJw0mazwT3pZezD3xiAeV
	kWgU/4l0qirg++zpldmlmzUp0mNmRAvCT3BA6l1Wd9zmeYqdFWzqCSXa+ulzQoLZzmE/C9PCdN44n
	9jXYZUtjL+8RDSeS1cM9/rSrcrIy0ltqUNiiBahs9aBSepSsXNYbSZlA5zCluQTByoVQaKFIZl1I8
	CchxS0LTyKeLPfr83LoQlpKaWO7DlPLKnD8dJdO7DbGetKPYmDqB8bFkBdBpjw7A5hJTWLBwX2JhW
	BVTqEcyXqqsXXwJ1CW3C1gw+dB9otHwNWw97Wo71zOl2S/iy1e+gMSEPSFEWootwsEwS9Ef9wvy7f
	8Q6YZZBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMfQI-00CaLN-2g;
	Fri, 21 Jul 2023 01:59:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMfQF-00CaKX-0g
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 01:59:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689904750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G0CnLasAwk7QEzGMF4ayHtEf2TKT8SrgGzAZhiKurE=;
	b=ErknKCME8q3pvu9HIvgNtSqkXzTFR7f5LKRoIGkL8QjBmmnCSDlnGMJxJHy/A0pi3MiK1z
	NhO00hgEPBrgYpNy+U6uHoRBwORTHRpiU010iIa1j8ILSFLMBX3mq086rDG2GyzBkJJiN9
	oL8+mNgLZOVP6FvB6zcyWq5N7VqmO58=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-F4KC2hsJN3y6mwq_2bD9WA-1; Thu, 20 Jul 2023 21:59:09 -0400
X-MC-Unique: F4KC2hsJN3y6mwq_2bD9WA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-262e0c70e8eso731340a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 20 Jul 2023 18:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689904747; x=1690509547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G0CnLasAwk7QEzGMF4ayHtEf2TKT8SrgGzAZhiKurE=;
        b=IFkKnvJUnqRxPD78wfxa/FpHAR2Xjxf/TdkDVFX3IOoFH7KsmXr7nTOZJ86/+evTK5
         FHnR9gveQRzOde4JT9MD96EVpMAjq/fGnwdAGb102fQfdJ0eU4lfDKTKB5Hi3M6p7gJF
         sIahbsd82y02fvS5qEb9htAQ39BjwisdWuhIgWk+Jjph6YUiploayNU4uUux/QdUYlFQ
         XBZkjs3lclhJfkYfXnv5HHVYidtk+VHd1TTIb2eVkniSTcCfpuwAiaVxOowLBzOW4e5z
         btWjMcSRFNIWmP61OgZpWmCxJgy0zZ0TyFLZQgofOCm5O71ndWd1nGgo/j28KVHoJBf0
         z4nA==
X-Gm-Message-State: ABy/qLbCJVWWJ0F3fhk+2MaZBLK3y2+Cn5bT/wnz+ZelNY5okBYV+5um
	bvikngpuv+Q1wCOajLja7ENDgL9NfozCAoereMO0/sUCarA39kG89ngGHuj3yT2IGQRMw6k2AOv
	M0bjTWRGjvNYI6cRKGigGmhot3z3yuc9RRikDlLVmj90=
X-Received: by 2002:a17:90a:4597:b0:25e:ad19:5f46 with SMTP id v23-20020a17090a459700b0025ead195f46mr326446pjg.12.1689904747491;
        Thu, 20 Jul 2023 18:59:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEud+0AU+n3F2XLQgfcj5dE+dH08i4sIC20b0RGeYemcSKy+k5eiagsibx9Wbbii3KAP1rxkdjXtTclLPSGX6M=
X-Received: by 2002:a17:90a:4597:b0:25e:ad19:5f46 with SMTP id
 v23-20020a17090a459700b0025ead195f46mr326436pjg.12.1689904747219; Thu, 20 Jul
 2023 18:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230711094041.1819102-1-ming.lei@redhat.com> <20230711094041.1819102-4-ming.lei@redhat.com>
In-Reply-To: <20230711094041.1819102-4-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 21 Jul 2023 09:58:55 +0800
Message-ID: <CAHj4cs_XNfe3zfErc0B+tUG-_TOPb93pnicfHM=ViLbEbXZH-g@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] nvme-rdma: fix potential unbalanced freeze & unfreeze
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	linux-nvme@lists.infradead.org, Chunguang Xu <brookxu.cn@gmail.com>, 
	stable@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_185911_323011_55EE0461 
X-CRM114-Status: GOOD (  21.28  )
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

Verified it with the nvme/rdma scenario, Thanks Ming
Tested-by: Yi Zhang <yi.zhang@redhat.com>

On Tue, Jul 11, 2023 at 5:41=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Move start_freeze into nvme_rdma_configure_io_queues(), and there is
> at least two benefits:
>
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
>
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
>
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
>
> 1) same problem exists with current code base
>
> 2) compared with !mpath, mpath use case is dominant
>
> Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/rdma.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d433b2ec07a6..337a624a537c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -883,6 +883,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                 goto out_cleanup_tagset;
>
>         if (!new) {
> +               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_unquiesce_io_queues(&ctrl->ctrl);
>                 if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOU=
T)) {
>                         /*
> @@ -891,6 +892,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_=
rdma_ctrl *ctrl, bool new)
>                          * to be safe.
>                          */
>                         ret =3D -ENODEV;
> +                       nvme_unfreeze(&ctrl->ctrl);
>                         goto out_wait_freeze_timed_out;
>                 }
>                 blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
> @@ -940,7 +942,6 @@ static void nvme_rdma_teardown_io_queues(struct nvme_=
rdma_ctrl *ctrl,
>                 bool remove)
>  {
>         if (ctrl->ctrl.queue_count > 1) {
> -               nvme_start_freeze(&ctrl->ctrl);
>                 nvme_quiesce_io_queues(&ctrl->ctrl);
>                 nvme_sync_io_queues(&ctrl->ctrl);
>                 nvme_rdma_stop_io_queues(ctrl);
> --
> 2.40.1
>


--=20
Best Regards,
  Yi Zhang


