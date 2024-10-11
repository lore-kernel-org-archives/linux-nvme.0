Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034F2CFC61B
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 08:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=18OkBArkbEtf68TANpSux0605ps3AgHao4TlfNjLWVk=; b=VuomiY+2S7ZD2LuxAFN9fE+Ydl
	XHYu7RMtR0ltsRD2ZQGLJGBIB6t+4DDOWUFXY4choS/LHimaAnFKNvZebQXHIbhXgLMG5fU/fYwiA
	D6WJ/UT73Gt+hUd3t35bCuLfrc6F8GmkSAe3yTtpE/TKEpQT77EqpFNxCotrrimOcOKdhU9L+h/7N
	903nephzmXrgkoW1p9H8UA9256lXe5NSM8ZGUBm1ncjYmp0jWcPfC9lzp7F/uqBaBGLVFD3dadNii
	u+hha+qE1vCKD2T7IINbOH45XXmaqfKeJOf/GnkbC5mu1RpvBhosv7w5OgFZ6vE8JiWF5OOD9JLVq
	34MHnjnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szAna-0000000Ff7m-1Pco;
	Fri, 11 Oct 2024 08:14:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szAnX-0000000Ff7H-26GN
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 08:14:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6310E227AB3; Fri, 11 Oct 2024 10:14:52 +0200 (CEST)
Date: Fri, 11 Oct 2024 10:14:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyugui@e16-tech.com,
	martin.petersen@oracle.com, hare@suse.de,
	Matias =?iso-8859-1?Q?Bj=F8rling?= <matias.bjorling@wdc.com>
Subject: Re: [PATCH 1/3 v2] nvme: make independent ns identify default
Message-ID: <20241011081452.GA3337@lst.de>
References: <20241010123951.1226105-1-m@bjorling.me> <20241010123951.1226105-2-m@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010123951.1226105-2-m@bjorling.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_011455_704074_BD652298 
X-CRM114-Status: GOOD (  13.22  )
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

On Thu, Oct 10, 2024 at 02:39:49PM +0200, Matias Bjørling wrote:
> From: Matias Bjørling <matias.bjorling@wdc.com>
> 
> The NVMe 2.0 specification adds an independent identify namespace
> data structure that contains generic attributes that apply to all
> namespace types. Some attributes carry over from the NVM command set
> identify namespace data structure, and others are new.
> 
> Currently, the data structure only considered when CRIMS is enabled or
> when the namespace type is key-value.
> 
> However, the independent namespace data structure
> is mandatory for devices that implement features from the 2.0+
> specification. Therefore, we can check this data structure first. If
> unavailable, retrieve the generic attributes from the NVM command set
> identify namespace data structure.

FYI, I still disagree with this for the same reason as before.
Assuming we're not really going to see hard drivers I'd be fine
with using it by default for 2.0 (or better even 2.1) by default.


