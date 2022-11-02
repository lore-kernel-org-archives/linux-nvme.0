Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DB4C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 06:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZTvNic4jUZJgeWHENQhJLq3V0OADVSrCKfjLQplN9DA=; b=J5bFhoJRgSycvafBNq04av8mFS
	LUFVGJYF04Sj8T3Un8wLcYRXLpN/FUUSVXX6ENQ36arg4p4z/0L8X/GQe4j3SVrYxZMg+mUYW8svQ
	vzjXd70wf781gQIh7+A98aEaengHoo3bTvAl+xPa9BbzejLFGlaXU/b/p2ZANqelWspd97z72uPL+
	lDa8utD5+qYxXY+kt2Gjy4sjF22yeXKcYBFaEzRG06q+dZ5uotGuvdkJ6L1MFrsMrOoWVVqWrmSPp
	1dGjNZdJXytKdHf3a2fOXfo58MJDn2X//8v1dnjj+42kkrxSjPW4/bUIdQkKJL8oxHM/mQoW4Pq3i
	ZA4WzdnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7i3-008XhP-US; Wed, 02 Nov 2022 06:58:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oq7i1-008XgX-A8
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 06:58:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 695646732D; Wed,  2 Nov 2022 07:58:41 +0100 (CET)
Date: Wed, 2 Nov 2022 07:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Message-ID: <20221102065841.GA9020@lst.de>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr> <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr> <20221102064747.GA8903@lst.de> <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_235845_517463_A861E09B 
X-CRM114-Status: GOOD (  11.79  )
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

On Wed, Nov 02, 2022 at 07:57:23AM +0100, Christophe JAILLET wrote:
> What is the best strategy for sending such patches?

Just send them per subsystems as mini series or individual patches.

