Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D81FB519B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 05:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HMW7oetkt/E6ckNiJvJaQwGGXB0LLR7vtEG9qN+vPi4=; b=LdAKHCX4qRyluhwixpGkA1zlMi
	45rbAbOGAqq8cmCNqzLXxOsn+py0KcUpqEgJCtacDIJY7r/tWqYQbmb8fduJFEyB9ooloYAQxkuxv
	ICisxAPUVeRDrp/IwTWFHDiB53jvLoNC05KF9+VijlW7vFNEgOwiGB68k4jNKaVuJR1H0wxjHwscx
	0zQNpiMHJu76wVDAm5z+8bJ5pTSZ3ZhPo/vCjqqr4KVR7JNMfLl+Wc01apNloOWLYBlmR6s8y7p8W
	HfOcxNEA3nWS7s0vPqkTUgM8VB+4JM+Iq3plM59WMKQHwxRDGk6Y/51rtLJxb5xtKC9Hx5w37Zk5C
	Ttfvnmyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zOI-00000005x6u-3juH;
	Tue, 07 Apr 2026 05:54:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zOG-00000005x5y-0sNq
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 05:54:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0270868C4E; Tue,  7 Apr 2026 07:54:13 +0200 (CEST)
Date: Tue, 7 Apr 2026 07:54:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: expose TLS mode
Message-ID: <20260407055412.GB6405@lst.de>
References: <20260401-expose-tls-mode-v1-1-433a83d1d23f@kernel.org> <20260401140934.GD21703@lst.de> <ac373146-cf2d-47e0-a851-9c304bacd5f2@nitrogen.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac373146-cf2d-47e0-a851-9c304bacd5f2@nitrogen.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_225420_392223_A04C2ADA 
X-CRM114-Status: GOOD (  13.53  )
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

On Thu, Apr 02, 2026 at 08:42:57AM +0200, Daniel Wagner wrote:
> On Wed, Apr 01, 2026 at 04:09:34PM +0200, Christoph Hellwig wrote:
> > Looks fine to me with the example fixed.
> 
> BTW, do you think an empty string is better instead of "none" when TLS
> is off? 

Empty strings are confusing, so either none or off would be much
preferred. Out of the two none would be my slight preference.

