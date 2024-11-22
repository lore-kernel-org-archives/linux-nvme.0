Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FA8D75E32
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipDHbhVZ0CazdVf04xOhPvcgOaWOnN9QzI2h4S6fvQ0=; b=L9XMJIxTQIYNVpeeY6CwF5IUgu
	Dj9uRC68Ap128860+b83L0+ZQntCAwNUwnsO2ly6SZS/WMx9FSM7adMBF6ROkfGQBnxoUfemle734
	+OUnhctspGLrRGDHXPwLfJoyx30pPRG0vuj6iEL3NUKAuLP1fUrmcDf434IbMrPVEmfYO/opu5ZsX
	xN0r+4TC9EsUsnhongIQNNqLebeCMBZrhDLSY9DeR0CoKi3gRE/u2AtEYuNtCWfBp+w7Kd/PYIrNZ
	S8yv5pl2kL4xO/52qerNkgtVO0Gi0Jm76wGX0+fAPY5dtS5ad2CWJQwrb9Sid44HES91mdqAXaHFT
	3IH/2x1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tESTb-00000002Q8U-29io;
	Fri, 22 Nov 2024 12:09:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tESTZ-00000002Q7L-40hv
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 12:09:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 63E2968C4E; Fri, 22 Nov 2024 13:09:26 +0100 (CET)
Date: Fri, 22 Nov 2024 13:09:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bryan Gurney <bgurney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	mpe@ellerman.id.au, naveen@kernel.org, maddy@linux.ibm.com,
	kernel@xen0n.name, jmeneghi@redhat.com, bmarzins@redhat.com
Subject: Re: [PATCH 1/1] nvme: always enable multipath
Message-ID: <20241122120925.GA25817@lst.de>
References: <20241121220321.40616-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121220321.40616-1-bgurney@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_040930_150871_AB26F5ED 
X-CRM114-Status: GOOD (  13.74  )
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

On Thu, Nov 21, 2024 at 05:03:21PM -0500, Bryan Gurney wrote:
> Since device-mapper multipath will no longer be operating on NVMe
> devices, there is no longer a need to set CONFIG_NVME_MULTIPATH=n.
> 
> Always enable NVMe multipath, remove CONFIG_NVME_MULTIPATH, and use
> the code paths that would be used if CONFIG_NVME_MULTIPATH=y.

As mentioned last round not having to build the not tiny multipath
code for embedded systems and other small builds that never require
multipathing still seems like a sensible idea.


