Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAA4EDEC45
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 11:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LYOunGE77Xv0P7LB2mtrAgx02xhgVD94qWi7GJJIUHo=; b=bE3bFkfOghz3H+FReRYp9RtP42
	AZfAhhu1WIyhcltldaqHhVV8jUNvGMDGS1okoblAG5XuBdB6NJ70Kma5RuIYK7gv6/1rkQpDkDTYh
	4GQk/8HDlgQ2GwlZh/Bvd6I/+xDGm+1VZVUILjIqnOVRnZw2rH0vAQAAdYTf2fJ0EnFB//rBLxuUQ
	ZS5HPEm+FI8ESDMgq92PSFUjxffTBB8difixcduq67Qd5kcEUY3PNqgDy4RdScMpC5c4ZZZ+msOCE
	ld9nSH0xagbJS4gCOsW9MJJgHDzc24iq1FknEKABnS3QKtBt8p64wIQtopJWPGUngRnx8Qf9uffb4
	ZWQ57LVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgO9W-005kox-1c;
	Wed, 13 Sep 2023 11:35:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgO9T-005kns-2L
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 11:35:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E551D68AA6; Wed, 13 Sep 2023 13:35:19 +0200 (CEST)
Date: Wed, 13 Sep 2023 13:35:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, g@flourine.lan,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [RFC v1 4/4] nvmet-discovery: do not use invalid port
Message-ID: <20230913113519.GA1565@lst.de>
References: <20230829091350.16156-1-dwagner@suse.de> <20230829091350.16156-5-dwagner@suse.de> <20230905065032.GC19701@lst.de> <vml2mmhjurjaalzcmugnu2c4cm4okfkl43swbmudmaotew4gsy@o4q44el473to> <ebfmki7mifmo67x27wwrdpabdbiamalj7rsevxvabyi4sff4ck@4d5fyvrjggkw> <pti3xai6zkvitsqaw54sxut4lpb4qupo4c2n5alesb35ndhxv4@ni7ritoqopfe> <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pzgeaisqmqz5up5fiorl46lmb6xglpdu4hp5lxotclnzvpfjrj@mgyfvcrvpl4x>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_043523_911629_E2FFDA17 
X-CRM114-Status: GOOD (  11.60  )
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

So that's interesting.  But what I'm mostly worried about is how the
nvmet kernel code allows a request without ->port to progress to the
actual command handler.  We should never allow a command to get that
far if ->port is NULL, and should not allow to clear ->port while
commands are still handled.


