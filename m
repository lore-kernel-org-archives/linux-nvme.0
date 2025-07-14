Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26925C83F1B
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNMyIZJyXueqDxhMc2gAyF7Jz51P01o6d80BQGFvRh0=; b=zWzzV1Z8SkRE74plT6Tmd4sKdi
	1qBIQkyFjnFfyqxEHzQscG/PmuqKuU+Om+3YvthaA8HNHBP5UvXzwZYGtaPx2GzzJZl8hRK/hpg2u
	EuZLUdl3MDCbvUsDuHLBF84rchBa15MQDWP8t4IgkEioPWGnym3rgpPk2J0P91iLiymUMi79zSKL/
	8E3A7GbCAm76gAcM/PY6KX9rxxPcnb/ucqsdQ8ywAZM9XW6AklAAYiGUo2WQm+WdIllYf1Fyp5V8q
	P8d8Tvq6MmCC2/ImvXWWlYrHoEOQ9eZFyiLzYMlmdPrF/MpmsX1+5iuZkaAGL3boNip6fCh5GJ6az
	s0aPwiSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJaJ-00000002MoU-3LGj;
	Mon, 14 Jul 2025 13:51:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJS4-00000002LL7-3FBN
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35F10227A88; Mon, 14 Jul 2025 15:42:31 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:42:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	yi.zhang@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: Re: [PATCH] nvme: clear nvme request for nonready request
Message-ID: <20250714134231.GA11132@lst.de>
References: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628064634.3823093-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_064240_951014_8C940A3F 
X-CRM114-Status: UNSURE (   7.80  )
X-CRM114-Notice: Please train this message.
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

Are you going to resend this with the feedback from Sagi taken into
account?


