Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA12C001E0
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 23:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RH8Ah2Uni31h/fiwXRtVt9sVeTu7zxw4EJxO1ICw+kk=; b=URa2Q1k1EaElOZVDo/Qm+o3cay
	6TF9hQLJ/vJq1BmEVt39y9fWEslAvh6L9959V8GTiEUoO1ijDGjOmDdA0Tp12uKdT8XpYklj44Wp5
	LVoJAefCUDWh/D3ZFBwLbSzHhZ4fgp/9XnsZtk3Zpr2OFNmP2LKxt8ZiGC2stdlgW4eDXsmvEQK4y
	7vh29I5pMfvRHQRAZiFaoNB6khE/QfZ8n+rGGvUjXNNLU6mZKbXuB9RA6e2BBxiaOaKmmTrQA8GBj
	Z84JUdt1aC6oelzX1MepmDkrx4gYT37EyjtzdYtiOUbpd+pSiBiTgrQjULyWvlaPP5gXBK+svwf/Z
	vk6Hw8vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTVgg-003c3w-1x;
	Tue, 08 Aug 2023 23:00:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTVge-003c3J-0v
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 23:00:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3E90F62E0E;
	Tue,  8 Aug 2023 23:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27924C433CB;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535622;
	bh=+3PAhwcO5SkftV4Z9RzQcn0DU4daMBjo3PN9QdcSRoo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CLLVovkMCLtAJvaacutreZ2MMuycBuoiTlUHbPfRTS8aod/RqX8WHbQBc6raLrbzs
	 H8bDYzNykmtQ6WKyn70lo2bzJYCC8rW9jno/ylZT3/AzaAuUcZm2pYubVHahdNIBt1
	 nie1CvfUqQObbS86N6zkFz98ItnjDluz8IwUFK3TbHKbLmJ3BJmmJYN+gnmRzd8D22
	 95YqnYQ73K0xOhLiYj8KybI43I3C87wNkv1LvHljtXTjt7WCUGHcUc0DBbcc3EtmsJ
	 T6bnx+An85XW9z6F3olBX2h63woCC9yzKk458y3S9HmMCAE+CkUVvtjnZegil/aA4S
	 W0PEYKdlOL9pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08DCCC64459;
	Tue,  8 Aug 2023 23:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169153562203.6878.1667103889649969774.git-patchwork-notify@kernel.org>
Date: Tue, 08 Aug 2023 23:00:22 +0000
References: <20230807071022.10091-1-hare@suse.de>
In-Reply-To: <20230807071022.10091-1-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_160024_386180_3FF3C934 
X-CRM114-Status: UNSURE (   9.99  )
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

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Aug 2023 09:10:22 +0200 you wrote:
> When flushing the backlog after decoding a record we don't really
> know how much data the caller want us to evaluate, so use INT_MAX
> and 0 as arguments to tls_read_flush_backlog() to ensure we flush
> at 128k of data. Otherwise we might be reading too much data and
> trigger a TCP window full.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> 
> [...]

Here is the summary with links:
  - [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
    https://git.kernel.org/netdev/net-next/c/ba4a734e1aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



