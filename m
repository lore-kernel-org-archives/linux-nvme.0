Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FEFD0E6C5
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 11:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PRz526+qau8YvXzhqt7sWDl/Xm+RLryoGOw0Yh5juw0=; b=tsiutbrCEQTNVBgfMqQBX7USOX
	VNVTbknCvBLHdv8PqEguQu5E+J2QxATxSJWcenoiMIsH7k2fV0B8G8N/APNqBRxjwviZ+AQE9pnZo
	VzJQ7wbu+oC/jwNDwJJrUGqLlw8kwOLmLLfPBO1iMwD/7e6WScjJDm5BptcKA7ER+vEuoPmDvx7TV
	B6csHkUOzqBpwnkUkfR9UQ9A/HCfa5C7OGSYSo/fgizCW8ATjtoSMHm7QwmakbJoCLBpjlaXFKUYw
	j7fmpGObi1AQt7ky6XgQvMoS9YeCeDgP64LJAULuUIfvgsvFS5yaHJtJEtubEecK2fKiwsNezWueT
	qMVfByiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNquc-0000000DBPb-0yCV;
	Tue, 25 Nov 2025 11:08:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNquZ-0000000DBP7-00VZ
	for linux-nvme@lists.infradead.org;
	Tue, 25 Nov 2025 11:08:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D3DF68B05; Tue, 25 Nov 2025 12:08:37 +0100 (CET)
Date: Tue, 25 Nov 2025 12:08:37 +0100
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
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
Message-ID: <20251125110836.GA22313@lst.de>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com> <aSVMXYCiEGpETx-X@infradead.org> <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea2958c9-4571-4169-8060-6456892e6b15@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_030843_207106_C9B85166 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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

On Tue, Nov 25, 2025 at 07:28:45AM +0000, Chaitanya Kulkarni wrote:
> are you saying something like this ?

Yes, something like this.  I wonder if there's a way to avoid the nested
flag saving, though.


