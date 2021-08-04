Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6757DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 14:33:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3877260FC3
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 14:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3877260FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JA5T0uLRbE1VQfyD+8o8wFN7iBsFBPVQKRHOC2s3+tE=; b=F9zO5+TnXpSCy2
	KuvJsHIMh9dSVJbgUSRYoNxrrRB0LrNcFC5rssC34Ty0L4TVyJbQsb41z72aQRowanvXLsLJlGlOy
	QhqFIxDGYi38it1zoY++N8cBN3wgjvfu/jrSI+PJMGfs//ebDmUe85cgCU8I7QwmOUYLMMAPofe5b
	0d22Pe4xbQ5WPN4EBM+vZwqFM7PG8X+fVZ7aM29qm4FKTf+vRrPeMECOeCtmz6x344j3UQZPtmlKP
	sAPaF21DqIs/tY3ng32bmX3hidzXcZdVS1ZtwulaC1FJMIsbiGdLjBKcqftuJyALcHv1Km9W7q0TS
	qgnLo5wKbn59XZldgJyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBHxQ-006S1d-Kg; Wed, 04 Aug 2021 14:33:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBHxN-006Rz7-Fr; Wed, 04 Aug 2021 14:33:18 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AA66960F58;
 Wed,  4 Aug 2021 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628087596;
 bh=C00JtgOcAHMho4HSW46amt4u1PEDLgE0FCLDRj9vJyE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r5GGuOVFvQsum4XAR7C7YBvKDsK/mFn7OHK1uuaLXRstSUvJF6WN5SAcMH42cka84
 XNI6JmV4ddzVk3D3J2YlbCsl6RVftxgl1k5Vs3nz5huKGNFgnQBY2iei65nSAundBj
 gr1MQgM6nEcpjWrclG+PO2XuVtuhgDLnuVCxLN/ur1yVfnHV1jME0OH5CUcgso0JH9
 OkCnqulR6QQPlr+/+sWhnm9w3GZI3LrX0Du7/iC3FQiuwUJ/6hK/4Zm/l13ruiwaM0
 PswWW1T0VxSiyJLTXtgN/AKJ1p4nBl2lAi+w/iFwSNC7dXt6aRCMFqvyz/tryXYCNL
 6UR6ytS23PJoQ==
Date: Wed, 4 Aug 2021 07:33:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Song Liu <song@kernel.org>,
 Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Phillip Lougher <phillip@squashfs.org.uk>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-um@lists.infradead.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: Re: [PATCH 15/15] nvme: use bvec_virt
Message-ID: <20210804143312.GA2296276@dhcp-10-100-145-180.wdc.com>
References: <20210804095634.460779-1-hch@lst.de>
 <20210804095634.460779-16-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210804095634.460779-16-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_073317_582582_542CB3F9 
X-CRM114-Status: GOOD (  17.01  )
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

On Wed, Aug 04, 2021 at 11:56:34AM +0200, Christoph Hellwig wrote:
> Use bvec_virt instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index dfd9dec0c1f6..02ce94b2906b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -968,12 +968,11 @@ void nvme_cleanup_cmd(struct request *req)
>  {
>  	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
>  		struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
> -		struct page *page = req->special_vec.bv_page;
>  
> -		if (page == ctrl->discard_page)
> +		if (req->special_vec.bv_page == ctrl->discard_page)
>  			clear_bit_unlock(0, &ctrl->discard_page_busy);
>  		else
> -			kfree(page_address(page) + req->special_vec.bv_offset);
> +			kfree(bvec_virt(&req->special_vec));
>  	}
>  }
>  EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
