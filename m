Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A62C9832F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 09:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hApaCMmqd0ZdsgU3Fzkd4F/2G7vnzlI2W1/8dub5qBU=; b=d1tjFqqFhmsLsMywODbEvNPsBV
	v4ydrhnWil/ViZabAReSamDuvEBTkARecRu+rR9ueD4ez+mDrhBXxx/NaEeoux/sAEQoFoLyeURRL
	+u/mTRo0/Mu5bZTkR8aPLwvvnjqtsk6OWr5nalalNUqMvd32hY1rX0zcoRd0Lz+Tm0XSg7C83gZL7
	r6QlfCs56aiv/pTfWe7NIJidkRbpYXKA9yrIAK9bc10m9J2ULxqxcK+KLOvSgenWqMBlGm9rD9Pzs
	3ddgk76+UlXF0C3QmhOq0JmfIpsrgrn7cdD0Aw2WmifIvfsLntV9W1N9nLtUP0Cxaf0R66mEsOKCc
	VE1wOCxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB7RU-00000000CCs-49FN;
	Mon, 28 Sep 2026 09:14:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB7RR-00000000CC6-3DHX
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 09:14:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3000168BEB; Mon, 28 Sep 2026 11:14:28 +0200 (CEST)
Date: Mon, 28 Sep 2026 11:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: John Garry <john.garry@linux.dev>, axboe@kernel.dk, kbusch@kernel.org,
	sagi@grimberg.me, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 0/4] fix NVMe multipath partition diskstats
Message-ID: <20260928091428.GA29876@lst.de>
References: <20260921083752.1154316-1-john.garry@linux.dev> <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fe0a938-aaf4-46cb-8fba-3524586ac5b4@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_021433_952729_B1298C21 
X-CRM114-Status: GOOD (  12.38  )
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

On Mon, Sep 28, 2026 at 08:30:10AM +0100, John Garry wrote:
> On 21/09/2026 09:37, John Garry wrote:
>
> A reminder on this one ... or are we just going to leave this broken?

I find the amount of overhead and relatively invasive code very
offputting, and I still don't understand why we now have a strong
urge to address this after 10 years.

