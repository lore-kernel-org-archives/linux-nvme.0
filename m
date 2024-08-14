Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121FBC531DC
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fDv9V0v7KkpdJrpMs0piYzLNRxXj+irK5gUuUzZpGhs=; b=oyHWS2x5WpWjkobpfB7/luwv5Y
	mfODvZoGCuIXAiOJC/0tsBh2hNG+ysjMSxkTZlTEPcQ2C5URLFentA8GbwAp9BuMbEyZQdjew9ZqE
	emqpfJkXmtHzVYO/v8djjAEBKhGI8x8OKUApuV6/4WyKB5hjHwMvh97nLaVR+okZMj/dbLIurfFc4
	dpHLBEuENjsiR8B3VR2AwS+4I2UHXQHcYKlV6SoeoxYajQX3ZgA9JjoQLh+GMZZaAm7XNvb6ip4bR
	Z5oJGKgeZLsekMwyJjdvHHjYipH239R7e3wYMzmAJHlw+lNQpUUqHRQFdV880CUbcrWE3xCJbSpT5
	QSorxUsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgQjQ-00000005nTQ-4B97;
	Tue, 20 Aug 2024 15:25:13 +0000
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seGGB-00000007Xdq-0ljq;
	Wed, 14 Aug 2024 15:50:04 +0000
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-7093472356dso3808968a34.0;
        Wed, 14 Aug 2024 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723650600; x=1724255400; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fDv9V0v7KkpdJrpMs0piYzLNRxXj+irK5gUuUzZpGhs=;
        b=agZH/ZXpAcLPfQassLFhc/2ozkTNvReTdbZSFlp2taXO2B8Sld/PQgPOteOahfVKVB
         KmNprTVSq7w2OvKYIdv2fRo148/YRmFYUD9/E2PS0sxBOgQcN83Nd57TFveM0RMEZh07
         JpZA15yuQVN7xh5VVnuPv7MCzoM4Mn34ZHyS3n9BSdOrGH6GVFN938K9ZBQzkVewQhcs
         EHwgRiGLEHXY0mi7nu4UZLNgTKVVcX1kocbC47+tl/3o6gIawxPi3Am5Imkq3tRc2sYr
         L58NMG5pl48XJAztqz9tg1bf12mY7zOkO4RK94ZCjMzjTwKieFehVt7cnExXdyhMSsNg
         sxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723650600; x=1724255400;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fDv9V0v7KkpdJrpMs0piYzLNRxXj+irK5gUuUzZpGhs=;
        b=oACMhlTcVcj6TncepflqCuN4wBE0xrNkRXXuGVvoF5W1KcjB92E85tpy6DkV/PMUN9
         7n2PakIwPlm8GG0xPC5Vo4qN+PHPllO0IdbQD+r69a3RdUkFfJxKoegXQGuP5V+8y8sN
         JxFXI0jEevmDD0fSotB9mHTFiuv2pVS5abNtRWyHg+0qBSRV2u3jLTf9azuiaIRTpygv
         cM8nLu+l7+EOjjjd4jU3moUjykgPwIdUmunhPZ2ZG0Nan7EfzPP2wShFjFDBytTYSlw/
         eDTb5D8n2LeRDJ4RD1x/Gw0kbkxNP4sK+WP23zf2nTrfpHyvXcXMKjSPrF3ZgBwlrCpu
         ffZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOedF96vx0FSC1ZWQOYhEDmaoOYJIUct/iy2twWdYsrNjYNtTsHRHKhmy/czaBZfcd4ykaTh9P45zKmhqrk2kEkYCHWHC4/k7PDfScLwuYrKF3BBbDln5P59YatVPH8Op/p0broLIqlK98nN3eyZeC6uVKYXwFz+nDaNQL7crhlF91i7ijFJ+0TKz5P9FCctQ2n3zsP9dgWuDlbDZs8wCCrGECGRye81XAa/NsbxkhZEEag3Gxh2M=
