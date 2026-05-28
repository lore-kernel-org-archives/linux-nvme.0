Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BEACD6E44
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 11:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iTEH889qdyjQuOYuPdCeZWG7mcxcunl8XrScgzNxwwU=; b=XnTQqwZYL1Soxf57VZL35KuC+W
	y9ti3RcdzFViH4uag3jIh93ZiaOk6MjNjs93W1vduTaZoTmXtxWBnMH4abWThe/1Tg88CNjrJzQF2
	nTz/jA0PLFZ4IDkYypia1ZpwVuJUbViCi9MBbxpo7nEAK9vCwHpTJTFF5Wn+WNglwDM9Q2K08f7gl
	BiIQKCieBWqMnbbHTifpQkJFZGpoJJECHzCLXRDe1To8KpZEPb8tVi3hpt6zoeTIiJoypyMvoeq1Z
	0ZmFlF5wJsr/myUC3LmTMKF7lY++3bmzOx5IOKpI0UeehOBHjgbi15bSROsZLr6C7j1XrbbttCKz3
	3VB2FXFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSZFn-00000005gbp-3Psg;
	Thu, 28 May 2026 11:50:23 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSZFk-00000005gbN-2drm
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 11:50:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6A480418D7;
	Thu, 28 May 2026 11:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0E51F000E9;
	Thu, 28 May 2026 11:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969019;
	bh=iTEH889qdyjQuOYuPdCeZWG7mcxcunl8XrScgzNxwwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bzl248sXAa3UsUsND4J7ufxCXCDIAJLLAS1Yyacj2SFB2yMB1pgqsluRZZAnRpWr8
	 eImQq13Vtp7mGv6oTx03e+E4Pxjbs2jdXeVFE2PWTa6D6jRNQTpw2nqfS0XCrnpIR8
	 3KLau5qSkgb1Q9wq/hsXd9yTKOud5hKtJehVQGTGQX3QNNTfOn5WJecXaNLkupaCpa
	 qRBuoq48kftWLRZHUUnSVPfZQZqQL90R9do9pBaKMS1S40nXWHIm2asI8Mgz/NaFNk
	 Bf84uKsWyZsl+wL3qWzlLpr2pUWHxvjIKVd1BC6oo5bACVccXDuK9dU/raQwEW0yo5
	 K2KPGK6gFcEEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19CC53811959;
	Thu, 28 May 2026 11:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/8] net/handshake: anchor request lifetime to a
 pinned file reference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <177996902389.890175.13707702597875560897.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 11:50:23 +0000
References: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
In-Reply-To: <20260525-handshake-file-pin-v3-0-66c616906ead@oracle.com>
To: Chuck Lever <cel@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, clm@meta.com, brauner@kernel.org,
 kernel-tls-handshake@lists.linux.dev, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, chuck.lever@oracle.com, hare@kernel.org,
 alistair.francis@wdc.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_045020_710234_07CB8EBF 
X-CRM114-Status: UNSURE (   8.55  )
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

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 25 May 2026 12:51:14 -0400 you wrote:
> handshake_nl_accept_doit() has accumulated four follow-on fixes
> since 3b3009ea8abb ("net/handshake: Create a NETLINK service for
> handling handshake requests"): 7ea9c1ec66bc, 7798b59409c3,
> fe67b063f687, and dabac51b8102.  Each was a local refcount or
> NULL-check correction; none moved where the file reference is
> owned, and the same code keeps producing the same class of bug.
> Reworking the ownership is what breaks the pattern.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/8] net/handshake: Use spin_lock_bh for hn_lock
    https://git.kernel.org/netdev/net/c/cc993e0927ec
  - [net,v3,2/8] nvme-tcp: store negative errno in queue->tls_err
    https://git.kernel.org/netdev/net/c/9015985b5eb1
  - [net,v3,3/8] net/handshake: Pass negative errno through handshake_complete()
    https://git.kernel.org/netdev/net/c/6b22d433aa13
  - [net,v3,4/8] net/handshake: Take a long-lived file reference at submit
    https://git.kernel.org/netdev/net/c/09dba37eee70
  - [net,v3,5/8] net/handshake: hand off the pinned file reference to accept_doit
    https://git.kernel.org/netdev/net/c/f4251190e58b
  - [net,v3,6/8] net/handshake: Close the submit-side sock_hold race
    https://git.kernel.org/netdev/net/c/5da98f55b131
  - [net,v3,7/8] net/handshake: Verify file-reference balance in submit paths
    https://git.kernel.org/netdev/net/c/204a5efde5ed
  - [net,v3,8/8] net/handshake: Drain pending requests at net namespace exit
    https://git.kernel.org/netdev/net/c/ea5fe6a73ca5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



