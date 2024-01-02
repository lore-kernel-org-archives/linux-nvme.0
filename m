Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB2AC46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rjhtxx2Tx2QBCh6ClpJGsz5HBDYQfGq994uUdNepEUY=; b=OgifWXzuhAfWRA32sInRIeCWqT
	tNpv3pVqrWd6t+7TtqQDGBRlK+/nKWKL/KJxtlMJDUDAhshtBassW+R1De/dImDED22+1mTSwzxhM
	dWP7vZCVUfQh/ACFtl/gTYP3BPtYbbhnp4NCZVtJD731exv03oAHkfdzv8jhgRZsITAdhdRdUjuir
	xV0njbjmoSp8jsZc34qNxMHKwjYgrGVpNBwiTfQee4WiDU740OvRum8GPv6DglJ33khdjA0TP1spV
	ddqqA7STNCXMmwDck/6LvnYw9bf/mr99sP92i53Df0b6etlrolr9YefufWLnsyo5D0pqqpT7gHfFB
	q2tWY/rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmEc-0092cC-16;
	Tue, 02 Jan 2024 21:23:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmEZ-0092bY-15
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:23:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6BF7661245;
	Tue,  2 Jan 2024 21:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BE4C433C8;
	Tue,  2 Jan 2024 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704230611;
	bh=VLXexuac711NYUOQz3egV0MDroo6y6cy6zZdEV3D4+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEK3mK3Yf7iqhf5JBRonpDKv5LUE/4qB8g+eRa+m1/1kee8/ze9PDDuQ3aAx37jdb
	 7bNsiiwMoJDd7zmOftJPwyM+CD1j2LtTmZawfTmX5BXlVIRpg1xC6tkLWVktLqCveO
	 DxCaZUtovtmh+NDt/Bv8CF5gQVrNKzZswF+lGOWwefYd2LllR7Kp4odqaTJOjTz/aq
	 S6kzc6zVMCnjwwT4k0Kcfs5HjTlIo3agVEceKP/SU6CiCsCt3kyW3S1Bpz+CRMwklE
	 IP9V9DtUq8ZK8Cw0kML0wSRcJzyI7lhfS/TBqCM/BOeM9uw8zTEcfN8rzy7CIGtrsB
	 JS3X2gWrNxY0g==
Date: Tue, 2 Jan 2024 14:23:28 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kch@nvidia.com, hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix a missing endianess conversion in
 nvmet_tcp_try_peek_pdu
Message-ID: <ZZR-0Afl21Ft_sAx@kbusch-mbp.dhcp.thefacebook.com>
References: <20231226081329.180017-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226081329.180017-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_132335_429964_71776E47 
X-CRM114-Status: UNSURE (   9.12  )
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

On Tue, Dec 26, 2023 at 08:13:29AM +0000, Christoph Hellwig wrote:
> No, a __le32 cast doesn't magically byteswap on big-endian systems..
> 
> Fixes: 70525e5d82f6 ("nvmet-tcp: peek icreq before starting TLS")

Thanks, applied to nvme-6.8.

