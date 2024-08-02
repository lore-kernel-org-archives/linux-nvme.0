Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73771C3DA7F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpcsgqmtuPo+pz6tWtSNKqkTo9JxSymPCppu91onA2Q=; b=LKDVVDSEuv9tE4Wg8FNUSF0Zqn
	7ydcgsyGKSHCjqJ/4xVjO94M3T4NJVL8EejVAFiDNt+YqdWMmBNUufmyK+8iRtzvrnY3hjBO314Eb
	vEbK3IW5v1uw2xnPM3Mj3slW/Y+zS+tEcpnWhVER7hopXPKzqrHcpQJapIZ4HmKSuW62/yb/1Hxd6
	7iNYod+AbGSlQWcBIDzmgsoVdvnfFyWezLHiy9CLNYRUjoT/KPJ+g6M2AzoSggpzNpbSdufwJEkpd
	k1UJwjfjgZ5yA0D51bYSi0OW+yp50r7QPdhLll5NP9ABiyJ77F6tgOEZ7LBaZh7u/E6VHrUENGCw8
	Tu9WR9oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAeg-00000000LGs-0QaP;
	Tue, 06 Aug 2024 03:14:34 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZveY-00000009YJn-3FpD;
	Fri, 02 Aug 2024 17:01:20 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3685a564bafso4082089f8f.3;
        Fri, 02 Aug 2024 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722618077; x=1723222877; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpcsgqmtuPo+pz6tWtSNKqkTo9JxSymPCppu91onA2Q=;
        b=c6KUhB+wfCXTw94QzW8dgOJUWhwXbzSItahmX0L03jGz8gy2zIg45Q5IXPYiA0ym8c
         6T66cIIFJKjYXO0iA29DCjhkl8YGLVgUTzxtPRsTAeC0ppC/Z44kMRdETR300Xir7NL8
         /zdeZw5BusdpSA1AeJRv5m79Q4lK10QRJZTTiVtF8oogKYaccqrlRnViGXkqWm+dlA4P
         6u4nZe8C/ssBRe9sxJDQRFDRTvZ6Xo+QW6dd5DqP4S36A2+2VLDaCvt4dFWxk2hFiY48
         2m0+3Wt5tcJSLTF6Z6ptoB41janXNmRF0kf8gb7tye2xPBVqWHIo3xkXfocSSfoqQkSo
         nQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722618077; x=1723222877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpcsgqmtuPo+pz6tWtSNKqkTo9JxSymPCppu91onA2Q=;
        b=fGVtQT5BQ3BpPnlBQYt93anyQDzQNyGt6mJgvHX6/WAzhbxEwp9gg6LS0hvlTBLX0A
         2wYtasfKZ5QoD6LHtdosbM258DYkpxkZUJoaWpGYqisA1ShPZfD31NQxd/qzRnBdoJDk
         pfnAoJYBLkS5/XTEakWufdLiEd2boHxxaA6ZZrxylFyCCyqqD7EaNzTB+u4ACYSt+ouQ
         hLcbRGY6D1s4s9B1quyY4IIgkqQLV7OstX5XXparmDtxq+2Fafgaa8BX6UWdGTbHKqCL
         wOUqM32LcL/moXU4kLNf9NnLAanJ89oB2UAtZn7Zf012HD7vHXkL30wpO0oA1yvWDlVF
         rhug==
X-Forwarded-Encrypted: i=1; AJvYcCW4HbPZhiB6S8lfUnVkMk/s2nnnKudUk7mB+Jb/979fvudQfGEBB9s73JWRElA2BF5iAvh1OOHdzt6bHJbj2WOUN8H9aVC0uDLZNegiwgyYL5CE/2wlWsNwRFda7r/f/ByoPMKql4o4SSkE98SRrN3Np6+VCY4vO9p0uCu+NdKZLn+4nhELHZhCX39O+HEb7VSyiOtQv8F4YrOXmjScJE1jCrp5fROMYBBbg1Ozgl7LKz361cOye/g=
X-Gm-Message-State: AOJu0YzD04+nt50MtHOvVsOhCRa8c0huCqdCnxgDaUNmYqbg4gWjFuCH
	emoLpkrPGlQecegsujEWlnxiJJUR/r8gdnwZhvrJ6Ms7oCuxSdcGc8pKxlF/5wpqN3ykGHPhrwj
	MoOttBzaorAMuwDouUXk6xQZWVAQ=
X-Google-Smtp-Source: AGHT+IH75FU4JpBvhRKVqmFn8me2clEuJ7/a5V8Xhv6OElYPF/ofyi1s2L5ZzsGAeeZuvfLRALy59I0v9WsGM6Mhk90=
X-Received: by 2002:adf:e98a:0:b0:368:4d33:9aac with SMTP id
 ffacd0b85a97d-36bbc0fc757mr2416504f8f.31.1722618076415; Fri, 02 Aug 2024
 10:01:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com> <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com> <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
 <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
