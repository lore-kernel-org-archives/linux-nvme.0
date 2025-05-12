Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526D0C3ABCB
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 14:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4v5kfkr0obwZRMgFyHChDtykS7H8b+pCxEbIXQiO49I=; b=S95h+LP61O+bqvFNUuRupKNWB6
	rexQIJcWN7fUZNhqtide6NzGQ1QjnJ2o6nbG7IhgwkbRGdeycNkjKLVfKWk5f5nJwH93PcsXz7kq3
	dd25fhMg3b09GnKeupCoe3B125h8MOcArsqFyYoabFP2F8XWVPBsoTNz8gUgQRDCLrJhfsOtSl76s
	OZN727jvP5kVvyBm2LjORP1CS5wKiLeNiOBX/imgYUYSzLehVvtYzue51lLiT3EiV59Ym+BUWXDNy
	z7YPDWwlHZbtmowz/pZzorr617a38roU8KuZ/RtE9tQm8WVuYX+wO0ruLMMeaKapcY+rxzWxemQ2A
	7/XKQQvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEUGe-00000009kjA-16eY;
	Mon, 12 May 2025 14:36:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uETx0-00000009gy9-1uJ2
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 14:16:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AAC7B68B05; Mon, 12 May 2025 16:16:08 +0200 (CEST)
Date: Mon, 12 May 2025 16:16:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/14] nvmet-fcloop: track resources via reference
 counting
Message-ID: <20250512141608.GB3822@lst.de>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250512_071614_641203_DEC8F7D4 
X-CRM114-Status: GOOD (  11.64  )
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

I'd like to see more reviews for this if possible, but we really need
to make progress on it, so I've queued it up in nvme-6.16 now.  More
feedback is still welcome.


