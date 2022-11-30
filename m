Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C7BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9EEON2jPjxNd0q5Fit5Ep30QpXDxxg0+FsQZG8eBncE=; b=LCvVryfsR2xRJk/Qmh/8NU7sSD
	A7OPNc8WCEwk1VMXHeMwJitERsGZPw4M/QSmsyH9STK6JByc36rkz9v2Qlnwcm/TOIK5us5EA2Jp6
	UauIYgtyjYZidFGWMw0e61GfTK4OFEYEcW7B7uDs1WK+ouq3ZkFLox+gm4FcNM8sYlJVL4OaeLs7L
	FTDZGMSBVWmO+6EtZLucZ4NvcqX/ZI6aoyk8NRA1HSNMZOHMovHxwu2KmnZ+VtMzsAU5BqQ0aDD5j
	I7RiNq2Qv9r0AxOFVMKWaIzvf/fCXjQNR+LnQ+d9ZfgbtJ+6rqvQIgWJvTJ/ZkknOZGgAxukcWTW7
	S2Pxa/BQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0NGw-00GYOB-FR; Wed, 30 Nov 2022 13:37:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0NGt-00GYNK-90
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 13:37:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5714C68AFE; Wed, 30 Nov 2022 14:37:01 +0100 (CET)
Date: Wed, 30 Nov 2022 14:37:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Zhang Qilong <zhangqilong3@huawei.com>,
	hare@suse.de, kbusch@kernel.org, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Message-ID: <20221130133701.GA4267@lst.de>
References: <20221122044929.27600-1-zhangqilong3@huawei.com> <20221129084725.GB26082@lst.de> <20221129134042.GB13668@lst.de> <ea20a977-e0c1-d9a5-907e-387d312e55bf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea20a977-e0c1-d9a5-907e-387d312e55bf@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_053707_488612_D038EB1A 
X-CRM114-Status: GOOD (  11.72  )
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

On Wed, Nov 30, 2022 at 10:37:45AM +0200, Sagi Grimberg wrote:
> This is fixed in 6.2 with some of my patches.

And this version conflicts with that.

Zhang, can you please resend a fully tested version against the
nvme-6.2 branch?  Thanks!

