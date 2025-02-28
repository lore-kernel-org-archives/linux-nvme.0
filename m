Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A982BC282C5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 22:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W+vpdJlz+Ayxg970NuUfVJQSG3DAOWCzjnYY3uAXGZA=; b=Af0I6BuzHO36G8UFMn0VOGQGXy
	ZjsvKkkhsuOwQ+tHfzkydCYZwNaEJhB9fey+pz0V1kNtPrnQ1QdbLsZruyZ0wg6vOq7kBXyAppvFp
	do6gkpUjeLmMs0jftK71ZBrS7BDQv1mWAD2+Y2A58cQeylaKcmU+yqIlR5Vb6jNuWFy6zhrVWcal3
	gIMTuXOJNdRYGoUfONhrO6qCe9AaIS27NG/jnxI0acSyLFH08hA+wugKgeg/qB/2a2Omj/6L9A5qI
	JyzDfUvNEXPk1KlymxD/tSnmkeCRLpzrfOED5MmTJWYmgwNNNhigNSGgpHWTUTMH2LRbKeFjIi9GX
	bm8OcYxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1to92w-0000000CtCC-1YXp;
	Fri, 28 Feb 2025 22:41:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1to92u-0000000CtBd-1VTO
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 22:41:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C234A5C6992;
	Fri, 28 Feb 2025 22:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07D5C4CED6;
	Fri, 28 Feb 2025 22:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740782487;
	bh=hzK747d92ouJu/Pb2dMYkMI9shLcqknZwqwwHfWrsjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p/8gLqSPfZk6AChbiCG3fatuwp/obW1EQt/yPGMOUA/x5XaOphUxxrKxTSlWXh5kS
	 8oKJAneB2CpFXJPcbOOA4UKqN4bCf9J9x2JdRWjyg8jqzSymm7mBumvFF3uFkPm7Da
	 CjC6te0/UwWSQoQcMD6G1/DA8XtIinnVpwhv2og9d+M5nePZddAGZBe2vHaCz+rDvP
	 F80CijeezrKW5nWJe8LjHOv/8AXYzUYhwiY/Tdy0kc9QVCTdppGYv7n/h1AMITzHfc
	 ooaED6KHwm5xZ8N8nlBG6B5/oyhS93mhpyp4q3bGJZVMGj4bUXQSx5Ds6++S1pDRpO
	 QokU2CQVd8B4Q==
Date: Fri, 28 Feb 2025 15:41:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv15 00/10] nvme: implement secure concatenation
Message-ID: <Z8I7lA76zuE3LSm8@kbusch-mbp>
References: <20250224123818.42218-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_144128_452763_474A1515 
X-CRM114-Status: GOOD (  15.67  )
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

On Mon, Feb 24, 2025 at 01:38:08PM +0100, Hannes Reinecke wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Hi all,
> 
> here's my attempt to implement secure concatenation for NVMe-of TCP
> as outlined in TP8018 / NVMe Base Spec v2.1.
> The original (v5) patchset had been split in two, the first part of
> which has already been merged with nvme-6.11, and this is the second part
> which actually implements secure concatenation.
> 
> Secure concatenation means that a TLS PSK is generated from the key
> material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
> is then used for a subsequent TLS connection.
> With NVMe v2.1 the connection has to be reset after DH-HMAC-CHAP
> negotiation, and the new connection can then be started with TLS
> encryption using the generated TLS PSK.
> 
> To implement that Sagi came up with the idea to directly reset the
> admin queue once the DH-CHAP negotiation has completed; that way
> it will be transparent to the upper layers and we don't have to
> worry about exposing queues which should not be used.

Queued up in nvme-6.15, thanks.

