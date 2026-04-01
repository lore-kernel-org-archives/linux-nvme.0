Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D7D107638D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2026 17:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=; b=Z3KnriFbLCxmlrtHeobmyBuPn9
	zHfIPWp91nDrlNGVBFhjojH3R5NemvYAdR3QnFd34D+vQ4VwivYwiAieZCiNuAlRGEFlY/rYGARp4
	5/DYitWlJjFQYrK9Um/pHTkm33iNdoqtPrByFGpKrQvo+C7qicIwKdpTVzPRlngY/nzXO9W/8bMUW
	XfVjo9vd/HnL6jMS/IZ5qlNxkrAibj5jZG8rbRzRcTH2d/cui8tuItjQu1re8E4x3lTyXOOLNTAvc
	O+ama2Z53a2ODc69DqdhnxwcoypiX3kTU4WT+/oLuliZl71HsLnLCjaw1MxCV19n/vsC0xY+VPES6
	7BGN4sCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7znK-0000000Ftgt-1llQ;
	Wed, 01 Apr 2026 17:55:58 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7znI-0000000FtgR-1VaO
	for linux-nvme@lists.infradead.org;
	Wed, 01 Apr 2026 17:55:57 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-509062d829dso43771cf.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 Apr 2026 10:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775066154; cv=none;
        d=google.com; s=arc-20240605;
        b=Grdcsf64JvWXWpYn4Fk/MOanR8tZVmk2bxJMRRMLcstEvBVkHqUhSDxziHUbCykLwg
         w0a2/21E3XwaMFSVhb5h6uJ8lkPSLSI261z26UiSnpAZ3xa4UdPLWcEOPLu89sQXUJky
         vIxarK7z8ihaCPKbkW1fy0/PP48wZD+f/AcTHGOG9HfxdsX3YgXtS/TghUA3YmLNFiiA
         3S7RidPl/2+XqQgXZXDyLb7BAwdDiermvlWrN6Ho5Petlvh80bs8IJcJhJ6TNCoZ+FqP
         9wCL5elw6DN1D7biosGYJsn/UxS2PiotUQE8oATq2+27HCPlLPwxGIKwWqmwndoexNxx
         1sVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        fh=w0Ga8Z9+I1elUbLqzSq85cpN+GKteA93jqqGKE9fO70=;
        b=Gw5SaKWq/K4NjSnieoTyFqGb9Cb0xwrDVeDHoAINqfacCYAd1MXMqkUZ8jGKVTw5B3
         XTMFicg0nMqPjQC38XCYTj+OF9jgn38SmSasZ7iPwtEhhvHpgzxjqnHpDOmdBD9wptK7
         6Db4dJ91XObsEZhiTuU8mmPzjx06m+5Uq4c7IBA7mftr3QgdPiqRSrGbvH0jNZXDNDIs
         nrICmDg5ldpGNFRiTAxcU+Cn+tHkeyGTkqeqoUtJGTap78gnx+Y1jJVb7/ehxeuQhFeq
         5DVxhwGfJWjG1lC3Mp5veGPLzwqiVviVMe6lTHAV3GefS+7r4DHfHFR2wnTXZIalmEf9
         nO5w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775066154; x=1775670954; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        b=qxKSfolxI17h7lvDLa4yffYO/r9vCATHHUdEJlzgdqBHePuGjY5pxls9IZLdL7+kpv
         oCJj+L5j//QJ4XXnQPtzM2WMe+l1FyRAUe/KwKaXIbB2M22ChCdFzXp5lcRJLifDr3qn
         8vWhaJqyOMEjYeB+dahObnQLb+2c+W0UqB9nhf7t01T15rG08gAC7g4gCSwo1NodpBKO
         sjXGls7lsINswCg1DZLg1/jG7f9V5YxWB22TGebmLGc4MjwCYfAUz5Dz9H0HpovrPwCz
         PN5ddnsU/0FG5tN+bGGJRmyDyvsDjhUwec1uUzeN0+jHiozzi4/xWDHRZJFPtfBnsCGB
         HcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775066154; x=1775670954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ReGvIRamQKTwLkNtBvdSUx11bFcxQAtxWsfgviw7Dlk=;
        b=XBmhixDE+Z1TN9ka6fh22cMJp+gdJjoU/QABit539QHhIVB7Sp9/crYIjfEfxT8RHd
         IwUvtkJl4fmj3cF5+oapBxwefQLGz9Hmv9G1C0B8Cibz2LnVt+RZciCGudem+p5BQgOI
         +4VGgpjzffo9haQ5F7wOhPwsMam1lwalPqMzfMk1c+jeWQE+AWdN5d9uFte35mkoJMIZ
         K8WMdi/AlwRkwHrb14NpCWG7+irFKnRuK1P2bHO6Y7lHcJfFn1XQQ3m2/LhrITzmFdxz
         xBHO9eF8YHLkBTHvLDUZLSif8Idh6NORb6qTYzjW302AS96td5nxeoGmrjH24/tImw6X
         CW3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCUDkVnG403n2L9b+ldj6wfOOzcO0S6FpvEjlzYlE3CgDhSejvJt+aWNHUI1JsxjaHaw7hgKKvVehb@lists.infradead.org
