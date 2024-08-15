Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E57EC3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5A/Pf35dj4E2EpVtARhuhl6tAP8WNgJnMyspcYzO+k=; b=iFC350aycEBVbXsaJ+vu4mkUI+
	xemt1z3sXqO7BiuHn2Sl/GWBhbMtm8atpg7+zdnF8JFoDhthsaVu/aIvt297IMqtXmoly+oH26VI4
	S4JDiFjb6um+K8N7bcY3ojy5KodaFtkphJcjcb/jqZwncBoPan5NH85bMU+/NQk1qRADDsQvD8e4L
	SyyyOlB0HpgxYNLePBA1WY7MAKxAN3/cxewVjU6DsALzQlrqDQGHq7um/l8aFn+M08k1NJHeGyHRs
	VFDF0kXe2xWwcW9L8VrwfcLemTS/F093Si6jP2Vb8L98vZ0BZGV3pe+oEo704csoiyximUXKUIiS5
	c1f6VAZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQjT-00000005nUQ-1WKE;
	Tue, 20 Aug 2024 15:25:15 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sebyi-0000000AIa6-2iK8;
	Thu, 15 Aug 2024 15:01:33 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-42803bbf842so9584715e9.1;
        Thu, 15 Aug 2024 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723734086; x=1724338886; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5A/Pf35dj4E2EpVtARhuhl6tAP8WNgJnMyspcYzO+k=;
        b=WHxcbyuAWCrTO3UiSy+hGifJKcmf8zg1ipCaTG28tfDDbuppwCep/4IVyFoSB2lW5g
         gPpd+zvMJL1ArM+BKieTGAxSCymwPAdZDRfqRKQAqifvjvySPCpBvs/9/3ELSUmZUR+y
         DwYsZajsAchMvIdIP6DWdMEs3xrIk/7RMJU1RBCVQlhU8KgFxkTG49K7XC1LeOx7vqBq
         NqptpCR5lR3Yy8U3XfetMYqqbEFU1LGhWBBJQPK+2K87eyI2GiY0e+wBL0SH4LFHiGBs
         +DTMmaM7Tnyg6b8HLdF1b9xctXZzEjGHgaGEEFZmoIpvJ2zWrOv1qAuXTEFiM7QAafeN
         jI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723734086; x=1724338886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X5A/Pf35dj4E2EpVtARhuhl6tAP8WNgJnMyspcYzO+k=;
        b=YIzl0MCkyxku5cQwratMQ3pWvyfS1pc9x4B46WwuqVrhjB/5iOWIxRVlQcV4h5Q6x/
         wxeso4y1ptkarn0mkLKjvcDJhdmrwcEr/JNJtGI8DxMNBWlh3jYfBDDynDDu7PQpvihI
         +WQ0huYS4v9C44oe7p0sDy3A2VcJWoW+4pr7vFyYQsPuKxAZzjAf2xb9Htdxmnu5TLDN
         DVPZzC1vMdIi2238Ih6//Rc/Fp7/28bBRDanLedRSOxTTZfOUtoMdXb+DH4H1HBGcsdI
         cCFhM4D6eUp4cECfeNpuz0KPj0u3JwQfvMY3PEAaYulfL1NU1BisvFyDTLibXD1oL1nU
         R9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL96OIBG6WF+5VEbXkxGv3/wPYTzhPPh+1BUviaNKGLkdB8FzTGQF8i/d3S4E79g+jjbU6tOHwpnHV0Rg1UH3KtA9zEk2yfiWuUE8xgwLdgawIe6E62Qd+md5B4Sr2W6RZCHVy6+oxUpK3MawoBRzTGx3DyngiPZfGN+NN5GOLliAJaXMjpSNvX1tcH2q7Y03jTLPI+idYbqa4BX/1n1e21Mb31sDO/nRbXsGmwpc37DOMxSnehFc=
