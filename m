Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BD9C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 06:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qI5ZMtQdrueY+Pa5uttWmTIsGCmQIPmQ98MOsZBU/UM=; b=TSBoGHajjJw5+9ir1wMG8P3Azu
	ka/h5YS4wU4nBnUYcg5pV1nyQwDy3t3RckAXsMbSb2C64qK0pYBiUTQ5Ba14TSD67mf4DSX0GPgPn
	tOaUvT+fw98bOZcgOBvzXWt4FY0MtqzT3oZTg2xnHR0WGG870gh+YtPsti3JB/y8LokQYglvWDDbA
	gV0ycbBibNQ+1jvpaD7DTYISBqd81YjyfuG81g82tbm67nPUV+N6uHkmcMFKlIO/SkFCHKjji9D7q
	k1VzzJ+7oZQmKEbyGkLazpErUvgUPWjlYHlZFP9kve0X8s5WeJidfiWYkA24VEt4vmdy23gDlzb1t
	WhFc3p8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2LJ-00000005GDJ-0tQ5;
	Thu, 23 May 2024 06:54:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2LA-00000005GBa-2xFZ
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 06:54:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 16D3A68C7B; Thu, 23 May 2024 08:54:13 +0200 (CEST)
Date: Thu, 23 May 2024 08:54:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
Message-ID: <20240523065412.GA29137@lst.de>
References: <20240522091534.472449-1-sagi@grimberg.me> <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm> <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com> <20240522162845.GA16783@lst.de> <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me> <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk5lU1IqmLAhhSCX@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_235416_902183_9C682F5A 
X-CRM114-Status: GOOD (  11.91  )
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

On Wed, May 22, 2024 at 03:36:19PM -0600, Keith Busch wrote:
> The below patch is what I'm messing with. I have a CMIC PCI NVMe and
> nvme native multipathing enabled, and that can recreate the lockdep
> splat 100% of the time. It goes away with this patch. Non-multipath
> devices are harder to hit the lockdep splat for a different reason.

I much prefer the srcu locking as it has real benefits as well over
a global-ish rwsem.  I'll try to get to a real review in a bit.


