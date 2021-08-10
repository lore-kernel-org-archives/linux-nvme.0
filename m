Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B227BC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 13:30:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57CDA61019
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 13:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57CDA61019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DBhhLp6kKuS702MZ/l+/gFrZi9q+oXFeSG2iJVnrn+M=; b=HWSd1n9BLQUAgK
	TmI/86pLi6rF2yBxrmmHMTJRMtgWGSQoVcSOVOljm+BoFtNrkqVcMHiFJD8FQiAbfz2ZQQUDHmJLR
	x+27HHds89eQdgf+G2QJmL0dBTNxAY/Q/27YY6m65Kuqd5aqAbwtODUycOstjvnKd54dsKqMHYxGU
	vvPoQPBhk7N40N0I5qhTJ8Fl0sAqtAlyAqZDl0NxSXQP/ZKkVZeDxYYY9u02f0IOTTJMncf6GGkhn
	T7cL0Uu/yTnFa7brBIOpbicaVwSikcpNLG0XDvdYFGBIdvKa47tMqS//6w8l5zSI1Uez55o2/ICXX
	TgxnM4Yw8CqHIKQyeSbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDRpK-003yQN-Mg; Tue, 10 Aug 2021 13:29:54 +0000
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDRpH-003yNx-Hw
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 13:29:53 +0000
Received: by mail-il1-x133.google.com with SMTP id c3so15357623ilh.3
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 06:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OwFDk7GN/WvHjIQfExElRPlnWlbCzEVVeMa3dwRYSGg=;
 b=eigR4KsX8ShfnDfG2ef2VVtjYBv4SQ0mqhCpkJkH/PjQ4Ro74WbS52pH8F/R8I5b7x
 GCnmj7kdF8Dl2LVY4fljQrvXpc7X4U17SBSJ/xP/7pJgkV0ecAhRUukXuDgEvF2CVwn/
 dDCP1rZ9DFeCxcU6e4+Z1CSGKIRVCxpvABPnGs1N6GoVqUBT3OO06LGQvnqOxDW3rxK5
 Y1IxpYehQQ8fCSOOoReDimIgaeNkXlchS4CXhTPqmp0b6SjtzSS5LlQJTovcxvg/9y2f
 GWvbniMcJXGLzdpk8ahCigLE4wSEps976FtVfxe4rJiCfKo3vx3BdK9MlQArjg0uzn1U
 iLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OwFDk7GN/WvHjIQfExElRPlnWlbCzEVVeMa3dwRYSGg=;
 b=bCkD4laSncINSLjwj3/vaREB5JyFFSjMjozOdfP63hX//JyUf+7VG1uFpc+SxqkyF9
 Z7/OgSVA5vuaYHOsemoZUIu4uMKRb+qoKKFKbglLs/I9Ix05acg6YDx5b3V/cYth5Bm2
 TtyOPBRWEquYsrUbj3M9I2BdYlhAVasrOxFPSc9Gsl7EHhjzM7kdnTjIv6GmdwEMMqvu
 p/Q8nrz6TfcM02fMTXnlYcAs3g1rsXYb0QZuaKE5UTHGRAPeBQuxK6PYu2cwRjQVRLCj
 Zt5lOS1NduPezDAwLfuCegK1KuU7qpvByp1YyjiEpsssaZFwJJTN1BLdKbwlvR6/uRTL
 7MhQ==
X-Gm-Message-State: AOAM532/RnR3MFeEJgseswCCtM/QyDkYCv0uZtOcX2zDs0rlI4z7xn/h
 kTaKySMrs8BopbphBrL+fCMh5bqCLt36Q6akdDY=
X-Google-Smtp-Source: ABdhPJzEDxQLAhdTU09T2kFlxcCFhEHGWs95QHE1D9caZvuDO90Lh3oRtD4hCl1jeDvEAZmQvbvfns9H/7aSw+TnaXg=
X-Received: by 2002:a05:6e02:528:: with SMTP id
 h8mr1376379ils.223.1628602188151; 
 Tue, 10 Aug 2021 06:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210722110325.371-3-borisp@nvidia.com>
 <YPlzHTnoxDinpOsP@infradead.org>
 <6f7f96dc-f1e6-99d9-6ab4-920126615302@gmail.com>
 <20210723050302.GA30841@lst.de> <YPpRziMHmeatfAw2@zeniv-ca.linux.org.uk>
 <CAJ3xEMid0sWkCf4CPK5Aotu=+U4=vtDrdJANqn+CnWd7HTb-vg@mail.gmail.com>
In-Reply-To: <CAJ3xEMid0sWkCf4CPK5Aotu=+U4=vtDrdJANqn+CnWd7HTb-vg@mail.gmail.com>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 10 Aug 2021 16:29:36 +0300
Message-ID: <CAJ3xEMiNU5_+hcbzgXP6n-muE2790iT19BO6R7A2c0CeMu4Uuw@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 02/36] iov_iter: DDP copy to iter/pages
To: Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: Boris Pismenny <borispismenny@gmail.com>,
 Boris Pismenny <borisp@nvidia.com>, 
 David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Shai Malin <smalin@marvell.com>,
 boris.pismenny@gmail.com, 
 linux-nvme@lists.infradead.org, Linux Netdev List <netdev@vger.kernel.org>, 
 benishay@nvidia.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Yoray Zack <yorayz@nvidia.com>, Ben Ben-Ishay <benishay@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_062951_660318_8FFD05EA 
X-CRM114-Status: GOOD (  21.35  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 4, 2021 at 5:13 PM Or Gerlitz <gerlitz.or@gmail.com> wrote:
> On Fri, Jul 23, 2021 at 8:30 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > On Fri, Jul 23, 2021 at 07:03:02AM +0200, Christoph Hellwig wrote:
> > > On Thu, Jul 22, 2021 at 11:23:38PM +0300, Boris Pismenny wrote:
>
> >>> This routine, like other changes in this file, replicates the logic in
> >>> memcpy_to_page. The only difference is that "ddp" avoids copies when the
> >>> copy source and destinations buffers are one and the same.
>
> >> Now why can't we just make that change to the generic routine?
>
> > Doable... replace memcpy(base, addr + off, len) with
> >         base != addr + off && memcpy(base, addr + off, len)
> > in _copy_to_iter() and be done with that...
>
> Guys,
>
> AFAIR we did the adding ddp_ prefix exercise to the copy functions call chain
>
> ddp_hash_and_copy_to_iter
> -> ddp_copy_to_iter
> -> _ddp_copy_to_iter
> -> ddp_memcpy_to_page
>
> to address feedback given on earlier versions of the series. So let's
> decide please.. are we all set to remove the ddp_ prefixed calls and just
> plant the new check (plus a nice comment!) as Al suggested?

So we are okay going for the minimal approach / direction suggested by
Al of adding a (base != addr + offset) check before the memcpy call.

This will also simplify the changes to the nvme-tcp driver.  Please
speak if you want the ddp_ prefix approach to remain.

Or.

> re the comments given on ddp_memcpy_to_page, upstream move
> to just call memcpy, so we need not have it anyway, will be fixed in v6
> if we remain with ddp_ call chain or becomes irrelevant if we drop it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
