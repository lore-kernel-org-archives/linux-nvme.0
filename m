Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695AAC3DA70
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jul 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=; b=iJaQpEDmsxIQNKMl4eRRbm4Guu
	Kc1I4e1VxB2PD4zotnWmfkjUYbxOdH7Nxsh2nALuciNXkuS4/f9Jw9Q1q10YvEeW4p3pe++gGWZ3L
	amm+DjX3+F5frMl8JBXJYrUwpVkuYEoLeypNIskcwjarp9P7XH4AsoOUrw2r5x5oYRrGd/WGPLJI0
	SNmfXOoAgc2GuKDvv1RlGOldq7DazgXw7wrjtz7HGTRw8EFxDe9v2QpW87Kwh/Y9TRXgvxIfvKax3
	aDsfVe+fJO8LrtR69SPDVQQuMFo6HrRX1ajPYd2TR/V2lcaEZnQehJ3ncjp2dZOYShVPvC22rUrIG
	P6Y0J20g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYoUW-0000000FbHX-3Y6C;
	Tue, 30 Jul 2024 15:10:20 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVdO7-00000007X1h-1LD3;
	Sun, 21 Jul 2024 20:42:36 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3684eb5be64so1592091f8f.3;
        Sun, 21 Jul 2024 13:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721594553; x=1722199353; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=;
        b=j1NJukITQddtPsAje4wPStOyNshFayqNxlD34MM9Vqvn1EnNFYekQyHY9twei3APgQ
         w2SMROB3yYruxmIPiOnDC2s9cNFlMhOvryxsuLAgn5yOvK8dNcRYc3JpRjZR22ZpKRQD
         3mgFPmKxUR74JhzDBV58t6/X8Pcbmlwhfqn8qIxJAMYkP4DRIpqFRSdAO9RyOmTRMpfs
         esuN49A+yeYN6sOAQBeoN8z4S6IHJDZ7eeriZpqlzuJUl6VZgKw92fTAVmbCLkW+J/kN
         7P8jH5hjUBlhauu6ZmAYlhs6CSkuij9QR4qj6c6j4cG+NXdPjy31tNSTIGtwuoYejerB
         /zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721594553; x=1722199353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2Prf/IbMk4LMsyq34wH1row2ki7pR91wfPtg73kQoQ=;
        b=dHn/clkiO8dNsm3aJ1ivZtbo9xwUIgsYRipW7dUnnkmA5Od6L5PySBIiTSF9yV2I7H
         R0sRDrasrecsAOcexosbhf8iwuMJBx5w2jAlybbROQl7gxc7LAg3HPu8xWkFQu06Coqr
         f97yWY0RfFcLeM/9syqFeQg16FhZNhq6rciLxiMCrCYm08zkwJnRerAz0DAmJ5gkg8oA
         mfPgdaQOLRxcfA9zWa8lMRQ7bcYlN7yVGYB5uk7r583ungWs2tf16uVTDuEb/djZHck5
         OYW3lvYxk75u3I1mee4WqBu3ODoYHEotRXZf2SdNQtBjd4P50TclDAh8Dvsgo3mgpgfd
         CtCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIJ8PZ30YFFH+SLg7W4qpBg/yit0xquwVpTDtusEsoGymieUb5pyehGC+bZASQg+qYkCL+Qj3xivme4dVE5XflPGRUEqpqXpmRUw8wT9AFo/xZ9M+/WGPA5JdStFkrmRIsMjBNMH6wlwEhlzMFrKQqohN2zD2pofTMSWc+Ju+1TcT/TlTKLPTEudO1xZowm9uHmo1VI6OuDndUikeU6UQCIJyG3hsYBZ2B0LhKlPrGSyCo3Qutme4=
X-Gm-Message-State: AOJu0YxxxNRQmuSBVB8n3KuGEApcJjTthckSBDFl0sJvQbaiXgxb340w
	o5vJMhi3RBiEPLlho0mlcQ90QrL1VUYPIRYp3ysLSw410eBtCBnuIIRU/P2En2mtmTtx9OK91kp
	tjINqE7+sLZM3uPACI35wHb54MX4=
X-Google-Smtp-Source: AGHT+IHzyJqN1Q0WaIfDKyj2SqhKg2oxhBaiBXCVTaoG5f0KmwGrOsY8JwrfF4zCan/VnZBfTxjvlG6f3HfT9iOc4L4=
X-Received: by 2002:a5d:59a4:0:b0:366:e838:f5d4 with SMTP id
 ffacd0b85a97d-369bbbb4b95mr3333434f8f.3.1721594552579; Sun, 21 Jul 2024
 13:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240719093338.55117-1-linyunsheng@huawei.com> <20240719093338.55117-5-linyunsheng@huawei.com>
In-Reply-To: <20240719093338.55117-5-linyunsheng@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Sun, 21 Jul 2024 13:41:55 -0700
Message-ID: <CAKgT0UcqELiXntRA_uD8eJGjt-OCLO64ax=YFXrCHNnaj9kD8g@mail.gmail.com>
Subject: Re: [RFC v11 04/14] mm: page_frag: add '_va' suffix to page_frag API
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
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
	Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240721_134235_384772_8811EF0F 
X-CRM114-Status: GOOD (  17.65  )
X-Mailman-Approved-At: Tue, 30 Jul 2024 08:10:19 -0700
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

On Fri, Jul 19, 2024 at 2:37=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
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

Rather than renaming the existing API I would rather see this follow
the same approach as we use with the other memory subsystem functions.
A specific example being that with free_page it is essentially passed
a virtual address, while the double underscore version is passed a
page. I would be more okay with us renaming the double underscore
version of any functions we might have to address that rather than
renaming all the functions with "va".

In general I would say this patch is adding no value as what it is
doing is essentially pushing the primary users of this API to change
to support use cases that won't impact most of them. It is just
creating a ton of noise in terms of changes with no added value so we
can reuse the function names.

