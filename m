Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BE5C35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 05:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hqE0DWR0QvEKKxfmQXgNlpXx/3yw+/ivNNrnEvnsOb8=; b=LK3cFz5JwiuplRBJmCoVybxMZf
	r1kfLLy97H6KTzXHpYW1hgj+KpwxnB8VRA+QJHkZjoJuvQhWBu/0pfnf1HKJh6mfIrLNO0M2YRZ5t
	I9VcAenOK25oc+1RWdaRjoi09sWCDf61wBkchSdOJ76pnc0JLIg7Hlh0mOZax7ExHMy84RVOEinED
	JIaLVZRcs79ZknJher9htcKb7vOq/9+enIxdbkkIckcIpn41d1xOfE81vDEQLvwXiptq/NIQ8bZEz
	pIvrgyLW2oZBOPo+0WjBdCqFs4ijmhw5hc2qrJJ25DbaV6jk6YL2LQaf9n9O3Pd8s9UnNu9/5Of6V
	akH4aAxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvUZp-0000000Drcb-1iED;
	Fri, 21 Mar 2025 05:05:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvUZm-0000000Drc3-38LB
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 05:05:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B02B968AA6; Fri, 21 Mar 2025 06:05:38 +0100 (CET)
Date: Fri, 21 Mar 2025 06:05:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6YK15Z+55p2w?= <shaopeijie@cestc.cn>
Cc: Christoph Hellwig <hch@lst.de>, kbusch <kbusch@kernel.org>,
	axboe <axboe@kernel.dk>, sagi <sagi@grimberg.me>,
	linux-nvme <linux-nvme@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"zhang.guanghui " <zhang.guanghui@cestc.cn>,
	gechangzhong <gechangzhong@cestc.cn>
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <20250321050538.GA2038@lst.de>
References: <20250320072517.GA14672@lst.de> <1382721899.82743.1742525374789.JavaMail.xmail@wm-2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1382721899.82743.1742525374789.JavaMail.xmail@wm-2>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_220546_927757_F61A1A4D 
X-CRM114-Status: GOOD (  13.79  )
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

[note: your mail was mangled html, I'm trying to extract the answer]

On Fri, Mar 21, 2025 at 10:49:34AM +0800, 邵培杰 wrote:
> Sure. But on the target side, it's a bit different.
> All socket operations are done in the workqueue with domain kernel_t,
> the kernel_t can access other labels, so I think there's no issue.

Indeed.

> By
> the way, switching to sock_create_kern() could skip selinux avc
> permission check and might give a very small performance boost.

It also helps to avoid copy and paste bugs..

> I'll send an optimization patch later.

Thanks!

