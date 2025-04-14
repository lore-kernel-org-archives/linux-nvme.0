Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28FDC369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JNsGfOSiTDgxiWR0GpDReokl0GmYlvCqvhLlp15oFCY=; b=ZObSnfJlnWF34sber7l4Pi4jgu
	Qw4lnVODBGso9b+AMmXYPip3z7KWAQK8G7MJz45350xqduipkRrC0ESQpakF6Xqe3eUAvwinKgEny
	WpIZ9kimVdHvyIN3XAmBv7YJhbA9l6VMl78TrZp8RwfAlRW9MYtH/oWJz/IgimwtsacuCYTbiWHhh
	jNERJSbqWbidTkFhcy4hNx/zicB3SpCNhqKkRCFXqpVHO4bDjC6gZ8NsNEVRNU1uWIHzOuMC50Hfh
	9N4jCHLIsqNpqx4OUIna8t+ZujcZPo+iaJj43YliVjCDZOtnvc8Zj1H5Ri/B+Jru+6eGwAdVlG811
	0iJAi17Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Iwf-00000001waq-1Zgl;
	Mon, 14 Apr 2025 12:29:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4ItL-00000001wD6-0edb
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 12:26:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 21E8368B05; Mon, 14 Apr 2025 14:26:17 +0200 (CEST)
Date: Mon, 14 Apr 2025 14:26:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Srikanth Aithal <sraithal@amd.com>
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
Message-ID: <20250414122616.GA14884@lst.de>
References: <20250414120509.49638-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414120509.49638-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_052623_343931_D967A851 
X-CRM114-Status: GOOD (  15.16  )
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

On Mon, Apr 14, 2025 at 02:05:09PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> Commit 62baf70c3274 caused the ANA log page to be re-read, even on systems
> where the ANA is not supported.

And unsupported log page should normally not cause a boot failure, but
it seems the controller in question does not handle it well.  I've
applied the patch with a better subjet and commit message explaining this.

But if the controller handles unsupported log pages so badly it will
probably cause trouble in the future as well, or even now when
applications ask for unsupported log pages using the passthrough
interfaces.

Srikanth: what controller is this?  I'd like to add that to the commit
message as well.


