Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1526CC25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  7 May 2024 07:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=104gQoAFoq5dkDZ/o+s6gIi93+GtjdzLG8dzB3tH+kc=; b=axjzxcvqcbT9j6S041esOiANuY
	zSQ+XCitCLsff1KoFUa4Or6wnw5ke4mNUts5EHdK5rBlYUEzY65sEeBqN1P7AgNQnHcBQZPv7mEdb
	V4wxX0i9abEntM/X0jyEcNgFjGn++/iAtY/MnLkd/liHBwOHCwgHBsiR0WlhRBEwcYswmk9GuUF+u
	/u32CMmVlFoN7Tjr9DQT4SzeIiB1K3fSbgUhhE7YqEuO0q7/hp53I99ldbhmhWqV0GTkv4eQ8YTZb
	fuwrM9tL9eivY0EvZKijVF1nVIGJoMZ2X9obsNYuAbSv2fpUVGPQoKrcZs9yVdLRFFbvxFYIWs4k0
	p59EDiIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4FDg-00000009yWU-2pQx;
	Tue, 07 May 2024 07:26:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4FDc-00000009yVM-2RLd
	for linux-nvme@lists.infradead.org;
	Tue, 07 May 2024 07:26:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 363EB68AFE; Tue,  7 May 2024 09:26:27 +0200 (CEST)
Date: Tue, 7 May 2024 09:26:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet-rdma: Avoid o(n^2) loop in delete_ctrl
Message-ID: <20240507072626.GB6569@lst.de>
References: <20240507065444.1109334-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507065444.1109334-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240507_002632_897303_4326D0FC 
X-CRM114-Status: GOOD (  14.87  )
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

On Tue, May 07, 2024 at 09:54:44AM +0300, Sagi Grimberg wrote:
> From: Sagi Grimberg <sagi.grimberg@vastdata.com>
> 
> When deleting a nvmet-rdma ctrl, we essentially loop over all
> queues that belong to the controller and schedule a removal of
> each. Instead of restarting the loop every time a queue is found,
> do a simple safe list traversal.
> 
> This addresses an unneeded time spent scheduling queue removal in
> cases there a lot of queues.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(crossing fingers we're not going to run into a mess due to
rdma_disconnect)


