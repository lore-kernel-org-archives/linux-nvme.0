Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D8FC5AE59
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eKwVFgz/+dQbqyKpSV4HJ7V56NDcII6+itJlBJJDBI=; b=X4VwnfFUeQyoTQPobCwXSDmgNu
	c9bAtcqnTS3R4lfsmrvOpItkbCU1G50RpzZmsrEjX37AkJpMHdir+8coz8oQ5unOhwVtbwVKZjQeE
	gmqMyh0+11isRO5XCEd9wzoYgNSjCkcCY4X6v4Llhdxs0OnbwlfyRVRNYhgoj4KyU8BWwEZ2+qCkW
	eQCbsYz8r5Ml9xlWjdPDVYXIRZYBl/+23UzR0FVu/C+fHlFgo1dK/DEJHm8399G0DnIzEZWDkNl6v
	Fft2VzpNKlJOhCdvMLUpIiDYj9zLWQ93HzqoIXXQGAjBPDV/G1PF/sST1fMehxwMUn/F/yGQFWljq
	ipvL6pNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMTB1-0000000BECA-1uyk;
	Tue, 03 Jun 2025 15:03:43 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJoRn-0000000A7oe-3N5Q
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 07:10:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5842DA4F0DB;
	Tue, 27 May 2025 07:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E665CC4CEEE;
	Tue, 27 May 2025 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748329802;
	bh=xzocwWaxsjqNHkYeqf5FJ8YRMOeK+a1p789rrCvbcaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eU6NFJs5jQ5CdwzHVb0PsOj0P5C+r9ru3pBi1gfG47A5NbrUFqk8CUh3aO2dGMtlN
	 riSAXw9+7UNBMO7viNU/MRiaql8t+VNyMYc21nLp2aav1RRmxtktNRSrqwSoL1hoNt
	 V1RqWCR7JGkjHjRqenpNmeroLv5Led1ciz24aCEy9/9y5Ng2lO2Wsu9SknhUWj22wC
	 BFbjBZ/YZx2QueOZQZ7xlPsl7Fd782O8nHROKAaOjGnPT3PpcNQ90ZikCrQKHOOsvE
	 1FtotNgCcpoC0dCAVA114GlETolXnkFsawoq/8gX4+Ppxhw6jmQxQbtw/wJmIzgsaK
	 Ar3h0qA7AATGw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D18380AAE2;
	Tue, 27 May 2025 07:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: <174832983626.1188942.1099978775563244121.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 07:10:36 +0000
References: <20250521204310.it.500-kees@kernel.org>
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuniyu@amazon.com, willemdebruijn.kernel@gmail.com,
 martin.petersen@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael.christie@oracle.com, mgurtovoy@nvidia.com, mlombard@redhat.com,
 d.bogdanov@yadro.com, mingzhe.zou@easystack.cn, christophe.leroy@csgroup.eu,
 horms@kernel.org, linux@treblig.org, gustavoars@kernel.org,
 andrew+netdev@lunn.ch, sdf@fomichev.me, cratiu@nvidia.com,
 leiyang@redhat.com, idosch@nvidia.com, sam@mendozajonas.com,
 fercerpav@gmail.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, hayeswang@realtek.com, dianders@chromium.org,
 grundler@chromium.org, jv@jvosburgh.net, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jiri@resnulli.us, jasowang@redhat.com, vladimir.oltean@nxp.com,
 florian.fainelli@broadcom.com, kory.maincent@bootlin.com, glipus@gmail.com,
 olek2@wp.pl, phahn-oss@avm.de, ebiggers@google.com, ardb@kernel.org,
 viro@zeniv.linux.org.uk, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 shaw.leon@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_001003_974744_0348EE91 
X-CRM114-Status: UNSURE (   9.17  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 03 Jun 2025 08:03:41 -0700
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
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 13:46:08 -0700 you wrote:
> v2:
>   - add conversion of dev_set_mac_address_user() (kuniyu)
>   - fix missed sockaddr/sockaddr_storage conversion (kuba)
>  v1: https://lore.kernel.org/all/20250520222452.work.063-kees@kernel.org/
> 
> Hi,
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: core: Convert inet_addr_is_any() to sockaddr_storage
    (no matching commit)
  - [net-next,v2,2/8] net: core: Switch netif_set_mac_address() to struct sockaddr_storage
    https://git.kernel.org/netdev/net-next/c/161972650d67
  - [net-next,v2,3/8] net/ncsi: Use struct sockaddr_storage for pending_mac
    https://git.kernel.org/netdev/net-next/c/db586cad6f45
  - [net-next,v2,4/8] ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
    https://git.kernel.org/netdev/net-next/c/7da6117ea144
  - [net-next,v2,5/8] net: usb: r8152: Convert to use struct sockaddr_storage internally
    https://git.kernel.org/netdev/net-next/c/79deac8d538d
  - [net-next,v2,6/8] net: core: Convert dev_set_mac_address() to struct sockaddr_storage
    (no matching commit)
  - [net-next,v2,7/8] rtnetlink: do_setlink: Use struct sockaddr_storage
    https://git.kernel.org/netdev/net-next/c/6b12e0a3c3c9
  - [net-next,v2,8/8] net: core: Convert dev_set_mac_address_user() to use struct sockaddr_storage
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



