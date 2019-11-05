Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C4FC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:58:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B8AE217F5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqM/a6td"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8AE217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bqd+wKm48WgxNObvVKvRafY8ZFBIJ45EopSBDgXYNLk=; b=iqM/a6tdyCKb7k
	c5fsXHhsIoOWxIuFPnlnPpMwhHMY7XK+R/Q38KuP1UnGuwQZ6zl/WjrQWZatOVD1YUUhy7F+c9YEN
	Axm8IzCjaoLcSzmkHCMESjP30ChAxFnK81teDmD4i6ELoRkLa/XmiVYwTZJyQViucjtnylnY9zzH+
	HnrW7Yp4UtlpNHP8SjdbuXKXXIexGhSUzmCxsr74ymJuytNDAUqtgFIGr9nn7DaIqIdCp0cDl98y9
	TN3eA+xTmAc1x0uUpHd1aBMSdw6aPEJmly7buJY8m82souv9+ClxsRx/wOUyxx8BeNIPzNi1Q2pwo
	HIY6zV8A7rVn+aP/caaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS35u-0007De-9P; Tue, 05 Nov 2019 17:58:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS35r-0007DE-1e
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 17:58:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 743E768AFE; Tue,  5 Nov 2019 18:58:12 +0100 (CET)
Date: Tue, 5 Nov 2019 18:58:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 05/15] nvme-rdma: Add metadata/T10-PI support
Message-ID: <20191105175812.GE18972@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-7-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105162026.183901-7-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_095815_240837_6460731A 
X-CRM114-Status: GOOD (  14.05  )
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
Cc: sagi@grimberg.me, vladimirk@mellanox.com, idanb@mellanox.com,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, shlomin@mellanox.com,
 oren@mellanox.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 05, 2019 at 06:20:16PM +0200, Max Gurtovoy wrote:
> For capable HCAs (e.g. ConnectX-4/ConnectX-5) this will allow end-to-end
> protection information passthrough and validation for NVMe over RDMA
> transport. Metadata offload support was implemented over the new RDMA
> signature verbs API and it is enabled per controller by using nvme-cli.
> 
> usage example:
> nvme connect --pi_enable --transport=rdma --traddr=10.0.1.1 --nqn=test-nvme
> 
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> ---
>  drivers/nvme/host/rdma.c | 346 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 298 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 05f2dfa..16263b8 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -48,6 +48,12 @@ struct nvme_rdma_qe {
>  	u64			dma;
>  };
>  
> +struct nvme_rdma_sgl {
> +	int			nents;
> +	struct sg_table		sg_table;
> +	struct scatterlist	first_sgl[SG_CHUNK_SIZE];

I think this needs some rework.  Kill the first_sgl pointer, and then
just set the pointer in the table to address found by pointer
arithmetics behind the nvme_request in the allocation.

We also have an open todo item to not actually allocate SG_CHUNK_SIZE
entries, but a much smaller value like in SCSI.

Also the whole switch to use struct sg_table should be a separate prep
patch.

> -	struct sg_table		sg_table;
> -	struct scatterlist	first_sgl[];
> +	/* T10-PI support */
> +	bool			is_protected;

This is a bit of an odd variable name.  Why not use_pi or something like
that?

Also all the new code should only be built if CONFIG_BLK_DEV_INTEGRITY
is set.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
