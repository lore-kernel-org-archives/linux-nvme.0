Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB36C5AD44
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2026 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKrWoAPilpib+yPYfjFE3Q+TPQyDryTcB/pFUP55CH0=; b=S5m95FsTS6M1gTg0HI1QiOyIiT
	jTrV3YtDvaGjP8Jbvu4809jNkGFat7LTYa4R9LXbGwaQl4zcJXVbdGaYqDSITB4hgSEVgWnftUIdy
	eittuRnX8jhIvNv6Slhc2uctbZiEOh3rMLQNdVG1YLF9mh+Obs+z67RdPWTFg0PXMcusa/Hga1FiP
	tn8wFLffacjZ9rehU5dJIN6+eIWccSZQTygugBjr7jBM30GfBjADIXN8jBip8a2gUoxAdyYp/mK+y
	jYmesmaveuhciRPRfPX7qJSVC6iOYtBjwZQCJkwhEGTo8lCksweGOdjAVTQx3uke21eCPK+AB9GgI
	b3oDYViA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsnD7-00000009hMl-1fSx;
	Sat, 08 Aug 2026 20:00:01 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsnD1-00000009hMf-3Ifn
	for linux-nvme@lists.infradead.org;
	Sat, 08 Aug 2026 19:59:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C8DA76001A;
	Sat,  8 Aug 2026 19:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01EA1F000E9;
	Sat,  8 Aug 2026 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786219194;
	bh=XKrWoAPilpib+yPYfjFE3Q+TPQyDryTcB/pFUP55CH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fNMwnnOVntnbcKmmCD86srsQFJ3QdNN4X1E3kLqOVb6jg/k80C6+kFZ4qJTKeqdsZ
	 tl5Rbfi0+Synrl+WQrfY9uAkA8g7fnKPECSDSCfqRKfp1EtHs3UbWgWCHL2sg/Bbep
	 IthedKvCDn8q8vkoXKMQKPLn151mqNFNytEhXnxU0wbWiciSZ91C/zS/b/vBXP7F0t
	 fL3Ok34RHUGZFGges0qGrLJtVV7YjlrADsj5zofadRQ2hHoD1wDMgUQhWY+IrtHA4S
	 cKhpm4EO6DFXOxGq8XyM6JUl6HWDM32PF8nNnpLI2JxhLy7S3BUXnTgb3qOkdrr0dP
	 KCTk1q/QfCMYw==
Date: Sat, 8 Aug 2026 12:59:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geliang Tang <geliang@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v2 1/3] ipv6: extract and export ip6_sock_set_tclass
 helpers
Message-ID: <20260808125953.1e8488e3@kernel.org>
In-Reply-To: <d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
	<d06402e4fa9e1c879296dfb8ca5a73e34d4b13d2.1786171863.git.tanggeliang@kylinos.cn>
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

On Sat,  8 Aug 2026 14:54:59 +0800 Geliang Tang wrote:
> IPV6_TCLASS handling in do_ipv6_setsockopt() inlines the same ECN mask
> logic and inet6_sk(sk)->tclass write that callers need when propagating
> a tclass value onto a newly created socket.
> 
> Pull this into small helpers __ip6_sock_set_tclass()/ip6_sock_set_tclass()
> exported via <net/ipv6.h>, so external modules can apply IPV6_TCLASS
> without duplicating the ECN handling.
> 
> __ip6_sock_set_tclass() will be used by MPTCP's sockopt implementation
> (similar to __ip_sock_set_tos),

not part of this series

> while ip6_sock_set_tclass() will be used
> by nvme-tcp (similar to ip_sock_set_tos).

setsockopt already supports generic kernel callers, sth like:

   do_sock_setsockopt(sock, false, SOL_IPV6, IPV6_TCLASS,
  		      KERNEL_SOCKPTR(&val), sizeof(val));

? Please don't export helpers for every single sockopt.

