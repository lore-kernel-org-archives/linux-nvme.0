Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D1AC5B572
	for <linux-nvme@archiver.kernel.org>; Sun, 16 Aug 2026 19:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=; b=qui40UrJclyIS0EeQXX3ts1C+0
	zFiJhIpHeA/rAdXnxGbhSdosPQm2e6G/uisAMKjlv3pA79fmhYbsfJTkyrhYbl4CM6j2V0qXCpwN8
	K3LJ6mhmaO1n0KgNrrBaRQCnE2vUXddb/ALWI9WMNIebLHRLJqedgPpwtSY12ahf8WVcOYOtczj4r
	3XMhLMr5JL3sLCfosn7X8+gMpLE5icqiYHoCOWBgG+gCfDMOhuXQekynI6zHCxfdVON/ilGmZjU7Q
	LbCSP/J+6c6/s8i8hAigBlIb/G8WSTQNoNjEh2/Twjk/t9vQp7YEUqiNDFfJ2L0hw63ceyDE8vko+
	Fp6xwCCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgDR-000000050gz-2CEh;
	Sun, 16 Aug 2026 19:08:17 +0000
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvgDL-000000050gb-0X4k
	for linux-nvme@lists.infradead.org;
	Sun, 16 Aug 2026 19:08:12 +0000
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-69c108fee7fso3571802a12.3
        for <linux-nvme@lists.infradead.org>; Sun, 16 Aug 2026 12:08:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786907288; cv=none;
        d=google.com; s=arc-20260327;
        b=QZsZ1QgsvT9rZSVNG/vBi8YGdPod5WFEDf89PXIq38FnrW8t/4QCHvOu2DPlIZxbxN
         fRC0jxaF7njw/ZbcTnOsr/XRTyP/fOzcLi3aVcjUBIxZCA4GvfHnVqiCdsig43R2QpyP
         KjpMzxEmRQ5MAzXwRr5FJaMgaaHsDGmzmYUfrpSUVk57qJrWtxIKD51ObWuOG5zNA2PX
         Zg4jhE598lz1zsXpMMLDa0/e5YT74ggG5lFvSswwDOwyWGppcj/25LbF/IqKfCegiC34
         iJbqP9PQBlQecWh/J1ZvjZYHVJp9+j4wqG4LAa2PY6cyGkYUXfwhKMfnYNKZ0vnyCJ1C
         ccTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        fh=O0h+atCtIs0WQIWEIibVTghGVU0slS92u5K7rc3hBQA=;
        b=MOHKc6Q1ksCSFHtvvXt2Wq2qBbyDeJBC7orQ2kF8coIZe8kqbHus/zMoE7ijNR6Cz+
         ZY6E8v1Yn0LZ8jOmvLOIfgjhDlsaqIyqjeU0y2URV4sM4ae2G67+lMKmECVTxDGpsbWd
         otuZvLL+TjkpQXtjytALuHsiDB+qLNCT08MHNIUs7PQwHGGjk+hMWdqtAaTCU4/Ce7nw
         ulu3jr5yJjx2JVaTf5lKAABqWLNSK7tSM5/oPgSqkvck01yfdcUiXuzlemogLbCLaVmT
         hckmdWbwV5Drzba4mYGVh6/aMSjOLGglCOVXqzEi07UJ2bozGElwGdMBUyJqZRAJr3+R
         73bw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786907288; x=1787512088; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        b=TSM/BIa2V5uIeuQ9fHxfvG1Mz57iN9u40XJa+xRhB89iCThrfLJz4YfdgQLzqV2LCn
         ze6Iqxk+ACFjw13Ppur7VVFrtsm3vf2Pgj/bafmbrZp636bZNKp0aTtTqupx62uMR63k
         tWp72B7XMinEHqhEXA2Jm113+pTJ8a6YBtBi73gSuTYyq5+l5m3enbz9B1/Tl9zBfV1b
         yaqctzeyq17j+RXqj+cSHTS3OU1FfZGpv+Xk2CNOZ0ZEfta2E1r8WHuC4zwX8yFA9hzM
         hTKMxtUzOh8JgEXlEVN0cv5MrMwkF87PLiIXq/l2FFk2OgDSyMkq8yEaR1iLkzVUJfy/
         p9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786907288; x=1787512088;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJpiUaeSmSukMEiVdIJ7E+Eb4oTrVCSTLcJCR2loI3k=;
        b=WqrJTo6XjaQ2VbNUkKULsRiEFKEHg89hyzp9TQAtSoZgrprDZn0iafcFMEcdAidp/p
         MLqNN8WW+P91OdzGHIof01zs3UsFTZPokJFJE5OFOGkCG+oGERmXMqxIXv2dbqgk0JbS
         8mfqlBgtR/wr5/i088nTkHuWH0ZPn1/mRN6VcmfqnHuKTMC/0CEQuyLxFRAEQi729FGD
         5WwHRFMIKpMZ46zOkUNX4z8VSFKnahTVsvRjJk+SV+nTVHWtifXNbUdOxQu83K+hI0lc
         G9DvEg0H4xXEMQu/cqtIahU1whWv3JFZQFyjPSNvW7OUK8aD3DcBJ7v5KM9nPu9tcy2P
         Y/og==
