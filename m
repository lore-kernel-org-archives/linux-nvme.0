Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 823F5EB64DC
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jul 2023 08:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rIuqhH6IY8ONncAtN7QDgruUel+r3gNk5xnCvWyYpDA=; b=DI0fO1d1ayy7pIrbXjsU/VWFDR
	xGyfBa2xkAWBUOYfcn8ORmaQOqnM7IndDFcMet5KTuagRi7PvCmzjoujvpVUDdN5Qw+RGosapYqnI
	iUBldwXP+n/N9EsFLHVmxEU2tld4kdNjmhg24n8myzDfO20AQPWMW5H40msn+is2JznwIbF73PJVu
	JpTfyX5ZL2bfCLl4J4k1IlHUe6XeLzNWLEbWrgaZTGrAXVBEGEiiZ2YXfD9KWV3MKcY9vmj7h/W7Z
	7a/2nK+XtWGGuood876cNztjUZK3Eyt22cxNhBJHQmZLFXVrkEP4x5fvqZC6li5FbUqsdF8XyjDV+
	g+qHzrgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlp4-00DQMz-2C;
	Fri, 21 Jul 2023 08:49:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMlp0-00DQMW-30
	for linux-nvme@lists.infradead.org;
	Fri, 21 Jul 2023 08:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689929349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIuqhH6IY8ONncAtN7QDgruUel+r3gNk5xnCvWyYpDA=;
	b=g+SjWqt1Ppe1PQHt6jDqtgaZfpZVu/EOACeTEaQqgNv9YsIH7A0yOFlfXtXi/kGdBx+TNB
	H67wdz/NkOkht2P6YIi7CECyUC4MYyw+o78SMxx6JdjM08xiuWhK0dsKwB40CI84e362Ua
	1rUtXP6sdwqxuabEPso/de9q6k34wbg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-7BJI8WwOOCGkGhdT2d1gVA-1; Fri, 21 Jul 2023 04:49:03 -0400
X-MC-Unique: 7BJI8WwOOCGkGhdT2d1gVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 531D3936D27;
	Fri, 21 Jul 2023 08:49:02 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F57F40C206F;
	Fri, 21 Jul 2023 08:48:55 +0000 (UTC)
Date: Fri, 21 Jul 2023 16:48:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Justin Tee <justintee8345@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Justin Tee <justin.tee@broadcom.com>
Subject: Re: [PATCH 3/8] scsi: lpfc: use blk_mq_max_nr_hw_queues() to
 calculate io vectors
Message-ID: <ZLpGcJbCFyK0vB4+@ovpn-8-26.pek2.redhat.com>
References: <20230712125455.1986455-1-ming.lei@redhat.com>
 <20230712125455.1986455-4-ming.lei@redhat.com>
 <CABPRKS9WPBq1R9EH39=8vCAcW0+0YDAuYKRtEU9ck=BRfZKo1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPRKS9WPBq1R9EH39=8vCAcW0+0YDAuYKRtEU9ck=BRfZKo1w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230721_014911_928968_CBE935A6 
X-CRM114-Status: GOOD (  16.48  )
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

On Wed, Jul 12, 2023 at 05:03:19PM -0700, Justin Tee wrote:
> Hi Ming,
> 
> A few lines below in if (aff_mask), vectors can be overwritten again
> with min(phba->cfg_irq_chann, cpu_cnt).
> 
> Perhaps we should move blk_mq_max_nr_hw_queues min comparison a little later:
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 3221a934066b..20410789e8b8 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -13025,6 +13025,8 @@ lpfc_sli4_enable_msix(struct lpfc_hba *phba)
>                 flags |= PCI_IRQ_AFFINITY;
>         }
> 
> +       vectors = min_t(unsigned int, vectors, blk_mq_max_nr_hw_queues());
> +
>         rc = pci_alloc_irq_vectors(phba->pcidev, 1, vectors, flags);
>         if (rc < 0) {
>                 lpfc_printf_log(phba, KERN_INFO, LOG_INIT,

Hi Justin, 

Indeed, will take it in next version.

Thanks,
Ming


