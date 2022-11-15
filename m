Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2014CC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S1N0tHoJB91LMpEfiERPWvY0x7AdrTEap2zVNrQGk+k=; b=ReMdNLBxp3356OTttpdrLzD/Q4
	zzlSYQYnQF1m9uZiWK6rESLhML8B7BnwPfhyh4hwbGEwIKdwQMW2uMP2L6e+MnUev0QwvZp6HwJ4Z
	6hOpXNDn04uj00OFM/C5OnLm7cEzaW5DPg5VrgM7zarWhNdITkZl0KRTGYyVeBLDjazYPpOJ0BAGZ
	C4Qg9rVRkq6zhyE3t3HmwoYaaXAQCynG/erXam3n3x0yuGr4+l2rD+0EpDDs3ixboo1MGRGX5hh2d
	m2EQ5y29R1qHnOUKU/xRKihYLI93q9aLxPtgqVe5ZET0/VygxjnRrQ1Z8Pyu3UGX97DN7Qh8q9dOl
	WeLH6cFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov133-00DuNT-Hm; Tue, 15 Nov 2022 18:52:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ov130-00DuEV-Uf
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 18:52:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E6E6468AA6; Tue, 15 Nov 2022 19:52:32 +0100 (CET)
Date: Tue, 15 Nov 2022 19:52:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Nathan Chancellor <nathan@kernel.org>,
	kernel test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [linux-nvme:nvme-6.2 26/41] drivers/nvme/host/core.c:5122:6:
 error: assigning to 'int' from incompatible type 'void'
Message-ID: <20221115185232.GA32242@lst.de>
References: <202211160055.rbjs32vH-lkp@intel.com> <edda71f4-9912-d336-6d5b-0e1e102d4bfe@grimberg.me> <Y3PLZxNwqioynAtw@dev-arch.thelio-3990X> <5d14f4b9-5c1d-9caa-e70d-576bac98abc3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d14f4b9-5c1d-9caa-e70d-576bac98abc3@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_105239_151622_E0A6D142 
X-CRM114-Status: GOOD (  11.40  )
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

On Tue, Nov 15, 2022 at 07:52:35PM +0200, Sagi Grimberg wrote:
> Didn't even compile it...
> infradead is down again, I trust that Christoph applied this fixup 
> correctly...

Yeah, I already manually fixed that up after I did a AUTH=n build
after the first report.

