Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAF1C44515
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yGyqJ8AvdG3YA49IhFpi74Ur1oDcn1l4zcXslCUbYhw=; b=0fJoQ4lNNb+LUc0wZTQfswDIbt
	qK2hKQqTWCxFk/pT+IRITkjL2cGrWkOTblG4UpbuO2jmagKPSXjKL5POVvm0rlR09J1xbfrVIGPDW
	T4HBS2nE0lChVV3FYWQnCl1FfwjTxIOms7sfwj59hApN0oU3DsONdCKeT2EYz39pvjXyJRsS1iVcM
	4PKviaSGnbnYVogRMw47EGRcfjSm3Oyk2UFSuUp2ZLvLrvrE9UAmXPHzB6EsMeSdAxW4vAJ29LUG4
	VALIOylJTvQEKbzt2TApyj0Nau0776VD71vVlKHK+wKkJYMEuYgKBm8hOoovFQCbh8kX3nPBYwULh
	CHDgysbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wljIC-00000006BcR-2CoM;
	Mon, 20 Jul 2026 08:24:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wljI9-00000006BbM-1TG0
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 08:24:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4672568D32; Mon, 20 Jul 2026 10:23:56 +0200 (CEST)
Date: Mon, 20 Jul 2026 10:23:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hari Mishal <harimishal1@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: passthru: fix OOB reads when parsing ns id
 descriptor list
Message-ID: <20260720082355.GA20499@lst.de>
References: <20260717144353.19436-1-harimishal1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717144353.19436-1-harimishal1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260720_012401_539847_0D1D107A 
X-CRM114-Status: GOOD (  23.06  )
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

On Fri, Jul 17, 2026 at 04:43:53PM +0200, Hari Mishal wrote:
> nvmet_passthru_override_id_descs() walks a namespace identification
> descriptor list populated from the underlying passthru controller's
> Identify response, which is device reported. The loop advanced pos by
> device controlled amounts (sizeof(*cur) + nidl) without checking that
> the next descriptor header actually fits inside the buffer, so a
> malicious device could push pos to within a few bytes of the buffer end
> and cause cur->nidl, cur->nidt or the reserved field to be read past the
> allocation.
> 
> Additionally, when a CSI descriptor lands exactly at the last valid
> header offset, cur + 1 points one byte past the end of the buffer.
> The unconditional memcpy(&csi, cur + 1, NVME_NIDT_CSI_LEN) could read
> that out-of-bounds byte and copy it back to the initiator via
> nvmet_copy_to_sgl(), leaking adjacent heap memory.
> 
> Bounds check both the descriptor header and the CSI value before
> dereferencing them.
> 
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/nvme/target/passthru.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index e27f84e3cf2b..7ef02958078b 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -53,13 +53,21 @@ static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
>  	for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {
>  		struct nvme_ns_id_desc *cur = data + pos;
>  
> +		if (pos + sizeof(*cur) > NVME_IDENTIFY_DATA_SIZE)
> +			break;
> +
>  		if (cur->nidl == 0)
>  			break;
> +
>  		if (cur->nidt == NVME_NIDT_CSI) {
> +			if (pos + sizeof(*cur) + NVME_NIDT_CSI_LEN > NVME_IDENTIFY_DATA_SIZE)

Overly long line here.  Otherwise this looks sane.


