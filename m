Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDE5C7EE2C
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J49g5r+C8X2NVCkBgl8IzrTCMvTMcQQzUyfAMjxZsPg=; b=0QYAnzEca8TXoNcQiTFj2ZcWX9
	ZQQrPclqF5UFOQ47S/d2w5CyzAn6RFTnHkUIdKJMAigan8D86VJaCKaunTBXoPitwbis+dULLYBYG
	t6Ii5ABS77Sop2aWldF28M1l4mQOB+9Q9mkC/wVygMoc/cFQ4QDvNJCIyiihxnhG60tDmqcb62YQF
	kcWepDMmSYQD8KEXQTcoeY+SbwXVuiKSoXKECa1fVg8piDnh+N19w24psfnw3h5pF7BWElA1l1vm7
	QK1EvNFH/tSo1a/vSNAFwK3JEfZKz5JwhlGN4Jjnx/ToQRJdc+PdEXAnF1E7nJoRxhs34Qr3fwunv
	2jGSFNDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtQ-00BHmz-1e;
	Mon, 29 May 2023 17:42:52 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2w9F-005ySq-21;
	Sat, 27 May 2023 15:48:07 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5346d150972so1613032a12.3;
        Sat, 27 May 2023 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685202482; x=1687794482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J49g5r+C8X2NVCkBgl8IzrTCMvTMcQQzUyfAMjxZsPg=;
        b=bUL5aHRkLeXZgL9zLh88p3YSSEdIcCAWRafE5CCYjGxTY3b4C3Nvx9HyPTyr/MFIOy
         XNJoF8YCF/UuX9K7KUHu0+XrePH07oMRCWX8Xbo1x7sNks0uPXrC7DyAE2YZ4nRJbxmX
         R+vS/qobWvWDwbY/vp3IFGaoobPrHdxLodkySGURPv0utOVIMAyhkSVf+YGDr2He0s2+
         mFeAz0s4hFMt6E5OhaapTV9xjhbS5h7hmrocjChFeleEtRzzQxiyNpffZQ1mkdD3wp6N
         kwic0v4RCyjRUeyXdYulrgWtKqFCkPBnTY7+z+AWj+P7a+4sVK3Mo/U26rqt0pp8KAYf
         6I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685202482; x=1687794482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J49g5r+C8X2NVCkBgl8IzrTCMvTMcQQzUyfAMjxZsPg=;
        b=lZ7lRgV1qAEv0gDAl8v4zXFw3v3zj8aJQtZ0jZhVnVLabbGh6QKt2FY8f7cgoNnDS3
         LI5qeKPRQ93QTRJNeyVpbXfUwGNQ3a9xaReTjqhP7ZCrbxjLaaNwxV0WSEzOnFwRSWyZ
         ykYza7QcBwXUzH3j46OkmHtCpXSswqFvT/Lrennf2YR7xRDYj32iTh3m645GRWeGhbYH
         HV+x8I0r7RgtQGGWqd9FBdYP7KKPdaR4OKnnLBsa8hHduvs5YTMRHhLQXkegkZpGoTaZ
         eLCB3TW45sMXZyFFEK+T6lFlGJfEIGapariA11AuSlN2mtdbzqb8DFyuxjBupUfRimtQ
         WoPw==
X-Gm-Message-State: AC+VfDxnhCezYjvP30ZXTK2b7vg+QFLaxEqpHYsrthcyMf7ZH2plMnSe
	h9YiUHK6vGQyHCP1u+o2FbQ=
X-Google-Smtp-Source: ACHHUZ7QPh85GAe4qtDoAAFctO3cPI86At/IRUfb5BaooKwKJwDEqjmatrKZ0/p6N1NdUk4vgS+bMw==
X-Received: by 2002:a17:90a:7021:b0:250:7d1f:938b with SMTP id f30-20020a17090a702100b002507d1f938bmr6504460pjk.23.1685202481899;
        Sat, 27 May 2023 08:48:01 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 5-20020a17090a000500b00253311d508esm6598798pja.27.2023.05.27.08.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 08:48:01 -0700 (PDT)
Message-ID: <f7919c2c9e1cb6218a0b0f55ddaa9a34f7d2b9a7.camel@gmail.com>
Subject: Re: [PATCH net-next 04/12] mm: Make the page_frag_cache allocator
 use multipage folios
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, David Howells
 <dhowells@redhat.com>,  netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>, 
 Catherine Sullivan <csully@google.com>, Shailend Chand
 <shailend@google.com>, Felix Fietkau <nbd@nbd.name>, John Crispin
 <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>,  Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>,  linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org,  linux-nvme@lists.infradead.org
Date: Sat, 27 May 2023 08:47:58 -0700
In-Reply-To: <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
	 <20230524153311.3625329-5-dhowells@redhat.com>
	 <a819dd80-54cc-695f-f142-e3d42ce815a7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_084805_669417_1E857875 
X-CRM114-Status: GOOD (  30.26  )
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

On Fri, 2023-05-26 at 19:56 +0800, Yunsheng Lin wrote:
> On 2023/5/24 23:33, David Howells wrote:
> > Change the page_frag_cache allocator to use multipage folios rather tha=
n
> > groups of pages.  This reduces page_frag_free to just a folio_put() or
> > put_page().
>=20
> Hi, David
>=20
> put_page() is not used in this patch, perhaps remove it to avoid
> the confusion?
> Also, Is there any significant difference between __free_pages()
> and folio_put()? IOW, what does the 'reduces' part means here?
>=20
> I followed some disscusion about folio before, but have not really
> understood about real difference between 'multipage folios' and
> 'groups of pages' yet. Is folio mostly used to avoid the confusion
> about whether a page is 'headpage of compound page', 'base page' or
> 'tailpage of compound page'? Or is there any abvious benefit about
> folio that I missed?
>=20
> >=20
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 306a3d1a0fa6..d7c52a5979cc 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -420,18 +420,13 @@ static inline void *folio_get_private(struct foli=
o *folio)
> >  }
> > =20
> >  struct page_frag_cache {
> > -	void * va;
> > -#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
> > -	__u16 offset;
> > -	__u16 size;
> > -#else
> > -	__u32 offset;
> > -#endif
> > +	struct folio	*folio;
> > +	unsigned int	offset;
> >  	/* we maintain a pagecount bias, so that we dont dirty cache line
> >  	 * containing page->_refcount every time we allocate a fragment.
> >  	 */
> > -	unsigned int		pagecnt_bias;
> > -	bool pfmemalloc;
> > +	unsigned int	pagecnt_bias;
> > +	bool		pfmemalloc;
> >  };
>=20
> It seems 'va' and 'size' field is used to avoid touching 'stuct page' to
> avoid possible cache bouncing when there is more frag can be allocated
> from the page while other frags is freed at the same time before this pat=
ch?
> It might be worth calling that out in the commit log or split it into ano=
ther
> patch to make it clearer and easier to review?

Yes, there is a cost for going from page to virtual address. That is
why we only use the page when we finally get to freeing or resetting
the pagecnt_bias.

Also I have some concerns about going from page to folio as it seems
like the folio_alloc setups the transparent hugepage destructor instead
of using the compound page destructor. I would think that would slow
down most users as it looks like there is a spinlock that is taken in
the hugepage destructor that isn't there in the compound page
destructor.

