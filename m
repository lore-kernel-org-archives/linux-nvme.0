Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B74C3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=; b=U8F/AIo+OKAUlOy4WCnh7m8JKs
	PqdMM/c3ccO39uYckxsF3WMWQbi0QkqvYYdBObERyvLZcDWWHcii9pLMMDlF7OloF1UnlgXFZtBnJ
	C1G4nCX6qNR/56d9jCotp1abr7X2vqrAiWzegKTbhTMsSV6rNZcWDr+O7PkRN7eiKTx4rZ8BGILEO
	VmRVWMndr30C94JdLb4jfa6chvR5AFptniiU8MI8TxAUBx/IVsAXuYrC4eCqobsi7ZQFoVJvDeRTk
	hiotvDrqDt0nH+Hzrm5QhBoJMeXUidFBsE+SQyBveG2/tMP3N4q+QRqBnPHcVckJcUQ0lEJT/hsLe
	nJtQ5P+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAee-00000000LGZ-3PHA;
	Tue, 06 Aug 2024 03:14:32 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZXdW-00000005qP3-2xXc;
	Thu, 01 Aug 2024 15:22:40 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so6439285e9.2;
        Thu, 01 Aug 2024 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722525756; x=1723130556; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=;
        b=XslYqm01ZuG2hwiK/ltovYDhfbTwtLb0VeUHlz4ZeXoV/+D80vafzv3i/+jXe/S85U
         lsqvjcQI8UIuSXJGT9XpKVCWC2j+nVrEb+J0FlqgX9OOZCD5eRJ/USReWfbSIGex+BtK
         014saqBbLcEkjFFUnNsdHQ1Gq7aT3TSoh9Y+sgGqEGqO48i9wggD5zVMBD0HUiwIYOhU
         cyX5H5Z/LiZVTbcG6MrrMnBqyRfesv9vKESZ333BLjJLYYJFqKetbI9s++up0u2DJGDU
         RQCqwBHxQEYZbskakBEPUCgtdy1jRHhriIqGUjzSlsq7nxRLP4Rzbc0oOGbh44XC4F7Z
         etbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525756; x=1723130556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Dx2Bv0d2od3Km7MjoXRYzhl1VfhP4WqwsY5gBZHcjc=;
        b=IYn4JbP2PWYvSwYppZF7w2nNIYEWlxFMGUqv5Zaf25mZqQQeaw2F2xRosKVE4s3Fys
         P8cPWwitW4hPiffUh5/JDMGiUR+czpqtvO/AZxjckNBvwcoK/xDhZgte1shwTMyNr2cc
         gBpXJpFzLxEl7byEVDLd+dMDZAOxvWv9UVVWybA5I4KzRjqUeM3gsmrtDo7obl/m0Xuw
         vUlqFUzS58NG9vVWNkIeVeXtQyel+v160F+fhneCZbrwLqndNapzEgwPd6EpTKdMG0LY
         zvlqn+Z5Zzwv24HmanWq93X2b7TvC/r0D15FHqpO4I8JKLMqeBfYhu8q8y6Xk8COVyyx
         lD4w==
X-Forwarded-Encrypted: i=1; AJvYcCUDzPaQ5kqBysrvWT69JYfGHq+Qblcv20nTLQMtwMZ+K7DtmrLG+IXDNEfETBQDm/2iwSInby5NLTPipXzD/6yhjuVE6ngJDV/Q9sxpGE6eHL7XOg9NrCfZ8HjUWHQQjW50Fa9QDFdKVVWUxMftzshSrDQuwFYAOozjMgfGlcozBpL2MWC9zOIHfBmHkzbBVywI7yaTaZnMwoqR/nl4OexsGb4pTIeU4h8qq8m3iWrh7DSmV7mrsXM=
X-Gm-Message-State: AOJu0YzW8ZNBImhCDaAf4jRANGQjpsJdJrzgssyHJ77eKHNadmsPqlsb
	7fcuTsVf99QNhK49FrruaJ8bvcBCS2xDkRtb2KvaXPeDINNIEhsCmKlMq6u2SltZzCp9kdDzNsW
	CAoiCLcLrRiS0oFYKZhHTVE5j+eU=
X-Google-Smtp-Source: AGHT+IHJwpMJUuvVBDGd0+iVwndbV1UbEfs+MYBNb+0c/veShsqCR+fklPSjDi/gK00dEDB9UQYZf/nj06+15imHIwM=
X-Received: by 2002:adf:f14d:0:b0:368:4bc0:9211 with SMTP id
 ffacd0b85a97d-36bbc0f3459mr125871f8f.17.1722525756248; Thu, 01 Aug 2024
 08:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com> <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
In-Reply-To: <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 1 Aug 2024 08:21:59 -0700
Message-ID: <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240801_082238_766551_3F955A80 
X-CRM114-Status: GOOD (  21.80  )
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

On Thu, Aug 1, 2024 at 6:01=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/8/1 2:13, Alexander Duyck wrote:
> > On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
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
> >
> > I am naking this patch. It is a pointless rename that is just going to
> > obfuscate the git history for these callers.
>
> I responded to your above similar comment in v2, and then responded more
> detailedly in v11, both got not direct responding, it would be good to
> have more concrete feedback here instead of abstract argument.
>
> https://lore.kernel.org/all/74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawei.c=
om/
> https://lore.kernel.org/all/11187fe4-9419-4341-97b5-6dad7583b5b6@huawei.c=
om/

I will make this much more understandable. This patch is one of the
ones that will permanently block this set in my opinion. As such I
will never ack this patch as I see no benefit to it. Arguing with me
on this is moot as you aren't going to change my mind, and I don't
have all day to argue back and forth with you on every single patch.

As far as your API extension and naming maybe you should look like
something like bio_vec and borrow the naming from that since that is
essentially what you are passing back and forth is essentially that
instead of a page frag which is normally a virtual address.

