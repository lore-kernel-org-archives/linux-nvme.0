Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05D7C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 14:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EC/AN9Xk8yU21j82wMdyomcndXdJbX1syrT1lj0PhV4=; b=oeNMiB7NQzL2extcLcHUpy2YGk
	xl9DBFhSR0gBdzFNRDTVsbE2rqSbr3RYTQ0Vs5KaiBqFCqIG76cnkYcUQ8LzAzjEY4ejIZE5M4jYI
	74RU3UjavFjP8HpbdI6blbo7Fyg5EOsllHQLjLkJb4oMIj+REHvrhKVIkO6blbPvL7U9NtbMMZLSP
	vxtyUWg6AfokQ9jKrWnGCUMUBwHA8L1nbYXJy6x2Kr/yJoTq/3aIyxeM0HgIPY4xmvLfqdL5Vpkyd
	+uk358k+bifIS5ptwjCly8vXcDsRm5GjLAIlMLSg2bA3QNEcCZHk82iGioLHGApud2cirDp+d3Bq3
	JEc6f0kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ZVy-0000000Ei9w-3CTz;
	Fri, 18 Sep 2026 14:24:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7ZVw-0000000Ei9V-0QZK
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 14:24:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA1F568BEB; Fri, 18 Sep 2026 16:24:27 +0200 (CEST)
Date: Fri, 18 Sep 2026 16:24:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: yupeng <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvmet: add cgroup_path to charge namespace I/O to a
 cgroup
Message-ID: <20260918142427.GA19316@lst.de>
References: <20260908011214.11344-1-yupeng0921@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908011214.11344-1-yupeng0921@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_072433_182276_67CDB8CC 
X-CRM114-Status: GOOD (  11.91  )
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

cgroup charing does seem useful.  But please do a human pass on the
code and especially the commit log and text in documentation, this
Claude slop is unreadable, and I also really want to you to be able
to explain the details of the new code.  Please also Cc the cgroup
mailing list for the next version, as they are much better than us
nvme maintainers to judge if you're using the cgroup APIs correctly.


