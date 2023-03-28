Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27A7C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HI19u/9smZKoYX/NENVT7to3YhUKTIGatVPGOUI+IMs=; b=JtZgltqTNRre6r0RWmVrARfi21
	zISsJJTX0l3X6T9Djj1cuMapbwivSW8LthWXNGHCtCyf1a4xGxSBvfWaDLKuisqdW2ofMK/IxBGL8
	yYmVeORmrh1vNwD0Riyxcfz5u7M2LAu2rEWQFROXZoesOkZfQwIMupFMV98jhycjqPRo5IoOoqfHS
	NPtTCLKiWJGbbD7OIRVTn/csWkJ8HoKomWaDU//bR+/KmWkQuAK6UAHqqrAxvGAKSj9avnwbeY3YT
	zoCceZGRgKaPbh4a9nlw6ibo0OAbK4GMvvy/65esAdP9Wz2x+d0GubDEclcJJEZqx8sjilPpljc+d
	sLj5J44A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxQz-00CjXY-17;
	Tue, 28 Mar 2023 00:43:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxQw-00CjWx-1Z
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:43:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE7CE68AA6; Tue, 28 Mar 2023 02:43:27 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:43:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, hare@suse.de
Subject: Re: [PATCH V2 8/8] nvme-core: fix nvme_submit_sync_cmd() args
Message-ID: <20230328004327.GC21054@lst.de>
References: <20230327060418.86655-1-kch@nvidia.com> <20230327060418.86655-9-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327060418.86655-9-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_174330_664952_F8368A7C 
X-CRM114-Status: GOOD (  11.05  )
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

On Sun, Mar 26, 2023 at 11:04:18PM -0700, Chaitanya Kulkarni wrote:
> 4 files changed, 112 insertions(+), 38 deletions(-)

This:

 - adds a shit ton of code
 - makes it harder to use the function
 - creates tons of churn

Why?

