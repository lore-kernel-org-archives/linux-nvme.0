Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241C8C52D70
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=; b=SSXgGgvhUzBL903VUHYYDfU6SQ
	2O1pkOlAtkWsbA9MLwVdMKl9SmGXTkY25TtEKcl7LanCknox+6mo3WfSXMB5/KCzzwSzE1tPAacgJ
	1J5pqTIeUIsnw7l4TIZiCZz5r70uGBgjPKvu5VBVd/1419FyJ7Wd4qZyqlZbhjPKYFlKEdVktsHE8
	nfGgshX89kpx2IYmjzIg9phpve54RaoZwJG66FrjSpHz0L0dF5CSELF+fGE6rFXksIXc3Ku1Qf2X4
	S25imMtgL3dR/6/8q9AbIBLPCsWfq8/xV4Dhyo4vdqAfNQt8MNejLfyFjjNiBXdgTeS5EXUgwtNdd
	Zd9s1Ehg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAed-00000000LGI-2NkJ;
	Tue, 06 Aug 2024 03:14:31 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZDqL-000000026LV-460I;
	Wed, 31 Jul 2024 18:14:35 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-427b1d4da32so7550525e9.0;
        Wed, 31 Jul 2024 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722449671; x=1723054471; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=;
        b=Mj/wafu4Bi/sjUDZRGWkV9f4tR81UbCDJh1gijbTDMP1V3V1yk+xvlPDJAXBFjNWZS
         QeJ2DU3uI9CxsrtwbQ/gKQEIx+ydl7cgDz5eQXeCUhVoNxQxeNDk4C/Optmkcv0ytnIr
         i8tuZwWhJoOsi58iW2vntueFuhJAlSDI2ZauDVeSkSM8qN2BBEFET7OZfPDensRVqaha
         3lyalLpNWF/sXB8mjhwUrmvj7HoFPWdD3YeUIC1g3CRtZE4uqeE7SDvuGcVuusQYtzjO
         2Ki/t6Gdw+9cBzDGg3vYKMiYurm1aPHl2MTtHTDgzF9P4a4zcs3aEDcqv44tbcNjorJZ
         ao7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722449671; x=1723054471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp0vWyL7VeDKadleGOEHNTdhDMPNVXeakIX5tgvvsCU=;
        b=L5HX9RRboEyAXfFWsAueg68BZpaYv6f3AoF5g0S664QoNrKRZ/pif9lJZ5ktUvr8bk
         ERY8+U41ABktqaYnyDdTzBrSeQGjaxGoR9hK62rCAeoWJ1rATdc2cyTcvXCpJUO8KTDs
         Ql63hGK0cjdWNNsep1r58InY0N0Iuhru1Acuy/blI8IzAQ/0DZDqtB5IBSSTi6/EX69w
         /UwcICBxEXA2I3TJdIYtsrcZptBMRD8KR/2zjseoC4IUsZu80FJOebqnBY2uaIRzzAvL
         yKBCk9BTAWHHvS9BcUtQAxsNaLOqhblgZRHZ5VkE0Y36WqrepRFx3Gmk5O+QQctMRfmM
         /jjA==
X-Forwarded-Encrypted: i=1; AJvYcCW31MTmp1OXqkTnCQhW3ZDYyms/OxsbQD3ZvYgbFE9Gt5yf8z8oSnZiiaaBWqKPu2H97NgEKBZT0aPf27vCkDPulVoVqig+kF1X+okkP9ztgNOhzNGUmH/AcSJpVxtLVJm1mohGZDme6O+noVaCywEgvV+NoVarHjkhNoPlTAJhjzMV/qtIU6S9O/je8HmtTJ6id53jR9r1LqCGbfyDBx/jxUUd8FjgmLkJQQtxeLg8xCxsC/SdMO8=
X-Gm-Message-State: AOJu0Yw/HVNsRvTYU7IiHvMjDvr/FfRb5Z52/+4VJCd48nAbMQrhjmpm
	6k7c2oSPNOUKfeZr+v8Wc2rWefjTQB9LsW3dO72FBdsM5yQdeUKy8GpP8NXg8TnvHDaupkKUJcd
	NVY3Y1dZOvGp4t0lBcLLAqxHY1C8=
X-Google-Smtp-Source: AGHT+IGv2ta3BQ/aeYaFuo6uJnDIs2Oh1PDBCcZrH55JaT3W4vssxSHelAFkF3XSYf9nggWCe12LvyT/WHK2KvkPs3c=
X-Received: by 2002:a05:6000:4582:b0:365:aec0:e191 with SMTP id
 ffacd0b85a97d-36b8c8fdbdbmr4052808f8f.21.1722449671103; Wed, 31 Jul 2024
 11:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240731124505.2903877-1-linyunsheng@huawei.com> <20240731124505.2903877-5-linyunsheng@huawei.com>
In-Reply-To: <20240731124505.2903877-5-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 31 Jul 2024 11:13:54 -0700
Message-ID: <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240731_111434_042140_A6B0C459 
X-CRM114-Status: GOOD (  16.08  )
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

On Wed, Jul 31, 2024 at 5:50=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Currently the page_frag API is returning 'virtual address'
> or 'va' when allocing and expecting 'virtual address' or
> 'va' as input when freeing.
>
> As we are about to support new use cases that the caller
> need to deal with 'struct page' or need to deal with both
> 'va' and 'struct page'. In order to differentiate the API
> handling between 'va' and 'struct page', add '_va' suffix
> to the corresponding API mirroring the page_pool_alloc_va()
> API of the page_pool. So that callers expecting to deal with
> va, page or both va and page may call page_frag_alloc_va*,
> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

I am naking this patch. It is a pointless rename that is just going to
obfuscate the git history for these callers.

As I believe I said before I would prefer to see this work more like
the handling of __get_free_pages and __free_pages in terms of the use
of pages versus pointers and/or longs. Pushing this API aside because
you want to reuse the name for something different isn't a valid
reason to rename an existing API and will just lead to confusion.

