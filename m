Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E792EEC2B3
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 00:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=; b=rRUBffjduF3mTQfnjKXX5fHX25
	yrETLQw1tGIJwEa19Q3/cB5JKsqgkpp1ALak113k1h+SFkKypUFrl5uoEcmzasJEvh+ChQnE5pTbh
	1zs8Oe6KZWWPeX9o2GQJPS8VyjkOyml/3of70NigReBVrmBBegs0ssAwqWuqU1ZB7BcMBDKeGZZYW
	lY2z/GhRzLzvfXg20K2M5osLz5H7kY48RitLJkbKgmpT63efZse3wTHkOAqtyDfv62Hl8LJdkZbX8
	VuH0IneNRy9beA+5CxiuGBjWTRV4zlFheEzntkAbpMYnQwtJVdnI7Q0f+QuOrplDRd84ED0+94O1O
	Ta9OKqUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vug3E-00000001EES-2jns;
	Tue, 24 Feb 2026 00:13:20 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vug3C-00000001EE5-0Qhv
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 00:13:19 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-48373ad38d2so31175e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 16:13:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771891995; cv=none;
        d=google.com; s=arc-20240605;
        b=C0D7AFAoACqWkWxTh11Zz4nJvsluu82B3ca/GCXzbwIGsk+4g0EcFDlrB9sPLwaaqq
         /6WJoTbbnCx3/QTygzAr8YlgGTjuJFkm38B2FeXblSC7OhB/V9hFef0qVyLG34dVVS/K
         Hsc3oiJGO4c/6on+1t3p79156zEMDrZ/HxsWZRXFjEpbZWEo8DzDgy9qcF6/940KmeLn
         oCsvPQATcuQQPdWFj3ZYD+yacqlBPo9Xj3He7/X0F3hw4vq7ibHdHxFmv5QH19mBvDib
         vGUdZvmUx6Vq4ddSilfGA42wI4UXkGSVkmNV3LoZ+NOuWywYPlI4B3+kiNTrJBGo2P1j
         bk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        fh=ff+oaLvTuFxsuDc81jFLnMh1oJmUZV9TQKqFTLoR10Q=;
        b=NAzn3t3c0xPqzuvWWkajPTJBBLtXE+4mBcAeeLq8nGTeuAPF18yqdZkZT0D1pqHbo0
         gE9oAWLoHxWrjPmMjMrWddc3gPkBflU6mfrUzrgYmUGz3Cv1tOW4/k0HSMUBcYfUVKn8
         vF4D1QvGbTHdo0e+rMWH6eKsrybzMTPFjvaov/PeSK7l/EjIeL9wLh3LPuDSvH8acB6N
         nB+27yj6IEJhhqzNq/qpqm/afiTq688EUDcY6T+crmdmXN8eL/uIQI3HAVvwst2e7X7z
         Hi6wTFfaUIF9fuUYLbc2UUyWS/TD5YnrlyJmGMlUk3fxjRuKslrnLv0GUpf5bEf2W3Ku
         liyw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771891995; x=1772496795; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        b=piJZzhwFVPdH8Zf7YPWiN+s2s7YjU9nUWIlsLP4tf93b+IQc5TeiqmD8PytpUlBBhy
         RQ0TAG45RLXeK7eNpprAsklSfFJhafE6fvcqt5trhPPYnNGPz20WVRm0UlZtjOLg//Gq
         pw8tmQW9W5uCNBD2xEQMvEYG/iw88C/zFp/LZ6h9nsK35KHtlaPEgRoYceh+xyBXqLoo
         1Z0Heoh1vRFKq6nD/2b7K8SjpqVBH2qBNvq2v/GjCw/xvg0w8ArIIVEmynKMxiLpWtxq
         MwQEUOzUOCJB/di+ishdzmxiwXubTYgnQnkE6pGmgRah9Lz8b2IfDbMKc2P2BXmFuaUi
         nVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771891995; x=1772496795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bweRSyy13JW5iYuGfSQw8Rmf+z1/DCVAjagAYtz2NFs=;
        b=cUXTaJKMeWsSj3qQXGqz9qh7c87V8swUXKLc1UcIOeYLceNdVNPrYGTyXNG7LZz1b2
         FmkUX9pk5kbGqis+iv31oNm1k1GIWLBgYs3Jk35SKYbr3CR4m67/Hg5gO3e3uy21RrYU
         XeNo2Z1dddvXqQWy0n3V9JpJGtOtJIZ4PjTyv00rQZClBW8Np9YKxX65IUCtrcKuXKDI
         kTttrbUORWwO0fOekoRRdqteiKodR3V5fqklCu85ooNcpcU4lVixEAV6aiDps4f4MhFl
         canX8D2QdEpb96c6w26IHMA20+WCiuQsucT56HeCDquXt/EixSea4XXtALw0C7V6BNiB
         gjHA==