X-Gm-Message-State: AOJu0Ywq2fmBghNnxXkqwoBBYwvKDoNl5jCfl4ecw5qESYK3mb/unJR9
	BJiADinsx+LgN+rgrmdYcCxnN4N8Yu3IwNQhDJpgac87AzfcEBjOV59BuLtwe+IHoPr1e1XIjJO
	v9dxPATFGDV4fX4Ey/nTDyNJ9Z+w=
X-Google-Smtp-Source: AGHT+IFDnpMtbZ2O72JrYtKTcNGdeMRDRFuISj162VcIBgDVR4ZNDcEgvb9oYMQdJ7UgCrLds6/xYlzhvGcrtQXyvpA=
X-Received: by 2002:a05:600c:511e:b0:426:59d3:8cae with SMTP id
 5b1f17b1804b1-429dd236521mr62262805e9.13.1723734085882; Thu, 15 Aug 2024
 08:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com> <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
In-Reply-To: <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 15 Aug 2024 08:00:49 -0700
Message-ID: <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_080128_714983_342B5D56 
X-CRM114-Status: GOOD (  32.31  )
X-Mailman-Approved-At: Tue, 20 Aug 2024 08:23:04 -0700
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

On Wed, Aug 14, 2024 at 8:00=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/14 23:49, Alexander H Duyck wrote:
> > On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> >> Currently the page_frag API is returning 'virtual address'
> >> or 'va' when allocing and expecting 'virtual address' or
> >> 'va' as input when freeing.
> >>
> >> As we are about to support new use cases that the caller
> >> need to deal with 'struct page' or need to deal with both
> >> 'va' and 'struct page'. In order to differentiate the API
> >> handling between 'va' and 'struct page', add '_va' suffix
> >> to the corresponding API mirroring the page_pool_alloc_va()
> >> API of the page_pool. So that callers expecting to deal with
> >> va, page or both va and page may call page_frag_alloc_va*,
> >> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> >> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> >> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> >> ---
> >>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
> >>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
> >>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
> >>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
> >>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
> >>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
> >>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
> >>  drivers/nvme/host/tcp.c                       |  8 +++----
> >>  drivers/nvme/target/tcp.c                     | 22 +++++++++---------=
-
> >>  drivers/vhost/net.c                           |  6 ++---
> >>  include/linux/page_frag_cache.h               | 21 +++++++++---------
> >>  include/linux/skbuff.h                        |  2 +-
> >>  kernel/bpf/cpumap.c                           |  2 +-
> >>  mm/page_frag_cache.c                          | 12 +++++-----
> >>  net/core/skbuff.c                             | 16 +++++++-------
> >>  net/core/xdp.c                                |  2 +-
> >>  net/rxrpc/txbuf.c                             | 15 +++++++------
> >>  net/sunrpc/svcsock.c                          |  6 ++---
> >>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
> >>  19 files changed, 75 insertions(+), 70 deletions(-)
> >>
> >
> > I still say no to this patch. It is an unnecessary name change and adds
> > no value. If you insist on this patch I will reject the set every time.
> >
> > The fact is it is polluting the git history and just makes things
> > harder to maintain without adding any value as you aren't changing what
> > the function does and there is no need for this. In addition it just
>
> I guess I have to disagree with the above 'no need for this' part for
> now, as mentioned in [1]:
>
> "There are three types of API as proposed in this patchset instead of
> two types of API:
> 1. page_frag_alloc_va() returns [va].
> 2. page_frag_alloc_pg() returns [page, offset].
> 3. page_frag_alloc() returns [va] & [page, offset].
>
> You seemed to miss that we need a third naming for the type 3 API.
> Do you see type 3 API as a valid API? if yes, what naming are you
> suggesting for it? if no, why it is not a valid API?"

I didn't. I just don't see the point in pushing out the existing API
to support that. In reality 2 and 3 are redundant. You probably only
need 3. Like I mentioned earlier you can essentially just pass a
page_frag via pointer to the function. With that you could also look
at just returning a virtual address as well if you insist on having
something that returns all of the above. No point in having 2 and 3 be
seperate functions.

I am going to nack this patch set if you insist on this pointless
renaming. The fact is it is just adding noise that adds no value.

