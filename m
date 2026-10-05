Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AA2CA9EC8
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SmEheTWh0J3/BQpX78BoIhroKKmwa4bnJ1PAI32f3F8=; b=2zymZDR2OKg6VfDunztMSAHU2W
	OGjvDtd2qXX9Zw6Z/I4yfuD9zno2MeRvXB83REn6pkJ1K1b/GH2Fe9X7/mvitEyY0bNEHVsdjdVPc
	ADyl1jMiOfOpab7MYU5HxTGDw0V/b7uogcFOnIvMeIrQlTf2UAeHSnobz6FFDBe2dXIQUqGGx/v9s
	mcDlisln/aKDju3MTjMhOy96BE2LY29Z8UIHmUhliPy/gMHCiOGIHVUNhuN+8pPWVhfOW9VUAtRS+
	5L/5ixzeND2fCDwn7v5QrSEHrMIhZ5Z/eqeRb02yjBIT6nTHNnGfxZ4OjJFbmr6I2gl3KahS4NLtP
	x8cVEuKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDta-00000006hUS-0H33;
	Fri, 09 Oct 2026 16:56:34 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDs8M-0000000HKht-0SrR
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 23:30:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6DC1443C28;
	Mon,  5 Oct 2026 23:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452681F000FF;
	Mon,  5 Oct 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791243013;
	bh=SmEheTWh0J3/BQpX78BoIhroKKmwa4bnJ1PAI32f3F8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QowSKdTglffOCMECbjuqpAMyBjSXe0IwVe2eeCPRlbiPFr8CUDY2rnL5/c0wwX+u2
	 FK6woTdZrstoZC0cokzBWn1TFSI1m8PNX3EaxwdhSw7YKX6W/HJdK16A0vEFMupZF5
	 xygIzUXPVlc8yi1qcvJt/uri3Uzz3xNJolOxe+4VqU7nhzJbS0kPUjJaEsKvIR5EPP
	 pn3qbFkaAQI68vdXFigt/222laEsF0AJ8H0H2YMIoyMLv8jJLRzvhhbQBUnawfKlEW
	 gC0f8trnGlCXpLbQVNG8/W35ZRw1rCfB6IdkoZ9YFj5CMcD8u6ghZAZBCG/wIzu+IG
	 +KZdLHtzzZZow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A23A392667F;
	Mon,  5 Oct 2026 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next 0/9] tcp: avoid struct socket cache line miss
 in
 tcp_check_space()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <179124301177.1937173.6611394010312791388.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:30:11 +0000
References: <20260929071743.23624-1-edumazet@kernel.org>
In-Reply-To: <20260929071743.23624-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, edumazet@google.com,
 netdev@vger.kernel.org, aahringo@redhat.com, teigland@redhat.com,
 gfs2@lists.linux.dev, john.fastabend@gmail.com, jakub@cloudflare.com,
 sd@queasysnail.net, jiayuan.chen@linux.dev, matttbe@kernel.org,
 martineau@kernel.org, geliang@kernel.org, mptcp@lists.linux.dev,
 guwen@linux.alibaba.com, dust.li@linux.alibaba.com,
 alibuda@linux.alibaba.com, cel@kernel.org, jlayton@kernel.org,
 neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com,
 trondmy@kernel.org, anna@kernel.org, linux-nfs@vger.kernel.org,
 achender@kernel.org, rds-devel@oss.oracle.com, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com, axboe@kernel.dk,
 drbd-dev@lists.linux.dev, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 kch@nvidia.com, linux-nvme@lists.infradead.org, idryomov@gmail.com,
 amarkuze@redhat.com, slava@dubeyko.com, ceph-devel@vger.kernel.org
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 07:17:34 +0000 you wrote:
> tcp_check_space() is called on every incoming ACK and every transmitted
> packet, and tests SOCK_NOSPACE in sk->sk_socket->flags.  Because struct
> socket lives in its own cache line and the TCP fast paths do not touch
> it for anything else, that test pulls in an extra cache line that is
> cold when the working set of active sockets is large.
> 
> This series mirrors SOCK_NOSPACE into a new u8 field, tp->tcp_nospace,
> placed right after tp->chrono_type in the tcp_sock_write_tx cache line
> group (fitting in an existing 3-byte hole before chrono_start, so no
> other field moves and sizeof(struct tcp_sock) is unchanged).  Both the
> transmit and ACK fast paths already touch that cache line, making the
> fast-path test in tcp_check_space() free of extra cache misses while
> keeping __tcp_check_space() authoritative on SOCK_NOSPACE.
> 
> [...]

Here is the summary with links:
  - [v3,net-next,1/9] dlm: fix send buffer backpressure handling
    https://git.kernel.org/netdev/net-next/c/e234d7625598
  - [v3,net-next,2/9] net: add sk_set_nospace() and sk_clear_nospace()
    https://git.kernel.org/netdev/net-next/c/6ba48a271bdb
  - [v3,net-next,3/9] sunrpc: use sk_set_nospace() and sk_clear_nospace()
    https://git.kernel.org/netdev/net-next/c/28613c4d4757
  - [v3,net-next,4/9] rds: use sk_set_nospace()
    https://git.kernel.org/netdev/net-next/c/b747807ccaf9
  - [v3,net-next,5/9] dlm: use sk_set_nospace() and sk_clear_nospace()
    https://git.kernel.org/netdev/net-next/c/0e0be63cb35d
  - [v3,net-next,6/9] drbd: use sk_set_nospace()
    https://git.kernel.org/netdev/net-next/c/24280d1d2832
  - [v3,net-next,7/9] nvme-tcp: use sk_clear_nospace()
    https://git.kernel.org/netdev/net-next/c/f80fa2ddfe95
  - [v3,net-next,8/9] libceph: use sk_clear_nospace()
    https://git.kernel.org/netdev/net-next/c/5181ac617537
  - [v3,net-next,9/9] tcp: add tp->tcp_nospace
    https://git.kernel.org/netdev/net-next/c/4eee6d58ad14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



