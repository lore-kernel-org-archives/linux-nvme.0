Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AEBCD5BB0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aF7MJ20JD5hBN+lrJqi3nxqiYIIxcHoUM1hcwQj2ipk=; b=vSDG9ylejBRKqfAGXGZkuhnJD/
	11A4BTGIF6XTNZ30tQh31bYo2xtOqXeF0YBKdDMhZoSyF4KBaFYIJgTmJ7s24zVlj6XC2m7KZ/OmR
	0mc/QsgrcLMbMNtcs46xMNVMLrpP52dmcSifnArSmOif3EYCHV75yKd8GQ++jTETDjX1rJ3n5GpGE
	PN0HKHt3YHB31HBSI4UiSOxeLh7daKB6ZWDVEDV8ktQKASbLXx7efnOqtZif2l2F6n9njEgJMUkcW
	CLkYjlqtbQ+agYFmZjINJ6vCTgv6S5eGclF7aK834p0DF25nS7Go4/lqFwJoySJHVw/ZWRZGLfitR
	iF02fZPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRmP-0000000BFJT-01mc;
	Fri, 22 May 2026 15:27:17 +0000
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQRmM-0000000BFIr-2Ekg
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:27:16 +0000
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-43a5fc4c9e5so1200333fac.2
        for <linux-nvme@lists.infradead.org>; Fri, 22 May 2026 08:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779463633; cv=none;
        d=google.com; s=arc-20240605;
        b=fzZaaAZkUuJEriDvWIaYs9EmaAAP6SxYIwRm861vmvbZu7kAO853WJ5l0U1MENlI49
         SleXluxBAGCGKAow5TANZK+LtRujyFUc+C+d2DDLdb+f+tz05MAWWGVPkPhGjatKiUyi
         tZDVY+xkEnX+h8QP+UoZUNfNM40WEFGZUolz8c7qNySAeFuLjk/JhOXw93HcroZyjgcA
         wY/EU7iiUoET/UQetFDZapV7UmmTr9NNKNL0orsieE1mI66vblEIMQ810SMCDKvY5Qm/
         y0cP5SDR9cqv2fOvNV39tiKx6wOeo7PWQYJl/bREc0A5scUU1LU4x6yZNFIXogUI5dQW
         Tn4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aF7MJ20JD5hBN+lrJqi3nxqiYIIxcHoUM1hcwQj2ipk=;
        fh=6UftC//lVMjJg2nECAzVUfxSIRfUm2AgWC9m2k9AqZE=;
        b=GzQmagF5ODXvnyxKfOv2YGj4s/IPi6vzLKxHvXFcj6AGbAAw9E/cpj/PnMwH06tP5L
         zeWJj6tOyyo3pDDTxJwYFjAG2wLd/n3VJERQN4M1ZKTmRabyLGrMAYfdU+eY3n6jbNtD
         Ma8UX9Eb0C+27LGO5fvUUpOD2I1i1IznWBJFPQaeq2BGXOL/SChTkFD+205ajuiiHZ40
         Mwh4n6zHiQBdi9BU54Fnh6/UL9WrnnhttnOj63kUYzfu/tx4MwgVmu494GprEcsjH3MJ
         +52x6Uu1Kj/LC5OmGivpyri47fqyfdAdwJLrxc0bL3irbMNhFduEoU/698VvLZsMqB7H
         vcrg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779463633; x=1780068433; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aF7MJ20JD5hBN+lrJqi3nxqiYIIxcHoUM1hcwQj2ipk=;
        b=bvYwxxDWiUQod2QvCqogBo/1Kd/M2VzNkJJJDy0pc48lSqqKMO0qgaWePIcYi1t5Z5
         hrJ1pYHI8qqdDv0BF/VrLAwqIzapwxF1aIWsv4EFfc1pV1jbv3pcgF9MKD5oSxxjumPk
         7/CRLfRRNs1GR63J+cs2XwxnIwpuzkdtXczxRjDEkBjDEjc63YBBNuagmu1LaYUs6UyY
         8W0N6W3M07dgRaWuaQljordPtoSuh6K0TFFHjZ28I6XWA1/AvY3Mr2I7K5iITZbcxS6L
         WUjM9rO7stOCt/XOD5A8nmBIi3oRv0P4s3SvonxH00nOqFkOGl8j7sx4OH2FSrm9AdFV
         t6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463633; x=1780068433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aF7MJ20JD5hBN+lrJqi3nxqiYIIxcHoUM1hcwQj2ipk=;
        b=iBVaSIhYnQsCPSjaGeSUpgnRfChvfytKlMa3wBr418IXN2Y+xThFmyWdPVoTGglRWf
         J1/pLuXbjfmejcuczMFGgWsZ9Cm4yuvqyAzxd6haxQp0AnqWYqea5Wig2qynv23tYaci
         yYjsejRUHg8/Bq/khlxnZhmtZIbenRzB5NOxBczx5dDe24ub3H8LrWXrJMsra4prhKi0
         cQnmPN3OeWIB6MIRTtF/noXolG0nb2wUEQvFAXOv8lDDZKrPY/ECDMi0PzwFZaGYEMD4
         6nrT73y9DCSKYzJROqfZgo3oKo54iOzkJOucUObOUoVZJP+LkhrRpygrOGrviND7+M3o
         sANA==