X-Forwarded-Encrypted: i=1; AJvYcCXj+srSpUTnEehC0HT4JMn9++nH+skZF2+2GWL0pnIPGoorS1dGw6Qogskg3wmfROaNkSVkNp+EPkq2@lists.infradead.org
X-Gm-Message-State: AOJu0YyS5hO2YklAPg4JpGixDy51YU1Ohh5KMqzpCc7Vm5+RmifpiwoJ
	MxY877kq6stH9fXKscH/Il1/tj0O5lID9fyE9NUZB4rayv54OMqdFcq42IuGDsZcXLKOZviG9JI
	f3zB4tJ7CqMzPaSuHoeochHTSaEN6zmxUHsuYRHFn
X-Gm-Gg: AZuq6aIN+RhhsFtjsL9zyTF1LNoYeofbrklaNJdY0dN5GQcO9KlxX6fy/Jj5W3DMJVv
	a8aLko7CvrHGFwv/FzlTRQ4x9lyFfwmjNLe2jGGIXeoDLX3GuwaSqBYXEshFPnUWTwSlktH0yjY
	AlOEcFQZN7vFtGJFjdgBhWpaMMyPutzIv7Ipmu3PFBNG7LQ3DaaA6EmJd/mku99DlJmD6o6cb4C
	W/MtHaRdTL3L5aEt0gSIKMgFVQXWieUoqSLl18gGGwjR90GW7Xuk46hYxURM4mZLj9sbybRWtuI
	kLc/bUrHaG5DwnqbQJn00NN08prsVyrMDGhW7Q==
X-Received: by 2002:a05:600c:3011:b0:47e:de1d:ce99 with SMTP id
 5b1f17b1804b1-483b876e3ccmr255025e9.12.1771891995111; Mon, 23 Feb 2026
 16:13:15 -0800 (PST)
MIME-Version: 1.0
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 23 Feb 2026 16:13:03 -0800
X-Gm-Features: AaiRm53fe0m1UF9UR81dGOPUcovFTRZhHstytiajG9W0XdK3GHymEz_MxNhuT1c
Message-ID: <CABdmKX2+OiqobQKf5G0ABiTeW5oqXS0p1dH7wRe2H7Gwdroi0g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Gohad, Tushar" <tushar.gohad@intel.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_161318_206487_B564572D 
X-CRM114-Status: GOOD (  23.72  )
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

On Tue, Feb 3, 2026 at 6:29=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.c=
om> wrote:
>
> Good day everyone,
>
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.
>
> The proposal consists of two parts. The first is a small in-kernel
> framework that allows a dma-buf to be registered against a given file
> and returns an object representing a DMA mapping. The actual mapping
> creation is delegated to the target subsystem (e.g. NVMe). This
> abstraction centralises request accounting, mapping management, dynamic
> recreation, etc. The resulting mapping object is passed through the I/O
> stack via a new iov_iter type.
>
> As for the user API, a dma-buf is installed as an io_uring registered
> buffer for a specific file. Once registered, the buffer can be used by
> read / write io_uring requests as normal. io_uring will enforce that the
> buffer is only used with "compatible files", which is for now restricted
> to the target registration file, but will be expanded in the future.
> Notably, io_uring is a consumer of the framework rather than a
> dependency, and the infrastructure can be reused.
>
> It took a couple of iterations on the list to get it to the current
> design, v2 of the series can be looked up at [1], which implements the
> infrastructure and initial wiring for NVMe. It slightly diverges from
> the description above, as some of the framework bits are block specific,
> and I'll be working on refining that and simplifying some of the
> interfaces for v3. A good chunk of block handling is based on prior work
> from Keith that was pre DMA mapping buffers [2].
>
> Tushar was helping and mention he got good numbers for P2P transfers
> compared to bouncing it via RAM. Anuj, Kanchan and Nitesh also
> previously reported encouraging results for system memory backed
> dma-buf for optimising IOMMU overhead, quoting Anuj:
>
> - STRICT: before =3D 570 KIOPS, after =3D 5.01 MIOPS
> - LAZY: before =3D 1.93 MIOPS, after =3D 5.01 MIOPS
> - PASSTHROUGH: before =3D 5.01 MIOPS, after =3D 5.01 MIOPS
>
> [1] https://lore.kernel.org/io-uring/cover.1763725387.git.asml.silence@gm=
ail.com/
> [2] https://lore.kernel.org/io-uring/20220805162444.3985535-1-kbusch@fb.c=
om/
> --
> Pavel Begunkov
>

Hi, I'm interested in this topic. I'm guessing this will be in the FS track=
?

Thanks,
T.J.