X-Forwarded-Encrypted: i=1; AHgh+Rr5A+Ny3d2oMjXedB1QfHna9Wx6p9d9ZD7UAA6ovdrdDlqD+1ZaadglNdo4LrGjqKuEExpsg7IW4xAX@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/onxx9nvOzSouHhlHyXjn7V7QXPpwaqCZQM6Ty36hxcFGl7Lf
	SuTIDz/a/mJVhvL+GRvgH8OLg1Ug4eHWL+278R2Vl2rHHORCjaobdOgqbyfUW2oJKtRtJXIJxef
	u8f8OvY0peQXCtO4FsmxAn0tDQmEYnCk=
X-Gm-Gg: AR+sD10/G5OaiHiNxF/IG/pvNzfGO9PI3LAj8za/OCWayRjfQC7k9dHEMC7vUkrQbeY
	S44A9oEaNWBOrr4UeQcxJSSNfQE9jtikjSuwiGSucpiKxj1iTywn215FJyDS/GNLpkhlg3widRS
	qSLw3oWKeo3P8q6O3y67xg5HyFwM73BERPoeRg4Aaw/9otTxbJz0Wr5vi7o41nHyQdPEFbwVMwP
	qwM/JJ+cDwvdfDTqvNMuxO35FABa6IbF9T813GjTrTd4kFt7SLJOHZObeVRj280ivKpyKl0zLjD
	z+tT4oIUCqz0Bvwd/f7Gs0QIct0aFqQYADUgZIwFcUym
X-Received: by 2002:a05:6402:530b:b0:6a0:567c:c2fe with SMTP id
 4fb4d7f45d1cf-6a38a9a323dmr9308591a12.20.1786907288432; Sun, 16 Aug 2026
 12:08:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260814160954.2839507-1-coshi036@gmail.com> <an9sbzM52QqKdQuP@kbusch-mbp>
In-Reply-To: <an9sbzM52QqKdQuP@kbusch-mbp>
From: Chris S <coshi036@gmail.com>
Date: Sun, 16 Aug 2026 15:07:57 -0400
X-Gm-Features: AcwNN1UGmJA_m0q1P9tSBlDs0Z5V6pFvjJicpL-HIgO9xLhhaYThNptM0VyB1C8
Message-ID: <CACd_6n1d9kdEYARkmf6bRzbt5SXwmf-8jk_Dd-xJ0gyQ1TcMMQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reject zoned namespaces whose zone info query failed
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, joshi.k@samsung.com, 
	weizhu@fiu.edu, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_120811_207330_45554EF9 
X-CRM114-Status: GOOD (  19.74  )
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

On Fri, Aug 14, 2026 at 3:28=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Fri, Aug 14, 2026 at 12:09:54PM -0400, Chao Shi wrote:
> > Before commit c85c9ab926a5 ("nvme: split nvme_update_zone_info") the
> > caller tested "if (ret)" and bailed out on any non-zero return.  Restor=
e
> > that behaviour.
>
> I think the namespace is generally left up on purpose for controller
> reported errors so that we have a device handle for admin debugging
> purposes.
>
> Can you just skip the zone limits update when you have a bad response?
> Something like:
>
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2457,7 +2457,8 @@ static int nvme_update_ns_info_block(struct nvme_ns=
 *ns,
>                 capacity =3D 0;
>
>         if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> -           ns->head->ids.csi =3D=3D NVME_CSI_ZNS)
> +           ns->head->ids.csi =3D=3D NVME_CSI_ZNS &&
> +           zi.max_open_zones)
>                 nvme_update_zone_info(ns, &lim, &zi);
>
>         if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)

Thanks -- keeping the namespace around is clearly the right, I
had not considered the admin handle.  v2 does that.

I did not use zi.max_open_zones as the condition though, because 0 is a
legal value there.  MOR and MAR are 0's based and FFFFFFFFh means "no
limit", so nvme_query_zone_info() does:

zi->max_open_zones =3D le32_to_cpu(id->mor) + 1;

which deliberately wraps FFFFFFFFh to 0, matching the block layer where
0 also means "no limit" -- blk_validate_zoned_limits() tests
"if (lim->max_active_zones && ...)" for exactly that reason.  So a
healthy device that reports no open resource limit has
zi.max_open_zones =3D=3D 0, and gating on it would leave that device's
namespace unzoned.  QEMU hits this with its defaults: hw/nvme/ns.c has

id_ns_z->mor =3D cpu_to_le32(ns->params.max_open_zones - 1);

and zoned.max_open_zones defaults to 0.

zi.zone_size does not have that ambiguity.  Every path in
nvme_query_zone_info() that returns a positive status returns before
zone_size is assigned, and once it is assigned the only remaining
failure is -ENODEV, which the caller already handles.  A successful
query therefore always leaves it a non-zero power of two.  So v2 is:

if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
   ns->head->ids.csi =3D=3D NVME_CSI_ZNS && zi.zone_size)
nvme_update_zone_info(ns, &lim, &zi);

One open question in v2: on a first scan the namespace now comes up as
a non-zoned block device.  Setting capacity =3D 0 there as well would
match what this function already does for nvme_update_disk_info() and
nvme_init_integrity() failures, and would still keep the handle.  I
left it out to keep the change minimal -- happy to add it if you would
rather have it.

Sending v2 now.

Thanks,
Chao

