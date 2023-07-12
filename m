Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9A7EB64D9
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ke1RoJkWHrGMbLYzmAUCdXFetzVb9Iew9ttJlTbSIZw=; b=M3tccF7+v6eb5iRfrB5Aw3IGZk
	DyypGhwP+wxHQNcjZV54/Kk8wZjCO+z3qitx3665g6x7RbiQ9NyixvZo4YFu+jWjGycAwpzsW1Oa/
	mnNgxxBZgPEJj6NrVnGEwOKH5q7U/150P1UaccTXMWTRoIrRIeG/Kh18d7oP83XAClrZ6DZ+szOaF
	Y6GoPHY4dvDU4ECfnEv/xfcJ+qo2dHAlehUW59NzRVP8Y5ci+xE+Loi7JtSVRXorlnv7M9/T/gEzM
	ty/loM5ZQDJrhLyyl/SS64kN2J+cp4aOeWGW3v/pL6G6hZkwAXcEC/Z06EmSJu7kd01axqTOCdiqj
	o9T+6e8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZdr-0002wg-2n;
	Wed, 12 Jul 2023 13:12:27 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZdp-0002vU-05
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:12:26 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso10961221e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1689167539; x=1691759539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ke1RoJkWHrGMbLYzmAUCdXFetzVb9Iew9ttJlTbSIZw=;
        b=Os6xvLS8Gk/Mp/m8MHivo/UCzBAVjtPOvDtXql9zLZoLY1ym8+E7fhdqYVmM5y/8C3
         DTiYnp5WLQgLSnRWO+k60DVBIFPmMjB2bp/Mh+UgkZ03bWwQlDTikNGrQr1e4oenY9Vs
         +K2SGHrZm16dW3VXLxvtJog4yJ0WhPlwYxnzpsK1kN+RxfiqFmPLvRHEJet1LyRu3GXl
         10yBI/rK8n9Qbm+mTunQS62K2IhtSVovM1gwq5Flm9wOf2hJjqp9WAdoRMzecflfkFKW
         RjXVQeoVS7Q4BUT0XuysnIzAY7P1hpJ1RGlv+62T3LhY1/3AziEWFx1I/S7ZfYEd5bSe
         g+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167539; x=1691759539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ke1RoJkWHrGMbLYzmAUCdXFetzVb9Iew9ttJlTbSIZw=;
        b=OHOJR/WjgVnAVeQ38o9DtgpqbgrUODGnWw9ALCkoI2Xwz+HhfwQ22I/lq6DywNAZGi
         Vh+eibCUwCSNSPu2YkLHO89bvtDA1pO/EDzvLuRKyXw+m2xUKfXBOPmSOtMv0rMl5L66
         xNhF4b7a+iBT9b+hEnvWc2o16nEKnkQu3h7r92fo/QQcHG3vCVZk4Up+dGotCoFKJFlw
         yll3qFTsarQz5G7zom/crKJixHx2y1Z/EqaKSiMeKo1brj9Mw1TZNZAIzvR7cbu15QcR
         NkaWWnVBCxbHyF5ewi4bFiZJcwSsfPXIVm5YeE+vDZPj8WwFQf5Pl/OiClLWo5MEO2Hb
         UfgQ==
X-Gm-Message-State: ABy/qLZ5rS8ZkO+ifUireQpT1nCSrc+pKatEfWMHTzBeQayyO4nxio3a
	EGu1sIavwmL0SuCQBvm1WZoxMol17QMs86osLCf/Dg==
X-Google-Smtp-Source: APBJJlH/yrSGeZhx17n+01HoYW2tT4q99wyogdL6NM70ZV25ta/wXIG0VoK3rkFu1pl8TskJhm79jGLE2XEGDY8IUhs=
X-Received: by 2002:a05:6512:32ce:b0:4fb:9f93:365e with SMTP id
 f14-20020a05651232ce00b004fb9f93365emr18369739lfg.41.1689167539433; Wed, 12
 Jul 2023 06:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-9-ming.lei@redhat.com>
In-Reply-To: <20230712125455.1986455-9-ming.lei@redhat.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Wed, 12 Jul 2023 15:12:08 +0200
Message-ID: <CAMGffEkY9SGCXrdOYYLU8BYacvw+sOdZFr770=idZZ1hVLtygQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] scsi: pm8001: take blk_mq_max_nr_hw_queues() into
 account for calculating io vectors
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_061225_059804_93D110FE 
X-CRM114-Status: GOOD (  21.71  )
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

On Wed, Jul 12, 2023 at 2:55=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Take blk-mq's knowledge into account for calculating io queues.
>
> Fix wrong queue mapping in case of kdump kernel.
>
> On arm and ppc64, 'maxcpus=3D1' is passed to kdump kernel command line,
> see `Documentation/admin-guide/kdump/kdump.rst`, so num_possible_cpus()
> still returns all CPUs because 'maxcpus=3D1' just bring up one single
> cpu core during booting.
>
> blk-mq sees single queue in kdump kernel, and in driver's viewpoint
> there are still multiple queues, this inconsistency causes driver to appl=
y
> wrong queue mapping for handling IO, and IO timeout is triggered.
>
> Meantime, single queue makes much less resource utilization, and reduce
> risk of kernel failure.
>
> Cc: Jack Wang <jinpu.wang@cloud.ionos.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
thx!
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm80=
01_init.c
> index 2e886c1d867d..e2416f556560 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -965,6 +965,8 @@ static u32 pm8001_setup_msix(struct pm8001_hba_info *=
pm8001_ha)
>                 rc =3D pci_alloc_irq_vectors(pm8001_ha->pdev, 1, 1,
>                                            PCI_IRQ_MSIX);
>         } else {
> +               unsigned int max_vecs =3D min_t(unsigned int, PM8001_MAX_=
MSIX_VEC,
> +                               blk_mq_max_nr_hw_queues() + 1);
>                 /*
>                  * Queue index #0 is used always for housekeeping, so don=
't
>                  * include in the affinity spreading.
> @@ -973,7 +975,7 @@ static u32 pm8001_setup_msix(struct pm8001_hba_info *=
pm8001_ha)
>                         .pre_vectors =3D 1,
>                 };
>                 rc =3D pci_alloc_irq_vectors_affinity(
> -                               pm8001_ha->pdev, 2, PM8001_MAX_MSIX_VEC,
> +                               pm8001_ha->pdev, 2, max_vecs,
>                                 PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &desc);
>         }
>
> --
> 2.40.1
>

