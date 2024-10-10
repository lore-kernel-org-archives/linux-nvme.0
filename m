Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7E0CF07BF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 08:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sKWJ3l4GiEI9DusGGHu2Cc0sXMNnncLY7avmubYGgFA=; b=b6xO2ZWo3e+KnIkX/INvCbe32b
	28YTlmbQ3cF2KnU3DPiLCuC2BifBBxHTRWVTUxxWh142FXmOtf1T0HblFJGxZDeWO63xLHrzTbKPb
	HuOE5QNO9FWYDTiLEZ2TxpDFj3UzjKaHSg8k0r/Pg7mpDjMsjIa+3DZhMnC7CywKcTgF9Eb1iYhe0
	87k1gfckNWlLyK29yNZbtBnrmuc/nYX5ywItvIY80Us7z7wUrCDMH24H31DfQNXL6ZAFODScQtn6i
	JgnkgkisQFpl6KFDEh6m0ybNKr7NvArMQzDDiKNi/dknnIQI14ZeF3rKdWxLJ3OWBoq2zga7JHkkn
	NmFYPdQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syoK1-0000000Bw7t-18Qy;
	Thu, 10 Oct 2024 08:14:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1synzn-0000000Bslc-08pR
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 07:54:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 15AD9227A8E; Thu, 10 Oct 2024 09:53:52 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:53:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>,
	dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/2] nvme: make independent ns identify default
Message-ID: <20241010075351.GA7525@lst.de>
References: <20241008145503.987195-1-m@bjorling.me> <20241008145503.987195-2-m@bjorling.me> <20241009074611.GB16181@lst.de> <ZwaZoJayzu6XZom1@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwaZoJayzu6XZom1@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_005403_246055_E5214332 
X-CRM114-Status: GOOD (  18.28  )
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

On Wed, Oct 09, 2024 at 08:56:32AM -0600, Keith Busch wrote:
> On Wed, Oct 09, 2024 at 09:46:11AM +0200, Christoph Hellwig wrote:
> > On Tue, Oct 08, 2024 at 04:55:02PM +0200, Matias Bjørling wrote:
> > > However, the independent namespace data structure
> > > is mandatory for devices that implement features from the 2.0+
> > > specification. Therefore, we can check this data structure first. If
> > > unavailable, retrieve the generic attributes from the NVM command set
> > > identify namespace data structure.
> > 
> > I'm not a huge fan of this.  For pre-2.0 controllers this means
> > we'll now send a command that will fail most of them time.  And for
> > all the cheap low-end consumer device I'm actually worried that they'll
> > get it wrong and break something.
> 
> We already send identify commands that we expect may break on pre-2.0
> controllers: the Identify NS Descriptor List.

Identify NS Descriptor List is mandatory starting with NVMe 1.3.  We only
issue it for 1.3 or if the controller advertises supporting multiple
command sets.


