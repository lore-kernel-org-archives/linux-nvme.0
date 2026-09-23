Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48788C98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 00:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0ozVqhfvrckFmMoctVk48Vngujn2pQPCuaFxfX6BfM=; b=vQpb4ZwXaHxWlDZBaG2FPhrrMA
	tnn/79ENHNkyko4ny5jxNtzRq5NGnWaqchz4wLU/B83RPAaSJbmNJp+58a1THLODLhvAsyFWLYIdh
	0Yj373N5a/mj7x+6nwNw1datRqLkxNeAiYIbaX4QMyR1lllHGmRF4Rpg36SuXFCN5/zInOfaEAdyq
	/uWTQfdEi4/vSIFYvaWP2hkAXk/yoWsjpBhhg3yFHHzw/yNaaLWMlVQ/7l9SyBvdMvm5BOGtt3ade
	3SFcsdbJH6bSeNbixS2YyMHhkAWtTicsTLMSG8ky1a+vD6Z0ZMAzBMefrpDR9V+46JE5Nj0g6IW+V
	BLClkmEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9BI7-00000006ovL-1Scj;
	Wed, 23 Sep 2026 00:56:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9BI6-00000006ovF-0Tpq
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 00:56:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4CF97601F0;
	Wed, 23 Sep 2026 00:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC331F000FF;
	Wed, 23 Sep 2026 00:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790125013;
	bh=o0ozVqhfvrckFmMoctVk48Vngujn2pQPCuaFxfX6BfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U1dbpVR7ZZ+zsTPe13TuViU+GZKu1eMjkdJxpCBNKWtOpkYxRspLYXSK8jYwWVHyC
	 EjYJU/oG9UVI1I36ABJqgaE36G3XNHHJ6Y7TskEtcS/nCb6VoWhZp+GHh3JPjIu+8k
	 J8nTxtdp85dd3jSqwu88YwyzI04O6FNhiDIMy5GmNj+qvvS7dEQsLj6GLuFOAcphLr
	 nostbWOhjWpJq0+CAcNGDfu5tUG7th6wV/WvKV4S93PT6D3StwBCDaDSPsR2qKtCmR
	 f6GhCXc1EPKkupuou9V3W25Z/Vpk1RNWo7BpfRjCyWG3PVtqVLujOQis3vmYfGZJim
	 p0MWBzT/Wi/hg==
Date: Tue, 22 Sep 2026 17:56:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Sabrina
 Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org, Martin Belanger
 <martin.belanger@dell.com>
Subject: Re: [PATCH 2/2] tls: return a distinct error for control records
 from read_sock
Message-ID: <20260922175651.3ce5d18f@kernel.org>
In-Reply-To: <20260922133708.84522-3-hare@kernel.org>
References: <20260922133708.84522-1-hare@kernel.org>
	<20260922133708.84522-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 22 Sep 2026 15:37:08 +0200 Hannes Reinecke wrote:
> tls_sw_read_sock() leaves a non-data record on the receive list and
> returns -EINVAL. The same function returns -EINVAL when an sk_psock is
> attached, and an actor may return it for other reasons, so callers
> cannot determine whether a control record is waiting.
> 
> Return -EPROTO instead. The record can then be read with recvmsg()
> and a control buffer, which reports its type.

Please run the selftests.
-- 
pw-bot: cr

