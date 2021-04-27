Return-Path: <SRS0=pISK=JY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F45C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A02F6105A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Apr 2021 20:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A02F6105A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/c20pVSzjG/CotUY/mSTAdF65bPHMo4vhplHRFC1nBk=; b=PLkHPJDDd5FTXzEu9TbvIIHrS
	RBJBULYyhuZqslFJdABVRIupzpWURMCxoiUogXzUpjyxHFa9n7WHu5L7moUWtwuMPDlPAuzlvF4Dj
	/kmTlYqx7N5JsDWOqJXQzyX8fy7NpkFnPo0tMFeaveiVik211vTVpBJR1PDj3T9X5e4m4tQ7h/GhK
	2OAWBGVKkJBqiVPrn02aij1ev5HM0wI0cAmoSPR8HhuuEbKWdEfrQ1rngmHKozNwM8uox1qq4NXcw
	77wWvVKvLvvg3oKhXuDEvUXV/0LVVmmVj9NdrNoqbpbSbsU1rODlsU6lJV957ILcRFGnWdzjYoagE
	BbexNxbRg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbUdv-002Ery-JZ; Tue, 27 Apr 2021 20:49:15 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbUdr-002Er0-Qb
 for linux-nvme@desiato.infradead.org; Tue, 27 Apr 2021 20:49:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=; b=SBWzUKfbpD7/EW5oDyQvnwMdc4
 UDogJXOHIcd62NJ9Xs/GgWAzXKSB/bgMLVIfvwiRHCxx6ZBRK3n9aD7WLjes7Yv/pvmNjdz1QTPsN
 Ux6qpCa4Y9Pgu3tHnXSmM1Czhs5G/3V140BUE06kPH+pmQI1T+kSIgJShI3dJd4wuY7DYP9g/nDIU
 rUylpH2xnlt5zP6ve76FNWY5UsZ/AoeS6uZGcFZkMVX04muJuAkZRuA0hJ6Qq/GqRikoN5Zvh3hOI
 KwbmcrcFtbuRZyEBqGfSS/ptQOOtw8UbI39wGA3WpAb4H3qEIjTGY6NDEWw7X8ERoGZZiBX8qIg7c
 TWkO6uTw==;
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbUdn-00H02B-7M
 for linux-nvme@lists.infradead.org; Tue, 27 Apr 2021 20:49:09 +0000
Received: by mail-ed1-x533.google.com with SMTP id s15so71619849edd.4
 for <linux-nvme@lists.infradead.org>; Tue, 27 Apr 2021 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
 b=qEfkSh7MGE8PVxlqCWGjjSgsiEnsnVBnvrjRNNxqQEj5HU0k4aWay+siPtJdTOW5Xf
 zVOpXzCXY0HakOzD/zAOFn8Rvsn7R9MMypGaIbyqQ5mvyZd62oAMQzRju3r4ZZ6Dbh4Z
 PGwXTw7U7ke5bt4PusVhU/FjOe6PO8GyPwyQEOdOvEKEQO2whSN6EREZEHU4BumJ0tUN
 wYRqkBp8E0mktosAXmG+bLKjKBN+4yGMkELK1CaFKSqtKceOXNV5kbTOZ4Y9znDBNz7U
 OaKb8R39/BDxfS854M5MpP4bM8rl5sKWIpgUHtqb2i2Vtr8Gvv6JoSyU7i78Aj09c75j
 QnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GGoNFfJfVqo1Dt2wA+3xepQEKzGpUM+1CEyd/kxn9I4=;
 b=ChEq80GeP3wdw8Kaa78MaJd7gArXnlOP5P49YpHgxVDN0t9u5aGOyABxcLnLQ3OMuh
 5aCxMjigi7Uk8Jmp962bDLIsvYwYn/iaKh0zYVTRjg1YbpHQgpzOuH0tMTsohJPUx6Q7
 cRjTnVLC/sZr35z9e5eMk28+1quwo7l2mBOMFsC5mTnSdmUjWOrOQjb8QUjG5nsuFs5x
 VyV0zz3CwJqZk+ZkbVb+JWwEJJFPonu7Lax1FshjrKuxNlH2ZKUruV6plLHx1PYlJw78
 bJ6U1tgBBuDoCfbPpOxoxneBvn9KcXPPxlec+Sp6bG+yoJfh9GDUNLYX+MVZwCZT9mty
 cGcA==
X-Gm-Message-State: AOAM532vEXpgg/AuwootAAdNBDBXdGsZS1skj3WmmMcuQUcQRc4UgMCJ
 WXBRzMVehdVXKqRWhz1P3CxvvGu71a7qwXCwo0lamQ==
X-Google-Smtp-Source: ABdhPJyFMNunA2bOW/HTfw7I2Fxc07FXNBNlKOc55ZJx0surGmu20mPs7uTrsxToUeLXW66T1s7Gq8IAg4lX/ItiTU4=
X-Received: by 2002:aa7:cd52:: with SMTP id v18mr6553464edw.97.1619556543314; 
 Tue, 27 Apr 2021 13:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210427192838.GP2047089@ziepe.ca>
 <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
In-Reply-To: <52f14602-94bc-fa98-0b97-5f4084d808a0@nvidia.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 27 Apr 2021 13:48:58 -0700
Message-ID: <CAPcyv4h-YVLHTCnXhTy5DVbhXndWZnhcKerDdS=+wDjWzZc4Fg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
To: John Hubbard <jhubbard@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Logan Gunthorpe <logang@deltatee.com>,
 linux-kernel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-mm@kvack.org, 
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>, 
 Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, 
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, 
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>, 
 Robin Murphy <robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_134907_285338_F8CB6554 
X-CRM114-Status: GOOD (  21.79  )
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

On Tue, Apr 27, 2021 at 1:22 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 4/27/21 12:28 PM, Jason Gunthorpe wrote:
> > On Thu, Apr 08, 2021 at 11:01:07AM -0600, Logan Gunthorpe wrote:
> >> Hi,
> >>
> >> This patchset continues my work to to add P2PDMA support to the common
> >> dma map operations. This allows for creating SGLs that have both P2PDMA
> >> and regular pages which is a necessary step to allowing P2PDMA pages in
> >> userspace.
> >>
> >> The earlier RFC[1] generated a lot of great feedback and I heard no show
> >> stopping objections. Thus, I've incorporated all the feedback and have
> >> decided to post this as a proper patch series with hopes of eventually
> >> getting it in mainline.
> >>
> >> I'm happy to do a few more passes if anyone has any further feedback
> >> or better ideas.
> >
> > For the user of the DMA API the idea seems reasonable enough, the next
> > steps to integrate with pin_user_pages() seem fairly straightfoward
> > too
> >
> > Was there no feedback on this at all?
> >
>
> oops, I meant to review this a lot sooner, because this whole p2pdma thing is
> actually very interesting and important...somehow it slipped but I'll take
> a look now.

Still in my queue as well behind Joao's memmap consolidation series,
and a recent copy_mc_to_iter() fix series from Al.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
