Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D316C5AE59
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jun 2025 04:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vt87YbeDiCHjHPiQQfO5pxZWMmchAsUjZb6vIjKhHps=; b=SwzIT4ycNKnzO6JtN1G6iqlU2K
	Vup2aMEo7HE4Z7MZQWgsUJxy3ktIvO9izkKXe3aQuCvi4HGWOyA/I5BR5bq7B0CP8UdZOcbef6szm
	xNVm0kKpYTZuBL9FeNJrxCVPNrmHeokNc+jBLYCiE/3fKG+pKgidPuda90nQyGfNQjE2C7/7oLNrR
	y6G6YXBZ9HGeRGozx+khETWK+/l4zAw+59fN6hFq0ECutoNVjspBoxyr4k4MLBnvAz9vTf2owslEi
	Cev3Xew9TwDcHR4cQTWyc/tSa8fSWXcwYw20AYveSpV4ILUnDus7sUOe/IvCuK1nU7zUacrLkO5qY
	VQY4yk6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMJew-00000009jKL-1POD;
	Tue, 03 Jun 2025 04:53:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMJbZ-00000009iet-3jeS
	for linux-nvme@lists.infradead.org;
	Tue, 03 Jun 2025 04:50:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F14468C7B; Tue,  3 Jun 2025 06:50:21 +0200 (CEST)
Date: Tue, 3 Jun 2025 06:50:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, chuck.lever@oracle.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jaka@linux.ibm.com, jlayton@kernel.org, kbusch@kernel.org,
	kuba@kernel.org, kuniyu@amazon.com, linux-nfs@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
	matttbe@kernel.org, mptcp@lists.linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sfrench@samba.org, wenjia@linux.ibm.com,
	willemb@google.com
Subject: Re: [PATCH v2 net-next 6/7] socket: Replace most sock_create()
 calls with sock_create_kern().
Message-ID: <20250603045021.GA8367@lst.de>
References: <20250602050949.GA21943@lst.de> <20250602215314.2531309-1-kuni1840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250602215314.2531309-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_215030_083279_9278D2B8 
X-CRM114-Status: GOOD (  17.72  )
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

On Mon, Jun 02, 2025 at 02:52:47PM -0700, Kuniyuki Iwashima wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 2 Jun 2025 07:09:49 +0200
> > On Thu, May 29, 2025 at 08:03:06PM -0700, Kuniyuki Iwashima wrote:
> > > I actually tried to to do so as sock_create_user() in the
> > > previous series but was advised to avoid rename as the benefit
> > > against LoC was low.
> > 
> > I can't really parse this.  What is the 'benefit against LoC'?
> 
> It was a kind of subjective opinion whether the amount of changes
> was worth or not.

So the simple scripted renaming was not worth it.  Maybe I misunderstand,
but based on the reading we should basically have about a handful
callers of the non-__kern variant left.  Or is it a lot more?

