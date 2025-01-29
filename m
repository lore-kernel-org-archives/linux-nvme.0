Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE5CC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BhrRRn5LFueIgErKa4aNHztlX4iAnzv0g/GSKVTZQ0=; b=dRZRDD9uqf+apUmX7G2+0iitnL
	3K2Bjl8lp470nk982bDkp+23r8FEndU2ssTot5/tqnWSPX3jjNZYr1od26RJ32KN/1NBCySTDOchD
	kvca4A++OuQ0HvSoNkPy4u/ZPO1VsZZG870ojUfHgHTf6bto/6ZrFrS8gpC5YInk8kaR9Nm26v5iY
	0rqdoA6FMQMMZN1tJpDo1Yp0h8Pa+z24mPcVImvNnVxnBu30OV8hZd5UnvO4dfr06NMWLnve3gkud
	tIvul67IlcInvuVax/IYBZaeboVZ6BeOgNmDUWlVy2pH9QktYN0LRFmgXE3zO5qhMu366N1OizkP8
	nj4j6cJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdCQX-00000007ZKT-0xhF;
	Wed, 29 Jan 2025 18:04:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdCPc-00000007ZHh-15Eb
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 18:03:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 86A085C5D28;
	Wed, 29 Jan 2025 18:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0551C4CED1;
	Wed, 29 Jan 2025 18:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738173819;
	bh=fGp2xaP4mmstBrpG7VZNDHnMwJnBSocGcTWYaJO1KJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBYvsP4apvQaGb4Xg2vfMDOZ/XPXBr88G4C3rEeQPOCRI2VJyLHGyKwb2+5bxXMs2
	 Pewr2CSX167/UwDcMOdO+KWEJr5vE9K5EMZqAA4MbQdpjlM1uaYki+4FfGOl9eoVrF
	 4OCmJmeOXJS6SEzOaWaWZbVhZfwPjRfk6szaisl22/zS8UE/CrFr+SRvuZNoVvp+40
	 ewAm3ooOnzzk4D085+rD7eonV1dMxrAo2ZrbTbKBNdXVWTxrLJcQ9wjYMUiS0f0XbP
	 nlvDAJBOToR8bs6R6FY5sBi5OHnp/GJCUKu2YIRV/vWfITPsaDpp9DYXDRtTfaF5pB
	 3kTKJ1Hjq1HAg==
Date: Wed, 29 Jan 2025 11:03:36 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, josef@toxicpanda.com,
	dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <Z5pteC56jYBRDupP@kbusch-mbp>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com>
 <20250129140207.22718-1-joshi.k@samsung.com>
 <Z5pJGHAR7AWCC0T4@kbusch-mbp>
 <20250129154025.GA7047@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129154025.GA7047@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_100340_345520_D5C27806 
X-CRM114-Status: GOOD (  12.74  )
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

On Wed, Jan 29, 2025 at 04:40:25PM +0100, Christoph Hellwig wrote:
> > 
> > Another potential benefit: if the device does the checksum, then I think
> > btrfs could avoid the stable page writeback overhead and let the
> > contents be changable all the way until it goes out on the wire.
> 
> If the device generates the checksum (aka DIF insert) that problem goes
> away.  But we also lose integrity protection over the wire, which would
> be unfortunate.

If the "wire" is only PCIe, I don't see why it matters. What kind of
wire corruption gets undetected by the protocol's encoding and LCRC that
would get caught by the host's CRC payload?

