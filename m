Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760BFC7EE2C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnoITA2vyclEeBazfSggjPhtOGEDLsTXi0beytycRp4=; b=OmedMntzqgGm/1tRfLUpI61SO5
	gyzbFTXwfipiwgGCOF06JMvcudRk1FMYojzYkH9ddKf3cEC4HpwaHU4PvTy3wdeXL6lWXcNq+yAaC
	u3/kxlD8/tr0tPrlGVo6m/a/KiorG3z0QDO8gY9195SO7XBWhadJIwjLeDl0wJlVi3eEuZEyOEuBJ
	iNZr1fwjinusHOPGMP4tmJSxM+xEvyAYtHA99LAzbJm4Wj2ZmfzegaswecsvGx5bJG4Hshgn2BWUG
	PthWz/E/wYVDAdGn94nzZD8K7aQXcAVxzGo5i9vY+5dfWOFuZbrEOszVmxEGj32s+3EXSShm9AfR3
	j3Ctk3dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtK-00BHi8-2b;
	Mon, 29 May 2023 17:42:46 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2W3T-002OOS-11;
	Fri, 26 May 2023 11:56:25 +0000
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QSNYk2f5Tz18LY9;
	Fri, 26 May 2023 19:51:38 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 26 May
 2023 19:56:10 +0800
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator use
 multipage folios
To: David Howells <dhowells@redhat.com>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens
 Axboe <axboe@kernel.dk>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, Jeroen de Borst <jeroendb@google.com>,
	Catherine Sullivan <csully@google.com>, Shailend Chand <shailend@google.com>,
	Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-nvme@lists.infradead.org>
References: <20230524153311.3625329-1-dhowells@redhat.com>
 <20230524153311.3625329-5-dhowells@redhat.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
Date: Fri, 26 May 2023 19:56:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20230524153311.3625329-5-dhowells@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230526_045623_762565_E8721E19 
X-CRM114-Status: GOOD (  22.16  )
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

On 2023/5/24 23:33, David Howells wrote:
> Change the page_frag_cache allocator to use multipage folios rather than
> groups of pages.  This reduces page_frag_free to just a folio_put() or
> put_page().

Hi, David

put_page() is not used in this patch, perhaps remove it to avoid
the confusion?
Also, Is there any significant difference between __free_pages()
and folio_put()? IOW, what does the 'reduces' part means here?

I followed some disscusion about folio before, but have not really
understood about real difference between 'multipage folios' and
'groups of pages' yet. Is folio mostly used to avoid the confusion
about whether a page is 'headpage of compound page', 'base page' or
'tailpage of compound page'? Or is there any abvious benefit about
folio that I missed?

> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 306a3d1a0fa6..d7c52a5979cc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -420,18 +420,13 @@ static inline void *folio_get_private(struct folio *folio)
>  }
>  
>  struct page_frag_cache {
> -	void * va;
> -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> -	__u16 offset;
> -	__u16 size;
> -#else
> -	__u32 offset;
> -#endif
> +	struct folio	*folio;
> +	unsigned int	offset;
>  	/* we maintain a pagecount bias, so that we dont dirty cache line
>  	 * containing page->_refcount every time we allocate a fragment.
>  	 */
> -	unsigned int		pagecnt_bias;
> -	bool pfmemalloc;
> +	unsigned int	pagecnt_bias;
> +	bool		pfmemalloc;
>  };

It seems 'va' and 'size' field is used to avoid touching 'stuct page' to
avoid possible cache bouncing when there is more frag can be allocated
from the page while other frags is freed at the same time before this patch?
It might be worth calling that out in the commit log or split it into another
patch to make it clearer and easier to review?

