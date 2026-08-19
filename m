Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B926C5DF87
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lYfeP9WUbHszkMtgoDUYiluPRe4QGeEextrg7r7ra8=; b=PDsF3T0DoJIWe9DMzi25EzBmtq
	H6VP658bFC04uq3jstP2De9xTr/rg4qXP27TIpeGLqxXIruFO05t4IoOez177rXIcj3E5UiFc2flj
	4zcqUZ/Kq171vxaJuvaRg+kwJuwFzFSIyFdmXU+ejCPNDzhDgYqtatXPEhE0xDTvxAX6ShcJnEYIf
	BWcb4k2TOgy26qyRGpz2o94P9bBTjEvGP/d/YG/MeKmtcdMhbtTUlUv2WK1WF+aSiDF7gd5Yw7/2z
	+hKuZx9sLeR6V7A83rDzWBzrFZTBi+Op3niSdQbzT9xaMzFPEPkv5vFHmua3VO4riv8WsazNPHj6U
	qcE56RLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwe6z-00000009cR0-2Ara;
	Wed, 19 Aug 2026 11:05:37 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwe6m-00000009cDS-0zJN
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 11:05:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/lYfeP9WUbHszkMtgoDUYiluPRe4QGeEextrg7r7ra8=; b=PEQf05DSRjDo4BBdNUv0Rp6rve
	rD4sIBMLADaFrm/XAn+y8Ib+WIF7vy8SN8Qjv7MxMnO0KZa+s/ty/kxIosVZ/+Z9EJcdZrUnB6hEo
	ztQYhJQviOzks61njhVECfKSw70h7RGlWbnW08RqJhaVrcr+F/yE62napF+HbUvmk6LI3bMeK6mAu
	ynk/IzA7CXDpWOD6d3yTlV7h6eZ7QENc+tDi8l7zsoqjyE2TJJPCw+2tf/Rt3Mf70rsOaraNfkdGj
	qoBn4pML0Ce8C+caRtDp7F8eC2aeS9iZC8r1YCzneNtJn1aQRKqnBngULEUxkMMrVxoA1pWw6js4a
	srMgX6XA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwe6K-009kMp-1B;
	Wed, 19 Aug 2026 11:04:56 +0000
Date: Wed, 19 Aug 2026 04:04:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	Stanislav Fomichev <sdf@fomichev.me>, Geliang Tang <tanggeliang@kylinos.cn>, 
	linux-nvme@lists.infradead.org, netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <aoWNmG2X0aylHDFd@gmail.com>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
 <20260819090439.GB9267@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819090439.GB9267@lst.de>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_040524_286489_51C02D5E 
X-CRM114-Status: GOOD (  14.99  )
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

On Wed, Aug 19, 2026 at 11:04:39AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 18, 2026 at 02:03:00PM +0800, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > This patch consolidates socket option settings in nvmet-tcp by utilizing
> > the generic do_sock_setsockopt() helper for options including SO_LINGER,
> > SO_PRIORITY, SO_REUSEADDR, TCP_NODELAY, and IP_TOS. This change eliminates
> > the need to export and use specialized helpers for each individual socket
> > option.
> 
> Hmm.  I see that do_sock_setsockopt is exported, but it really should
> not be.  It's really just an internal helper exposed for io_uring
> and no modular code should be using it (never mind the non-GPL export).

Agreed. I am happy to remove the export, given it was introduced by my
change in commit 1406245c2945 ("net/socket: Break down
__sys_setsockopt")

