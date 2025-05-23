Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54686C3DA6D
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6eJZWbtERZJB88Pd/u5AKxzzQUN61sU2ou0z+3xai9s=; b=XAhHnyaduhy3f/IMv2ec9OwnIp
	i5ndqbxU/6R5HdlYpxlQBCIPxHiHGfk2xi+jAzbS08rwEBhrU05muWCYl8SpOHzm5EYsn3lNJzbEV
	4ateh3DaGlDH+Id6F6PdQ06W57qQITxP+SMjLHKq92KvCH5S5KwTiq3S4A5NBwbuRAsGIs28TFHYX
	HBi4fPywqZ/ubvpvfuTzANYD4kL8i4jY+kYV2IdLKLZOVcKEs1PKg7uHu1H3mYQCvjOVdczt/wW+4
	FtlG9Q1Nm88h3ppU6Fldmrmx7w/v1KrYH/E3HY379vbqheyntXDwzK57v/uFmsnmHkIMz1JAr5m79
	i83092tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIJwG-00000002t1g-4BWI;
	Fri, 23 May 2025 04:23:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIJwE-00000002t0Y-0yMO
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 04:23:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E183567373; Fri, 23 May 2025 06:23:06 +0200 (CEST)
Date: Fri, 23 May 2025 06:23:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Steve French <sfrench@samba.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	linux-nvme@lists.infradead.org,
	Matthieu Baerts <matttbe@kernel.org>,
	MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH v1 net-next 4/6] socket: Remove kernel socket
 conversion except for net/rds/.
Message-ID: <20250523042306.GB6344@lst.de>
References: <20250517035120.55560-1-kuniyu@amazon.com> <20250517035120.55560-5-kuniyu@amazon.com> <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a965a97-a6d0-462f-b7dd-8833605ea7c9@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250522_212318_414888_547B7498 
X-CRM114-Status: GOOD (  10.66  )
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

On Thu, May 22, 2025 at 10:55:47AM +0200, Paolo Abeni wrote:
> https://lore.kernel.org/all/20250517035120.55560-1-kuniyu@amazon.com/#t

Kuniyuki, please resend this with linux-nvme included to allow for
easy reviewing, for which lore unfortunately is not very useful.


