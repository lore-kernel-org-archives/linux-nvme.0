Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0736CAC597
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Sep 2025 21:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BzUcY/wkafkCK6O3HS7reHyYdllw7Y0C2e1XfuwcHWU=; b=vkbQwAhqi9sAokdc9oN6a9r22V
	Fd0l8BVSEg+JTmVILp3ddY3x0TqITzdSQogrft7/ypHYr0tViQuSAN+gQotCNc/1CVAg86ycPMxbN
	6cvRE4LUs+VaYsBT7vOjlNDRbndfUx+GIyxggFFG5Dt/FQf4Py8i0719qXndVM8NFtaiXD3MP4N1o
	XZ+77aKjBbwOw5x4jLw15JwVlyKqnrqkoQwxZeGxUDiZcEiuY5CpZUWjBaXkDPn0NK2OU34/xmd+e
	Hx72jnf5jBjeorV5Lkjv3FVX6sKWqEA6ApP2Rt8FXQwblwsytj23O5R1pIoPLk9oVbeH/OuZNQND8
	dR9GlPjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyH2G-00000005jNM-3u4b;
	Mon, 15 Sep 2025 21:46:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyH2E-00000005jMo-2MnI
	for linux-nvme@lists.infradead.org;
	Mon, 15 Sep 2025 21:46:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C616944168;
	Mon, 15 Sep 2025 21:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD04C4CEF1;
	Mon, 15 Sep 2025 21:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757972813;
	bh=D9jfoYbyApINAB7D0xsIHvhQDmuv3Id/XROTByhTTos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZYLHroJgZiBKoAKKM2DNo0gpnT7Cb4/o0sE3e/ou2L5J6r+k408b3ij0UlBrGW03H
	 yQhKpBXc7pO8kBJ8HnEv31n0y7FKDWZMkvLi89IZhh1fAq/4LxyAO0sCpskKKvWcsq
	 /UmuxU4VFUliUMrCCfNZ2Op3E9iDknviVZ0kpAoHATaumVU6Ra3BkJG6UvxDlUxBrN
	 Xz2AjaosFPxtm5SLbVn9xStDl81ceXMaQjVZO4Td7uwTwK3mKJmA87r8ciRHQpeEeK
	 paFXxuNg3FTjDpQN48+wIVfPmZLX7kZGc3J58OfszpO8Id7jVz3my8+Dmmgfl2HGT8
	 FBnOMKzKVJGdQ==
Date: Mon, 15 Sep 2025 14:46:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Olga Kornievskaia <aglo@umich.edu>, Olga Kornievskaia
 <okorniev@redhat.com>, chuck.lever@oracle.com, jlayton@kernel.org,
 trondmy@hammerspace.com, anna.schumaker@oracle.com, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, neil@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com, hare@suse.de, horms@kernel.org
Subject: Re: [PATCH v2 3/4] nvmet-tcp: fix handling of tls alerts
Message-ID: <20250915144651.7bec7ad4@kernel.org>
In-Reply-To: <aMg0jDkXOd8E7Ihj@kbusch-mbp>
References: <20250731180058.4669-1-okorniev@redhat.com>
	<20250731180058.4669-4-okorniev@redhat.com>
	<CAN-5tyF=5oQLyy7ikbbhFW10OrUfHh0Sr3D=G1nHN+pEsfiSzw@mail.gmail.com>
	<aMg0jDkXOd8E7Ihj@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_144654_630774_AA1D5976 
X-CRM114-Status: GOOD (  12.48  )
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

On Mon, 15 Sep 2025 09:45:16 -0600 Keith Busch wrote:
> On Fri, Sep 05, 2025 at 12:10:21PM -0400, Olga Kornievskaia wrote:
> > Dear NvME maintainers,
> > 
> > Are there objections to this patch? What's the path forward to
> > including it in the nvme code.  
> 
> Sorry for the delay here. This series is mostly outside the nvme driver,
> so we need at least need an Ack from the networking folks if we're going
> to take this through the nvme tree.

In case you decide to take it, LGTM:

Acked-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

