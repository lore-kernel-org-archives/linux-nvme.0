Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA7BC001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u8mBYQ48hqxLsJ20eS/0jkkgIvd41omZCyTUT7Irfl8=; b=Uh7nchWbW0UCzxKN7Ut+ydDGi+
	eIvDIt2tybZt8+dh793wNxW/XzwusEthBt1r9MYbI3cSGQR3NpsUijWX8oU/60HSo7HoIFKoPi7OW
	V3DxeU7EqsPAXvLwhJfNkVnbr91LK7+BUdJE6q98D6g9z3gQuDiSSU+1j2VwSPS5fOcdVvxS/z2iv
	ExKn/Mawr4xjYmMv2Jo5oQ5/MrwdSkVKn9nqMClurGXlnAtvBN5d3SJnzx/wbfBAkDhyLq2AuLIX1
	CTCuI/+1nMCAIlc1aBdr6VZqHN3NEYt8vSGH0SQ8+TVF5XX3JNuIMnBKQLfNPjP4FjsD6q+SUl+cC
	ilbUP0RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOmkC-00BcEd-0W;
	Wed, 26 Jul 2023 22:12:32 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOmk9-00BcEF-0v
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 22:12:30 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5844191983bso556127b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 26 Jul 2023 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690409547; x=1691014347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8mBYQ48hqxLsJ20eS/0jkkgIvd41omZCyTUT7Irfl8=;
        b=FGMXJIm+YcdnO2qdl9FARUysPWEgy4ZPjJMWoyY5JQFrLYy/xhbsOd/fGYe1HgkGql
         pwgC+CQD+7sPsRUocSzXMxgtDZMqOlRK8JOk8aFBW/RwtRTD8Ox/vfB53GHO6EOOygld
         YgpptCv1YGYr+QjGiznuxc0N10q8/czjpTLTJUUILRBrN0sKXYI6Wiy5lZQ/tyUenAXA
         THq4EpnBOvuM7e1m+P/ccaGwlZQEZCiO1eQQxB18EzMY4+iYdcLfIrmMFoxINsS1EkP8
         CQq9H0/aL9FBMZQK3S9ktE0nJv0/z26zCITlVUKYKkqHI0q+846gLlY+ehtBe9nreUrK
         tY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690409547; x=1691014347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8mBYQ48hqxLsJ20eS/0jkkgIvd41omZCyTUT7Irfl8=;
        b=N1uM/pG3oyf6VqzCxL3J7djRBkmC++m0bZllnHHTbR5dhQprRonSRfCJ/1aTi50s0X
         e0cI7+n7sD2YqxR5neS7YoZy2vViSyqh3t1TUnkbnpCD422c+AtUNKeZic/Tp97W9nsX
         e/aEB45VBq8ehAwuz2kBNW2TduxnJ0pmXqqJkgcoTYGDx1Z6YJE8HYnqsJYMDefc/HGz
         WbfevzasDUR7nKeANKbO6sN5xXkBH8oK35KLdfT400qP+0jhFdGjwoFNnLgyXsWsqPGP
         UAuAvZqo4Mp8y4mme7uTh5MMZLimoJN34LH3qFiYrqqU/ly/qb5bCo1V7hiQ1rnh1enX
         NnIA==
X-Gm-Message-State: ABy/qLYFO7hhk62WhWW5ASpwjemMj2jx+5dB07kv3KvRCkpbkihw7FJE
	POXy2J0GG8PNYhjRZBM/r+PrbLob2Rn0HQLWLok=
X-Google-Smtp-Source: APBJJlFve1PkP06DY6fpBvu+Zd5E0ezqHhw29sIUPOsCCsvNLLVEHnoLaKmgHoIiHbPqze9ucSiCbjkXkmHOEVV5l+c=
X-Received: by 2002:a81:6d51:0:b0:580:e3bf:698f with SMTP id
 i78-20020a816d51000000b00580e3bf698fmr1781329ywc.3.1690409546737; Wed, 26 Jul
 2023 15:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726094027.535126-1-ming.lei@redhat.com> <20230726094027.535126-5-ming.lei@redhat.com>
In-Reply-To: <20230726094027.535126-5-ming.lei@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 26 Jul 2023 15:12:16 -0700
Message-ID: <CABPRKS-0GQqMRiGh6akOgk3BKpx5kqTd0QVhH4nPe=fUdi7DbQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] scsi: lpfc: use blk_mq_max_nr_hw_queues() to
 calculate io vectors
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, Wen Xiong <wenxiong@linux.ibm.com>, 
	Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_151229_324834_59D6A2B7 
X-CRM114-Status: GOOD (  21.85  )
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

Hi Ming,

From version 1 of the patchset, I thought we had planned to put the
min comparison right above pci_alloc_irq_vectors instead?

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..20410789e8b8 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13025,6 +13025,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
                flags |=3D PCI_IRQ_AFFINITY;
        }

+       vectors =3D min_t(unsigned int, vectors, scsi_max_nr_hw_queues());
+
        rc =3D pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
        if (rc < 0) {
                lpfc_printf_log(phba, KERN_INFO, LOG_INIT,

Thanks,
Justin

On Wed, Jul 26, 2023 at 2:40=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
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
> Cc: Justin Tee <justintee8345@gmail.com>
> Cc: James Smart <james.smart@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index 3221a934066b..c546e5275108 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13022,6 +13022,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
>                 cpu =3D cpumask_first(aff_mask);
>                 cpu_select =3D lpfc_next_online_cpu(aff_mask, cpu);
>         } else {
> +               vectors =3D min_t(unsigned int, vectors,
> +                               scsi_max_nr_hw_queues());
>                 flags |=3D PCI_IRQ_AFFINITY;
>         }
>
> --
> 2.40.1
>

