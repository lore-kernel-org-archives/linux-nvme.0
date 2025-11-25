Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDA9CFD368
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Nov 2025 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vg+723AT+F9V+nofvRgONAE2TMnTjFK/s4MnVxWOoQk=; b=WpH25xu5FQ66wG8KzumTwcKDbz
	86c7KRx0j8Dw3DAaGhUjtMxCFOfe6jYHliaRVFwQxwvqOO7EOKMu6dNe3bQgaacWo/x2d1NRaRkq/
	Zx3V05O0NYu4dF2RanIyNG9ribuM/V2Lk3zN/FwgSBiLt8gek+T4xCeeyVUXCXnW/Ad+Yzubiy5rE
	uFUxOdb2ftsjl5/YqrEogPqgPh5IuqlrK8rJ2sJLCnlaZ1Xxh97GDEHHRg8w6Kxo1lbOiR1VrxB1H
	qFD0nRLUtE+xhOoPessPcUUgz6B35mHAR8UpkdqjyL+be+5rDWfTD6N9vtVwIKIX4uogaAzgXlqS4
	vwACXE7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmWf-0000000Cp73-3LTp;
	Tue, 25 Nov 2025 06:27:45 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNmWb-0000000Cp6S-2lJ5;
	Tue, 25 Nov 2025 06:27:41 +0000
Date: Mon, 24 Nov 2025 22:27:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
	axboe@kernel.dk, dlemoal@kernel.org, wagi@kernel.org,
	mpatocka@redhat.com, yukuai3@huawei.com, xni@redhat.com,
	linan122@huawei.com, bmarzins@redhat.com, john.g.garry@oracle.com,
	edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [RFC blktests fix PATCH] tcp: use GFP_ATOMIC in tcp_disconnect
Message-ID: <aSVMXYCiEGpETx-X@infradead.org>
References: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125061142.18094-1-ckulkarnilinux@gmail.com>
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

I don't think GFP_ATOMIC is right here, you want GFP_NOIO.

And just use the scope API so that you don't have to pass a gfp_t
several layers down.


