Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D103ED5AE60
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 05:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TMmqE25vU8M94uvjfDkZUqX395rfKiDU7o407L+XLp0=; b=jgdEWz7jKmTLXel3D5ULGTppJA
	WFvufHPmHJROa8ywNPRrueLAhYHKa1KyRj5mfcYcyzNax+FRuX376Fo62g4r+JN74TDWrJb76K/kM
	T50Wc87Zfd3SLpPS5y/vyA8caWgGtDB3uBrFfCIetLblvl0IP76yH+mcOqxlVJDLPtsjX3mq2Seqv
	iHZ4hhEttbd450Yop9+0xj4hVpjd3h35HHeNi66hUBCtTpKXhX7nldJn6MrIMF7m+q2cy8Ewb2qA3
	e4TdUoABb1fbuIAGqRR0KmKk2VZB0tNt7tK3mADu4W3bHcpQTmX9mo+fGWziv6+IUeOp6tOUFP6VU
	WO5gV81A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8v4h-00000005iDr-1afq;
	Thu, 07 Nov 2024 05:28:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8v4a-00000005iCF-0r5n
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 05:28:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFC2C227A87; Thu,  7 Nov 2024 06:28:36 +0100 (CET)
Date: Thu, 7 Nov 2024 06:28:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: check at least one ns identification reported
Message-ID: <20241107052836.GA1947@lst.de>
References: <20241104031418.121235-1-kanie@linux.alibaba.com> <20241104131529.GA14373@lst.de> <dd51a183-6313-454e-afeb-c00f0cb02f30@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd51a183-6313-454e-afeb-c00f0cb02f30@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_212848_407185_E530FB25 
X-CRM114-Status: GOOD (  13.87  )
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

On Wed, Nov 06, 2024 at 06:47:43PM +0800, Guixin Liu wrote:
> I assume that the dm-multipath

dm-multipath is not supported with nvme..

> will not recognize nvme device if nothing to 
> return,

But more importantly the user of the sysfs files is the right place
the just check for these values being non-present.  As said before
it's perfectly valid for 1.0 devices so they have to cope with it
anyway.  I don't think a message in the kernel log that is very to
process algorithmically is not very useful.

(I really with we'd have useful and required identifiers from the
start, but that's a separate discussion)


