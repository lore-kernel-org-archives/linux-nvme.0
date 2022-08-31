Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DB0ECAAD1
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 23:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7jPkOYBwac8qC34nK3SY2G2LAOdWyfIUqKuxgclApY=; b=AM4h20HX/1p68qqD2pfScmO2sJ
	TKgT73a16Zwh+vQ01Cf8CFiFP5AXdAd+xk1glI1WPRqpGCNbebA2BCkzeqp7M3vdjhH6yi4SHlCtn
	zgnq0yvG7B9yh3ccfIX62acWuP6N0cLWNHdq58ma2L04bJpyjtAQ7WIrhM0eK71vQLk+Y8towpUEh
	PUmT9/4YgzT8+xeY5Y8EW/zYST34NunT3xG/jG5FlN+1VLZWB58oh3E8sXMi7K023B+1EHYmH6Gta
	vnD4qnDbnY6OZaQ0AcE/u7CwysvlaYNE++65CGiZbMk1uLmgBMb4EpQVczKqkvO1658FNgOHTmilD
	mKRnhMeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXSP-008ezK-VC; Wed, 31 Aug 2022 23:49:17 +0000
Received: from zeniv.linux.org.uk ([2a03:a000:7:0:5054:ff:fe1c:15ff])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTXSM-008eyi-Mr
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 23:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=S7jPkOYBwac8qC34nK3SY2G2LAOdWyfIUqKuxgclApY=; b=harToSvXXXtKZNY/7p0UCHiheI
	NH8Ml83jhu51qV79EUrIGtDQUZtkBPPWvSSaXPU6q6SP6G1FBRWNphPuVeRxjENgPmmAC6nWLzxgH
	cSHpuT8aLUgxu8T0QphOgQlOLMpXKz4tX7FzFgzfnw22VRQ4YWTipD6yPL6An5cu6ijaMoSGBZTg+
	pc+ym/z4ggxvkd/Kmn7MDg6Y1sajVQYNBrnE4QW7mwNnKuef4CutI+bvU3aWGc9q7d7mfY7oUprRl
	VxYamz7Z36YQMHQxlgsyZKUiBNwsgVZR+lKw2VW5TJcIyDXbNmaaaIYodxsyPdE8dVyR4CE5JAeHL
	MRpTWSgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
	id 1oTXRs-00AmZd-L4;
	Wed, 31 Aug 2022 23:48:44 +0000
Date: Thu, 1 Sep 2022 00:48:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <james.smart@broadcom.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v3 1/1] nvmet-tcp: Don't kmap() pages which can't come
 from HIGHMEM
Message-ID: <Yw/zXJdO3/x5dGdb@ZenIV>
References: <20220822142438.5954-1-fmdefrancesco@gmail.com>
 <2887364.VdNmn5OnKV@opensuse>
 <Ywkf3NJQ7/8SSV+e@ZenIV>
 <1924196.usQuhbGJ8B@opensuse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1924196.usQuhbGJ8B@opensuse>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_164914_778734_ADFDA3C2 
X-CRM114-Status: GOOD (  11.17  )
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

On Tue, Aug 30, 2022 at 10:06:54PM +0200, Fabio M. De Francesco wrote:

> Thanks so much for the time you spent writing this detailed explanation. I 
> really appreciated that you spend time for teaching newcomers with kindness 
> and patience.

*blink*

You are welcome, but TBH answering your question took about 5 minutes.
The question had been fairly simple and reasonable, and the lack of
in-tree documentation covering that is my own fault, so...