X-Gm-Message-State: AOJu0YzfLUaQTijw6lK22J3Q39TKGcHIKc1O25tCesOIDcKuHe4rOdQU
	o29F946Fo+dwUddH24eIEF6kY8iP0KKd+F5ByvXJ1eIbUEI7iWf4SZs/7LB244rdLTICcb5SOCS
	PNXdW//0M/EsS+4nwvKThHAvww8/KbqmiCLeff+/H
X-Gm-Gg: ATEYQzwHrYMdnap7D4m9woQEHI2Z4nqq0uMLH/HyWytoAAfqcFIJBIPxXFN6HMFg6d7
	0AniDZVUkPm0O8q0HL8B3BLEpWHsNwFufh/nO7JtfSPE0NnQDuYY9PyggnHNpP7NXLGUTLOU/Sr
	htXYEEIuSAohYBdqM/6nbF03t1GpE+orq1JRN2O80r8jA9QrrR7nNCiYHI6zoDqt0UHsvGjkXI0
	tDGj9q7Gqg7nnsxiAoxpQL5/ARum+jgf9tA+l+9jJ9GxOpLSHpLhjBtIzmQY7rXFfda9LzoRebb
	lDUpaxLuI9rE8qeOyN0rZ4c/jqYaNb6YN/YSiOXA1w==
X-Received: by 2002:a05:622a:a984:20b0:508:fd42:fd05 with SMTP id
 d75a77b69052e-50d4cf74f96mr468201cf.15.1775066153808; Wed, 01 Apr 2026
 10:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260401103441.1229964-1-shivajikant@google.com>
 <20260401141706.GA22165@lst.de> <ac1ZOgnpSjxo51WK@google.com>
In-Reply-To: <ac1ZOgnpSjxo51WK@google.com>
From: Shivaji Kant <shivajikant@google.com>
Date: Wed, 1 Apr 2026 23:25:42 +0530
X-Gm-Features: AQROBzBO3uwmhMnnY_FB_39FojpSluJnZxwak-mZYTWRmVQmxbW5MvZBvJOGUt8
Message-ID: <CAMEhMpk=hro9xWuxo6rYaatsjJvVPuLM1Wi-Y6zbzOxcpPFqCg@mail.gmail.com>
Subject: Re: [RFC PATCH] nvme: enable PCI P2PDMA support for RDMA transport
To: Pranjal Shrivastava <praan@google.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260401_105556_428694_6EA24B9E 
X-CRM114-Status: GOOD (  32.28  )
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

Hi,
Thanks for the reviews.

On Wed, Apr 1, 2026 at 11:13=E2=80=AFPM Pranjal Shrivastava <praan@google.c=
om> wrote:
>
> On Wed, Apr 01, 2026 at 04:17:06PM +0200, Christoph Hellwig wrote:
> > On Wed, Apr 01, 2026 at 10:34:41AM +0000, Shivaji Kant wrote:
> > > Enable BLK_FEAT_PCI_P2PDMA on the NVMe when the underlying
> > > RDMA controller supports it.
> > >
> > > blk_stack_limits() currently filters out this feature bit because it =
is
> > > absent from BLK_FEAT_INHERIT_MASK. Manually re-assert the capability
> > > in nvme_update_ns_info() after the stacking operation.
> >
> > This is really two different features/fixes and should be two patches.
> > Note that Chaitanya also has an outstanding patch about p2p on multipat=
h,
> > so please work with him.
> >
>
> Ack.
> Shivaji, I believe this [1] is the patch Christoph's referring to.

Ack. Let me work with this.

>
> > > Hardware reachability remains enforced by late-stage distance checks
> > > during DMA mapping.
> >
> > I don't know what this is supposed to mean.  Callers need to check the
> > reachability first before submitting P2P I/O.
> >
> > > +static bool nvme_rdma_supports_pci_p2pdma(struct nvme_ctrl *ctrl)
> > > +{
> > > +   struct nvme_rdma_ctrl *r_ctrl =3D to_rdma_ctrl(ctrl);
> > > +   bool supported =3D false;
> > > +
> > > +   if (r_ctrl && r_ctrl->device)
> >
> > to_rdma_ctrl is a wrapper around container_of, so r_ctrl can't be
> > NULL for a non-NULL ctrl.  ->device also should not NULL because it
> > is set up before namespaces are probed.
> >
> > > +           supported =3D ib_dma_pci_p2p_dma_supported(r_ctrl->device=
->dev);
> > > +
> > > +   dev_dbg(ctrl->device, "PCI P2PDMA support result: %s\n",
> > > +                   supported ? "PASSED" : "FAILED (HW/Driver restric=
tion)");
> >
> > Overly long line, and screaming isn't really something we do in our
> > messages.  We also don't do that debug message in PCI, so please just
> > drop it.  IF you think this is important enough add a tracepoint in the
> > core code in a separate patch.
> >
>
> +1, we should drop the log and add a TP if necessary.

Sure, sounds good. will incorporate these changes in v2. thanks.

>
> Thanks,
> Praan
>
> [1] https://lore.kernel.org/all/20260323234416.46944-3-kch@nvidia.com/

Regards
Shivaji

