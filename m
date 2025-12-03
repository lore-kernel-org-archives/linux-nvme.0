Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A663D1266D
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Dec 2025 08:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:From:
	To:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Message-Id:
	Date:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3udpsM+2T3nQ5UURtINjXldf3VB9au4wNTCoRu+8JM=; b=Y/mw0Vpn7HpIqYjTEMp/fbUeW4
	1V2UmbEBvFI46kWqDXyGIsUv5dN1eFW/jIg67TIIG3VKH2P+iO8ruvxnCL+hRyPB715KKlEfu6hjB
	oEzbBkT8xAQd+RGuhchba2veHsplQxzj3bs3voGALuTNrF6/evHvfc/Y+WKyRu1PekssXqK9T7Rja
	AELHb0mpZ9Jnn7yaqgXF2H8smzMNSgBtxx+yPkoC15FAFAC7lg/GY8vv9FQgL6Vhpj1yF782JBOvT
	NIB6ON6ktx5ovr1Onkir+MdFFacs5j+XknTy75s8hnaeuSkSCE6vCBELTfdxPlVumoEClxA3SWMHU
	N5ndCmAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQiGm-00000006JaV-3fIo;
	Wed, 03 Dec 2025 08:31:28 +0000
Received: from sg-1-100.ptr.blmpb.com ([118.26.132.100])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vQiGi-00000006JYk-0mSD
	for linux-nvme@lists.infradead.org;
	Wed, 03 Dec 2025 08:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1764750666; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=w3udpsM+2T3nQ5UURtINjXldf3VB9au4wNTCoRu+8JM=;
 b=bV6r9i6iGq3nGG/Z5pAu0TZzedyNUOPvimryp7xYUcU1nv4gwnuzP6bdh4OKcAD5WcM1y3
 iY321ci9VxbK/juDRzQBAzLBCIJk3FQCAxM8vTVExmbS1ZDJhNMGoMGT30rEUSr4zPQ1Xq
 X1dYFSAD+bUwNz66FsUbiSZslr0EaDg7ysAgyMg84H1cvkLcAY/uEC1Nr7MK9d3UI/Iaxb
 CAQf/nVaUciKkxwr9heH+U5Kh3wpTfywKJ2BgEMWUjp0IWH+ujWloTSpWEcH/8rFEP27EE
 0GbInBk5mzUYg/5NtY1dY+jpCkD5oMd16O1ExEXHxkCokacw/Dvwetc4lY2SDg==
Date: Wed, 03 Dec 2025 16:31:02 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.198e8c10.5c50.4606.8f05.84122efb6429@bytedance.com>
Subject: Re: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, 
	<jack@suse.cz>, <asml.silence@gmail.com>, <willy@infradead.org>, 
	<djwong@kernel.org>, <hch@infradead.org>, <ritesh.list@gmail.com>, 
	<linux-fsdevel@vger.kernel.org>, <io-uring@vger.kernel.org>, 
	<linux-xfs@vger.kernel.org>, <linux-ext4@vger.kernel.org>, 
	<linux-block@vger.kernel.org>, <ming.lei@redhat.com>, 
	<linux-nvme@lists.infradead.org>
From: "changfengnan" <changfengnan@bytedance.com>
In-Reply-To: <20251114092149.40116-1-changfengnan@bytedance.com>
X-Lms-Return-Path: <lba+1692ff548+5012c8+lists.infradead.org+changfengnan@bytedance.com>
References: <20251114092149.40116-1-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251203_003124_728470_E2403951 
X-CRM114-Status: UNSURE (   7.92  )
X-CRM114-Notice: Please train this message.
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

Ping

> From: "Fengnan Chang"<changfengnan@bytedance.com>
> Date:=C2=A0 Fri, Nov 14, 2025, 17:22
> Subject:=C2=A0 [PATCH v3 0/2] block: enable per-cpu bio cache by default
> To: <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <=
jack@suse.cz>, <asml.silence@gmail.com>, <willy@infradead.org>, <djwong@ker=
nel.org>, <hch@infradead.org>, <ritesh.list@gmail.com>, <linux-fsdevel@vger=
.kernel.org>, <io-uring@vger.kernel.org>, <linux-xfs@vger.kernel.org>, <lin=
ux-ext4@vger.kernel.org>, <linux-block@vger.kernel.org>, <ming.lei@redhat.c=
om>, <linux-nvme@lists.infradead.org>
> Cc: "Fengnan Chang"<changfengnan@bytedance.com>
> For now, per-cpu bio cache was only used in the io_uring + raw block

> device, filesystem also can use this to improve performance.

> After discussion in [1], we think it's better to enable per-cpu bio cache

> by default.

>=C2=A0
> v3:

> fix some build warnings.

>=C2=A0
> v2:

> enable per-cpu bio cache for passthru IO by default.

>=C2=A0
> v1:

> https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O=
3hjexFNb_tM+kEZA@mail.gmail.com/

>=C2=A0
> [1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86=
c6c7d@gmail.com/

>=C2=A0
>=C2=A0
> Fengnan Chang (2):

> =C2=A0 block: use bio_alloc_bioset for passthru IO by default

> =C2=A0 block: enable per-cpu bio cache by default

>=C2=A0
> =C2=A0block/bio.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 26 +=
+++++-----

> =C2=A0block/blk-map.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 90 +++++++++++=
+++++-----------------------

> =C2=A0block/fops.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A04 --

> =C2=A0drivers/nvme/host/ioctl.c | =C2=A02 +-

> =C2=A0include/linux/fs.h =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A03 --

> =C2=A0io_uring/rw.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A01 -

> =C2=A06 files changed, 49 insertions(+), 77 deletions(-)

>=C2=A0
>=C2=A0
> base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682

> --=C2=A0

> 2.39.5 (Apple Git-154)
>=C2=A0

