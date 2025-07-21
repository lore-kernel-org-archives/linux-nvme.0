Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24CBC83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fv9I2W0HPIiuwfuR85B40flZe4ucdfz4Ly+NYFIOjjk=; b=19FLTI/nr1LA+49nTUWseA5qJn
	KM/XkHVIizrjPLVPI4PlAi3lDayHiunKZwL+49F8I/xpQ916qA1QyvRnqZrVLi+laFF1WzKNG1PQU
	ToOlZ4+obQ50ujO/Ee5KZpJcRCirjsf5vb7T9sjQXm3gLSIbyrGjX5RClassKi/P514dBiQZPqtkV
	VxWZ9w6RLx99AQskvOx+VvSr87nu5KZZuFLcAHarW8JMeL6LdemXYXPndV/h5Zq/S7O6wwL4xNrtj
	+TK1fQn3A3YEhCt73UwA+CgCuvLUr46bD3QHxNJUCXgGVS0WCN02YHith+FkPXJ1OSeOaQXy6FfZS
	3HCIth8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udrc7-0000000HY2X-0pVX;
	Mon, 21 Jul 2025 14:35:35 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udqMq-0000000HMdH-3JWJ
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 13:15:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D746B5C5E73;
	Mon, 21 Jul 2025 13:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3752DC4CEED;
	Mon, 21 Jul 2025 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753103743;
	bh=mwwxA6mQpFGv/fMSObulRQgthQ8CoywztVNbwD6LVJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8Uf7fF33mwkmPDNI8ecdi4l0ppwuaq4Om6A7aSvZwa1VrdzDYOKFaqox6IaOeoFJ
	 R4qCH8CUcFUPlq7twRUvsn6yp3HlkTbLpVcM4lk2qEWDvq6ynuTCgmpGSnxoN/r1LP
	 pU55/I0GFR/i6JcriobOJzHYnKEJfrDwnPagTy4fD7pZ5zyn/whO7YuHayIIJ/tfPn
	 /LRGwHdzudKoc069TmYeBL82EqSfoeXYXzdEtTleX5nmwm2g91+cxADokV7nL7B2LW
	 rukV6sdececKdTkhUPOWuFEarUZwH6bly7BV6Vb/XFmM0Bg6urVnx1psXgJEa4Rh5h
	 9d2/CmH69tHuA==
Date: Mon, 21 Jul 2025 07:15:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk, leonro@nvidia.com
Subject: Re: [PATCHv2 7/7] nvme: convert metadata mapping to dma iter
Message-ID: <aH49fa1qH4HN5P7w@kbusch-mbp>
References: <20250720184040.2402790-1-kbusch@meta.com>
 <20250720184040.2402790-8-kbusch@meta.com>
 <20250721075053.GH32034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075053.GH32034@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_061544_868607_2161BE79 
X-CRM114-Status: GOOD (  17.02  )
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

On Mon, Jul 21, 2025 at 09:50:53AM +0200, Christoph Hellwig wrote:
> >  	if (entries == 1) {
> > -		nvme_pci_sgl_set_data_sg(sg_list, sgl);
> > +		iod->meta_total_len = iter.len;
> > +		nvme_pci_sgl_set_data(sg_list, &iter);
> > +		iod->nr_meta_descriptors = 0;
> 
> This should probably just set up the linear metadata pointer instead
> of a single-segment SGL.

Okay, but we should still use SGL with user passthrough commands for
memory safety. Even if we have an iommu protecting access, there's still
a possibility of corrupting adjacent iova's if using MPTR.
 
> > +	if (!iod->nr_meta_descriptors) {
> > +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list->addr),
> > +				le32_to_cpu(sg_list->length), dir);
> > +		return;
> > +	}
> > +
> > +	for (i = 1; i <= iod->nr_meta_descriptors; i++)
> > +		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
> > +				le32_to_cpu(sg_list[i].length), dir);
> > +}
> 
> The use of nr_meta_descriptors is still incorrect here.  nr_descriptors
> counts the number of descriptors we got from the dma pools, which
> currently is always 1 for metadata SGLs.  The length of the SGL
> descriptor simplify comes from le32_to_cpu(sg_list[0].length) divided
> by the sgl entry size.

In this patch, the nr_meta_descriptors value matches the sg_list length.
The only real reason I need this 'nr_' value is to distinguish the
single data descriptor condition from the segment descriptor use, but I
can just add an iod flag for that too and save some space.

