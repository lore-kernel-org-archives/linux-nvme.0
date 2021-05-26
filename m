Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FEC47089
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:20:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A44160FE3
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 15:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A44160FE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YIKmGKiFxEl7llhDuOmYwesGvONlW5NPXnXsFhgVZS4=; b=np6JVGZb7NaYit
	C+6tV3XZMGJmER8wB+LDniDlNR2a3IbM4mQc4fySt/2FjM7g2+izCfQ0cyjRHjK4dnLC7Uyc7hg4r
	OFpfeUBrHu42RURYRsknbVJYMODH0wdezA8oOGETV6p4DaoTBBrdHJzxJrSgUQqn7sJYc12URIO29
	bk6ItdRmDxFNSO/fBVSVA9ocUmuaoXwN6KPj36kFZJmswBpjTnw13yUzBWRCVtBHFdYC/xOO3eAet
	xE7fqw3LZa2EHKwWS7oCc47nkNKxs/SO8OZLmPWy0A0E+yBZCAmlgtj1amGT8EcNCBrS3A4KkgX1t
	btWovRqmK0saQ12SHhIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llvKm-00FJ5u-46; Wed, 26 May 2021 15:20:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lluG7-00EkVL-AK
 for linux-nvme@bombadil.infradead.org; Wed, 26 May 2021 14:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=dOlOg83r02k/HD3soPQLhLqKJHkR+0wK72J8GcBwY1w=; b=f82B7eOBKU/Lgu2iRRPzh8tPem
 /vvrjDfedkbcNidAqisC5NYzK9HA/tzLbrvGS/1ExqoLSl1aykFttvqsCqutJ7tBP4mezxGDcewUI
 xyspz3FNkuDlVEujPwjr1yKJ3+TiXXFMVRB454xJgrQ9tv3p6U/4Ki1sLCK/sVtKob7Y4IRyRLprc
 quI9oMreapOEF2Bs7qbkfNIw5K8m4ZaAYSCBf8tMpf0TdXsx6u6D7GoRsKA3OpHPXgnzQXLcZbRjP
 2MuHzT4YT6KNhTaKpJQI+gXNOqYKc0bBfrMfr/Biglot8iuePrdHN/XK3us8QMj1ItwiqJlFhrLaz
 usJDJjnA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lluFI-004agG-Lf; Wed, 26 May 2021 14:11:15 +0000
Date: Wed, 26 May 2021 15:10:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Walker, Benjamin" <benjamin.walker@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Israel Rukshin <israelr@nvidia.com>
Subject: Re: [bug report] nvme sends invalid command capsule over rdma
 transport for 5KiB write when target supports MSDBD > 1
Message-ID: <YK5W7F5DD4grBZLB@infradead.org>
References: <BYAPR11MB2824E1B94D81B837E474A7A6EF269@BYAPR11MB2824.namprd11.prod.outlook.com>
 <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dc96c3cf-e895-77c0-3d1a-1bc7e96cfd40@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 26, 2021 at 02:12:08AM -0700, Sagi Grimberg wrote:
>  {
> -       struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> -       struct scatterlist *sgl = req->data_sgl.sg_table.sgl;
> +       struct nvme_sgl_desc *sgl = &c->common.dptr.sgl;
> +       struct scatterlist *sg, *scat = req->data_sgl.sg_table.sgl;
>         struct ib_sge *sge = &req->sge[1];
>         u32 len = 0;
>         int i;
> 
> -       for (i = 0; i < count; i++, sgl++, sge++) {
> -               sge->addr = sg_dma_address(sgl);
> -               sge->length = sg_dma_len(sgl);
> +       for_each_sg(scat, sg, count, i) {
> +               sge->addr = sg_dma_address(sg);
> +               sge->length = sg_dma_len(sg);
>                 sge->lkey = queue->device->pd->local_dma_lkey;
>                 len += sge->length;
>         }

We do need for_each_sg here indeed, but you also need to keep
incrementing sge for each loop iteration.  I think we can also
drop the scat local variable with just a single users and all the
renaming while we're at it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
