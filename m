Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08369C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 17:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAtM1/zqtZZjPBy9u8kxxP+Y/hVwz6Dsu9594IH55L0=; b=amdw44wTtL4+2CQfNNCwjGAFqa
	KLABRXv+s2oSiopk578xZMpV12sa3I4Cbmrb0hVt/PkjIfFtHAJQQRdyP4p/10iu9uCf44MSmjTxT
	oAvG0VxfPqjHINH1Hn2m2rsKPfkw79lWspW3/RaKLb4yUwmenLCJrSzjUmgf9ERy9GEUzxgPN8Ee0
	Watxu42iBoaZTLkl66TEe/PusqyO6bfJW4cnhguh8+Oz8v+3tgwZ4Rxdvr717C4qG2k+pqpJa1FOL
	PyAmAXdiYzTPXIiYdLHnw4pRAoNvmxejzUWBx5FIyhTPV7O2numD7t51wdFQn00kz1AzIeE5+tbYT
	I2BqG+nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1negxA-001y5r-2O; Wed, 13 Apr 2022 17:38:52 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1negx8-001y5C-5p; Wed, 13 Apr 2022 17:38:50 +0000
Date: Wed, 13 Apr 2022 10:38:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: bvanassche@acm.org, yi.zhang@redhat.com, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: can't run nvme-mp blktests
Message-ID: <YlcKqu3roZQSxZe8@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZXOC4VgmDrUGIP@infradead.org>
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

On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
> > I do have CONFIG_NVME_MULTIPATH=y but I also have:
> 
> I'd suggest to ignore broken tests that require a deprecated option
> that will eventually be removed.

CONFIG_NVME_MULTIPATH will eventually be nuked?

  Luis

