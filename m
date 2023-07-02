Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89976EB64D9
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Jul 2023 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uw4T7cj2BukkMspJJ4v60joeosn44hPLtpgFscdO0MI=; b=P8AHaw436V/aA4b/gCYA/cTy7f
	2ZHKI+6h27Jm+2nkYWpy5IqCDS5tEEnnVh9raFN7wqk3nyyPvROU8NBubBocpLnsJ4NdnYWHdFCDM
	Xmi+x5hIOX2ZdgT6Xvon8GRupaIbvBoPNn0YDFoWelEEgilNI5L7M7r9FDEYXz31/7HCLJRgfkA78
	DKIfXgqEJzwJ7eBRJgNsUa5/130cHlRuYPWUVW8KmIam6+aAiom0uqNAT4Pf6muNTQGU7a2hmkT7p
	1tRAcFwtCty4JMEbwnzDByVgonnctejLZIG8o032Mkj+g1FoBnTdByxTqWk9Em0aIKNfOJ/7WB45y
	ZSN4MWHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFyPD-007zy9-2u;
	Sun, 02 Jul 2023 14:50:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFyPB-007zxD-1D
	for linux-nvme@lists.infradead.org;
	Sun, 02 Jul 2023 14:50:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 764A660C23;
	Sun,  2 Jul 2023 14:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5681FC433CA;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688309422;
	bh=Wc0RhP4G/pv3DHMY2yfgseffeJ8g3oRRMSXqSu0WTd8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m/iVoT4b9DimYe1pRUw+So14f/kTqawakGnautvzHUMASOV6nrkKhHIWj5rxi/vOg
	 MZB+pAM6RyENU1+xrJluqfYWa6nMQu7um7oKGmzoDYgFhmfootIHuZzJBe2+ssOwQt
	 cxfoCG4R9yQ4mTKy87m/zFP8HJXEZJOvvXTc4a7+pkk1WTFrlNIlTF4TdVoztuYfEU
	 KQeSHHGOWbAYAYcCwHRvPoiBDNTcECjk7sDVFVCUWzDip0mcPry4kWS6W6z3MnQqZ6
	 f/5j0OMT/l4gyCqDcSy0Tg7+A/O393AfUQLPkuHcSed9KYAgvlDLnk1oEXd2fBRfkX
	 XdAhR/ruT8pag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D4A2C691F0;
	Sun,  2 Jul 2023 14:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] nvme-tcp: Fix comma-related oops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <168830942217.27441.11517289068592385502.git-patchwork-notify@kernel.org>
Date: Sun, 02 Jul 2023 14:50:22 +0000
References: <59062.1688075273@warthog.procyon.org.uk>
In-Reply-To: <59062.1688075273@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, aaptel@nvidia.com, sagi@grimberg.me,
 willemb@google.com, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 kch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, axboe@kernel.dk, willy@infradead.org,
 linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230702_075025_594794_3BB812C3 
X-CRM114-Status: GOOD (  11.31  )
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Jun 2023 22:47:53 +0100 you wrote:
> Fix a comma that should be a semicolon.  The comma is at the end of an
> if-body and thus makes the statement after (a bvec_set_page()) conditional
> too, resulting in an oops because we didn't fill out the bio_vec[]:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000008
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     ...
>     Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
>     RIP: 0010:skb_splice_from_iter+0xf1/0x370
>     ...
>     Call Trace:
>      tcp_sendmsg_locked+0x3a6/0xdd0
>      tcp_sendmsg+0x31/0x50
>      inet_sendmsg+0x47/0x80
>      sock_sendmsg+0x99/0xb0
>      nvme_tcp_try_send_data+0x149/0x490 [nvme_tcp]
>      nvme_tcp_try_send+0x1b7/0x300 [nvme_tcp]
>      nvme_tcp_io_work+0x40/0xc0 [nvme_tcp]
>      process_one_work+0x21c/0x430
>      worker_thread+0x54/0x3e0
>      kthread+0xf8/0x130
> 
> [...]

Here is the summary with links:
  - [net] nvme-tcp: Fix comma-related oops
    https://git.kernel.org/netdev/net/c/c97d3fb9e0e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



