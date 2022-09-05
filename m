Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABAFECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 14:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=BwPZBZF8wkjzcDD0+nhyMozWvR
	ERn0G9nRQHKtOG0FmrIjTKbhdA6xFscQqRvkAWVDp+3gzjWnm8BX8P9tNcjURxq/H5NA0GKjCoiMC
	XTd1eON5A4dF9CIhMoDDwqe0ZpGqbkZe3EFsPnW8ZW2zI4XWqQuzu8WPZQUALSOOSCCxwV+EvGnsk
	A4PtA0auTh9qePjWNaYNfVtqlK0K6reG9iq4H6ZkRGMZcQjpqFX4TKHdSroankpGiUIjmqyJO/2WC
	CJtrAlmPBz+Po4R/wigZ+ucZQT4Dtp0fm7yLOIaPcV0Pcdrjzjv+vQ6bAWOLWab2x9lXOfydh9J0P
	4zEjhQnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVCpL-004DXk-Ul; Mon, 05 Sep 2022 14:11:52 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oV9yg-000uHU-QO; Mon, 05 Sep 2022 11:09:18 +0000
Date: Mon, 5 Sep 2022 04:09:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v4 0/3] Handle number of queue changes
Message-ID: <YxXY3vbwm5ABoN0j@infradead.org>
References: <20220829092841.14244-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829092841.14244-1-dwagner@suse.de>
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

Thanks,

applied to nvme-6.1.

