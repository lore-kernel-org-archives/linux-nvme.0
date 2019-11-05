Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04CC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601A421882
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 17:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lr+N4ON+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601A421882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FRMOcHGNPBBEMznOn5ZMTt/v/+fklDaIoe60FugIGCk=; b=lr+N4ON+oooPlJ
	IlMRFgkPfSKTxQ1QXlcZc8puQpMQhRD5oUQaPKtmSUBMhklsLgi+eSzG6qVuxATjN1WTz9nDaBNAz
	N/Tumzp4NC/asiv1/olunuAqkYUmpEjUqbFoxHoDCD+h74pMWLyXs2V2rvMoZW67RP2G4UTlifDAw
	/yZNhMeOXmLFn7Q12G5UFwthYvDnZzZZwT9Do/Ygmlh7P/Pi+LSUzJKSDqQytuwph5OmcNntPvZNA
	asS20W7+ioh7Er1Qzk5eAQk3t2myrx8NVfxrVszTzQPcYlSs3Lsu1f/9XZqKGF2nFbvnYjp1d4P9T
	o82F8szmeufFLee1Mb7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS307-0004NP-9r; Tue, 05 Nov 2019 17:52:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS2zx-0004Dt-TA
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 17:52:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C29868AFE; Tue,  5 Nov 2019 18:52:08 +0100 (CET)
Date: Tue, 5 Nov 2019 18:52:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
Message-ID: <20191105175207.GD18972@lst.de>
References: <20191105162026.183901-1-maxg@mellanox.com>
 <20191105162026.183901-8-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191105162026.183901-8-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_095210_089130_FFB693B4 
X-CRM114-Status: GOOD (  15.30  )
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
 oren@mellanox.com, martin.petersen@oracle.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Please also sends this to Martin.  In fact adding him to the whole
series might help you to get some good feedback.

On Tue, Nov 05, 2019 at 06:20:17PM +0200, Max Gurtovoy wrote:
> From: Israel Rukshin <israelr@mellanox.com>
> 
> It means that reftag shouldn't be remapped. This flag will be used in
> case some other layer did the reftag remapping (e.g. in NVMe/RDMA the
> initiator controller performs the remapping so target side shouldn't
> map it again).

> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  block/t10-pi.c      | 7 +++++++
>  include/linux/bio.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index f4907d9..6de380b 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -144,6 +144,9 @@ static void t10_pi_type1_prepare(struct request *rq)
>  		/* Already remapped? */
>  		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
>  			break;
> +		/* No need to remap */
> +		if (bip->bip_flags & BIP_NOMAP_INTEGRITY)
> +			break;
>  
>  		bip_for_each_vec(iv, bip, iter) {
>  			void *p, *pmap;
> @@ -193,6 +196,10 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
>  		struct bio_vec iv;
>  		struct bvec_iter iter;
>  
> +		/* No need to remap */
> +		if (bip->bip_flags & BIP_NOMAP_INTEGRITY)
> +			break;
> +
>  		bip_for_each_vec(iv, bip, iter) {
>  			void *p, *pmap;
>  			unsigned int j;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 3cdb84c..2ba09e6 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -299,6 +299,7 @@ enum bip_flags {
>  	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
>  	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
>  	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
> +	BIP_NOMAP_INTEGRITY	= 1 << 5, /* ref tag shouldn't be remapped */
>  };
>  
>  /*
> -- 
> 1.8.3.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
