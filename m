Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139F3E6F08E
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IeWJWhtQhjcxQr4A9iIy5+M/sXKM43wi4WaU7WOmfsE=; b=YQ9T0XA7DDVp0wPrrnOX0RT+e2
	T5Pf5ewXxJ3t08bD0wlS3HSgjtFz87ZuRBelQU3b9Un6XhpaOwh87hnvvyqj1WptXxI0/OAiz9zMN
	XIH/C3Q4q3mYkBRHByNEAG3RXAcUKC3f5Vm2N8/rlCHpwvqRgcWemkTFkPIw+o+r4hfzVC2+9fhJ0
	+eQrY/tn5xslu8P9Bw3sX2DeeqPobSJAawTPT/omQKkhJUsEwOoUGcoZcYDBaHvLIOQSgON/ic6Gh
	cW0X1iCYdoCq7jHsfmk+uXcxGX22g768/o53LBgpyX9CQJOl4NfXmkYjYGjRJ1FYANzA1ZAzQSa69
	iQWrzxXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t70OT-00000008Tt8-2MBF;
	Fri, 01 Nov 2024 22:45:25 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t70OQ-00000008TsL-0wrN
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 22:45:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A86C4A44CE8;
	Fri,  1 Nov 2024 22:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF66C4CECD;
	Fri,  1 Nov 2024 22:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730501120;
	bh=SkEop5/7smK/MSZYAFqBhRctwlHKaIbrZmOShSAg2a0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dV+DKEI59gzZ7vZ7g6rBWuQ1pBC9BQ08cUWOFgV3rDETROWtZj37bpVQ+IrFlJQdn
	 GS3Wv9smC4PbSHUvCy4oQiCvCiOBoIRoOlNDH7gSRHbDTKni9PPkfw2lBuLY6WOdqd
	 mN2K0Vkf0OWXAdqG+vOscXlNzoPwGGzbqJ1nSWffsAwzA6BrlvrUz+ymq/k9salvOR
	 waad78D/rW6fAjLj0KcvNxoDF4IWZJ6uJp31m3Qs4Bg1Rt22BggwfY7eeCCC5J3x7V
	 lRCqfH8VBEqLXOHDdy7kJplF5eqkVn/bX/KZjYHwqiD8GSSi5axArTyj3Va7whKyG1
	 ad1ZgyE9IsHhw==
Date: Fri, 1 Nov 2024 16:45:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>, dlemoal@kernel.org,
	cassel@kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	wangyugui@e16-tech.com, martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <ZyVZ_T4HtnqSWTm0@kbusch-mbp.dhcp.thefacebook.com>
References: <20241010123951.1226105-1-m@bjorling.me>
 <20241010123951.1226105-2-m@bjorling.me>
 <20241011081452.GA3337@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011081452.GA3337@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_154522_355352_C2F163CB 
X-CRM114-Status: GOOD (  17.94  )
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

On Fri, Oct 11, 2024 at 10:14:52AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bjørling wrote:
> > From: Matias Bjørling <matias.bjorling@wdc.com>
> > 
> > The NVMe 2.0 specification adds an independent identify namespace
> > data structure that contains generic attributes that apply to all
> > namespace types. Some attributes carry over from the NVM command set
> > identify namespace data structure, and others are new.
> > 
> > Currently, the data structure only considered when CRIMS is enabled or
> > when the namespace type is key-value.
> > 
> > However, the independent namespace data structure
> > is mandatory for devices that implement features from the 2.0+
> > specification. Therefore, we can check this data structure first. If
> > unavailable, retrieve the generic attributes from the NVM command set
> > identify namespace data structure.
> 
> FYI, I still disagree with this for the same reason as before.
> Assuming we're not really going to see hard drivers I'd be fine
> with using it by default for 2.0 (or better even 2.1) by default.

I've got the rest of the required logs and identifications implemented
in nvmet to support this. There's one more issue, though, if we do
restrict the identify to >= 2.0 or 2.1. nvmet reports 1.3, and I suspect
there's a bit more work than just changing the value of NVMET_DEFAULT_VS
in order to comply with claiming that version.

