Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B9EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 00:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rkkA0LMXJ6EJO8ZBIrahw9NK6XtYuf0ofi+9E893seU=; b=ft7PSXwLdlA6E5o/sNVUJq4uKE
	ac+DQfBKIgXvBejqi6v8dxF9MAORU4x9yT5VQ8QNpBZIA8VuD5KrGFSyc4dSF/jnQ5WIlQel+tzdY
	6bvNBUXtforwmHWvt1XmMWHJnSg1riUfIhh0tk2bo2V9Wiqf3AmpQWRTZ8+YspeSpIdXNWvLORGrE
	zY+/WHn20xGeTrqYGkfQ0zCwQqapDovQIzYSTA0Eq1GDQ1RWRKbtZB+ElkUdU3t4bNlNgpZBg3giF
	I9Nz/e2bMmg9cT46Elc7Ui253U4vC5w/n/2UDomkTvR3lr0i/4iVJmwVIRg9Xrm+4EvK4KcAmDH+x
	3aXsd5Fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJjo1-001XXR-1g;
	Thu, 13 Jul 2023 00:03:37 +0000
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJjnz-001XVr-2F
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 00:03:37 +0000
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-c387552291cso7488276.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 17:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689206610; x=1689811410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkkA0LMXJ6EJO8ZBIrahw9NK6XtYuf0ofi+9E893seU=;
        b=B4bVQ0sWquLoM0r6xOPwFQ8N6TQnuKE3itkRYhssSKUTCfWniZDokY97TmM4vK4l0k
         7FpToXZGtZD1L8yZVObxO0vaQBOBT5lMcFLdA9tLsrIhr/yzzoYPIlxpOjpvW0hpo73G
         CvWObux//kErneUPfSjCCfOYNrqtV9eK4uFtAyYeKL5rRPITQJ3QWbk3V56qhVR5j93d
         RWU0RjMnah4yf3k1Kc6RIb2XKmEnpo8I5SNjSePmVcQIM3PFf2zwxlw0JxiByDBzPfrK
         7ThMZoB3hRRTSrAO2vdKu+J7B7KfZKVdJotveK6uiWhRavSGowH8kSV0xHHeZfaxCABM
         /L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689206610; x=1689811410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkkA0LMXJ6EJO8ZBIrahw9NK6XtYuf0ofi+9E893seU=;
        b=J4rt1Oe2cjFcEYQvfLSoMDR3Kr7x0sQSGhpx4f8Ch0rAPMpK5c6kpXyU1iSRo4O1ia
         cSM5dBWjCUSPYVCT6CbFT7gESqzAgdu2M6EXxVDV1jVQZMBe1VwzDG9OakecTljvYi/Z
         Sze7/Sboas590Voge+HaDeuLwakPSbAOaC7XQrLgmoyra6mtWNftQi2zoQFilQUp5eI0
         xGuKYtzz+irX8gg3waK/u9AJJL6HdEYD3TDuzUIRvVu0p5sKkGuQRBojWDZl4bM5AbId
         RrTMeiR6CQts1soFUZDTarzUdOWY2agEHSs6OMfGzfngA2AYwUp7AGXs29wBEijsxJ41
         a95A==
X-Gm-Message-State: ABy/qLZDBYY1MnOjCOG4D9w+kkKiiVK1h/JVX0SA0JrJcVoxGEdzg6ww
	XuD563j3XjRK0sbyC2IqH/sfijKQzDytNHGhhuA=
X-Google-Smtp-Source: APBJJlGADVIdji1KcjMzFLea4D7Ai1TaoUOxO12SLFR1+VzgNBMYdqYw4++7zvjr0JM+V/BO9kUqgi+1qjZbdHQ1cPI=
X-Received: by 2002:a81:4c05:0:b0:569:322b:d067 with SMTP id
 z5-20020a814c05000000b00569322bd067mr104522ywa.4.1689206610234; Wed, 12 Jul
 2023 17:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-4-ming.lei@redhat.com>
In-Reply-To: <20230712125455.1986455-4-ming.lei@redhat.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Wed, 12 Jul 2023 17:03:19 -0700
Message-ID: <CABPRKS9WPBq1R9EH39=8vCAcW0+0YDAuYKRtEU9ck=BRfZKo1w@mail.gmail.com>
Subject: Re: [PATCH 3/8] scsi: lpfc: use blk_mq_max_nr_hw_queues() to
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
X-CRM114-CacheID: sfid-20230712_170335_731372_4CCB51B1 
X-CRM114-Status: GOOD (  20.78  )
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

A few lines below in if (aff_mask), vectors can be overwritten again
with min(phba->cfg_irq_chann, cpu_cnt).

Perhaps we should move blk_mq_max_nr_hw_queues min comparison a little late=
r:

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 3221a934066b..20410789e8b8 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -13025,6 +13025,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
                flags |=3D PCI_IRQ_AFFINITY;
        }

+       vectors =3D min_t(unsigned int, vectors, blk_mq_max_nr_hw_queues())=
;
+
        rc =3D pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
        if (rc < 0) {
                lpfc_printf_log(phba, KERN_INFO, LOG_INIT,


Regards,
Justin

On Wed, Jul 12, 2023 at 6:04=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
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
> Cc: James Smart <james.smart@broadcom.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/scsi/lpfc/lpfc_init.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.=
c
> index 3221a934066b..88314c3f1dc1 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13012,6 +13012,7 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
>         if (phba->irq_chann_mode !=3D NORMAL_MODE)
>                 aff_mask =3D &phba->sli4_hba.irq_aff_mask;
>
> +       vectors =3D min_t(unsigned int, vectors, blk_mq_max_nr_hw_queues(=
));
>         if (aff_mask) {
>                 cpu_cnt =3D cpumask_weight(aff_mask);
>                 vectors =3D min(phba->cfg_irq_chann, cpu_cnt);
> --
> 2.40.1
>

