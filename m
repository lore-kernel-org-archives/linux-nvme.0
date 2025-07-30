Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7060C83F26
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E4q/VTewWdAiwGBze8dCv3IXOy5Ea14A1k3uP8YBWc=; b=EnMaJBY74kDj7d0Q+8CaGOXVIZ
	CgivIJmToI+WXpzaJcwJIijuw0Eag5/waOYD5t+tRbcMg3uBjOs60qKwEHxwtIq3LSlHYdZYEYMkg
	/hfdQmyV+2fptuPBSTvuomwnqHNLEzfPclOCCQe/LMCUjd5tVGAhJykXVlauAWF+e/SlBkdO9lWDP
	hdaKGoKFHRyYdPW5vlCkkN6YphSelfIKxhG0CD8kiCzpyaOFbasciEmUzNvZiTw66HSjeEfEOMKji
	Y5pmD1Cu5rRAo5u6UJvLERfQVSHtevkA4X3f6EtIWWA2BaPCOMmGgf610WhLuDxyppveTTAZMCIGk
	RWNcaGZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh99Q-00000001tj0-2fu8;
	Wed, 30 Jul 2025 15:55:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh97r-00000001tVD-1oWl
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 15:53:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2934168BFE; Wed, 30 Jul 2025 17:53:52 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:53:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Message-ID: <20250730155351.GC19799@lst.de>
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_085355_611577_F0B8D37E 
X-CRM114-Status: UNSURE (   8.79  )
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

Thanks, applied to nvme-6.17.


