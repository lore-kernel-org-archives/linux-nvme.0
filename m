Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A384EC54F2E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RDL/zlXkplPEdMo04Hba0MRZk13Bli8euVOVKemeqZE=; b=C5ag54N8h1JhAGJqJ9giKS0VbA
	WxbmoD/oGfLbxng48d3zLZ8Swu2Jfuyk47CHv7ZPMlq2B1A5d7O83tgyTRT/8SJ0y3WtcA2mJfJgr
	GKd7uavjNQYN0ZqTLzYtuRLqVKQ0ik+0BozU2Qi+AY8lo6jFrfiJ3v2AfXs9BGUX3iv2YurUN6Awd
	qt2WiZKlX2RT4O7EEw/qhAgKNNzqLNKOuXtdsRaGoD3JljKLpLR1Vw1ehCTlGLqvJSsMk8d1KzKM8
	vEHIjS4pFzqGeOcAf9SQDFJv/Mce8UgzAVJ5k15gD3YqxngCEGy2k33ewLeH9SuI07XbAYYrNdo80
	kBBwdW+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIS1q-00000003smj-0oDe;
	Fri, 23 May 2025 13:01:38 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIRrB-00000003r8Q-1qze;
	Fri, 23 May 2025 12:50:37 +0000
Date: Fri, 23 May 2025 05:50:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
Message-ID: <aDBvHWPjYQwJQx7N@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-4-kbusch@meta.com>
 <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aab2c6c-4cd8-4f23-b61b-153f6e9c2ce7@suse.de>
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

On Thu, May 22, 2025 at 03:54:46PM +0200, Hannes Reinecke wrote:
> > +	if (req->cmd_flags & REQ_FUA)
> > +	        control |= NVME_RW_FUA;
> > +	if (req->cmd_flags & REQ_FAILFAST_DEV)
> > +	        control |= NVME_RW_LR;
> 
> FAILFAST_DEV? Is that even set anywhere?

That is a good question, but this is consistent with what we do for
other I/O commands.