X-Gm-Message-State: AOJu0YwXlPijBuiPoxMoL+xsidCU8Z+7zNld3IkcqQUjh1a2YbLD9d1g
	XSfkDzmWPjpJl/L1Doe4KpbOYTHvKfnb127hHl5nyCBdRAF/85Gi
X-Google-Smtp-Source: AGHT+IF+xU5hTvBzD845HScA3WjHDYwvu17hmSc7al7mxeLt+8xp5o7SMvsr67KFPwp2VJkvDAOPFA==
X-Received: by 2002:a05:6830:638b:b0:709:3f84:c1e0 with SMTP id 46e09a7af769-70c9d9c25a1mr3660423a34.26.1723650600144;
        Wed, 14 Aug 2024 08:50:00 -0700 (PDT)
Received: from ?IPv6:2605:59c8:829:4c00:82ee:73ff:fe41:9a02? ([2605:59c8:829:4c00:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70c7b880badsm2269478a34.54.2024.08.14.08.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 08:49:59 -0700 (PDT)
Message-ID: <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Subbaraya Sundeep
 <sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, Sagi Grimberg
 <sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand
 <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>,
 Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>,
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Mark Lee
 <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>,
  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya
 Kulkarni <kch@nvidia.com>,  "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Jeff Layton
 <jlayton@kernel.org>,  Neil Brown <neilb@suse.de>, Olga Kornievskaia
 <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>,  Shuah Khan <shuah@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
 bpf@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Wed, 14 Aug 2024 08:49:53 -0700
In-Reply-To: <20240808123714.462740-5-linyunsheng@huawei.com>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
	 <20240808123714.462740-5-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240814_085003_254563_167C621C 
X-CRM114-Status: GOOD (  17.45  )
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

On Thu, 2024-08-08 at 20:37 +0800, Yunsheng Lin wrote:
> Currently the page_frag API is returning 'virtual address'
> or 'va' when allocing and expecting 'virtual address' or
> 'va' as input when freeing.
>=20
> As we are about to support new use cases that the caller
> need to deal with 'struct page' or need to deal with both
> 'va' and 'struct page'. In order to differentiate the API
> handling between 'va' and 'struct page', add '_va' suffix
> to the corresponding API mirroring the page_pool_alloc_va()
> API of the page_pool. So that callers expecting to deal with
> va, page or both va and page may call page_frag_alloc_va*,
> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>=20
> CC: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/net/ethernet/google/gve/gve_rx.c      |  4 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  2 +-
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  4 ++--
>  .../marvell/octeontx2/nic/otx2_common.c       |  2 +-
>  drivers/net/ethernet/mediatek/mtk_wed_wo.c    |  4 ++--
>  drivers/nvme/host/tcp.c                       |  8 +++----
>  drivers/nvme/target/tcp.c                     | 22 +++++++++----------
>  drivers/vhost/net.c                           |  6 ++---
>  include/linux/page_frag_cache.h               | 21 +++++++++---------
>  include/linux/skbuff.h                        |  2 +-
>  kernel/bpf/cpumap.c                           |  2 +-
>  mm/page_frag_cache.c                          | 12 +++++-----
>  net/core/skbuff.c                             | 16 +++++++-------
>  net/core/xdp.c                                |  2 +-
>  net/rxrpc/txbuf.c                             | 15 +++++++------
>  net/sunrpc/svcsock.c                          |  6 ++---
>  .../selftests/mm/page_frag/page_frag_test.c   | 13 ++++++-----
>  19 files changed, 75 insertions(+), 70 deletions(-)
>=20

I still say no to this patch. It is an unnecessary name change and adds
no value. If you insist on this patch I will reject the set every time.

The fact is it is polluting the git history and just makes things
harder to maintain without adding any value as you aren't changing what
the function does and there is no need for this. In addition it just
makes it that much harder to backport fixes in the future as people
will have to work around the rename.


