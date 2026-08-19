Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CF1C5DF86
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 13:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZOXD71JU1KpdX15Nz9lGEsxLj/lhEZU2Yl2XPqq/vA=; b=JYlmuiA0taPqkdLKjgnLaYfU8q
	h/86dIxaEvkWh6vTXwULxwr93JyLOuk6dIKdPYGyxYIDzyjitZmSNcb9nOEACyX6g6XTkSC5Eu4Uk
	xRhPyh1/H3ZqKhDss6KhyKG9+K79Xk9ATKpRIIQpGTRhMoS9rq0qw+aetB1+vyxqBYhwe9yx2n/gW
	d1qxXeglOZmBWppXQ7YXgf/Dzqvil6aTDWJZJbRkxQoz2BOip0mnJnMKAWGiD5O0ndIS4jDGT29eX
	lMWIhBvudz+SbCsGrIlhqU0hg65+Sb1XTjDCFlKsvuCWXDnkh7x3SdwL2dDV8RE9cdi/K2pELKlXC
	qGx2Wkuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwgGW-00000009rL8-4A1Z;
	Wed, 19 Aug 2026 13:23:36 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwgGT-00000009rKc-3d5r
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 13:23:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kZOXD71JU1KpdX15Nz9lGEsxLj/lhEZU2Yl2XPqq/vA=; b=agYkyq0PvFJCAgahTzBwPHNLhy
	0IzBIxp5UDnOjGI6cuETCOGbMzrgX6HsM693ZWtpUBex81i6xZv91UX1GH0oeXkc365+yZBQdYKOA
	daUDB/r1U3Qvj1NSTjboICdZHaIBBQScaevJUzv5hsQ+ftV6eFGEf9MNjGmuxND/7APLm8BOhR6Wi
	VmoIrGVYOwtdk/ipZwMwz+Q5MRvcdhNDW8eC9pi5Q4UCkiYl5OzRCWfN1FGb94Eoa/wGWpa5xHPYS
	hhUYnOT+++PrzGfUcSw2duLzMB4+I4RkJZkyqc0SQf/sYpeFLN0QbhRvDWXqh5XgAEUlJYewXJdlY
	2GaaQnag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wwgG4-009oy5-0p;
	Wed, 19 Aug 2026 13:23:08 +0000
Date: Wed, 19 Aug 2026 06:23:02 -0700
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
Message-ID: <aoWuJGOJicyABPK_@gmail.com>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
 <010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
 <20260819090439.GB9267@lst.de>
 <aoWNmG2X0aylHDFd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoWNmG2X0aylHDFd@gmail.com>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_062333_934198_30434341 
X-CRM114-Status: GOOD (  10.06  )
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

On Wed, Aug 19, 2026 at 04:04:51AM -0700, Breno Leitao wrote:
> On Wed, Aug 19, 2026 at 11:04:39AM +0200, Christoph Hellwig wrote:
>
> Agreed. I am happy to remove the export, given it was introduced by my
> change in commit 1406245c2945 ("net/socket: Break down
> __sys_setsockopt")

Patch sent to net:

https://lore.kernel.org/all/20260819-hch_not_export-v1-1-af4b0de70e13@debian.org/

