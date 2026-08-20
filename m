Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF1EC5DF85
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2026 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VawSvgDX6fqaQP0qKQ8B6xmDg9CDCy/Pi7o+RV+1o7g=; b=pHVA3zp86yefcjhp58U2uIRFks
	L62uEjO/PG2ubWg6vCgGeV9vc3/QfmZIEIPGJrKIaqnlYNLk75VQdXWV1NshEZnS2kpUtWYiOSA0c
	9RhuDKGriZMxQfec6rqBoFKEMrBhg/f0RwzvLHnTgmZzGwbDML6oE3F6zJK1mdXUmSh0lk2oHOCU5
	5G9xehqKPiVE1zPJKPRUbZSTwo9w4VhrziLfDmCQg5jYcqipHthhKkQKr/oVEJN9Zr1ZPDuqlPGbA
	5m9W9XlUJkcyOCBeZURtyIa3cYlMj3q/+Uq7CENGFbSE8VYd5QF5LOboDAlcZw4a2EaffujeHal0E
	tKiNPXVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx6bk-0000000By89-3nfg;
	Thu, 20 Aug 2026 17:31:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx6bg-0000000By83-0vsB
	for linux-nvme@lists.infradead.org;
	Thu, 20 Aug 2026 17:31:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3815560A58;
	Thu, 20 Aug 2026 17:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2C11F00A3A;
	Thu, 20 Aug 2026 17:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247070;
	bh=VawSvgDX6fqaQP0qKQ8B6xmDg9CDCy/Pi7o+RV+1o7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ACWaXR6jAwHB7tv/c8Usip59at2gaF7rL8oSFt7sxp8wtbFVs2stRYjA1zJqy2p9z
	 LRNFKCOk0ZNwKI14iNCaXQIH6gK4/LqNv86PBNtdxK6UFTZiNz1EcVROWnlF4jtj6k
	 HVCiGId+moL/SN3sk7ugERolcUg5sxWGVQpxjdc3TidV65dFNAsvLWdwf/jshHQluR
	 h1TT+MQh2Xy4qp33v2xctAsqnqQNhcby0KMYhLduhtpCJdVFT/kQtJaLY3kGsX99o3
	 cvqvrQTjWMAN62bcxTrzQHc57fNPE9mrk6uNuWl/RbPdETNIhCoo9G4SirW32Z9pZk
	 08/tjNmQssbvg==
Date: Thu, 20 Aug 2026 10:31:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Geliang Tang <geliang@kernel.org>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <kch@nvidia.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Hannes Reinecke <hare@suse.de>, Stanislav Fomichev
 <sdf@fomichev.me>, Geliang Tang <tanggeliang@kylinos.cn>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v4 1/4] nvmet-tcp: unify sockopt with do_sock_setsockopt
Message-ID: <20260820103109.4d8ed110@kernel.org>
In-Reply-To: <20260819090439.GB9267@lst.de>
References: <cover.1786947923.git.tanggeliang@kylinos.cn>
	<010e6810cc4c10b30237c964b2bb9dfa7a3c740c.1786947923.git.tanggeliang@kylinos.cn>
	<20260819090439.GB9267@lst.de>
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

On Wed, 19 Aug 2026 11:04:39 +0200 Christoph Hellwig wrote:
> > A key benefit of this refactoring is that it decouples the socket option
> > configuration from the underlying transport protocol. This makes it
> > easier to extend nvmet-tcp to support other protocols, such as MPTCP, in
> > the future, as do_sock_setsockopt() abstracts away protocol-specific
> > differences without requiring per-option protocol-specific wrappers.  
> 
> We really should have generic helpers in the networking code for this
> and not duplicate them in driver using socket options.

What do you mean by "for this" ?