X-Forwarded-Encrypted: i=1; AFNElJ8UNdoJSAiVU8qml+UarZ50CCHeDILOjgCcqqA6L/ewrUiBBkVAKIP6zoFhLqiJDodEzUAIDyTk6kUw@lists.infradead.org
X-Gm-Message-State: AOJu0YyD2JMeTeooQjzDmYJehxFL9FrcXrg1qhK8MaO7eLEXUlLVrFTx
	E5jNMt+Ues4HzcBdCWKKDYNf9cb/XdynvfN0pJc5hTZNmuj005iDnYXTvBpFxOi29tUbbbdSSXV
	QqQupZbsf956K2ltzCo3/9b3efVKNbaXprs8bPL0Wvg==
X-Gm-Gg: Acq92OGrR5Dk0tt1rAuL/fkzgX1qhMHrEXTLONGq8TJP3OW4VaubCuwKuhJMnXQk6US
	ImiZZOmVcWLmap1b7VuzLvocxhiShdMeCyKlLgjvZldt6jLSAjjElubuI4RByy0/ljYJ+7VZdBI
	T8FOD8tfVT8I4v2+5H6upefixA7busm/IF3g6n3lBs2ilxM06++ZvHEocmLx1eRVjVHo2wT+g+2
	SXd96OoXmL2jeDXgDBAgpLXJm6xUxxyuGCfl4cNLYBkbX+HM6EKLC6Q9o23uDgTdyuluTQhCc5X
	WU6lxVc=
X-Received: by 2002:a05:6870:b603:b0:434:2a0e:1560 with SMTP id
 586e51a60fabf-43b5a9f4d0bmr1333082fac.2.1779463633030; Fri, 22 May 2026
 08:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
In-Reply-To: <20260522150628.399288-1-mateusz.nowicki@posteo.net>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 22 May 2026 08:27:02 -0700
X-Gm-Features: AVHnY4Imp3FTkTL6yJ_70gS9Stc6DiLwfgVgrbdtAf7Ox9IMEonEVHNQ2HXBEwU
Message-ID: <CADUfDZoHibw8RA_OiWfptQwa2HjPho9OotNX56kf5MvnQi8GuQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix out-of-bounds access in nvme_setup_descriptor_pools
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_082714_735430_0B725470 
X-CRM114-Status: GOOD (  27.21  )
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

On Fri, May 22, 2026 at 8:07=E2=80=AFAM Mateusz Nowicki
<mateusz.nowicki@posteo.net> wrote:
>
> nvme_setup_descriptor_pools() indexes dev->descriptor_pools[] using the
> numa_node forwarded from hctx->numa_node by its single caller,
> nvme_init_hctx_common().  On a non-NUMA kernel hctx->numa_node is
> NUMA_NO_NODE (-1).  Because the parameter was declared 'unsigned', the
> value becomes UINT_MAX and the index walks off the array (sized to
> nr_node_ids), faulting during nvme_alloc_ns() and leaving the namespace
> without a /dev node.

FYI there was a previous report and patch for this issue:
https://lore.kernel.org/linux-nvme/20260309062840.2937858-2-iam@sung-woo.ki=
m/T/#u
. Looks like a v2 was promised but never arrived. Some attribution
(Reported-by, Link?) for the original patch might be good.

I did like that the other patch switched the type of struct
blk_mq_hw_ctx's numa_node field and the argument to struct
blk_mq_ops's init_request function pointer from unsigned int to int to
clarify that it was optional. But probably makes sense to do that as a
follow-on commit separate from the bug fix.

>
> Reproduces on any NVMe controller probed by a CONFIG_NUMA=3Dn kernel
>
>   BUG: unable to handle page fault for address: ffff889101603d38
>   RIP: 0010:nvme_init_hctx_common+0x5a/0x190 [nvme]
>   Call Trace:
>    nvme_init_hctx+0x10/0x20 [nvme]
>    nvme_alloc_ns+0x9e/0xa10 [nvme_core]
>    nvme_scan_ns+0x301/0x3b0 [nvme_core]
>    nvme_scan_ns_async+0x23/0x30 [nvme_core]
>
> Switch the parameter to int and fall back to node 0 for negative or
> out-of-range values; node 0 is always present.
>
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
> ---
>  drivers/nvme/host/pci.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 9fd04cd7c5cb..ecec0f9cff98 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -587,11 +587,17 @@ static bool nvme_dbbuf_update_and_check_event(u16 v=
alue, __le32 *dbbuf_db,
>  }
>
>  static struct nvme_descriptor_pools *
> -nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
> +nvme_setup_descriptor_pools(struct nvme_dev *dev, int numa_node)
>  {
> -       struct nvme_descriptor_pools *pools =3D &dev->descriptor_pools[nu=
ma_node];
> +       struct nvme_descriptor_pools *pools;
>         size_t small_align =3D NVME_SMALL_POOL_SIZE;
>
> +       /* hctx->numa_node may be NUMA_NO_NODE; fall back to node 0. */
> +       if (numa_node < 0 || numa_node >=3D nr_node_ids)

Is numa_node >=3D nr_node_ids possible? I think just numa_node < 0
should be fine, and would avoid a compiler warning about comparing int
to unsigned int.

Best,
Caleb

> +               numa_node =3D 0;
> +
> +       pools =3D &dev->descriptor_pools[numa_node];
> +
>         if (pools->small)
>                 return pools; /* already initialized */
>
> --
> 2.53.0
>
>

