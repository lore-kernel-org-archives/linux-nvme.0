Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5567C5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 17:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ttpey8e22bb5fjPsr4NHOCagFDyabQZULxmMJsRWVEk=; b=UZOcf5r2m75YWF3GMe75PA6zYN
	HW3bThQbhAKYYTn4LZGIKH+kM7fYdTJt8jJe7sCyo76eOju0fLGAlp3y2Z1qW8hRy9ajbm+Pk6dcC
	odpUjdUP5uZMORkLlvT2qZOD9ybLgHTtLEP4QE4ivSsSQn5tPDMGcZojYrmelUFaP84DMWiZdV1cu
	usTdTjBKOaGG/5YZM0+VlU5Ht2DTBlXmjBwSuNDhagDmQXOvR+jrj33ZIyJi+34Rxjy+L/07Wt7FX
	YGvGQ3zjRhAc/32ndHrMCBNIrKwXNHBMftOO+KCTa2e6n2/m+0QkNOzdRPImkYr4jGMPusWhD1YNE
	fmRYwIMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEvqk-002squ-Fi; Mon, 09 Jan 2023 17:22:18 +0000
Received: from pandora.armlinux.org.uk ([2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEvqb-002spv-TG
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 17:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ttpey8e22bb5fjPsr4NHOCagFDyabQZULxmMJsRWVEk=; b=wh3nA418Dq6VkqIOxQz0hD3Bg+
	UI1PyspgLd0sOmQD3x8BC2pBsfp+Y30jgWO8788opuSoHIZ0C33Kq4UQGwOSbRlr2EcGtN1BECsx4
	u3oNCLcY0EMNlIOX1frLUnjlbkpxNpqX00BLihFIqmj0E4ibcOyoLm4w2gO5gaQxs9zxLL37FhXzs
	m47JEM6Gx4kEuaqPq5/m+3nd0CwOHfLfkUAw4VDLnNxlIQmNMCxWaDW6/jlkQoFTwilCFM1Ho2qWQ
	dq10iuS/nrXV2RiaufA7jVlLHgU51YLnGqbaU226PctLkhoZHYinjiLEa93NmJBgy5nHtpsoD1BIw
	FImCkmuw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36026)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1pEvqS-0002ll-Ra; Mon, 09 Jan 2023 17:22:00 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1pEvqP-0007wy-Ug; Mon, 09 Jan 2023 17:21:57 +0000
Date: Mon, 9 Jan 2023 17:21:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
 <20230108170520.GA19739@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108170520.GA19739@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_092209_958910_33C97D04 
X-CRM114-Status: GOOD (  14.33  )
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

On Sun, Jan 08, 2023 at 06:05:20PM +0100, Christoph Hellwig wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0cccd40d7801..64cc6947099e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
> >  F:	drivers/nvme/host/
> >  F:	drivers/nvme/common/
> >  F:	include/linux/nvme*
> > +X:	include/linux/nvmem*
> 
> I think the proper thing to do would to just match the right files
> from the start:
> 
> F:	include/linux/nvme.h
> F:	include/linux/nvme-*.h
> 
> is it ok if I commit it with your original attributation with that
> change?

LGTM, thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!

