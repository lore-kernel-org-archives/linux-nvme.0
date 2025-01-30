Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B96C0218A
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jan 2025 12:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ixTpACDj8tjLd6hwN2RxUR98AmMVrTJsn46slTquYI=; b=SPMlA3tYvEetqanbk/N6BIluCn
	TDVR7YbLMxeuXQD5lJyrnI5E8DLp69ECsKP9pynRhETgZ0qr4G/vucT8MKArpLROfOdnd1d1RFuR8
	prUdb/v5iPrD1bkBuz2Wusc4frbrxBFPYOudSBCQYP4omUEA/wzYtz5mfoNNAK3SsZ7AaCmSeNorm
	j0RTdwPTNqht/HO83LBxaNMCRCkTJDXRFSxTmB53uv5Mq2xH8oXpAFrqYGKAj3dhm58x2FdvYCjzF
	5rOCZDKu2fv3IO5+K8HXCMP343XiAcVgTwZXV9DzZrx6tMPIlydBPV1N8zw0mFD1w4fit/1xkX3Yv
	Q6ZYkOlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdU3x-00000008nZS-1qcI;
	Thu, 30 Jan 2025 12:54:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdU3v-00000008nYk-1Xtz
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jan 2025 12:54:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 70D0268C4E; Thu, 30 Jan 2025 13:54:21 +0100 (CET)
Date: Thu, 30 Jan 2025 13:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250130125421.GB19390@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <Z5pJGHAR7AWCC0T4@kbusch-mbp> <20250129154025.GA7047@lst.de> <Z5pteC56jYBRDupP@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5pteC56jYBRDupP@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_045427_548606_1618CA5F 
X-CRM114-Status: GOOD (  14.02  )
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

On Wed, Jan 29, 2025 at 11:03:36AM -0700, Keith Busch wrote:
> > away.  But we also lose integrity protection over the wire, which would
> > be unfortunate.
> 
> If the "wire" is only PCIe, I don't see why it matters. What kind of
> wire corruption gets undetected by the protocol's encoding and LCRC that
> would get caught by the host's CRC payload?

The "wire" could be anything.  And includes a little more than than
than the wire, like the entire host side driver stack and the device
data path between the phy and wherever in the stack the PI insert/strip
accelerator sits.

