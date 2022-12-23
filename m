Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866E6C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Dec 2022 07:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wg2clfQRdnGAunAT7gUdQ67t9fBODx9mH3RwlxNN0Pc=; b=uselnCscu1nUiknVFu9q97AK31
	+DEeDJRMd0eOVTDr6p0I4Hl2XW/VCnvK3kjwrq9UmOtWHcHMd73ea8H1SoNd/9RYhufrq9D542BxF
	GY4g6sl+7fD3lF/dEsvR2SC3y+Et3PZFOlcieudXhY3r/r4cJgpri9xmvfePY6fOCzPYJ3aWqtnmW
	kA0xk8JmqwREM19j1s0FQdpnfxqctoOJoSwgFYEoHbS6aBZKgm5X7J7Pg64UOq1rQk2+4fIctqxlm
	x10eeiBLZdC+Fj+GBmtIWt620hqTV6OwAOvWLRMt0h6guQoVLd0AB4m4u6L6XHQ+32oNup1IBzzK5
	WFk98KiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cPe-004kXH-3I; Fri, 23 Dec 2022 07:24:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8cPP-004kQ3-M4; Fri, 23 Dec 2022 07:23:59 +0000
Date: Thu, 22 Dec 2022 23:23:59 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: blktests failures with v6.1
Message-ID: <Y6VXjztUUz7GFmAW@infradead.org>
References: <20221223045041.dl6ivxgo25eiwy33@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223045041.dl6ivxgo25eiwy33@shindev>
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

On Fri, Dec 23, 2022 at 04:50:42AM +0000, Shinichiro Kawasaki wrote:
>    The test case fails with NVME devices due to lockdep WARNING "possible
>    circular locking dependency detected". Reported in September [1] and solution
>    was discussed. A kernel fix patch was posted [2]. It may not be the best fix.
> 
>    [1] https://lore.kernel.org/linux-block/20220930001943.zdbvolc3gkekfmcv@shindev/
>    [2] https://lore.kernel.org/linux-nvme/20221012080318.705449-1-shinichiro.kawasaki@wdc.com/
> 
>    This test case shows different failure symptom with HDDs. Need further
>    investigation.

Yes.  Not a huge fan of the fix, but we need to look into this.
Sorry for delaying this so long, I'll try to look into this.

> #2: block/024
> 
>    Fails on slow machines. I suspect test case needs improvement.
>    Need further investigation.
> 
>    block/024 (do I/O faster than a jiffy and check iostats times) [failed]
>     runtime    ...  4.347s
>     --- tests/block/024.out     2022-12-06 20:51:41.525066605 +0900
>     +++ /home/shin/kts/kernel-test-suite/sets/blktests/log/runlog/nodev/block/024.out.bad       2022-12-07 12:51:03.610924521 +0900
>     @@ -6,5 +6,5 @@
>      read 1 s
>      write 1 s
>      read 2 s
>     -write 3 s
>     +write 4 s

Yes, I've been seeing this for a while as well.

> #3: nvme/002
> #4: nvme/016
> #5: nvme/017
> 
>    The test cases fail with similar messages below. Reported in June [3].
>    Fixes in the test cases are expected.

I think this is related to the current NQN that Hannes added.
Hannes, can you look into this?


