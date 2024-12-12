Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A23DE7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 07:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djZV2qnS1InSA1SNCGBHfnB2TpUoMYnrwICAwkQaFdA=; b=jaPjp/j4RyKXF/jiy88VBykeQ1
	d8r0PqKRqpG7Yn4V84VQ/Kb5FH774o/B/oEcmVXYq0t7zVB3mOy6Y8P9OMTN9KvUW+winjy2gHuDv
	hhG5MwUdnC2WUvstwUGpDiUywxc3pzzNaSuErob+TNpd1tO0BQmmdTTfx6qmaOrHcbKx4YL1/R+xn
	4J2dUjUsJRwhDV1cWPuQJorW2PtB7v3KeAuot3KZCSIn7cW1jO4LrcJfg5eDyPAdk5bV4NKYGpgkt
	npekEZkYYtz22xb2h5FouBKND11bNFOQkotZlGkHktpESr7QNQO0yr2ZJ1psVJc4oeuyy9VMV7xd4
	3chlJp2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLddV-0000000HA0V-1W1P;
	Thu, 12 Dec 2024 07:29:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLddT-0000000HA05-0lL7
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 07:29:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7043E68D07; Thu, 12 Dec 2024 08:29:18 +0100 (CET)
Date: Thu, 12 Dec 2024 08:29:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: use dev_err() to make message more useful
Message-ID: <20241212072918.GA7039@lst.de>
References: <551518fe326d5cff08aa2df1b7d69fcd689fdd96.1733988012.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551518fe326d5cff08aa2df1b7d69fcd689fdd96.1733988012.git.baruch@tkos.co.il>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_232923_361862_86DA9974 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, Dec 12, 2024 at 09:20:12AM +0200, Baruch Siach wrote:
> +	req = nvme_find_rq(&anv->ctrl, apple_nvme_queue_tagset(anv, q), command_id);

Please avoid the overly long lines.  Note that the nvme_ctrl has pointers
to the admin and io tagset, so you can actuall simply the second paramter
here by just passing a 'bool admin_queue' and remove the
apple_nvme_queue_tagset, nvme_queue_tagset, nvme_rdma_tagset and
nvme_loop_tagset helpers entirely.  The TCP one still has other users
by might be worth looking into as a follow up.


