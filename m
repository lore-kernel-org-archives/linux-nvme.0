Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D1C35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YMFDUMWG3K3wYoSwxMOqac1Pz5RML07A7BlmLdz1jpE=; b=AZnzfBm8wCTrUE4NXJzWAlwWRy
	NMaObDmzPVlW9CxsGTkJpQGgPMgnjAA/v3yTw96VN+yy5WEjhxqbyZEEsyRX/P9yRA4t1vnihErrO
	b8dnRYVzeoNmWxvNlWV/wYNRUG72XZa8XLBP0CaN6Im6CiohDsVzj8jgxvgGromoBV06tAZ6yOght
	+I1KqteUsCVGXJBIYMwmcpse06UQOOeWanTR/ih/dEoAnwiosSZlgb3BY/ur7TBthNqHtx+W5UwSW
	VXWXzeCMgz8OOUlJtL9NLMaI6gys0cVGUUIQhxe6zs+QhFVih/5cPhIQ2TdUhMPB5miboLXSs1rXu
	AtyxgXkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVW1-0000000DwxO-1tMv;
	Fri, 21 Mar 2025 06:05:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVVz-0000000Dwwo-0PxB
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:05:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0B1D68AA6; Fri, 21 Mar 2025 07:05:50 +0100 (CET)
Date: Fri, 21 Mar 2025 07:05:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Daniel Wagner <wagi@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/18] nvmet-fcloop: refactor fcloop_nport_alloc
Message-ID: <20250321060550.GC3007@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-4-05fec0fc02f6@kernel.org> <a9055e3c-d36f-4706-9fdc-f4532d14adb6@suse.de> <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66261f08-5386-4b22-aa6f-7be1d4023fee@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_230555_277425_6E5D630E 
X-CRM114-Status: GOOD (  16.09  )
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

On Tue, Mar 18, 2025 at 02:38:56PM +0100, Daniel Wagner wrote:
> This means the new entry has always to be allocated first and then we
> either free it again or insert into the list, because it's not possible
> to allocate under the spinlock. Not that beautiful but correctness wins.

Yes, we do that a lot.  And if finding an existing entry is the more
common outcome (I don't think it is here, but I'm not sure), you do
a search first, allocate, and then search again.

