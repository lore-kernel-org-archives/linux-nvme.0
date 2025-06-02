Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12C8C5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 05:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHjHK+yZCg33iWBmNm5NuTILK1cC1xDLH1Wx5fyK6Ak=; b=wl7eHKT9t1hRD/rC4b48zcS0IU
	EkRy1/uBZaoNa00DK5Zf2cXb0NzW19uFPkY/UkyBa+IGLCu+8Wnc1G+FcpElsZEgkW/MZ3YuRAw5B
	Q9BsLP3h6CAcvSUmD4HWraEURlinGNPC5VUu3yQHXClBdZ9w1qYsXbxsDH3hjE+RO4A96Ztyu3QJV
	+ykYXX2E+MH20Yw1Cx+1lZt4nALyUyNxdNLmACGaymjKxs1rIEoXTIK0xVxZPhqvZBvx8n3aJGdDu
	KWYn8H0dUFzmP8OHJfy1qK0bLnL/OWcAdUIyy5mHch55SwNMZU7X/aJDQt5e8AEGNpjO3KCVYuYUC
	l4MtOv7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxPw-00000006jPT-26Jk;
	Mon, 02 Jun 2025 05:09:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxPt-00000006jOu-2Gy0
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 05:08:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D39F68D0D; Mon,  2 Jun 2025 07:08:54 +0200 (CEST)
Date: Mon, 2 Jun 2025 07:08:54 +0200
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
Subject: Re: [PATCH v2 net-next 5/7] socket: Remove kernel socket
 conversion except for net/rds/.
Message-ID: <20250602050854.GB21900@lst.de>
References: <20250526053321.GE11639@lst.de> <20250530025937.3214873-1-kuni1840@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530025937.3214873-1-kuni1840@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250601_220857_721603_CC603ADB 
X-CRM114-Status: GOOD (  16.27  )
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

On Thu, May 29, 2025 at 07:59:33PM -0700, Kuniyuki Iwashima wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 26 May 2025 07:33:21 +0200
> > On Fri, May 23, 2025 at 11:21:11AM -0700, Kuniyuki Iwashima wrote:
> > > Let's drop the conversion and use sock_create_kern() instead.
> > 
> > Please send a patch per subsystem that is converted to make the
> > commit log better and help with bisectability.
> 
> Do you mean splitting this patch into per-subsystem patches
> within the same series or sending non-netdev patches separately ?

Please send them in the same series for now.  I think they can go
in together, but without splitting them out it's hard to even get
all the reuqired attention.


