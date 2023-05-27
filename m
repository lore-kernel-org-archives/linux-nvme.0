Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0463C7EE2E
	for <linux-nvme@archiver.kernel.org>; Mon, 29 May 2023 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l+G4puGLv1p8z/Hlge1/6NOCJbk0UrLfWek2Xulcb84=; b=AA7dDmB7b5H7QxBw4Jqcp7kVy3
	qivTwfXEr3p82lK48lg1Z/EgWsuEXsi+ESXDXGbEnBqFVBwMesDVZgCrcumFyNaa00IIxPfUB1v2e
	OKTYfE+yHXE1nzW0VnXE4q5GijIrIw/x+o+k/fpRFIGoprWc62uSqZMGc4chZfwbbZR/dg+y8NFOh
	relbzhMKIyAtTN0L/s9GncluDFTeXVTB53wGxRujAI5dE+bCwoNiV3lY4s32ZwFXlJFlviRNmfag6
	EuV/bdf4eRRpnluwUFVQ4cgne6e+bvgZ8RVewug1leFw0kBcefRZmOKfn2H4VttYZ0RuOYO2lg0c5
	B6KsIAWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q3gtR-00BHo9-2A;
	Mon, 29 May 2023 17:42:53 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2wFb-005zKP-2q;
	Sat, 27 May 2023 15:54:41 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64d426e63baso2309458b3a.0;
        Sat, 27 May 2023 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685202878; x=1687794878;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+G4puGLv1p8z/Hlge1/6NOCJbk0UrLfWek2Xulcb84=;
        b=gQhLpA9ZJ3MsbjBLRHKg/Bu7sQtUuFnFo0w9+0BYJ9KOLiAmaHm/m4Y4E06NNRB1dl
         0q6K6DFbWeTb5Z/iyCZr4tT1ppDQtz7yJeeBl9m8r9FuOoRb1xD5m3BqBek2b4tbNxxa
         pA67T941mfHhp1dUVfT2Jr+DVuBy/2445xXa8FHpcG7rg9eZAqCVjK74O2s10v+F/6ug
         hMy8q4g8ddP/1iBz/DlNKwpEJann3ERIFh3Wn4PR1+/YgtOpHJkf01XWT69+1N+oMzVG
         cQNsioSb+HO7UB/dsiirhUAhze1c1ZFpySoti411TJ3f8G7crCWmFMZf6m+agVEApcpW
         vz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685202878; x=1687794878;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+G4puGLv1p8z/Hlge1/6NOCJbk0UrLfWek2Xulcb84=;
        b=Zf6iEobKksXilH4+D6bbyV7pskdtwiHd3/phAeXtgZomO2IR2qhXko90JFQWbARhkT
         NgHAnlU8NnCuWwwQpSL7/CmdHYwBzsq5N8uxniT38C59Ahkcmsq9JkpCasipLFEtMQ3s
         WykqMwQyyI6T1SrHdtknAgW004f7yD7XJBnOfqM7QxrkqhiNQ2TC2At5IB2LKVFfA3cB
         XfDyvesIHuEspN/0rIoWVIKksuRlczGstky+s1gwuznfEbY1ZkL0y/nmMtd35MbawUj8
         gd1oCZhYVaZP9RRuuuv4fvPMNZPg1PyF1Qim4F3U2ft9tF288N/oa8MDLRfZIiCpdeSN
         /ltw==
X-Gm-Message-State: AC+VfDx5Ug93uKm0UhzjnkycPI22AeOuDr+zyJktgygKz3W0eZ4NpfIi
	JKGSMsbhjX3yoDoHPJBc+eI=
X-Google-Smtp-Source: ACHHUZ4eTm+gSTcfMJyzZbWF/OB3D5r515LcsPPvEz9Qas5w+qwp4srtHFosGb4KBrd58salPotjYw==
X-Received: by 2002:a05:6a21:338b:b0:d5:73ad:87c2 with SMTP id yy11-20020a056a21338b00b000d573ad87c2mr3545769pzb.56.1685202878254;
        Sat, 27 May 2023 08:54:38 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id v12-20020a62a50c000000b0063f1430dd57sm4201560pfm.49.2023.05.27.08.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 08:54:37 -0700 (PDT)
Message-ID: <51161740e832334594960ed43430b868a6f892c3.camel@gmail.com>
Subject: Re: [PATCH net-next 03/12] mm: Make the page_frag_cache allocator
 alignment param a pow-of-2
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
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
Date: Sat, 27 May 2023 08:54:34 -0700
In-Reply-To: <20230524153311.3625329-4-dhowells@redhat.com>
References: <20230524153311.3625329-1-dhowells@redhat.com>
	 <20230524153311.3625329-4-dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230527_085439_916009_91937761 
X-CRM114-Status: GOOD (  15.28  )
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

On Wed, 2023-05-24 at 16:33 +0100, David Howells wrote:
> Make the page_frag_cache allocator's alignment parameter a power of 2
> rather than a mask and give a warning if it isn't.
>=20
> This means that it's consistent with {napi,netdec}_alloc_frag_align() and
> allows __{napi,netdev}_alloc_frag_align() to be removed.
>=20

This goes against the original intention of these functions. One of the
reasons why this is being used is because when somebody enables
something like 2K jumbo frames they don't necessarily want to have to
allocate 4K SLABs. Instead they can just add a bit of overhead and get
almost twice the utilization out of an order 3 page.

The requirement should only be cache alignment, not power of 2
alignment. This isn't meant to be a slab allocator. We are just
sectioning up pages to handle mixed workloads. In the case of
networking we can end up getting everything from 60B packets, to 1514B
in the standard cases. That was why we started sectioning up pages in
the first place so putting a power of 2 requirement on it doens't fit
our use case at all and is what we were trying to get away from with
the SLAB allocators.

