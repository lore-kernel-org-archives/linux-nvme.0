Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF26D3B7E1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HseCuxVcgTTpliTcRhjccSaoiUYsiM7w60CZwC55taM=; b=XSUlhoeYciDexY/1jmEm4jD6dS
	ZNtPnSEMF2FqBWlnb1YzuLPGoy7Dcq/qWLvwRxFUDdKOFOs6bOaY2XPOaxVDndRKu/WpSgGpoV9kr
	x6+67BisLk18uZiksHb3z/hihfMMI4e2JqGK/WDohNRQXkJTYErX2olRQSZsL6/1MsQB2q+rXWtwp
	qXI5AIoXofCw9j1GtWNAUgiuEZVbYnfLwdOVUjzXPsAsXvOZke1fXxp6v5pjFlxcEW89mGrVr4vui
	QB5sZ5WZCUjIIW94juYwJyoBF39AbEc/vk/uE46R1BsvoPqoOJlGNCZcc9cPhM9HnmZ/7SbHBNCtz
	8+Hkg3iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTst-00000007HJV-2fIF;
	Mon, 25 Nov 2024 07:51:51 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTsq-00000007HIU-1uep
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:51:49 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-aa503cced42so437708066b.3
        for <linux-nvme@lists.infradead.org>; Sun, 24 Nov 2024 23:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732521106; x=1733125906; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HseCuxVcgTTpliTcRhjccSaoiUYsiM7w60CZwC55taM=;
        b=FkXV0y/Jy10Oo9rgL7m16b5YBC1l/RRogMlYQOVSSHxSrl4aoElOyDeejL/LDlDkrO
         U8BdPe0v5QQrB6zlV7HiXDnNskCfwsPI7NwQhmFJF/OnFaxlCcoiCJTvmibS0pMobMd5
         8FGKlaEqjKN/dkSW5oVqa9StXyh/xArq/amWVKedkgMNsn2BitQJWM50EI4rGEpW+7uB
         KfZ7vuPw3ncPMQ68lOdBcU3xYOc2yVuQ005axPdER4kLqOUL3X60CdP0zGaaXNgAeZMW
         K5RkCoiCua/X+4fEksdYf59EBETo8NmhYW1kJJMB5AFximarEQRRZV7znYnmtLsIArcZ
         FkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732521106; x=1733125906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HseCuxVcgTTpliTcRhjccSaoiUYsiM7w60CZwC55taM=;
        b=RNoyVFvPtRjBuWrpFMZe/VJsO2OGFyMM4ULW2exuNQ3/rBJ8Tl9fC6EDgNp15faPri
         h8EimHjyUXk89+gxnODs8ySVaQtKzVgN8fi6+I9KvHkyg4c4O7lgZICLlajIVHj/sjaD
         03AhX9SsiflmF1A+rnwzJkOm7o7BU/EM0BK7/I7r+Qpxl+oChWRcQYpLugFN1PaEKq6v
         7Xd7uMKIrITrJXGy0BaEaOQlMuIQtjv2GkH4Ye10cpGy2wFi8k6JR4v8/VXKlihCdjCl
         drSLKSRgOf0ZMdQYho1ofkdRWkAmlINm/7nIP4ZUsq6oCUyWafT191gskAYaVECKVNN0
         MW0A==
X-Forwarded-Encrypted: i=1; AJvYcCVtbmQBQsxriV4foCMWLZQoMHTv7mnoByhHwffYv+AXifUXsAcuDUMRTkse7YS/KxtGCGs9Rgpl2V7G@lists.infradead.org
X-Gm-Message-State: AOJu0YzQHmN+1nMgvENQONudwnTIWIPryB1e+MSxjVI6jtpae4j+vdF9
	/jP5MVlhoG5jfN02MUBibElToWL1Djq31GUsrIW5ZCTl20IvJQHJur5MrtDKzNyYrTaeGYaKtrQ
	obwNJJvZIoRbTThKnPsXnC8mEH5Y=
X-Gm-Gg: ASbGncvKTBeJgkTG5xxZM0s6iHCQhGtw5bBoXdVeumdSvms+Sek4Sg/IT7zeq9i3IZH
	0sk6BYe298PdJISVDULBvEO82rWSY7eQ=
X-Google-Smtp-Source: AGHT+IErwpMqN0sd6ADDPNbcLBIAW3pMNYH7sBc8m/479mXRYyIOd/NUmzu3eps1LMnCEJhREs7F9fQCqO/Cj6eVZ/g=
X-Received: by 2002:a17:906:4c1:b0:aa5:c1b:2203 with SMTP id
 a640c23a62f3a-aa50c1b22a1mr797032366b.42.1732521106154; Sun, 24 Nov 2024
 23:51:46 -0800 (PST)
MIME-Version: 1.0
References: <cover.1732368538.git.chunguang.xu@shopee.com> <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
 <20241125072400.GD15647@lst.de>
In-Reply-To: <20241125072400.GD15647@lst.de>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Mon, 25 Nov 2024 15:51:34 +0800
Message-ID: <CADtkEecQ=vQZB+gAiG9peeqfAcMpLkQF=JFCHVxCF3k_ZAWN+A@mail.gmail.com>
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_235148_512961_0ADB3D79 
X-CRM114-Status: GOOD (  12.01  )
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

Christoph Hellwig <hch@lst.de> =E4=BA=8E2024=E5=B9=B411=E6=9C=8825=E6=97=A5=
=E5=91=A8=E4=B8=80 15:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Nov 23, 2024 at 09:37:40PM +0800, brookxu.cn wrote:
> > From: "Chunguang.xu" <chunguang.xu@shopee.com>
> >
> > Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> > the code and avoid unnecessary call of nvme_tcp_stop_io_queues().
>
> Please split the behavior change from the cleanup, and explain why
> the behavior change is fine and desirable.
I think what really change is  removed the unnecessary call of
nvme_tcp_stop_io_queues(),
as we have do it outside of nvme_tcp_destroy_io_queues(), no other
behaviour changed,
inaddition align with the code nvme-rdma, so it is easy to maintaince.

>

