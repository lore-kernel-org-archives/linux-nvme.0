Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2625AC7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F2xmqKILWJ1dgLZi6wOxmDNvNF7phhliXPZojQMvl0g=; b=X5FC6EGcyvvPYKKok4uRUrG/i1
	j5CI/0m00NqO8Ox1xVXKkoMhps+dYfZOxu0RvaBjUNh48+CGHMbso9DKot52Qtzlo0kIn4YwECqqE
	dJoNZTlLPqEh3Iell1GEVuKWwzTPEHVN5lqzijSI3fnps0NXe7YDjQfX+FUSuGsadaZns8vEsSZxY
	+kzl3rmk+v+jDpuL14JChcwSNrykQTGw8zSRY0eIGMV9wesuOeGleXf5RbPDtHvj7kuakg9pXbfgB
	C5Q6+8+MOA/hYUyyTmxOwLfjTbRgxLrHXNr96TWrU6emsC9u8sIK+hk4bXzyUpangiaKDnqneBHVi
	bbxTg+iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtN-00BHju-19;
	Mon, 29 May 2023 17:42:49 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2i8E-004TRc-2s;
	Sat, 27 May 2023 00:50:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7AD4E65489;
	Sat, 27 May 2023 00:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CF1C433D2;
	Sat, 27 May 2023 00:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685148604;
	bh=PctGZlrrzibp7UAnk07C/sOmUfyQ9mUKgJg38V2xuBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b5IVwgYRE/2EVTpq7191D0vqSuCOLDLA9yxTg8kzF2RTtrFlASvkrFmPLaJtaVukQ
	 dx5NKWsr6CkQoGLe9DVthIsfhGRUMLCIhOM3QVgrl7be2FWaDy+DnfW190vcVwTJ2s
	 zU16jMx+fgyZWf833+TKCK1dS9ojn0TwISpmHXXc4A6MxBBQ/0mOPvMaIk698Velpj
	 TprITEm52LvMpvY15nmUsfSBRWn/PIGwebDUf9F7yPhJw536eOoYIVLCUc4Fu6rjuw
	 5mKxlb8geTfkhmlqwBdxW8lU1ju4L3hTlb8r95qR77Md4eoESwaMNVfTOzd1VQdYKQ
	 4GtDL57/Vxi2w==
Date: Fri, 26 May 2023 17:50:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jeroen de Borst
 <jeroendb@google.com>, Catherine Sullivan <csully@google.com>, Shailend
 Chand <shailend@google.com>, Felix Fietkau <nbd@nbd.name>, John Crispin
 <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator
 use multipage folios
Message-ID: <20230526175002.2591ccae@kernel.org>
In-Reply-To: <20230524153311.3625329-5-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
	<20230524153311.3625329-5-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_175006_989535_C9227FC8 
X-CRM114-Status: GOOD (  15.96  )
X-Mailman-Approved-At: Mon, 29 May 2023 10:42:39 -0700
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

On Wed, 24 May 2023 16:33:03 +0100 David Howells wrote:
> -	offset = nc->offset - fragsz;
> -	if (unlikely(offset < 0)) {
> -		page = virt_to_page(nc->va);
> -
> -		if (page_ref_count(page) != nc->pagecnt_bias)
> +	offset = nc->offset;
> +	if (unlikely(fragsz > offset)) {
> +		/* Reuse the folio if everyone we gave it to has finished with
> +		 * it.
> +		 */
> +		if (!folio_ref_sub_and_test(folio, nc->pagecnt_bias)) {
> +			nc->folio = NULL;
>  			goto refill;
> +		}
> +
>  		if (unlikely(nc->pfmemalloc)) {
> -			page_ref_sub(page, nc->pagecnt_bias - 1);
> -			__free_pages(page, compound_order(page));
> +			__folio_put(folio);

This is not a pure 1:1 page -> folio conversion.
Why mix conversion with other code changes?

