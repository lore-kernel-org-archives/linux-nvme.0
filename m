Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436E0C07E9A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:43:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 129C06115A
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 07:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129C06115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:CC:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oxxsL6gwoxk2eLaSQr0r5sYdf0SPjTzQ0JHt00PX5/g=; b=ALn5qdAB53ukfN+fAEJju3J1R7
	KJiMe4dyQAjI42uVZ8AvfwPCSnCBJqODOeQFgUNjw8gwDQ6wCfGQBVivWGRwWGNgbR7jhC5V/VM9b
	GDE8Y6LPkk8UZbi913EkHuC13irPoigQIkI6pLO+yMRc/FoGrMTosnNpTrWSRz+W/EetQ1HBmwBrO
	dPA4eQ41t57d4k1Wv4GS/oc2B6jXhqgiM1N8o92OmI/z6vGsWWzlg7PZqOZiY4HMI8bvw5B4uCkeM
	0Z+xKvmjrGi4MYeQpGGoTLCVuv55sdKWORQrjmpoPfunhLleK1H7Jl2+Xr+PjTK8NGNze2AuxlwmS
	pPsfEB1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0JG9-0086gX-5e; Mon, 05 Jul 2021 07:43:17 +0000
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0JG5-0086fH-L6
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 07:43:15 +0000
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GJHXB27Bwz6G7y4;
 Mon,  5 Jul 2021 15:35:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Jul 2021 09:43:07 +0200
Received: from [10.47.90.223] (10.47.90.223) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 5 Jul 2021
 08:43:06 +0100
Subject: Re: [PATCH V2 4/6] scsi: set shost->use_managed_irq if driver uses
 managed irq
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, "Christoph
 Hellwig" <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-scsi@vger.kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>, "Wen
 Xiong" <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, Damien Le Moal <damien.lemoal@wdc.com>, "Adaptec OEM
 Raid Solutions" <aacraid@microsemi.com>, Subbu Seetharaman
 <subbu.seetharaman@broadcom.com>, Don Brace <don.brace@microchip.com>, "James
 Smart" <james.smart@broadcom.com>, Kashyap Desai
 <kashyap.desai@broadcom.com>, Sathya Prakash <sathya.prakash@broadcom.com>,
 Nilesh Javali <njavali@marvell.com>
References: <20210702150555.2401722-1-ming.lei@redhat.com>
 <20210702150555.2401722-5-ming.lei@redhat.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0dda0d19-8f6d-b231-08f3-6cf594b83352@huawei.com>
Date: Mon, 5 Jul 2021 08:35:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210702150555.2401722-5-ming.lei@redhat.com>
Content-Language: en-US
X-Originating-IP: [10.47.90.223]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_004313_874638_01500C2C 
X-CRM114-Status: GOOD (  12.01  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 02/07/2021 16:05, Ming Lei wrote:
> Set shost->use_managed_irq if irq vectors are allocated via
> pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY) or
> pci_alloc_irq_vectors(PCI_IRQ_AFFINITY).
> 
> The rule is that driver has to tell scsi core if managed irq is used.
> 
> Cc: Adaptec OEM Raid Solutions<aacraid@microsemi.com>
> Cc: Subbu Seetharaman<subbu.seetharaman@broadcom.com>
> Cc: John Garry<john.garry@huawei.com>
> Cc: Don Brace<don.brace@microchip.com>
> Cc: James Smart<james.smart@broadcom.com>
> Cc: Kashyap Desai<kashyap.desai@broadcom.com>
> Cc: Sathya Prakash<sathya.prakash@broadcom.com>
> Cc: Nilesh Javali<njavali@marvell.com>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
>   drivers/scsi/aacraid/linit.c              | 3 +++
>   drivers/scsi/be2iscsi/be_main.c           | 3 +++
>   drivers/scsi/csiostor/csio_init.c         | 3 +++
>   drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    | 1 +
>   drivers/scsi/hpsa.c                       | 3 +++
>   drivers/scsi/lpfc/lpfc.h                  | 1 +
>   drivers/scsi/lpfc/lpfc_init.c             | 4 ++++
>   drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
>   drivers/scsi/mpt3sas/mpt3sas_scsih.c      | 3 +++
>   drivers/scsi/qla2xxx/qla_isr.c            | 5 ++++-
>   drivers/scsi/smartpqi/smartpqi_init.c     | 3 +++
>   11 files changed, 31 insertions(+), 1 deletion(-)

Hi Ming,

hisi sas v2 hw is missed - it supports managed interrupt as a platform 
device. Setting that flag in hisi_sas_v2_interrupt_preinit() might be best.

Thanks,
John

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
