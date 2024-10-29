Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD57FD3A68D
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=; b=CmQr7TzqHNTeouC75H6rnnC42/
	eDVLYAoWsEgm1ptD7jjfTvtzOPLUT1/6mgO8G98RuABom427gxVF9KONdKCqqD+39bsAzsfsYzENb
	in7BCV3GY73Pik8/CgwHG9kebggn2YYYx6rekDZvv7ORRaVPdeNJAi8JcvkDUmvYiAzC9ROifphV7
	69sKfe/RDYn7RpOkgjDjJdp8QJwPQAto20RZq80nVwHLBPlTk8KBBrrfbJAoFNU++JHg/bYMSGwjm
	WWr7kORSKhuVl4qhOK8zb+fQGsyTKyCrELf1XZ8wClNpohUuAA0LICDzj8mbUi0DEfH/6gtESGxlh
	AktkwKGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rSx-0000000FbZ0-2Y9d;
	Tue, 29 Oct 2024 19:01:19 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rQg-0000000FauP-1tNS
	for linux-nvme@bombadil.infradead.org;
	Tue, 29 Oct 2024 18:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=; b=R+2o6H+RdnLA4Cb2bxxK99wwC2
	0Y4naPGbkN/6zVw9m/cVcQDY24gR+OADw4GUcSP2peZTRNP05FKYZe2ZG0GaIXiAULkkj8N4hhVZ4
	lkgq2qAtHH3U0fIq75zahHrhAvinQWP39ViS8GEMsbLgYURqv0ayq6tR0ql5yuvGJwJ/aETF7i7Xm
	wFbDKJEd5sqT8hDBu16W28WwgqDAtodWK319lk1GJzwj4jgZ1cikgWh2V4Amx4yO86alT6y1kZ/1a
	IBozIQu9dSEzgk+xThIj3kJuLB1KVER0jHi5Mi3kk3mUknW+bMnCGIu3ilD2SIjbBUZWTA6+U22Ia
	sbOOj3ig==;
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5rQd-00000009zHR-1mW2
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 18:58:57 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-50d4797098dso1855321e0c.3
        for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 11:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730228332; x=1730833132; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=;
        b=Nz1BhgLrKmfcj1DU5JX5I4a9HlmdPPUHwogQ+IphVEnGa3W97RQecBpdg055WfYO8Z
         dCHPeatQG6YywNI3wp26MoNo+i/Zljju/LmTKWuCk/PxnmvM4K3voGSAmWKFO0pOmz3f
         fylRyKr0M25VXahmt+sY9cXkDnY2yvVLHXSEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228332; x=1730833132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aWkTZc8Y+jqPDPjDkS4QGc/InSEpbKXcGRwTvfpXufY=;
        b=HL6xWaS6lyoCixzVKCcToUNYwYXku9/CUddyho5RJonnRZvZ/sbHPRIzYHfbCLw4nf
         Oq9/kQHRxXuqlSU8KzomlAZ9kYP/49rXIs5nqHARLCR8lLUVV2AGXvhRXfzMRltGzTOH
         NHZEX/QoUKWVJts2pUzIJD2/eDzGmZ7BEjOt4GzYtuvaBlkDjQV41P01FRKzu/K0du2E
         ht01B4D0RWZjV4KrK3DLynuhCiA4NGKH8a7wp4p83qkZ2xIFJxIrJGoZPrZIxhPjQ0U0
         ikhbklVvL3e5nU1UmNVtkJ88Ym/2GdyyA0Bxr+PG7u6KIgrgWFqzzNI7zRAiGs+/5nU1
         SHHA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ+nNzuw0s3FJdVH8l0icAghdm1kWvncEKpeM7xW5EVY9DJkVvbwzSIDtEyHPrP2rViqS8T9HzBPWi@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0kfaH9l0rIVja3+PxOjG6SpeFkfA6CBtsa+hobO0BdTzjWQF8
	wf/fzHqWsm9dPM5wIu4c1fvwSL5THXJFzD/s2z0YnXIc0u9qSbVs3nxNyCn5x7KfbT/SrhR2TMR
	gcVLAMuVLZYV9Gu9aBjfE2vOpDnhDOowDgjxj
X-Google-Smtp-Source: AGHT+IHNQarJDeF6ZTczXA6wAeLI1sDCSh6JY57hkDajWvrF0A7cvL2N28vNjvcVfNW7OPsHHTypPQAdAONKz15iu68=
X-Received: by 2002:a05:6122:17a9:b0:50d:57df:1522 with SMTP id
 71dfb90a1353d-5101502d48bmr9286161e0c.6.1730228331903; Tue, 29 Oct 2024
 11:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com>
 <20241029024236.2702721-1-gwendal@chromium.org> <20241029074117.GB22316@lst.de>
In-Reply-To: <20241029074117.GB22316@lst.de>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Tue, 29 Oct 2024 11:58:40 -0700
Message-ID: <CAPUE2uvUs5dGGmovvHVPdsthKT37tJCK5jDXPMgP18VKhm5qTA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
To: Christoph Hellwig <hch@lst.de>
Cc: bob.beckett@collabora.com, kbusch@kernel.org, kbusch@meta.com, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_185855_620572_FF8801ED 
X-CRM114-Status: GOOD (  18.39  )
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

On Tue, Oct 29, 2024 at 12:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> > PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> > is a NMVe to eMMC bridge, that can be used with different eMMC
> > memory devices.
>
> Holy f**k, what an awful idea..
>
> > The NVMe device name contains the eMMC device name, for instance:
> > `BAYHUB SanDisk-DA4128-91904055-128GB`
> >
> > The bridge is known to work with many eMMC devices, we need to limit
> > the queue depth once we know which eMMC device is behind the bridge.
>
> Please work with Tobert to quirk based on the identify data for "his"
> device to keep it quirked instead of regressing it.

The issue is we would need to base the quirk on the model name
(subsys->model) that is not available in `nvme_id_table`. Beside,
`q_depth` is set in `nvme_pci_enable`, called at probe time before
calling `nvme_init_ctrl_finish` that will indirectly populate
`subsys`.

Bob, to address the data corruption problem from user space, adding a
udev rule to set `queue/nr_requests` to 1 when `device/model` matches
the device used in the Steam Deck would most likely be too late in the
boot process, wouldn't it?

Gwendal.

