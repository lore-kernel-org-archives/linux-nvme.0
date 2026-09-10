Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B969C79FB7
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 05:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JAuNLLfvv9vk168Yjwj3mBiZusvmQ+Cp9oNXUkfz60A=; b=TOJGAOLxW352a3+6EyuaLgQgXq
	lC6dFC7uUS6WNjDKkl3zgTtUtXAiJIXLndAstXFfHeZoabFMOAgXKspXhss1pyjDObd7C1lXZfgdZ
	QarM6TU8WSRegylSV6ltgWZ74NtB/ISIwg1tMfCWuU5CVjYNqrIAewx5F4hICTzGYg5eYk6sul6Bg
	D5pxzEzldS6nKxBMxGOwNVgoCr6owpM9GwfbDU4cmn6V7LLNBayRSK6D+W+XFahtFWbuQnteXWKpj
	vG2d/tf1yaoP1owx2HZuDCO+sr35y3RnqNiDb7cP3LLjrpMnVe6e7HKRUaFnE1/5F+GkJaDzL5hhz
	weJSyCkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XTK-0000000DShv-3OKV;
	Thu, 10 Sep 2026 05:37:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XTI-0000000DShL-19cB
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 05:37:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 648E568D05; Thu, 10 Sep 2026 07:37:12 +0200 (CEST)
Date: Thu, 10 Sep 2026 07:37:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, kch@nvidia.com, armenx.baloyan@intel.com,
	james.p.freyensee@intel.com, ming.l@ssi.samsung.com,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH 1/2] nvmet: preserve device path on allocation failure.
Message-ID: <20260910053712.GA27511@lst.de>
References: <20260908033519.2721210-1-sunjunchao@bytedance.com> <20260910052503.GB27133@lst.de> <72eecee9-c103-4c6b-adc8-0fa1367313f3@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72eecee9-c103-4c6b-adc8-0fa1367313f3@bytedance.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_223716_460057_ABF8A384 
X-CRM114-Status: GOOD (  12.25  )
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

On Thu, Sep 10, 2026 at 01:35:10PM +0800, Julian Sun wrote:
> On 9/10/26 1:25 PM, Christoph Hellwig wrote:
>> Can you coordinate this with the configfs path checking series
>> from Runyu Xiao?  That one had a few resends, so I'd like to get it in
>> first.
>
> Sure, I'll rebase and resend once you've merged Runyu's patches.

Actually I noticed we need another respin of that anyway.  Let me review
your patches and see if we can fast track them in.


