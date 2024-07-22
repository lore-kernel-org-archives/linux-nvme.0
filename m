Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEA4C3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwlDfXUYz25gs7ry7Sp2+iMjDEsB1HC5vAte8h0SgLg=; b=wYsPG9LkwU2l/454QHFutTTBcT
	rIfKOk8XbzA0vfbP8AUD8lrbrqcZRR+cpdAE/8b3cIFO1vcw1CmlcQO//T2CUtEC0vfeOyv/G0fdY
	f2AIpC3ZouEBbqmZCZHZwED/bWv4q6OY9mL0SbprdVQgMouOrAIZrfHm4Yls43hx+d3lCW2RdX5PV
	pgeN7npE+xLWKDrFzIIpM5lN7/sZ+DeGzk7VKy3k52mzeNwXUn+Ng8GLwXETlr5cz4C3vzSaOl5aq
	SB4Lbc/kB5C6VsbEgaArFnQKHdvHbcfS+j02LvD/YaK9vudxkr/0D3Zra0k+Kia0LWGzl6ZYUt4KG
	i2verHHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVuJ4-00000009pDW-3JrY;
	Mon, 22 Jul 2024 14:46:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVuJ1-00000009pCo-2gMt
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:46:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5CE206033C;
	Mon, 22 Jul 2024 14:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57265C116B1;
	Mon, 22 Jul 2024 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659586;
	bh=/hcAlppWRMQ4kBgz/1HNiIVC3fCjtz9gIVIM83KEraQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLLfWM/0pVGMZkkHgUa5pAD5bbMa5puua7grNkCGSN+enk/ac+WHFYF9lC8wc0ijO
	 7uX0G9M7SxatsFKwigQQF02nxdb6apcNxMLev2+946U5GSmjlN8/f9S2GzLcT+23bb
	 Q3Sqy9uvwJAtKNye0xuG58Vep3USTPTdZZo3uC0e4X2Yy9H5ANQEK6jF4LnDDzbfvX
	 6B30J4O7UtUeMtDYwscx3UpJcUkGW7j+DTtkhU0DIfQklY+AXhzG/6cFGfmfHOzm/S
	 KY4AvD/Nj1iiM3UNRIaW++my3zDXzY7lhpg3ua5JzMO5b9IlkFJXFd5zBSc/U8W+Ix
	 B0HQpkYjPmtWg==
Date: Mon, 22 Jul 2024 08:46:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Martin Wilck <martin.wilck@suse.com>,
	Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <Zp5wv_cPBvijRUSV@kbusch-mbp.dhcp.thefacebook.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
 <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
 <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZplpjJqx0lySDzx-@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_074627_766545_8928A631 
X-CRM114-Status: GOOD (  11.30  )
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

On Thu, Jul 18, 2024 at 01:14:20PM -0600, Keith Busch wrote:
> On Wed, Jul 17, 2024 at 09:10:23PM -0500, stuart hayes wrote:
> > I agree, you aren't missing anything.  Thank you very much!  If you want
> > me to submit a new patch with this and Thomas' changes, let me know.
> 
> No problem, I've folded in Thomas's suggestions as well, pushed to
> nvme-6.11. Thanks!

On further consideration, this is a bit late for 6.11 inclusion. This
one could use time in linux-next, so it's top of my stack for 6.12 once
that branch gets created.

