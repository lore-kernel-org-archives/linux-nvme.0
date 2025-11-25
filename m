Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B196D0E6C4
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 11:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bS19uFF8l16858Xe287LXVItE1NuCB1dcXpauN8intE=; b=rvpV9FWt+4h8b/d0lCLFWYFmeN
	NMHTSf3b3pmm5mMgRc00McO7GIjfz/AdMe2k7dCwdUkwzPt98UTTcu4CjPw56/Hx120+h6a0VYVbB
	Vp8EUjtQmwVkhKz6nv6Nf91LJLQVjGEJEhhVKQrfQWL4+fCixd9IoTGYTCfOXNFA3Az5mypBb/CS1
	jcETRZVRbAsXLUQ4+L/JysFJLytn5O2eqHjMOdHGglxDHs/jEx8/st8W2Wusv8F/PFIQrhxc/mLQh
	2kFrBdO4opodgl6oZv8oqolu5QAI3leEy0J65VZqJ2N91ws+0zcUMks3sFhKvkKOSKUgOEn5oKYGM
	cLCLWakQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNrFT-0000000DDeG-0hWW;
	Tue, 25 Nov 2025 11:30:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNrFQ-0000000DDdK-3g8r
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 11:30:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F304368B05; Tue, 25 Nov 2025 12:30:09 +0100 (CET)
Date: Tue, 25 Nov 2025 12:30:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"hare@suse.de" <hare@suse.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>,
	"wagi@kernel.org" <wagi@kernel.org>,
	"mpatocka@redhat.com" <mpatocka@redhat.com>,
	"yukuai3@huawei.com" <yukuai3@huawei.com>,
	"xni@redhat.com" <xni@redhat.com>,
	"linan122@huawei.com" <linan122@huawei.com>,
	"bmarzins@redhat.com" <bmarzins@redhat.com>,
	"john.g.garry@oracle.com" <john.g.garry@oracle.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"ncardwell@google.com" <ncardwell@google.com>,
	"kuniyu@google.com" <kuniyu@google.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Message-ID: <20251125113009.GA22874@lst.de>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com> <aSVMXYCiEGpETx-X@infradead.org> <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com> <0caa9d00-3f69-4ade-b93b-eea307fe6f72@linux.ibm.com> <20251125112111.GA22545@lst.de> <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <234bab6c-6d31-4c93-8a69-5b3687ba9b85@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_033017_063545_C09B14D9 
X-CRM114-Status: GOOD (  10.49  )
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

On Tue, Nov 25, 2025 at 04:58:32PM +0530, Nilay Shroff wrote:
> >From git history, I see that was added to avoid memory reclaim  to avoid
> possible circular locking dependency. This commit 83e1226b0ee2 ("nvme-tcp:
> fix possible circular locking when deleting a controller under memory
> pressure") adds it.

I suspect this was intended to be noio, and we should just switch to
that.


