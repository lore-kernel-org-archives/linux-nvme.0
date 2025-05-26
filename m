Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2C3C54FC6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1tvCvARBUX6Zp0GbNTZLPqNG7cB1PnxMJvkbZ0Kg5pg=; b=diumiR5iTrqSumsUUN6oUZCeSE
	zWV0hVXXfEiTUY9XdfMRBF47UqMtVelaYvGIhFJmtg3I4iqd4U3eCw3KBPD7Yl/2pruwuznN8MxVK
	lGtJHw5QFiGlIVJhQm2IFg6YskS3dCGpB7ttTsuoDxdEAB18hnA0xFbZKDEEko4MhwU1KsRoeoeYj
	n0S4HPtCUPuqjJa6tHT1MjkWT/G9RcD8PT3XUOYF8Y0IADFogA0m9Eb7xR6nGKaeaUc8QCv8+pH5t
	9WcL/hHPJkodm2ljhFTCboI6xIXOPNXGE9ubUy+YqathNybWEy7iAeqkuj/qHp4SUCHjTgopLlCz4
	SpzNmgjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQPl-000000086xf-48d1;
	Mon, 26 May 2025 05:30:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQPj-000000086wy-257n
	for linux-nvme@lists.infradead.org;
	Mon, 26 May 2025 05:30:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35E6F68D0D; Mon, 26 May 2025 07:30:14 +0200 (CEST)
Date: Mon, 26 May 2025 07:30:13 +0200
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
Subject: Re: [PATCH v2 net-next 2/7] socket: Rename sock_create_kern() to
 __sock_create_kern().
Message-ID: <20250526053013.GC11639@lst.de>
References: <20250523182128.59346-1-kuniyu@amazon.com> <20250523182128.59346-3-kuniyu@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523182128.59346-3-kuniyu@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250525_223019_711062_5031ABF0 
X-CRM114-Status: GOOD (  13.68  )
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

On Fri, May 23, 2025 at 11:21:08AM -0700, Kuniyuki Iwashima wrote:
> Let's rename sock_create_kern() to __sock_create_kern() as a special
> API and add a fat documentation.
> 
> The next patch will add sock_create_kern() that holds netns refcnt.

Maybe do this before patch 1 to reduce the churn of just touching a
lot of the same callers again?