In-Reply-To: <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 2 Aug 2024 10:00:39 -0700
Message-ID: <CAKgT0UfUkqR2TJQt6cSEdANNxQEOkjGqpPXhaXmrrxB0KwXmEQ@mail.gmail.com>
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-nvme@lists.infradead.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_100118_841590_70570F43 
X-CRM114-Status: GOOD (  42.39  )
X-Mailman-Approved-At: Mon, 05 Aug 2024 20:14:30 -0700
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

On Fri, Aug 2, 2024 at 3:05=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 23:21, Alexander Duyck wrote:
> > On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei=
.com> wrote:
> >>
> >> On 2024/8/1 2:13, Alexander Duyck wrote:
> >>> On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>>
> >>>> Currently the page_frag API is returning 'virtual address'
> >>>> or 'va' when allocing and expecting 'virtual address' or
> >>>> 'va' as input when freeing.
> >>>>
> >>>> As we are about to support new use cases that the caller
> >>>> need to deal with 'struct page' or need to deal with both
> >>>> 'va' and 'struct page'. In order to differentiate the API
> >>>> handling between 'va' and 'struct page', add '_va' suffix
> >>>> to the corresponding API mirroring the page_pool_alloc_va()
> >>>> API of the page_pool. So that callers expecting to deal with
> >>>> va, page or both va and page may call page_frag_alloc_va*,
> >>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>>>
> >>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >>>
> >>> I am naking this patch. It is a pointless rename that is just going t=
o
> >>> obfuscate the git history for these callers.
> >>
> >> I responded to your above similar comment in v2, and then responded mo=
re
> >> detailedly in v11, both got not direct responding, it would be good to
> >> have more concrete feedback here instead of abstract argument.
> >>
> >> https://lore.kernel.org/all/74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawe=
i.com/
> >> https://lore.kernel.org/all/11187fe4-9419-4341-97b5-6dad7583b5b6@huawe=
i.com/
> >
> > I will make this much more understandable. This patch is one of the
> > ones that will permanently block this set in my opinion. As such I
> > will never ack this patch as I see no benefit to it. Arguing with me
> > on this is moot as you aren't going to change my mind, and I don't
> > have all day to argue back and forth with you on every single patch.
>
> Let's move on to more specific technical discussion then.
>
> >
> > As far as your API extension and naming maybe you should look like
> > something like bio_vec and borrow the naming from that since that is
> > essentially what you are passing back and forth is essentially that
> > instead of a page frag which is normally a virtual address.
>
> I thought about adding something like bio_vec before, but I am not sure
> what you have in mind is somthing like I considered before?
> Let's say that we reuse bio_vec like something below for the new APIs:
>
> struct bio_vec {
>         struct page     *bv_page;
>         void            *va;
>         unsigned int    bv_len;
>         unsigned int    bv_offset;
> };

I wasn't suggesting changing the bio_vec. I was suggesting that be
what you pass as a pointer reference instead of the offset. Basically
your use case is mostly just for populating bio_vec style structures
anyway.

> It seems we have the below options for the new API:
>
> option 1, it seems like a better option from API naming point of view, bu=
t
> it needs to return a bio_vec pointer to the caller, it seems we need to h=
ave
> extra space for the pointer, I am not sure how we can avoid the memory wa=
ste
> for sk_page_frag() case in patch 12:
> struct bio_vec *page_frag_alloc_bio(struct page_frag_cache *nc,
>                                     unsigned int fragsz, gfp_t gfp_mask);
>
> option 2, it need both the caller and callee to have a its own local spac=
e
> for 'struct bio_vec ', I am not sure if passing the content instead of
> the pointer of a struct through the function returning is the common patt=
ern
> and if it has any performance impact yet:
> struct bio_vec page_frag_alloc_bio(struct page_frag_cache *nc,
>                                    unsigned int fragsz, gfp_t gfp_mask);
>
> option 3, the caller passes the pointer of 'struct bio_vec ' to the calle=
e,
> and page_frag_alloc_bio() fills in the data, I am not sure what is the po=
int
> of indirect using 'struct bio_vec ' instead of passing 'va' & 'fragsz' &
> 'offset' through pointers directly:
> bool page_frag_alloc_bio(struct page_frag_cache *nc,
>                          unsigned int fragsz, gfp_t gfp_mask, struct bio_=
vec *bio);
>
> If one of the above option is something in your mind? Yes, please be more=
 specific
> about which one is the prefer option, and why it is the prefer option tha=
n the one
> introduced in this patchset?
>
> If no, please be more specific what that is in your mind?

Option 3 is more or less what I had in mind. Basically you would
return an int to indicate any errors and you would be populating a
bio_vec during your allocation. In addition you would use the bio_vec
as a tracker of the actual fragsz so when you commit you are
committing with the fragsz as it was determined at the time of putting
the bio_vec together so you can theoretically catch things like if the
underlying offset had somehow changed from the time you setup the
allocation. It would fit well into your probe routines since they are
all essentially passing the page, offset, and fragsz throughout the
code.

