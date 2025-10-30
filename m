Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F2CCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 22:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=6y1DtOnUkkgbVC/5kHS8ZeSezTrdv+/yVDVmDI+u+U8=; b=T6zjcXH7J7lBky
	+uxCqgxnDrHcCD3MQol1G5fG84FLpHp+aAZivBpQGBF6QVe2EDvenHPb6mXGq05PFmYOvBrbV4O2A
	oYlU+5F9zDn8LSSlv8HogR4BHUslZYCX9wwoFQKwJVLmbJwCepP5rm6XG6J45Pu28M/NfinxEEfe8
	2tpnY8jokCwI7wzJB74ZBJLQaPkd8cqaLC3ei7yUM2Esa3QevPOdnsr2Q988tkJ1pWp929e4m35VB
	tqf/o9+n0O74tnFZ877YfreDCrPrII6zW4tXsNE+qxyZbl7RVPsxX9yY2fXSM4YPxhuGS5WM5RwKC
	3d96nEHiYRJR46sQmOIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEb3H-0000000541Y-29dk;
	Thu, 30 Oct 2025 22:23:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEb3E-0000000541E-1c4A
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 22:23:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C03A24098C;
	Thu, 30 Oct 2025 22:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8094EC4CEF1;
	Thu, 30 Oct 2025 22:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761863003;
	bh=xG2I5vm7TB6tFU8dWnjN4R78M2qniumUpAN/EjStLCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hLSa9hrG5NYgAOb4NMZteW6MCeCMDiv16bI7WfM/rJn+8HmT3QshvlFe+usWRQL5t
	 y00Y/99kynsQc9bvWby5278iQhsbjqWf6SvmLiS1caiX1MbmzVCyx4HI8DsAd6WlJj
	 zsnozS+yFlmdFc1WIZ5UWwCRoQNrgG4Ze91AxD4QQA6kgdZHJth56IjJiWFBNg1Bpp
	 JHxqb3kSadWXm1h8+/BwsjnwLg5PiF935ggyvqVjxGdWUMUhQ50ZwYwQ+oU3Q/orsz
	 WbS0ypWR6zonFoDssFC/wQIMSU+xEPXJs/B9X42zwrqEqBw6mlOcXSVddO177Nyc/g
	 h5GNNjGJzeFkg==
Date: Thu, 30 Oct 2025 17:23:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Genes Lists <lists@sapience.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: mainline boot fail nvme/block? [BISECTED]
Message-ID: <20251030222322.GA1656973@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3152ca947e89ee37264b90c422e77bb0e3d575b9.camel@sapience.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_152324_463474_27DACF6B 
X-CRM114-Status: UNSURE (   9.59  )
X-CRM114-Notice: Please train this message.
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

On Fri, Oct 10, 2025 at 07:49:34PM -0400, Genes Lists wrote:
> On Fri, 2025-10-10 at 08:54 -0600, Jens Axboe wrote:
> > On 10/10/25 8:29 AM, Genes Lists wrote:
> > > Mainline fails to boot - 6.17.1 works fine.
> > > Same kernel on an older laptop without any nvme works just fine.
> ...

> Bisect landed here. (cc linux-pci@vger.kernel.org)
> 
> 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b is the first bad commit
> commit 54f45a30c0d0153d2be091ba2d683ab6db6d1d5b (HEAD)
> Author: Inochi Amaoto <inochiama@gmail.com>
> Date:   Thu Aug 14 07:28:32 2025 +0800
> 
>     PCI/MSI: Add startup/shutdown for per device domains

#regzbot report: https://lore.kernel.org/r/4b392af8847cc19720ffcd53865f60ab3edc56b3.camel@sapience.com
#regzbot introduced: 54f45a30c0d0
#regzbot fix: e433110eb5bf

54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
e433110eb5bf ("PCI: vmd: Override irq_startup()/irq_shutdown() in vmd_init_dev_msi_info()")

