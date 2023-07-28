Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5898C001DC
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jul 2023 03:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZDMDbKXLYL8jqpFBC7pTP00nk+E49e1wvyThutgAn+g=; b=uKY3Y7/F5DYr5PpnQ3Z/2/lDWz
	DKxuytOsNDfYDjvk+kiMB6pxX14INue5eAAuGbeAqMuT0llqLrjtkPuYPODS/Erqo/6RaLUibS9G1
	7sGVuGJGNWMhmZ1VStR60AQFA0oeY971G/QDLEtwC/AgjPS06Z9QhVjod74t3AUbH1W0/SHF6JtcP
	j+J+8BNdOhVWJOBOf5u+xIf0sh+CAmUS9rI75u0xkp1Iil5VgG48y9t/iO+gKZk5p86Y25d8XJuxx
	TLrxrTB22GLF59DuenufVQtvUUCmCdsAdAy+KK/tJmpARAqWWYPLAwL58sunouPtriQeBrgRAnRy5
	SJ6MxCJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qPEBT-001SMm-2G;
	Fri, 28 Jul 2023 03:30:31 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qPEBQ-001SMK-0c
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jul 2023 03:30:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 43DDF61FC5;
	Fri, 28 Jul 2023 03:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96C35C433CD;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690515025;
	bh=wTuzCF2A7a5OUWovA3zFSSC0NTzx9ILvTXye72QKJ70=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXbFayOq6bsCC8KGfMJ5xn4gJgmDCeW8uHm2E+I2r+v9erit0JmieD56Tntyw2ciC
	 1idfa5ZVK6e+XS0fMkG3s3bD3WtVYvpnmyt5UIMF/nDItcmCkZz9xoL8tjRxERYUTX
	 zy2O0BjIPBDv+fpOw0mB1Wl+bvGR/Flgf+nboVcy00/3KJNRMvXU+SyJwmC1o8r8p4
	 te8eISOHlGqYu1/rN5rmqZVY6m5rttv3/AcVQPeBqS0JpWdw5DIOZZ/4d/p2F3ir0v
	 E4FYtOfde8kc25mqLL1uU2438jUZczMBP7N4/8y5xx7bgDbH3UVZKKjnuo+b0hKPgK
	 TjjA0Uc4W5tzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83C76C3959F;
	Fri, 28 Jul 2023 03:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv9  0/6] net/tls: fixes for NVMe-over-TLS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <169051502553.18144.8079815837647562945.git-patchwork-notify@kernel.org>
Date: Fri, 28 Jul 2023 03:30:25 +0000
References: <20230726191556.41714-1-hare@suse.de>
In-Reply-To: <20230726191556.41714-1-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_203028_275103_48144F48 
X-CRM114-Status: GOOD (  11.57  )
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

On Wed, 26 Jul 2023 21:15:50 +0200 you wrote:
> Hi all,
> 
> here are some small fixes to get NVMe-over-TLS up and running.
> The first set are just minor modifications to have MSG_EOR handled
> for TLS, but the second set implements the ->read_sock() callback
> for tls_sw.
> The ->read_sock() callbacks return -EIO when encountering any TLS
> Alert message, but as that's the default behaviour anyway I guess
> we can get away with it.
> 
> [...]

Here is the summary with links:
  - [1/6] net/tls: handle MSG_EOR for tls_sw TX flow
    https://git.kernel.org/netdev/net-next/c/e22e358bbeb3
  - [2/6] net/tls: handle MSG_EOR for tls_device TX flow
    https://git.kernel.org/netdev/net-next/c/c004b0e00c94
  - [3/6] selftests/net/tls: add test for MSG_EOR
    https://git.kernel.org/netdev/net-next/c/8790c6a4f54d
  - [4/6] net/tls: Use tcp_read_sock() instead of ops->read_sock()
    https://git.kernel.org/netdev/net-next/c/11863c6d440d
  - [5/6] net/tls: split tls_rx_reader_lock
    https://git.kernel.org/netdev/net-next/c/f9ae3204fb45
  - [6/6] net/tls: implement ->read_sock()
    https://git.kernel.org/netdev/net-next/c/662fbcec32f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



