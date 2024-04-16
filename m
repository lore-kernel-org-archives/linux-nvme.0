Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DA8C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Apr 2024 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=; b=UV7j9ZhV651b5DRjTaaogMHgId
	p8DouIF8kNab28wQ1vdX6m4CjxZCeUc3CemPiuv6Ac4/ttjVo4MMVouZUywfHxdmFspfuFr0Kmgsx
	eXns8FMwmTtCKJSyidT3CGuSQHLcFedul0ea3yk4MIREXV56G/RA4AcKZDoTitym5k3mBkVd0y1EC
	6q4+Uy7cFXO9qGODN1vNUozoFaGuLnapngfMnK2AEAb5eqWG0YJsV//u+JOtIxBep63TwFgS4zUUl
	yKNm06Z8++oZZIR54bSLMV38GBCZhzk9U21pcntyNluhE8cjA5xgG817oT8r50Bc8iIbgja6dyLX7
	Glcd6PeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxqSB-00000006E8h-0JiL;
	Fri, 19 Apr 2024 15:47:07 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwlPs-0000000CwOc-0zJw;
	Tue, 16 Apr 2024 16:12:21 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so37020825ad.1;
        Tue, 16 Apr 2024 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713283935; x=1713888735; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=;
        b=AwJwbEtmneJaKPI3k/8TnJNKaBEAyUNYolsIdu8xL4fdDaqcu2DX85WLSebAGqDhxb
         DlcleJF9r6yTatxYeYFFmZGe+9oplsWMSPlCuTHiBE+L+I9bDRbX+dfu8ufyH+8pw7G/
         lx0SJvHjQaol56gkzCKOdNTt4rc9AzoEDlhERdoU8+0iGH1MfMVz4AeVikoDymhEfR0X
         5MQ5DlWAPPJsekBXSJMqsQROw1UtmHyDnxh/aMoGEuB+sg6txS1P3iKLmZtC5H2Ae3aS
         Wx/rtP5aTMtdkq4RH3+4tK27J1stPRnD2uP5a0YPlf2YzpyLnYWRtJy7j6svTaNhiTSy
         KfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713283935; x=1713888735;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKrDgIJgNXo/R8quzpUy0yW7erzp8PxvHvcTe/50ujU=;
        b=ueJjZCDKjykEESP5vx/Qj4oUS2sMUQhdkje8SIHfq4mzUrXz4KaufjdJgywkuj2tU2
         ZEmyf5iq5Q9lVBVqgGiatFjmQKE/sFgtyEE8ASI6pu8ErkttNnRqZu+IryitsH0FX8el
         vU1O53FYPvDXKkWx4dOZqbZH5d4FP3sO3HC75R6z1eLBKqrlBfzdeN1e7F/MA2Da+YgB
         /o09lEaK8FEWbCZ1oiGhNyEbH+QJd1gCiM2JIqsqBugMyP7AdsyKZIGjk7lNh/gUc9n4
         aFQi6HyB4iSX9oe1FulUW6Bra8AwCARMv+1oz2FJE4ILjGcdlskcbjcDFBR+ukiGG1mq
         UNwg==
X-Forwarded-Encrypted: i=1; AJvYcCVS81KfZnb4kpebTzTvqv/YuLodMUU+DVo+177KteY6vcWn6Vly18YTn5h9csV61d0o6iIeceomZReIqa5VgKtXRG7ar6BJ4vwsoRoSiWQ1mcFA8XZhcyNOBbTM01hrcO6nja/1F8r5c+CzSvPGyygvA8cjzAx1AsfAR6nLAboowMPYNviMo6WwCYg4aNQArnvh7bA7pNqIPAb4+kSij/rTZkVD45pbvgVWH3JWkuBuUFenG7jrsng=
X-Gm-Message-State: AOJu0YzZ/VZhQSw7MI7kZfhPEC85aCMDlrsuPMCv1LJtX+ae8x1uzP3X
	jXIT5XNAnS9Xj3bJHwsIUsjRqE8zND4E3D57QI+A6EEic45OiGSb
X-Google-Smtp-Source: AGHT+IEaBhKQrtE4y17EN+JRfoZ0nAtlgq9TOIgtvD46kDZyqFoPetYC3y2iMwccARAF9quBrezxcQ==
X-Received: by 2002:a17:903:595:b0:1e3:e4ff:7054 with SMTP id jv21-20020a170903059500b001e3e4ff7054mr10328895plb.38.1713283934861;
        Tue, 16 Apr 2024 09:12:14 -0700 (PDT)
Received: from ?IPv6:2605:59c8:43f:400:82ee:73ff:fe41:9a02? ([2605:59c8:43f:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id lf16-20020a170902fb5000b001e5119c1923sm10005822plb.71.2024.04.16.09.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 09:12:14 -0700 (PDT)
Message-ID: <18ca19fa64267b84bee10473a81cbc63f53104a0.camel@gmail.com>
Subject: Re: [PATCH net-next v2 07/15] mm: page_frag: add '_va' suffix to
 page_frag API
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,  Chaitanya Kulkarni
 <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Chuck Lever
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
 <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
 bpf@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-nfs@vger.kernel.org
Date: Tue, 16 Apr 2024 09:12:01 -0700
In-Reply-To: <20240415131941.51153-8-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
	 <20240415131941.51153-8-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_091216_850577_EFC0B5A6 
X-CRM114-Status: GOOD (  11.93  )
X-Mailman-Approved-At: Fri, 19 Apr 2024 08:47:04 -0700
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

On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
> Currently most of the API for page_frag API is returning
> 'virtual address' as output or expecting 'virtual address'
> as input, in order to differentiate the API handling between
> 'virtual address' and 'struct page', add '_va' suffix to the
> corresponding API mirroring the page_pool_alloc_va() API of
> the page_pool.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>

This patch is a total waste of time. By that logic we should be
renaming __get_free_pages since it essentially does the same thing.

This just seems like more code changes for the sake of adding code
changes rather than fixing anything. In my opinion it should be dropped
from the set.


