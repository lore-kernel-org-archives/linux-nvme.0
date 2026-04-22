Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B8AF94CD0
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2026 06:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rq5jcE3CJlCJsrJnRcjIAxYfuRkDbL+6lfQTh+4VpOc=; b=hKJmfXXksVP4Owhb17Mk0FHxxy
	qeKQBU/rX8lwHqrtLqXLXGEpH1JILJCY3tOZo+4aPPT2IDdBqY7zgb+OiM8ysG5CEjXD7TghmZwu/
	xyw846JYsayTBqzZYgGATh83FLMzDFogyi62HPaoK5zn/TZ/+Ari3hxw+vtmpEdBahwqHe9hJ8544
	TxZDXuHCFdgMrd7mu1s+Nye3ntfV+4tiwC/dxxhiEVjaXYFlvjl8whTe9ONyIgC1vrUtoaF5Y/W1n
	ehkl8C6Em9qFLMkd2A7oI5f+qd37KEcbF8S65Firo5JVyJMaSHyh8Ml7wVJkFvYKlW+HVt+74WzAC
	zs6OPfYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQzC-00000009esb-3ek5;
	Wed, 22 Apr 2026 06:22:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFQzA-00000009esG-3oQo
	for linux-nvme@lists.infradead.org;
	Wed, 22 Apr 2026 06:22:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 09BAA68D07; Wed, 22 Apr 2026 08:22:51 +0200 (CEST)
Date: Wed, 22 Apr 2026 08:22:50 +0200
From: "hch@lst.de" <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "song@kernel.org" <song@kernel.org>,
	"yukuai@fnnas.com" <yukuai@fnnas.com>,
	"linan122@huawei.com" <linan122@huawei.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Kiran Modukuri <kmodukuri@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V3 0/2] md/nvme: Enable PCI P2PDMA support for RAID0
 and NVMe Multipath
Message-ID: <20260422062250.GH5391@lst.de>
References: <20260416212633.72650-1-kch@nvidia.com> <3c4d2714-cbd4-40ce-b845-be9a02561d71@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c4d2714-cbd4-40ce-b845-be9a02561d71@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_232257_110624_6B3C172B 
X-CRM114-Status: UNSURE (   9.96  )
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

On Tue, Apr 21, 2026 at 10:32:14PM +0000, Chaitanya Kulkarni wrote:

[full quote deleted]

> If there is no objection is it possible to merge this via
> linux-block/for-next ?

We're too late for 7.1, so let's wait for the block tree to open.


