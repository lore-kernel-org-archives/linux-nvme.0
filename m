Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDF9C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Oct 2022 13:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zvdBMb4t8GfIZzbGdXApVGRLNuxibTDgMwjbJc4dxAI=; b=SzJB3z/q5Bdpvoidu0VpAXDmz0
	sUs/CEyR1fRtwmkCX+g//FEPoONaxkIA0ITc+L3tMSQwFCov8r7roKB+0lP2hn0Ov/IIKpSbeA5a/
	hLBM9cJHcHC5OgrOD+7MW8AkJ/mtjvNvoXfFBPRbhsTJF01WgNRcHKEmlLnIfWZzjAz489NoVbNO4
	B9feCORxb2kyn4JW+Jam5oH6C27aoJ7WWlNjU0sohw7SsnMw6TMb+bDQ5g6LTkXhChe4t65RJnbbR
	cQw3vgY02JP7ra30fVQo590FiGKavZizLRs2ar0SSziBsBLvv8AYCmNzyxjVmtvdP1IcblX+u05IR
	hdkQSHsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ols60-007yG8-PC; Fri, 21 Oct 2022 13:29:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ols5x-007yER-Rk
	for linux-nvme@lists.infradead.org; Fri, 21 Oct 2022 13:29:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0F04968B05; Fri, 21 Oct 2022 15:29:51 +0200 (CEST)
Date: Fri, 21 Oct 2022 15:29:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 7/8] nvme: remove nvme_set_queue_dying
Message-ID: <20221021132950.GF22327@lst.de>
References: <20221020105608.1581940-1-hch@lst.de> <20221020105608.1581940-8-hch@lst.de> <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55dfcd8e-c2f5-d064-bd4f-770383fc5305@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_062954_058091_DE53FAD6 
X-CRM114-Status: GOOD (  19.28  )
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

On Thu, Oct 20, 2022 at 04:10:47PM +0300, Sagi Grimberg wrote:
> I have to say that I always found nvme_kill_queues interface somewhat
> odd.

It is..

> its a core function that unquiesces the admin/io queues
> assuming that they were stopped at some point by the driver.
>
> If now there is no dependency between unquiesce and blk_mark_disk_dead,
> maybe it would be a good idea to move the unquiescing to the drivers
> which can pair with the quiesce itself, and rename it to
> nvme_mark_namespaces_dead() or something?

Yes, something like that is probably a good idea.  This entire area
is a bit of a mess to say it mildly, so maybe we need to sort that
out first.

