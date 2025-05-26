Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76626C5B542
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kq+P6qBOs8xBbzyQn0Bd3rQP+Ob5JIvNcKM/LFOf09M=; b=t5UrM+y/JKt6EpSs2/GkdQ3DhI
	2iANPnpnpHVG+FVZ4Tjr0sxlZaIgWYPnx7xfkIJexArTWejbqjTHjnu5ICesob2r9a5l2dSvB4MmC
	rnKkjeMYIqUDKyeKPt3zcmbhswUsbcwrIUBSVIHRNEEoj6zJulMo5flMJTOVRxO5Ez6vYM9xYpJ8Y
	pQT7IvQ172ZeDyfnwbhhAFrQktquRyM4Os9XkyhSyfumWxbfT473Bd4t+KJIIVBKZNL6S243Cx7l/
	qUi/kIJhg6fMNjtH6nnjhCnNJpJExEcUZPeb4NYjQIQjo84UtNCuHcJUnlzdmwuXmcuL9IAP7RS2J
	7VcNdIDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQTt-000000087Zb-2jCg;
	Mon, 26 May 2025 05:34:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQT5-000000087TT-4BOD
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 05:33:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C070F68D0D; Mon, 26 May 2025 07:33:43 +0200 (CEST)
Date: Mon, 26 May 2025 07:33:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250526053343.GF11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-7-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-7-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250525_223348_284185_97439415 
X-CRM114-Status: GOOD (  12.59  )
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

On Fri, May 23, 2025 at 11:21:12AM -0700, Kuniyuki Iwashima wrote:
> Except for only one user, sctp_do_peeloff(), all sockets created
> by drivers and fs are not tied to userspace processes nor exposed
> via file descriptors.
> 
> Let's use sock_create_kern() for such in-kernel use cases as CIFS
> client and NFS.

Same thing, one patch per subsystem please.

