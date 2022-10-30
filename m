Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10383FA373D
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 09:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NBUyAW76SIbg41V1mF/sGuKizNxaRGnKYHM8LZtEz+E=; b=cInYqloxUbfjwYsfyARjEW/gSs
	/7o4b1pvOPRZ39IfXzDTv1ZZSFU0CEsKOtqn1KdDIkTrOBaAp6RUwK/OhfebBGBsGoVpRCPHXc1/N
	EHrZ0BliglI3EQsuoFsKskXKgVk3rZAaMJGGIhf3Myk2uDXqs2/H7/UbOfBZ3KuSttJGYAhbhmFEm
	hLcUh1ynOfkhWGRPalM7cjY5fj+YYli6bleJ8VlmrDNF4wgFiNpCfd/Wh76rnmLAQCzz/GfvOgjUF
	reH8mBo+saTW7izEDQQ2MzKorZPwi/Ypzf8gS+N751VTs5JS1BI73HA92fKw1od94Pa12ANbNoGYQ
	LXqJay3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4SR-00Eimg-Lx; Sun, 30 Oct 2022 09:18:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4SP-00EijN-NL
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 09:18:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0BF7468AA6; Sun, 30 Oct 2022 10:18:15 +0100 (CET)
Date: Sun, 30 Oct 2022 10:18:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 03/17] nvme-pci: don't warn about the lack of I/O
 queues for admin controllers
Message-ID: <20221030091814.GB5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-4-hch@lst.de> <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b88277-b237-c89e-a63c-bd441615e6b2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_021817_920873_2D1E33BB 
X-CRM114-Status: GOOD (  14.39  )
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

On Wed, Oct 26, 2022 at 03:49:06PM +0300, Sagi Grimberg wrote:
> I have a feeling that we have quite a few other messages that are
> irrelevant for admin controllers. And I wander what device you have that
> presents an admin controller, but looks good,

Could be.  I don't actually have any administrative controller at hand,
I just noticed the warning while looking over this code.

