Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A74C282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 18:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rXOx2ba9APdbCYHcbnJvBsmzde/ImVgXgDmP6ym9y2w=; b=TxzUXn0lov1Kr0NDxa5tGr3fCw
	v3bk3b5LprQFPLk82jbLwvCXUgV+dBrZl3o6ciEdX5sHMFaJmCtLc+Xi6yJlEyLro6m4URndyLxGb
	dgrJUBhIsMLE3/XV5XWpX94RgFEcKfJr+D8TXBgvPiBCSGCkRnUdyNOSbghpRn6qr7gTBArbzZW4T
	LP5ki61lmYODziCowAV1eabpuY8p+8baE1NXiAjEvEYrhuPnpxg3V91/Ld2ZAl4/MsVSa/3QMN7kH
	06QA9z+8a+h2MJLMUrh+GLy4KM0gAStUhIHnrhRLVGkw9jZjv7TLHJsTEmONwPQUSdnNJt8FTqs1s
	+a5tqGsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trhyS-00000003cpM-1gqy;
	Mon, 10 Mar 2025 18:35:36 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgix-00000003TR3-3EBD
	for linux-nvme@bombadil.infradead.org;
	Mon, 10 Mar 2025 17:15:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rXOx2ba9APdbCYHcbnJvBsmzde/ImVgXgDmP6ym9y2w=; b=WoiQwIHJr7noeDbu6cqVEOyG8o
	AxLnRu9fOUTYSXBcWvz0gDw9ah64kmehlrEyZT0ZX/h5aSmpUL1kVJTGN7pgQ/J6zp5T6TwFXZGlh
	h/JspEBlpZTtHnHjfK36/MVKx+OZPZHJVCUgnouG786pz1Ehj0NRrwkIjjznCzffRDYscto0BL1/O
	RU0J2qtl2AQU4e4SXHkX3VRymaG8GiOy4WCfeBQrvXIYCStjNyuREKTTENIe7OR4JN9zythbsOmW8
	Ql/4gAwyti/oBxSNooNeKcoC//HU1L4clkDSkleGciSc8twuoqe/ACME2fM+gJ1ncMY5yLoQGb1PE
	Ly9EEYKQ==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trgiu-00000001yDv-37Rd
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 17:15:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6282B5C3F69;
	Mon, 10 Mar 2025 17:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DD2C4CEEB;
	Mon, 10 Mar 2025 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741626926;
	bh=rXOx2ba9APdbCYHcbnJvBsmzde/ImVgXgDmP6ym9y2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3IBrRezY2lodFfbEAfmelH9am050k+LFcydcRIdopHkDmsEcH6cNhYljzS86NFJr
	 744H8XGPXJtah58hpJ1/rzHHEbLYlFV8vujsmwPRmCJtYf6FS6NkW+micKRy8jpxPd
	 sbiuTRW9PrdqDNd2jSoc6HiwzlUCPT8+gD2L+Wgjbm20fRAyRUSVO8PAAuvz2P0QJx
	 GU103RIspE7Ab7+O17cVCT9g/zaZ0JL33sgDnnuq50q4jwk0jhajtVoG6bVC18q4DM
	 SXYYq3jSbjWtqCsj+k6+dih4TuKXobgy11wOnFap7z/uBBrLg5FuqrcXQYEEGMpkwt
	 o38XP7S02BG+Q==
Date: Mon, 10 Mar 2025 11:15:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/2] NVMe PCI endpoint target fixes
Message-ID: <Z88eLM3FoIeR1B5t@kbusch-mbp>
References: <20250306085549.834943-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306085549.834943-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_171529_026332_68DB3AB6 
X-CRM114-Status: UNSURE (   7.37  )
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

On Thu, Mar 06, 2025 at 05:55:47PM +0900, Damien Le Moal wrote:
> A couple of fixes for the NVMe PCI endpoint target driver. The first
> patch fixes an issue that sometimes causes crashes (hard to reproduce).

THanks, applied to nvme-6.14.

