Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4C4D68B38
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 16:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BfVIj6LwRRNJE/C0h1W8f9Gjev4FSLNXP97wWW6vqug=; b=LXZegkdTNN9OAGOqH9uGwLZ7NC
	OE4qvZ+julbYNB5VgBTJCTASGR7ffw9zhHREcqZrCALPhxx67wFQWcvxehXluUQatalUFnjaonBpH
	44Bw40GfdYhpW2/mwQA4D/DzbdLr2lVGqdG2W4aL7wJ1AhE5kwjOCOmjXKGKNC5ZyJAiObb2qIuhA
	YgmjfKtFA5nAGXsU0JIqPePA+7NYyUDHyOdf9XheRxWzqtg/yDcwjSuWKTUUbZGpPkRiVKZo+So/m
	Kzr+f4OyooDHdWvE5CfP6cSYKjsmuyX8/BdjxRMM8AK4lX3XXIG34rAWsH45yw7Os+leWL41yleFk
	5Mkb4Y8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd02-00000000C3Q-241T;
	Thu, 14 Nov 2024 16:47:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tBd00-00000000C38-0c8r;
	Thu, 14 Nov 2024 16:47:16 +0000
Date: Thu, 14 Nov 2024 08:47:16 -0800
From: Christoph Hellwig <hch@infradead.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Ewan Milne <emilne@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: CONFIG_NVME_MULTIPATH - Do we need this?
Message-ID: <ZzYplOLPyo9EeK6E@infradead.org>
References: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889e1d2a-1cda-4979-8279-f2f665350376@redhat.com>
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

On Tue, Nov 12, 2024 at 07:23:06PM -0500, John Meneghini wrote:
> I'd like to remove this parameter from nvme_core/multipath.c. The fact is,
> setting nvme_core.multipath=N never worked in anything but RHEL and keeping
> it around only causes confusion.

I'm all in for that.

> For that matter, I'd like to remove the CONFIG_NVME_MULTIPATH kconfig option altogether.
> 
> Does anybody actually use this?

It might still make sense to keep the code footprint minimal for
embedded systems that just have an SD/CF Express card or a sodered on
BGA device that most certainly aren't CMIC/NMIC capable.  But I have
no really strong opinion.


