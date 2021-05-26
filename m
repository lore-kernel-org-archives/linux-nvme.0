Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF7EC4708B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:34:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6402A6101B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 17:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6402A6101B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7Z1pKl9EyNuiA3/XKPifeU3GQZzjHDOun5zmSEdNDmE=; b=gc6HTzUidehHkC
	XUqqEMt3QoQX4NBId8UdJViEXYuESXfAUx30JizNybvtGbcqCK56t5PJ5RIsk1cinn4xhJP3Y7hq3
	ev3SuBAlJr0wIBVO3o7dUfI7qhEk32/dKXy+UpEKu6VyEwC8MAB7eHQkeVvdEKLVe0LDRIWf0iNWi
	Um6AYDcvl7gLt1gtSa74bEofPgFvW+FcAwNmyNmJihSa6W1ty8Pyd+oofFFEpKAhwhVyb5NyivuNK
	gJrx9bPNrO7POxRLRlt8QD7vGnGNZ24et9dpeBw5aP3tpiI7DXmOKmWbaesjt+x8E1f8Qtp9D/nPJ
	BhACO4hWnGEdl7DwUkcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llxPg-00G9Ng-QH; Wed, 26 May 2021 17:33:48 +0000
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llwKU-00Fhzj-Ft
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 16:24:23 +0000
Received: from mail-lf1-f70.google.com ([209.85.167.70])
 by youngberry.canonical.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <kai.heng.feng@canonical.com>) id 1llwKR-0008Fc-Iy
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 16:24:19 +0000
Received: by mail-lf1-f70.google.com with SMTP id
 o138-20020a1941900000b02902a5ff0b6936so373029lfa.9
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 09:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EaLER3aOaefvnJohx084gatUZrVitp6/k9BAoBcbFwQ=;
 b=mlyyeGK50PU0Ojapjv6GgfBxU3F9wwx67Ua5MVoXnhAuA6GjMqMFqmkGl7GZpVE+qO
 ToqYEdpA/q+ZjQRTqGmAEmCxUXFoZ55PLMCATQ3G0Tx8KhDaDE4fx92oLWtA1598hqN4
 ayil60BVfcI7D7WNvtVlmwLLGcRtzBErZagd99qqloPxnaAXcU0jfgsuJf9ymI8fWeJp
 9zCoh86tQdPZldEVjdM4O0M61vyo99wPcWBzq+ZmaOJT3vTTDa+H0VbcZCKIIBb2Xm74
 Ud2rKyG6it1cq0kQNue5kes7tNjm9VYelu7xE3orBQTFmYpGIo2/hwlHVWZeLo/FC/lS
 ogYA==
X-Gm-Message-State: AOAM5311kuBKkU/6pfJ+MsZ3wGatyM1puKNnRYAiRGSUrPHeeM5CnjGP
 7Wr/hV4RLg54u6JVTwQ2wL0W91x/jyILKXe/+LAVFwQPF6lajgsT4XvzLPan4uomTtQwfOeVVWv
 ZJsC+FDl7jcVLciMMtB6DiKrKRYxFrCUaa0RaBs8DH2zjDreg9tkWlwHfLE9z
X-Received: by 2002:ac2:4144:: with SMTP id c4mr2630891lfi.425.1622046258899; 
 Wed, 26 May 2021 09:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTX2NBJBNN4eqh1bmc0CzSsdUjoLFqYdZdKExzytvKRntLCQ7lGSKYfKS2XXdeHamQs7tXA0/k/v58IQQ8mVE=
X-Received: by 2002:ac2:4144:: with SMTP id c4mr2630873lfi.425.1622046258620; 
 Wed, 26 May 2021 09:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
 <20210526150633.GA1291513@bjorn-Precision-5520>
In-Reply-To: <20210526150633.GA1291513@bjorn-Precision-5520>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Thu, 27 May 2021 00:24:06 +0800
Message-ID: <CAAd53p7Mnv6HUv8hfjnsCpGeaSPXVAiA4D8gMxxdn6Bz8Z1fBQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Koba Ko <koba.ko@canonical.com>, 
 Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>, 
 linux-nvme <linux-nvme@lists.infradead.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_092422_575500_081E62D8 
X-CRM114-Status: GOOD (  27.58  )
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

On Wed, May 26, 2021 at 11:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 10:47:13PM +0800, Kai-Heng Feng wrote:
> > On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > > > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > > > at D0, which gives us a faster s2idle resume time. And now AMD also
> > > > requires s2idle on their latest laptops.
> > >
> > > We'd much prefer to use it, but due to the broken platforms we can't
> > > unfortunately.
> > >
> > > > And it's more like NVMe controllers don't respect PCI D3hot.
> > >
> > > What do you mean with that?
> >
> > Originally, we found that under s2idle, most NVMe controllers caused
> > substantially more power if D3hot was used.
> > We were told by all the major NVMe vendors that D3hot is not
> > supported.
>
> What is this supposed to mean?  PCIe r5.0, sec 5.3.1, says
>
>   All Functions must support the D0 and D3 states (both D3Hot and D3Cold).
>
> Since D3hot is required for all functions, I don't think there is a
> standard way to discover whether D3hot is supported.  The PM
> Capability (sec 7.5.2.1) has D1_Support and D2_Support bits, but no
> D3_Support bit.
>
> Are the vendors just saying "sorry, our devices don't conform to the
> spec"?

Yes, that's exactly what they said. Because Windows Modern Standby
always keep the NVMe at D0, so D3hot is untested by the vendors.

NVMe vendors explicitly asked us to keep the NVMe controllers at D0 for s2idle.

>
> If what you really mean is "D3hot is supported and it works, but it
> consumes more power than expected,

If D3hot consumes more power than D0, is it really supported?

> or the D3hot->D0 transition takes
> longer than expected," that's a totally different thing, and you should
> say *that*.

The D3hot->D0 transition doesn't take longer than expected. It's just
relatively slower than keeping the NVMe at D0.

Kai-Heng

>
> Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
