Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D4F606A31A
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XIS5YSXX;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=n4z7pKfv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Mime-Version:
	Subject:Cc:Content-Transfer-Encoding:Content-Type:In-Reply-To:From:To:
	Message-Id:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V7i4RlDFWSoW8wBciJiCSsfVygxZnW25vkRz+Gj8oUo=; b=XIS5YSXXMegnHxnyoadoxiJ41V
	i4oUmPQbPbYqEiMUuV8noS2hgEsX/rHJbms1si7szVhbUSbUlPTfupN8NRabBMBJYVFOnnT5eGi3A
	zZp2G22xIy3Rx6CUR2QP84HYgNHLaaGe+NNcOE4nwe2EQSv8NZYeNt9fyJVlrRkKM3/WMbOZChEJu
	FuiAzoHQqanLqd5Bfl4P3h03bazCk/UZMBSeO5HSLD525nktNqIxrzKy5POpEDLuWOGVYsRxLnXQY
	DI3h0JWT9BxDiFvkCKGySJVaT3NBaqNgD2+Vshy5qRd9omD0Cr0gU86Ej9jlgnYXSZABeIX9Ecnq2
	HC3BB2qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMFff-00000008BmB-3BPl;
	Thu, 29 Oct 2026 02:15:15 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMFfb-00000008Blj-15Om
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 02:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1793240097; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=V7i4RlDFWSoW8wBciJiCSsfVygxZnW25vkRz+Gj8oUo=;
 b=n4z7pKfv/tsaXySsUV9TQxUTNmHQ5jlE4niPTVxd63uEHs6y8VlUa1BLzbmguk6xtY+XK1
 M/Vb+O7cQvP+c0QdyochOqmTqMnKz/Q0nQjGXkCiTi4NgLTesK6reDAB+/oGDxVK+NSHd5
 QQ5gHIalupkc7GALSKLXANwAap349/1EWRsbkLgY6bVVBADVUcaOhNpg58rVP9G3F0dbAp
 Za+imwUQM0cqsoz8gLCp90WOLhixpnl2r1If/l2LZ5/ZelNQsj7jH5C6lU0Zc5WcgITS+T
 0hHaR9HzvdXJSh7I4p/mEwIXvpnJImBZ4+epTPk2rmOQbTUan+LSnaCxZ5zAUQ==
Date: Thu, 29 Oct 2026 10:14:52 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9ea1a2e5.340e.41d7.bbaa.69129ddcead9@bytedance.com>
To: "Keith Busch" <kbusch@kernel.org>
From: "changfengnan" <changfengnan@bytedance.com>
In-Reply-To: <auIRf1QATQjVDtkH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: "Christoph Hellwig" <hch@lst.de>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, 
	<tglx@kernel.org>, <namjain@linux.microsoft.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+16ae2ac1f+1f1b3d+lists.infradead.org+changfengnan@bytedance.com>
References: <20261013223543.395054-1-kbusch@meta.com> <16e8bc03-42c2-4bc8-bce9-dab49aad66b8@bytedance.com> <20261028150712.GA16374@lst.de>
	<auIRf1QATQjVDtkH@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_191511_707905_D0952072 
X-CRM114-Status: GOOD (  17.94  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


> From: "Keith Busch"<kbusch@kernel.org>
> Date:=C2=A0 Wed, Oct 28, 2026, 23:15
> Subject:=C2=A0 Re: [RFC PATCH 0/3] nvme-pci: dynamic interrupt moderation
> To: "Christoph Hellwig"<hch@lst.de>
> Cc: "Fengnan"<changfengnan@bytedance.com>, "Keith Busch"<kbusch@meta.com>=
, <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>, <tglx@kern=
el.org>, <namjain@linux.microsoft.com>
> On Wed, Oct 28, 2026 at 04:07:12PM +0100, Christoph Hellwig wrote:
> > On Thu, Oct 22, 2026 at 05:43:54PM +0800, Fengnan wrote:
> > > Hi Keith:
> > >=C2=A0
> > > I made some modifications to DIM and then implemented a solution
> > > using the DIM framework.=C2=A0
> > > Based on current testing, the results are now comparable to those of
> > > the previous patch.
> > > Here are the preliminary test results:
> > > https://docs.google.com/spreadsheets/d/1e8LQPnaDhmv50XlAM3XxI0TMQkhbk=
0bTZwlJP1Hzzdk/edit?gid=3D188992110#gid=3D188992110
> > >=C2=A0
> > > If you agree with this approach, I=E2=80=99ll continue testing and op=
timizing.
> >=C2=A0
> > =D0=86 can't speak for Keith, but I'd really love to see this going for=
ward!
>=C2=A0
> Same! This is a great problem to solve, but I'm just sorry I don't have
> more cycles to work on the cause. I can quickly respin the msix noflush
> pre-patches to address the naming issues tglx mentioned, and we can take
> nvme in whichever direction has the best performance.
>=C2=A0

That sounds good.
I'm currently working on continuously optimizing and testing both
approaches (using DIM and not using DIM).=C2=A0
I plan to update the code and add new data again next Monday.

Thanks.

