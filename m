Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE621ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lg/tEfGo54uVOy47kxfnC2Ioo2LMnFA6rnTG+QKd5Tk=; b=QUly3UMCjsuHEnasbp5l+jE2bn
	1df8BuUvhLl+RyxF0kSl/JsPwnCgcF3kJ7DKWUj1lySnQkz7RNiSkU9HOwshTfS4gepwAYoyMkCyq
	5au63ujboDvCE0kw9C+kmEpBZIo5/x8Yj3FDCOUToXRx8DW3aKnWAdYmqcASXztlnAA6LmKHJrYKk
	ea+aVvzmOA840D3suF6RiHUGszv56SCtoOmSyAKGLDbDwY0m0bwcybkVd9oM0vzul6/Xy76Fv+bMI
	isy8patgsB0HdpT1gmH+Yq7Tnxo4AFl0+ZI4IcAvm0KVqY2hweAsAzs5cC9TEItztUfR9fg6xSrhX
	r5hduEOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT8yA-0025pW-3E; Tue, 30 Aug 2022 21:40:26 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT8y7-0025nD-3t
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 21:40:24 +0000
Received: by mail-wr1-x429.google.com with SMTP id m16so15859690wru.9
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lg/tEfGo54uVOy47kxfnC2Ioo2LMnFA6rnTG+QKd5Tk=;
        b=Z6oOkavjVnED/mShXL5hsKZNMcoDOt4V5DtCsrOTgIy90U+X4CB9E+LkG6UwC23BOc
         5/vuWtGmsQ113awB4fdQoQfG0kmuyMWoNxkYGPu6Eg7rVUk5mCCBlaKpygTUPZcrtWaq
         jFi3kPCw2resLPwWvTatgKXTudFoIIpzraPdKefIgMeo0qcI+OPcf2HJwB4SFR2B/qyk
         vIhlJ0Y5tcLfAr1578pDlZazPYZg4g9nYC8IOv1lI6oU2YRvX1G/+leDUH/IquMTE1sc
         0Txb8CIMpowA0WMxAnJXMcv/1bVSxsgMKY1xoi2KqY1p/mGtVR5wRdvIuyND/uSQT1MI
         FS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lg/tEfGo54uVOy47kxfnC2Ioo2LMnFA6rnTG+QKd5Tk=;
        b=WOyIESnLz/zaeikGQ1b0jf8orkMzD348H+0zicxHE12LuToF5plqHGwtrVKUVCBFtW
         KfmD5UzgQ4kkP6v4tOEGimwldfFHxoEdhRKmyFAEspig75j3R31epfVyNM1A/zlkTRGs
         RcJrBYkNPsfgsGzQk9IAd25XzKn+SUPUWqo5PDQlDs3pJzppigQkAX4owaEmKFatCI5R
         KRkVGY18JViLMMk433ovwd6AEtoB6lKO0rABNNBSrmjdB/AGu+Oo1aU4COl6z6cZ5Zqc
         u3bykjZDp2oHLwdnhRHEeeVKVCnYEGI37H6VhLu3kQE6AEKSz8Z0U053Ogwe4+nbVsWh
         t3WQ==
X-Gm-Message-State: ACgBeo09VP/nJH+1PdXoqgG5XApJhrRV2FWOdJRzPtz2RnwKH1aizm76
	XqxfFHe1ln3kETf0JKc8cwzS2jxf13g=
X-Google-Smtp-Source: AA6agR5qQEilqp0MGt8d2vaiFLEH6jOxbq9ogp7W20gYy2g4K66xtD5zzz1R6CZVYoC79f2ABR/HGA==
X-Received: by 2002:adf:e583:0:b0:226:db76:ab6d with SMTP id l3-20020adfe583000000b00226db76ab6dmr6615942wrm.198.1661895613520;
        Tue, 30 Aug 2022 14:40:13 -0700 (PDT)
Received: from opensuse.localnet (host-87-1-103-238.retail.telecomitalia.it. [87.1.103.238])
        by smtp.gmail.com with ESMTPSA id m5-20020a5d4a05000000b00225213fd4a9sm10841293wrq.33.2022.08.30.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 14:40:11 -0700 (PDT)
From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, James Smart <james.smart@broadcom.com>, Ira Weiny <ira.weiny@intel.com>, Venkataramanan Anirudh <anirudh.venkataramanan@intel.com>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] nvmet-tcp: Don't map pages which can't come from HIGHMEM
Date: Tue, 30 Aug 2022 23:40:09 +0200
Message-ID: <5295597.Sb9uPGUboI@opensuse>
In-Reply-To: <20220829075401.868981-1-sagi@grimberg.me>
References: <20220829075401.868981-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_144023_180009_48E7C6D9 
X-CRM114-Status: GOOD (  19.69  )
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

On luned=C3=AC 29 agosto 2022 09:54:01 CEST Sagi Grimberg wrote:
> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
>=20
> kmap() is being deprecated in favor of kmap_local_page().[1]
>=20
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap=E2=80=99s pool wraps and it might block when the mapping space is fu=
lly
> utilized until a slot becomes available.
>=20
> The pages which will be mapped are allocated in nvmet_tcp_map_data(),
> using the GFP_KERNEL flag. This assures that they cannot come from
> HIGHMEM. This imply that a straight page_address() can replace the kmap()
> of sg_page(sg) in nvmet_tcp_map_pdu_iovec(). As a side effect, we might
> also delete the field "nr_mapped" from struct "nvmet_tcp_cmd" because,
> after removing the kmap() calls, there would be no longer any need of it.
>=20
> In addition, there is no reason to use a kvec for the command receive
> data buffers iovec, use a bio_vec instead and let iov_iter handle the
> buffer mapping and data copy.
>=20
> Test with blktests on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
>=20
> [1] "[PATCH] checkpatch: Add kmap and kmap_atomic to the deprecated
> list" https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel=
=2Ecom/
>=20
> Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> [sagi: added bio_vec plus minor naming changes]
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/tcp.c | 44 ++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 31 deletions(-)

Hi Sagi,

Thanks for changing the code according to the suggestions from Christoph an=
d=20
Al.

Differently from what I just wrote while thanking Al, and after Ira made me=
=20
notice that you are one of the maintainers, I decided to leave everything l=
ike=20
you did.

The only exceptions we'll be about sending a v2 with the "Suggested-by" tag=
s=20
from Christoph and Al. In the meantime checkpatch warned that the alignment=
 of=20
"nr_pages" doesn't match the open parenthesis, so I'm changing it too.

Again thanks,

=46abio




