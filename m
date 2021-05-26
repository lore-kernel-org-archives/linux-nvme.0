Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A323C47088
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:17:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22628613B5
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 16:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22628613B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=GgLTYa1AKSMy9lriJiJBQkQy486m6Yt6nlcKr/Ouuxk=; b=c9GfWg5/14a4fv
	NDvxD6nCu3ZBXUwKHX96UqSfpW+f4SAqg/yVhABCNi6vje5owTJWFa84eu67oEU1vd69UaJu/MFgN
	N1NjXJogy7fw2aMH070jcMxyhB58JfHd0d1fMPIRMi3wE+uTXxwWsz9GWrduD7pY7SPYq5O+Ahbsg
	7tC7ofWnnflGNAAO5D0XL1F2sNYJb2gFWrWi2BzOj3/9dYgMRpchYehxRVuWDp429fBAmGKJ/uzMw
	QpzrIR0TtkTurAh2cL46xqN6SpxkSD41GDXy3C9YK0sCKlWoJrPVGmcPxxZm0WmOf27sjsMkDMpBH
	O4RJtK2+M/LSaxxd2sRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llwDz-00FfWp-Ns; Wed, 26 May 2021 16:17:39 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llv7E-00FC6a-8J
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 15:06:37 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D09060C3D;
 Wed, 26 May 2021 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622041595;
 bh=Oy7BgTGryKAyp8xe25xWfjrue9Y5RYNIPBC147pGbFo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=niMC04LJXYXUtzW2Dcb2+dtMvOUv6SPJoC38MhVLRfGrARD2vKV5HnC4kTDzCFsaf
 HBJ0YjHY7iiKCugbbQ7iAtNe+PhhN56l0Suz4Py6ZvdALce+9GoJjrw8DPRzuW5uRi
 eL2F4OvDf6Czl3/XhIvDOG/VQpj1PFiR6F7iddWKy7+mPTBDR+umbrk0UdRtYuu73L
 sM8k+3P3+7yysf3qw6fUzr6/clnnVNc7397aIPvEzVcelzW/DiM7I989qRRgUsBiJt
 WGWpl1cmZb2Rly67CcMDMbX53C8wEXLsoX7ld5W+uf+HEncJLYQ70oVxre3iPdbfmO
 4tdyjhbNtsrVQ==
Date: Wed, 26 May 2021 10:06:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Koba Ko <koba.ko@canonical.com>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme <linux-nvme@lists.infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Henrik Juul Hansen <hjhansen2020@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use
 npss.
Message-ID: <20210526150633.GA1291513@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAd53p6TJev=LgdvGxC92A9HOy3B6jbPLymAqeB5bDe2=5Fdsw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_080636_366178_ABC2DF10 
X-CRM114-Status: GOOD (  20.50  )
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

On Wed, May 26, 2021 at 10:47:13PM +0800, Kai-Heng Feng wrote:
> On Wed, May 26, 2021 at 10:28 PM Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, May 26, 2021 at 10:21:59PM +0800, Kai-Heng Feng wrote:
> > > To be fair, resuming the NVMe from D3hot is much slower than keep it
> > > at D0, which gives us a faster s2idle resume time. And now AMD also
> > > requires s2idle on their latest laptops.
> >
> > We'd much prefer to use it, but due to the broken platforms we can't
> > unfortunately.
> >
> > > And it's more like NVMe controllers don't respect PCI D3hot.
> >
> > What do you mean with that?
> 
> Originally, we found that under s2idle, most NVMe controllers caused
> substantially more power if D3hot was used.
> We were told by all the major NVMe vendors that D3hot is not
> supported. 

What is this supposed to mean?  PCIe r5.0, sec 5.3.1, says

  All Functions must support the D0 and D3 states (both D3Hot and D3Cold).

Since D3hot is required for all functions, I don't think there is a
standard way to discover whether D3hot is supported.  The PM
Capability (sec 7.5.2.1) has D1_Support and D2_Support bits, but no
D3_Support bit.

Are the vendors just saying "sorry, our devices don't conform to the
spec"?

If what you really mean is "D3hot is supported and it works, but it
consumes more power than expected, or the D3hot->D0 transition takes
longer than expected," that's a totally different thing, and you should
say *that*.

Bjorn

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
