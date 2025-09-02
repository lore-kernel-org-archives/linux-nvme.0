Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF92CA1005
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KasjU0FBIZmRwjUp2mykUtIPtXubTqJGoHCKb7ncfls=; b=LveaeVzHy2oSGoyXvh1l8msQxw
	JvPZcIEgBK8jIB7Y1sQrN5FUlebmhK7ct523Neh6oBw17swVr/PwoB8ozAJqdKN6YZqQGtKoI+Hkb
	GXgj2EWqUYoinLo+Sce2t9qcHARNyJwrW8RLs2VWStexJrxpehzDvfvOINcdkWQ7QFs4FQ7j5mefa
	Hu3ET9Hfytdaej/rF8Zk5l+DmJ7h24VBfsh1lk3wLZfhUpDmTqLgq3cmTM8A2uGaNt5xIh8FBE+g6
	WLul35vRwSNBN/9pN0iAqV+SHrSas84uWNRMiksEKm251v9U2MOWdcQwByinFsUBZ1ctDg4eeivb5
	xUy7Rhow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utbcF-00000002pJ8-1Ojw;
	Wed, 03 Sep 2025 00:44:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWZx-00000001hLc-1YWJ
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 19:22:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1371544376;
	Tue,  2 Sep 2025 19:22:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A174AC4CEED;
	Tue,  2 Sep 2025 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756840924;
	bh=KasjU0FBIZmRwjUp2mykUtIPtXubTqJGoHCKb7ncfls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq7YJHANjbno1MM9AvQfiu91/1/0pCUotiHL+/ggJaeuOXrKx1JB3Xky+HoTjE7hD
	 qnTX4RWFl6vVrnqSyPRgOd+tDmcLdYZdHNRzpRLdTi8VbEg5HdLiB7LJdBt6QfY9Dt
	 pnPm3o5aV22xe+WUuRYrYrdTi7Wowiyx96LHikbKZvjmgXBF53OUtOae4ntPou6Giq
	 whNN8BeXOszNkegD1OW4XezCvYbO8Z1QN7ghXpgHLjb91uijAtEo4ZaKxtVVg40Re9
	 0/jZ+OsiT3RVIvZbzq6wi1ObjYJAo5UUrVdt+Lxgnv87pv2ue9JnRBsdMip7v4ZIX+
	 JVywKRUr2e3xg==
Date: Tue, 2 Sep 2025 13:22:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com, joshi.k@samsung.com
Subject: Re: [PATCH v2] nvme: fix PI insert on write
Message-ID: <aLdD2vqxdtYqTjvN@kbusch-mbp>
References: <20250825133327.518741-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825133327.518741-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_122205_428295_DBF85706 
X-CRM114-Status: GOOD (  10.61  )
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

On Mon, Aug 25, 2025 at 03:32:49PM +0200, Christoph Hellwig wrote:
> I recently ran into an issue where the PI generated using the block layer
> integrity code differs from that from a kernel using the PRACT fallback
> when the block layer integrity code is disabled, and I tracked this down
> to us using PRACT incorrectly.

Thanks, applied to nvme-6.17.

