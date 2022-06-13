Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F8BC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R9cwQes19biTPUFJ4Epw+9yyv9UPAuF4DYz7OKAEwIc=; b=dO+EGpBg4zpI/lq6DlcSdRAM55
	vMiS80zudESuLXoVEz0vj94E4AqLHZRF+D4mvUxy0nYnpJWCw9ElyqTyvwbrp5e+zk2a86PELrobE
	otJvoF+f+R+j/xGZL8hITI5SrEWEWVe45+GI5s7CDfom8AMDKxkd5Jn6LrVm5pFJb5MymORne5KkP
	f5rzawGpuyD5Xyfs5iEGVN0Z04QKcTnDKgDJ5ndxduwt2ir7mNMFUQT2UM70TFLbeuMnrVPaSXFQ7
	BRd85ZvFI7F+f6HD+w5Swk+XBNQGcYCvALFDhzo44zgSDwbUYMGDep99XrTZdS1E/n+t3YYmtmKY8
	mCeQ06OA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0ok2-0059Pp-Lu; Mon, 13 Jun 2022 18:24:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0ojz-0059OM-Jz
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 18:24:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 22D4968AA6; Mon, 13 Jun 2022 20:24:40 +0200 (CEST)
Date: Mon, 13 Jun 2022 20:24:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, joshi.k@samsung.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: Re: [PATCH v2 2/2] nvme: enable generic interface (/dev/ngXnY) for
 unknown command sets
Message-ID: <20220613182439.GA16349@lst.de>
References: <20220607134055.1742162-1-j.granados@samsung.com> <CGME20220607134312eucas1p1a66a21581dc64344f21c03a26e540fb7@eucas1p1.samsung.com> <20220607134055.1742162-3-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607134055.1742162-3-j.granados@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_112443_854393_4B2FC13B 
X-CRM114-Status: GOOD (  16.05  )
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

On Tue, Jun 07, 2022 at 03:40:55PM +0200, Joel Granados wrote:

>  static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>  		struct nvme_ns_ids *ids)
>  {
> +	int ret = 0;
>  	struct nvme_ns *ns;
>  	struct gendisk *disk;
>  	struct nvme_id_ns *id;
> +	struct nvme_id_ns_cs_indep *indep_id;
>  	int node = ctrl->numa_node;
> +	bool cs_indep = nvme_ns_indep(ids);
>  
> -	if (nvme_identify_ns(ctrl, nsid, ids, &id))
> +	if (cs_indep)
> +		ret = nvme_identify_ns_cs_indep(ctrl, nsid, &indep_id);
> +	else
> +		ret = nvme_identify_ns(ctrl, nsid, ids, &id);

nvme_validate_or_alloc_ns already does the nvme_identify_ns_cs_indep, so
we should be able to reuse it or move it here.

> -	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
> +	if (nvme_init_ns_head(ns, nsid, ids,
> +			      (cs_indep ? indep_id->nmic : id->nmic) & NVME_NS_NMIC_SHARED))

This is pretty ugly.  I think if there is no command set idepdent
structure supported, we should probably just fake one up based on the
legacy Identify Namespace.

> +	if (cs_indep)
> +		ret = nvme_update_ns_info_cs_indep(ns, indep_id);
> +	else
> +		ret = nvme_update_ns_info(ns, id);

And here we should do a switch on ids->csi ala:

	 switch (ids.csi) {
	 case NVME_CSI_NVM:
	 case NVME_CSI_ZNS:
	 	ret = nvme_update_ns_info_block(ns, id);
		break
	default:
		nvme_update_ns_info_generic(ns, iid);
		break;
	}

