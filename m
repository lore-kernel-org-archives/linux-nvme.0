Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2462CED61E
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2024 07:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8NlHwPmg4tV6goTP1ZCS1Nr5rTkRmVdZGHau9A5YtE=; b=sfiS4ME59/hXYmT+P9aq34QIkF
	1CblS0BWJZnxX2HdeU0Z3rW0gFD007FtdbTSoKJrxR9AQCTulQP3zm2bzQ+4SgXgXzRXJ56Bs3kvx
	v/GZDn14zPybwpJLQRRNy83qIyVCW6R7ZAhSNaatExditGde5uU/WH0blnxrxwFx9+91oGMPXB3Ni
	gslMkdNcyz/E1fPSCYKbQpz770MGpTKetYsnvANPMAnEeFg1BTLchqx9HiEKbMAR4GGwIg1aQKmaw
	E0vo5fcQ2dVidLUSgD2Z9MDfxMWSTJFjgmfNgeAJfMUHegaakxwHpkN128x+48cKSDsI07+iL6y9N
	4OC/nhKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syRYg-00000008KXl-1ogD;
	Wed, 09 Oct 2024 07:56:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syROh-00000008IhF-2Cz2
	for linux-nvme@lists.infradead.org;
	Wed, 09 Oct 2024 07:46:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45002227A8E; Wed,  9 Oct 2024 09:46:12 +0200 (CEST)
Date: Wed, 9 Oct 2024 09:46:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <20241009074611.GB16181@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-2-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241008145503.987195-2-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_004615_729598_527095A9 
X-CRM114-Status: GOOD (  10.41  )
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

On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> However, the independent namespace data structure
> is mandatory for devices that implement features from the 2.0+
> specification. Therefore, we can check this data structure first. If
> unavailable, retrieve the generic attributes from the NVM command set
> identify namespace data structure.

I'm not a huge fan of this.  For pre-2.0 controllers this means
we'll now send a command that will fail most of them time.  And for
all the cheap low-end consumer device I'm actually worried that they'll
get it wrong and break something.


