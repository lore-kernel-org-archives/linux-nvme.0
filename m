Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29359D12D63
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 03:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AszquRm3rEcjTNQTd7uRs0tgE9n1Q/miIDo52S90X0w=; b=AAuHd0TRLto8mznf/P5ycXsIsY
	Uzvzb6XcuBH3YhWsgqn04A9WbZ3lBpEi/cJmNfp8Dxt7TEThiknr2BkS2xXihxRgjBrS4Mx8dZCgV
	fwoR2vpS7Og5ByJLkg2YG4ivGtUGb/9ihgziaKxyuEBSpbOLRf2F/QNG1iomurA3vAcJqRGs9jS6T
	MEWVDm024L0b/zwsYX9EiyPVLoQiBxO6glgTN8T7FyZ3Kb5XflX1oZk59ztWzQ/VkA2h8az1Vy6Sx
	UclBUVy0Af5tvX2lbA0t6gk4anntuG/j7mp9qMe3JCLVc0TuJR7rBGYsARS1ylnl+6H7vyDtAlJc3
	ybH/sM3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAKsL-0000000GCQh-2ban;
	Mon, 11 Nov 2024 03:14:01 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAKsJ-0000000GCPj-1AgZ
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 03:14:00 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-539eb97f26aso3883277e87.2
        for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2024 19:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731294837; x=1731899637; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AszquRm3rEcjTNQTd7uRs0tgE9n1Q/miIDo52S90X0w=;
        b=ab4YOeCQKKXgqb8q3JLB2BwE167mlxzX8dsTDd+Gy0cHQxQDsiBnfdnpgCcMwvQMlj
         Z4EAVN7K4tyZgKPtnlPnwRqLbULwBbdRvhTeSExiHlBXpCleWKYaeYK2PVAD1wI44dI3
         E76CO+vkiU1GEtnSERRLbTptbK4xvceYFng6lPAvqOm6/vjajx15hX3fVSU3Am52SfKS
         DLkIS4iDm0EyGKDpdDthCDeP4LFdVQ8DXgpynTnewZViPEpO9rTlNyY0dM0UnGBnENHd
         TDBnYDbtREDsbEpZ1MBan2A8CxWxmXDa5BOidUXYMidlDe0nQ/+vaWXMlUnXUh/3+9eT
         9X3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731294837; x=1731899637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AszquRm3rEcjTNQTd7uRs0tgE9n1Q/miIDo52S90X0w=;
        b=icaqPnipxt8dt5CJDh5zBHmivlP4Y3jKcL+2HP3GXwyj+yxfIdc6XVvYfcrNwHRSsJ
         6CTGDMtPfXRnviU+ziHdqhe88FWixkJKABJ3cTVjb5BfQDeqehC9YWa4gecagrJpI23E
         GHzZ41azc+p4ox7Ey6ot464npskjNngR+Kcf9mW/HoaMuJpjYbWbaoJO2VLD6F6lafNS
         RX5KCq0eg539J5RjS1xcE9Wl22QvoTVuq0RM9MQDAiKNSUoFsMxBpcIYBoC/nG4SPQWm
         NuWsiu/6nzhWCOvuyjySFLtEMV8rFeVH96cxt4IlpzylFWa2RbV77uvsavnzRKo/kg5E
         Ft6w==
X-Forwarded-Encrypted: i=1; AJvYcCV4RE9Ll96Pt9UIb9Ag62USYT93L83wCLqLqXuPXCn1LEY9DOLGvVkyzqXHROcu5RrezD8B15CxPPd8@lists.infradead.org
X-Gm-Message-State: AOJu0YzKzQ8Rd95c5wmNLNQQMLmzcJbuEcgsNlu/zEJcxAK8itE5mQ0d
	6GZlP6jYCfo+dHSjQiq5IBz/67vWMYMnbEiNqFwjhAS3kU1+ryBCPLwpcQ/CfxDApnhu3ecY361
	YnbSQmpz7FmXvWCaSJ+R20I0dIyo=
X-Google-Smtp-Source: AGHT+IGCJWVGSDxh88mmV8TfpUkds1GTcb/SQfLMvdY+xjmMgOtiWhJjm3URTLzGgKvmaZLyg2QvEHBS9bNI0FtRaqQ=
X-Received: by 2002:a05:651c:881:b0:2fb:6465:3183 with SMTP id
 38308e7fff4ca-2ff201e7398mr46022501fa.3.1731294836895; Sun, 10 Nov 2024
 19:13:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1731244445.git.leon@kernel.org> <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
 <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com> <875xouv5lt.fsf@trenco.lwn.net>
In-Reply-To: <875xouv5lt.fsf@trenco.lwn.net>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 19:13:45 -0800
Message-ID: <CABCoZhDpdU0cGu8Ru5Jj+YmnS07cO4k_nbOFT+HkdFkpVo1NYQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] docs: core-api: document the IOVA-based API
To: Jonathan Corbet <corbet@lwn.net>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, 
	Yishai Hadas <yishaih@nvidia.com>, 
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev, 
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_191359_350165_7A2A136D 
X-CRM114-Status: GOOD (  29.03  )
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

On Sun, Nov 10, 2024 at 6:58=E2=80=AFPM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> anish kumar <yesanishhere@gmail.com> writes:
>
> > On Sun, Nov 10, 2024 at 5:50=E2=80=AFAM Leon Romanovsky <leon@kernel.or=
g> wrote:
> >>
> >> From: Christoph Hellwig <hch@lst.de>
> >>
> >> Add an explanation of the newly added IOVA-based mapping API.
> >>
> >> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> ---
> >>  Documentation/core-api/dma-api.rst | 70 +++++++++++++++++++++++++++++=
+
> >>  1 file changed, 70 insertions(+)
> >>
> >> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-a=
pi/dma-api.rst
> >> index 8e3cce3d0a23..61d6f4fe3d88 100644
> >> --- a/Documentation/core-api/dma-api.rst
> >> +++ b/Documentation/core-api/dma-api.rst
> >> @@ -530,6 +530,76 @@ routines, e.g.:::
> >>                 ....
> >>         }
> >>
> >> +Part Ie - IOVA-based DMA mappings
> >> +---------------------------------
> >> +
> >> +These APIs allow a very efficient mapping when using an IOMMU.  They =
are an
> >
> > "They" doesn't sound nice.
> >> +optional path that requires extra code and are only recommended for d=
rivers
> >> +where DMA mapping performance, or the space usage for storing the DMA=
 addresses
> >> +matter.  All the considerations from the previous section apply here =
as well.
> >
> > These APIs provide an efficient mapping when using an IOMMU. However, t=
hey
> > are optional and require additional code. They are recommended primaril=
y for
> > drivers where performance in DMA mapping or the storage space for DMA
> > addresses are critical. All the considerations discussed in the previou=
s section
> > also apply in this case.
> >
> > You can disregard this comment, as anyone reading this paragraph will
> > understand the intended message.
>
> I don't understand the comment, honestly.  You say "they" doesn't "sound
> nice", whatever that means, but your suggestion retains the "they"...?
>
> I'm all for reviews that improve our documentation, but it is
> *incredibly* easy to fall into the trivial bikeshed mode.  I've
> certainly done it myself.  The end result is less documentation as
> people decide, understandably, that it's not worth the pain.  Hopefully
> we can all try to do a bit less of that.
>
> FWIW, I think the paragraph is fine as written.

I completely agree, and that's why I suggested feeling free to disregard
the comment. When I read it, I felt it could be improved, but I
agree=E2=80=94there's no point in overanalyzing it.
>
> Thanks,
>
> jon

