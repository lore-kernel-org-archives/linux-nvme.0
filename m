Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B50C021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 22:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YUu6RIhyHTnqhUYX8cihMiaR6Pe8SQ1UERqGEfJjcaw=; b=mqmEgVV9Tor8s5muyiSyEJoIIe
	4UveLAOSMyX2L3zqVo18SWLHCUfnQ0NYtm3RJ4/QHuHn/EoLHPjJ/AVFS2v9nhuMVLLxnQlHk4Mo2
	duCIPEVu950PYWMPmnH+i3t7VYp9FhHEFc5J/cyoZOIAZ1DSNWJoBSUaiAc9A1QtnXDD1yKDy+0lz
	KWhG5irVlr6IF2pRq4Bh2nn1GO/ise0/hglgM0qQgsQgKIJKFeP2n0lkmhq8yqjVWfyCiC+cvR8fm
	5VG3Cd+H+lYdZcues99Dj04b29W8YIb0nrAHuYUSyKmMu36OgOEsH7DUF2httmX33IiezycjsoFye
	xP6Z+07g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhF0-0000000FPeL-3NNl;
	Mon, 24 Feb 2025 22:47:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmhEx-0000000FPds-3B7d
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 22:47:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3A2C55C5510;
	Mon, 24 Feb 2025 22:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A808CC4CED6;
	Mon, 24 Feb 2025 22:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740437271;
	bh=wMIvLbJfNQQSTTOirQXS5/ZivIl0Tf5lw4VoR7IEIXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJsDvnncd0YreqRgTlv4bKPNhnv04I/We6HiY5S52MbmuzwfA4V7RMvboH39ZwJln
	 mjwGXbLd4WPRXr6YlmEFMEarUUAmqslhh3Gv0nPizsXR6/T7y8QhIzutFzNSCM+FyJ
	 BCnnEU4XzRhMdQjK2mYNmhkdgzGIGbsHgbdve5AfWuV2kJZ4Txd3Zo+tdq1lyn5kk0
	 dfU0Uo8vd7mhoQv6PaY9B6U2q0KxmMlFedWKpy7ws4Tgccj4CeYS1L7KhqEpWEJlqy
	 O1Aw/ie3TQhEnQxoC/62th/0kPYUMl5goms35lKr3lRGVfKwErqDfI4H72NPvoldvi
	 8cY1Wrb/2oRYA==
Date: Mon, 24 Feb 2025 15:47:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH 2/6] nvme-ioctl: use common type for user data addresses
Message-ID: <Z7z3FZJxLekOpgyZ@kbusch-mbp>
References: <20250224182128.2042061-1-kbusch@meta.com>
 <20250224182128.2042061-3-kbusch@meta.com>
 <20250224223053.GA15518@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224223053.GA15518@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_144755_853976_CC164FEB 
X-CRM114-Status: GOOD (  14.65  )
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

On Mon, Feb 24, 2025 at 11:30:53PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 24, 2025 at 10:21:24AM -0800, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The data type is represented as a u64, but the metadata type as a __user
> > void *. These two fields represent the same thing, so treating them so
> > differently looks a bit odd. Just pick one consistent type of
> > representation.
> 
> Yes, being consistent is good.  I would normally propagate the
> proper pointer type as far as possible, but I can live with this
> version if you add a little blurb why it's preferable.

I have a reason, but it's not very good :)

I settled on u64 simply because that's how 'struct nvme_uring_data'
represents both, so it makes for a tiny bit less churn in later patches. 

